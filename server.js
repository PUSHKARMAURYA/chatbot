const path = require('path');
const http = require('http');
const express = require('express');
const socketio = require('socket.io');
const formatMessage = require('./utils/messages');
const {
  userJoin,
  getCurrentUser,
  userLeave,
  getRoomUsers
} = require('./utils/users');

const app = express();
const server = http.createServer(app);
const io = socketio(server);


 var datetime = new Date();
    console.log(datetime.toISOString().slice(0,10));




var mongoose=require("mongoose");
// Set static folder
app.use(express.static(path.join(__dirname, 'public')));



const MongoClient = require('mongodb').MongoClient;
mongoose.connect('mongodb+srv://dfgh:dfgh@cluster0.ocqnh.mongodb.net/dfgh?retryWrites=true&w=majority', {
	useNewUrlParser: true,
	useCreateIndex: true
}).then(() => {
	console.log('Connected to DB!');
}).catch(err => {
	console.log('ERROR:', err.message);
});


 
var chatbx =new mongoose.Schema({
	name:String,
	message:String,
	room:String,
	time:String
	});
var chatbox =mongoose.model("chatbox",chatbx);


const botName = 'ChatCord Bot';

// Run when client connects
io.on('connection', socket => {
	
  socket.on('joinRoom', ({ username, room }) => {
    const user = userJoin(socket.id, username, room);

    socket.join(user.room);
	    chatbox.find({$or: [{$and: [ { name:user.username }, { room:room} ]},{$and: [ { name:room }, { room:user.username} ]} ]},function(err,call){
	call.forEach(function(calli){
		socket.emit('message', formatMessage(calli.name, calli.message,calli.time));
		
	});

    // Welcome current user
    socket.emit('message', formatMessage(botName, 'Welcome to ChatCord!sdfsdfs'));

    // Broadcast when a user connects
    socket.broadcast
      .to(user.room)
      .emit(
        'message',
        formatMessage(botName, `${user.username} has joined the chat`)
      );

    // Send users and room info
    io.to(user.room).emit('roomUsers', {
      room: user.room,
      users: getRoomUsers(user.room)
    });
		  
		  });
  });

  // Listen for chatMessage
  socket.on('chatMessage',  msg => {
    const user = getCurrentUser(socket.id);
	 console.log(user.room);
    chatbox.create({name:user.username,message:msg,room:user.room,time:datetime.toISOString().slice(0,20)},function(err,call){
		if(err){
			console.log(err);
		}
		else{
    io.to(user.room).emit('message', formatMessage(user.username, msg+"  ",datetime.toISOString().slice(0,20)));
		}
		});
		
		
  });

  // Runs when client disconnects
  socket.on('disconnect', () => {
    const user = userLeave(socket.id);

    if (user) {
      io.to(user.room).emit(
        'message',
        formatMessage(botName, `${user.username} has left the chat`)
      );

      // Send users and room info
      io.to(user.room).emit('roomUsers', {
        room: user.room,
        users: getRoomUsers(user.room)
      });
    }
  });
});

const PORT = process.env.PORT || 3000;

server.listen(PORT, () => console.log(`Server running on port ${PORT}`));
