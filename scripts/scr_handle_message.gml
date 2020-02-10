#define scr_handle_message
//scr_handle_message()
//Basically just allows us to send some dummy packets
switch(keyboard_lastchar){
    case('0'): message = 0; break;
    case('1'): message = 1; break;
    case('2'): message = 2; break;
    case('3'): message = 10; break;
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
