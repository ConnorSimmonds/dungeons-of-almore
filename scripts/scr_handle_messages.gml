#define scr_handle_messages
//scr_handle_message()
//Basically just allows us to send some dummy packets
buffer_seek(message, buffer_seek_start, 0);
var opcode = argument0;
switch(opcode){
    case(0)://Initialize user
        buffer_write(message, buffer_u8,opcode);
        if(global.user != -1){
            buffer_write(message , buffer_u32,global.user);
        }
        break;
    case(0)://Ping
        buffer_write(message, buffer_u8,opcode);
        break;
    case(2): //Quit
        buffer_write(message, buffer_u8,opcode); break;
    case(10): //Update map
        buffer_write(message, buffer_u8,opcode);
        buffer_write(message, buffer_u8,argument[1]);
        buffer_write(message, buffer_u8,argument[2]);
        buffer_write(message, buffer_u8,argument[3]);
        break;
    case(13)://Open Map
        buffer_write(message, buffer_u8,opcode);
        buffer_write(message, buffer_u16,argument[1]);
        buffer_write(message, buffer_u16,argument[2]);
        break;
    case(14): //Create Map
        buffer_write(message, buffer_u8,opcode);
        buffer_write(message, buffer_u8,argument[1]);
        buffer_write(message, buffer_u8,argument[2]);
        break;
    default: //nada
}
scr_send_message();
//TODO: need to find a better way to add in all of the arguments - right now, it's super messy.

#define scr_recieve_packet
//scr_recieve_packet
//Just outputs a message based on the int gotten from the server.
switch(argument0){
    case(2): //clean up the connection and buffer
    buffer_delete(message);
    network_destroy(client);
    default: return argument0;
}

//this needs support for actual input past the opcode

#define scr_send_message
//scr_send_message
//This can only be called from obj_network, or an implementation similar to it.
network_send_raw(client,message,buffer_get_size(message));
