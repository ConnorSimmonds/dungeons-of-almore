<<<<<<< HEAD
=======
#define scr_handle_message
//scr_handle_message()
//Basically just allows us to send some dummy packets
buffer_seek(message, buffer_seek_start, 0);
var opcode;
switch(keyboard_lastchar){
    case('0'): ini_open("settings.ini");
        opcode = 0;
        var user = ini_read_real('UserDetails','userid',-1);
        buffer_write(message, buffer_u8,opcode);
        buffer_write(message , buffer_u32,user);
        ini_close();
        break;
    case('1'): opcode = 1; 
        buffer_write(message, buffer_u8,opcode);
        break;
    case('2'): opcode = 2;
        buffer_write(message, buffer_u8,opcode); break;
    case('3'): opcode = 10; 
        buffer_write(message, buffer_u8,opcode); break;
    default: //nada
}



#define scr_receive_packet
//scr_recieve_packet
//Just outputs a message based on the int gotten from the server.
switch(argument0){
    case(0): return "Server returned okay!";
    case(1): return "pong";
    case(2): return "Connection closed!";
    case(10): return "Map Value updating";
    case(11): return "Map File";
}
>>>>>>> parent of 6af7da8... CommitLog | Just added a TODO to scr_handle_message
