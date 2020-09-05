#define scr_handle_messages
//scr_handle_message()
//Basically just allows us to send some dummy packets
buffer_seek(message, buffer_seek_start, 0);
var opcode;
switch(argument[0]){
    case('0'): ini_open("settings.ini"); //Initialize user
        opcode = 0;
        var user = ini_read_real('UserDetails','userid',-1);
        buffer_write(message, buffer_u8,opcode);
        buffer_write(message , buffer_u32,user);
        ini_close();
        break;
    case('1'): opcode = 1; //Ping
        buffer_write(message, buffer_u8,opcode);
        break;
    case('2'): opcode = 2; //Quit
        buffer_write(message, buffer_u8,opcode); break;
    case('3'): opcode = 10; //Update map
        buffer_write(message, buffer_u8,opcode);
        buffer_write(message, buffer_u8,argument[1]);
        buffer_write(message, buffer_u8,argument[2]);
        buffer_write(message, buffer_u8,argument[3]);
        break;
    case('4'): opcode = 13; //Open Map
        buffer_write(message, buffer_u8,opcode);
        buffer_write(message, buffer_u16,argument[1]);
        buffer_write(message, buffer_u16,argument[2]);
        break;
    case('5'): opcode = 14; //Create Map
        buffer_write(message, buffer_u8,opcode);
        buffer_write(message, buffer_u8,argument[1]);
        buffer_write(message, buffer_u8,argument[2]);
        break;
    default: //nada
}

//TODO: need to find a better way to add in all of the arguments - right now, it's super messy.

#define scr_recieve_packet
//scr_recieve_packet
//Just outputs a message based on the int gotten from the server.
switch(argument0){
    case(0): return "Server returned okay!";
    case(1): return "pong";
    case(2): //clean up the connection and buffer
    buffer_delete(message);
    network_destroy(client);
    return "Connection closed!";
    case(10): return "Map Value updating";
    case(11): return "Map File";
    case(12): scr_handle_messages('5');
    return "Create Map";
}

//asdf
