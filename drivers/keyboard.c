#include "../kernel/low_level.h"
#include "../kernel/util.h"
#include "../kernel/isr.h"
#include "k_stdio.h"

void (*callback)(unsigned char);

static void keyboard_callback(registers_t regs) {
    /* The PIC leaves us the scancode in port 0x60 */
    uint8_t scancode = port_byte_in(0x60);
    
    callback(scancode);
}

void init_keyboard(void (*on_down)(unsigned char)) {
    callback = on_down;
   register_interrupt_handler(IRQ1, keyboard_callback); 
}

void print_letter(uint8_t scancode) {
    switch (scancode) {
        case 0x0:
            print("ERROR");
            break;
        case 0x1:
            print("ESC");
            break;
        case 0x2:
            print("1");
            break;
        case 0x3:
            print("2");
            break;
        case 0x4:
            print("3");
            break;
        case 0x5:
            print("4");
            break;
        case 0x6:
            print("5");
            break;
        case 0x7:
            print("6");
            break;
        case 0x8:
            print("7");
            break;
        case 0x9:
            print("8");
            break;
        case 0x0A:
            print("9");
            break;
        case 0x0B:
            print("0");
            break;
        case 0x0C:
            print("-");
            break;
        case 0x0D:
            print("+");
            break;
        case 0x0E:
            print("Backspace");
            break;
        case 0x0F:
            print("Tab");
            break;
        case 0x10:
            print("Q");
            break;
        case 0x11:
            print("W");
            break;
        case 0x12:
            print("E");
            break;
        case 0x13:
            print("R");
            break;
        case 0x14:
            print("T");
            break;
        case 0x15:
            print("Y");
            break;
        case 0x16:
            print("U");
            break;
        case 0x17:
            print("I");
            break;
        case 0x18:
            print("O");
            break;
        case 0x19:
            print("P");
            break;
		case 0x1A:
			print("[");
			break;
		case 0x1B:
			print("]");
			break;
		case 0x1C:
			print("ENTER");
			break;
		case 0x1D:
			print("LCtrl");
			break;
		case 0x1E:
			print("A");
			break;
		case 0x1F:
			print("S");
			break;
        case 0x20:
            print("D");
            break;
        case 0x21:
            print("F");
            break;
        case 0x22:
            print("G");
            break;
        case 0x23:
            print("H");
            break;
        case 0x24:
            print("J");
            break;
        case 0x25:
            print("K");
            break;
        case 0x26:
            print("L");
            break;
        case 0x27:
            print(";");
            break;
        case 0x28:
            print("'");
            break;
        case 0x29:
            print("`");
            break;
		case 0x2A:
			print("LShift");
			break;
		case 0x2B:
			print("\\");
			break;
		case 0x2C:
			print("Z");
			break;
		case 0x2D:
			print("X");
			break;
		case 0x2E:
			print("C");
			break;
		case 0x2F:
			print("V");
			break;
        case 0x30:
            print("B");
            break;
        case 0x31:
            print("N");
            break;
        case 0x32:
            print("M");
            break;
        case 0x33:
            print(",");
            break;
        case 0x34:
            print(".");
            break;
        case 0x35:
            print("/");
            break;
        case 0x36:
            print("Rshift");
            break;
        case 0x37:
            print("Keypad *");
            break;
        case 0x38:
            print("LAlt");
            break;
        case 0x39:
            print("Spc");
            break;
        default:
            /* 'keuyp' event corresponds to the 'keydown' + 0x80 
             * it may still be a scancode we haven't implemented yet, or
             * maybe a control/escape sequence */
            if (scancode <= 0x7f) {
                print("Unknown key down");
            } else if (scancode <= 0x39 + 0x80) {
                print("key up ");
                print_letter(scancode - 0x80);
            } else print("Unknown key up");
            break;
    }
}


char* get_letter(uint8_t scancode) {
    switch (scancode) {
        case 0x0:
            return "ERROR";
            break;
        case 0x1:
            return "ESC";
            break;
        case 0x2:
            return "1";
            break;
        case 0x3:
            return "2";
            break;
        case 0x4:
            return "3";
            break;
        case 0x5:
            return "4";
            break;
        case 0x6:
            return "5";
            break;
        case 0x7:
            return "6";
            break;
        case 0x8:
            return "7";
            break;
        case 0x9:
            return "8";
            break;
        case 0x0A:
            return "9";
            break;
        case 0x0B:
            return "0";
            break;
        case 0x0C:
            return "-";
            break;
        case 0x0D:
            return "+";
            break;
        case 0x0E:
            return "Backspace";
            break;
        case 0x0F:
            return "Tab";
            break;
        case 0x10:
            return "Q";
            break;
        case 0x11:
            return "W";
            break;
        case 0x12:
            return "E";
            break;
        case 0x13:
            return "R";
            break;
        case 0x14:
            return "T";
            break;
        case 0x15:
            return "Y";
            break;
        case 0x16:
            return "U";
            break;
        case 0x17:
            return "I";
            break;
        case 0x18:
            return "O";
            break;
        case 0x19:
            return "P";
            break;
		case 0x1A:
			return "[";
			break;
		case 0x1B:
			return "]";
			break;
		case 0x1C:
			return "ENTER";
			break;
		case 0x1D:
			return "LCtrl";
			break;
		case 0x1E:
			return "A";
			break;
		case 0x1F:
			return "S";
			break;
        case 0x20:
            return "D";
            break;
        case 0x21:
            return "F";
            break;
        case 0x22:
            return "G";
            break;
        case 0x23:
            return "H";
            break;
        case 0x24:
            return "J";
            break;
        case 0x25:
            return "K";
            break;
        case 0x26:
            return "L";
            break;
        case 0x27:
            return ";";
            break;
        case 0x28:
            return "'";
            break;
        case 0x29:
            return "`";
            break;
		case 0x2A:
			return "LShift";
			break;
		case 0x2B:
			return "\\";
			break;
		case 0x2C:
			return "Z";
			break;
		case 0x2D:
			return "X";
			break;
		case 0x2E:
			return "C";
			break;
		case 0x2F:
			return "V";
			break;
        case 0x30:
            return "B";
            break;
        case 0x31:
            return "N";
            break;
        case 0x32:
            return "M";
            break;
        case 0x33:
            return ",";
            break;
        case 0x34:
            return ".";
            break;
        case 0x35:
            return "/";
            break;
        case 0x36:
            return "Rshift";
            break;
        case 0x37:
            return "Keypad *";
            break;
        case 0x38:
            return "LAlt";
            break;
        case 0x39:
            return "Spc";
            break;
        default:
            /* 'keuyp' event corresponds to the 'keydown' + 0x80 
             * it may still be a scancode we haven't implemented yet, or
             * maybe a control/escape sequence */
            if (scancode <= 0x7f) {
                return "Unknown key down";
            } else if (scancode <= 0x39 + 0x80) {
                return "key up ";
                print_letter(scancode - 0x80);
            } else return "Unknown key up";
            break;
    }
}