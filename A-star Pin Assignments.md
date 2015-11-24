#A-star Pin Assignments
The following is a work-in-progress.  The starting point is the table in section 3.7 of the Pololu [User Guide](https://www.pololu.com/docs/0J66/all#3.8/%22User%20Guide%22).

| 32U4 pin name | Arduino names | A-star use | Alternate functions | Proposed R3.2 use | Other comments |
| :---- |:---- | :---- | :---- | :---- | :---- |
| PB3 | 14, MISO | User pushbutton A | SPI Master Input/Slave Output (MISO); Pin-change interrupt (PCINT3); ISP programming line (PDO) | Button A | |
| PB0 | 17, SS | Red LED (RX); User pushbutton C; | SPI slave select (SS); Pin-change interrupt (PCINT0); | Button C; Red LED | |
| PC7 |13 | Yellow LED | Timer4 PWM output A (OC4A); Timer3 input capture pin (ICP3); Divided system clock output (CLKO); | Yellow LED | |
| PD5 | - | Green LED (TX); User pushbutton B | UART external clock (XCK1); UART flow control (CTS); | Button B; Green LED | |
| PD6 | 12, A11, 29 | Motor 1 direction | Analog input (ADC9); Timer4 PWM output D (OC4D); Timer1 counter source (T1) | Motor 1 dir | |
| PB5 | 9, A9, 27 | Motor 1 PWM | Analog input (ADC12); Timer1 PWM output A (OC1A); Timer4 PWM output B (OC4B); Pin-change interrupt (PCINT5) | Motor 1 PWM | |
| PE2 | - | Motor 2 direction | Hardware bootloader select (HWB) | Motor 2 dir | |
| PB6 | 10, A10, 28 | Motor 2 PWM | Analog input (ADC13); Timer1 PWM output B (OC1B); Timer4 PWM output B (OC4B); Pin-change interrupt (PCINT6) | Motor 2 PWM | 
| PD0 | 3, SCL | I²C clock for Raspberry Pi communication | Timer0 PWM output B (OC0B); External interrupt source (INT0) | I2C SCL | Reserve for I2C (e.g. IMU) from RPi even if not used by A-star |
| PD1 | 2, SDA | I²C data for Raspberry Pi communication | External interrupt source (INT1) | I2C SDA | Reserve for I2C (e.g. IMU) from RPi even if not used by A-star |
| PD7 | 6, A7, 25 | Free I/O; Jumper to buzzer PWM | Analog input (ADC10); Timer4 PWM output D (OC4D); Timer0 counter source (T0) | Buzzer | |
| PF6 | A1, 19 | Free I/O; Jumper to battery level input (VIN/3) | Analog input (ADC6); JTAG test data out (TDO) | BATLEV | |
| PD2 | 0 | Free I/O | UART receive pin (RXD1); External interrupt source (INT2) | L encoder A | Ext INT for encoder ( but blocks use of UART) |
| PD3 | 1 | Free I/O | UART transmit pin (TXD1); External interrupt source (INT3) | R encoder B | Ext INT for encoder ( but locks use of UART) |
| PD4 | 4, A6, 24 | Free I/O | Analog input (ADC8); Timer1 input capture pin (ICP1) | L encoder B | |
| PC6 | 5 | Free I/O | Timer3 PWM output A (OC3A); Timer4 PWM output A (OC4A) | | Reserve for Timer3 usage? |
| PE6 | 7 | Free I/O | Analog comparator negative input (AIN0); External interrupt source (INT6) | | Reserve for INT6 or AIN0 use? |
| PB4 | 8, A8, 26 | Free I/O | Analog input (ADC11); Pin-change interrupt (PCINT4) | R encoder A | A, B reversed between L, R encoders |
| PB7 | 11 | Free I/O | Timer0 PWM output A (OC0A); Timer1 PWM output C (OC1C); UART flow control (RTS); Pin-change interrupt (PCINT7) | | |
| PB1 | 15, SCK | Free I/O | SPI Clock (SCK); Pin-change interrupt (PCINT1); ISP programming line (SCK) | | |
| PB2 | 16, MOSI | Free I/O | SPI Master Output/Slave Input (MOSI); Pin-change interrupt (PCINT2); ISP programming line (PDI) | | |
| PF7 | A0, 18 | Free I/O | Analog input (ADC7); JTAG test data in (TDI) | | |
| PF5 | A2, 20 | Free I/O | Analog input (ADC5); JTAG test mode select (TMS) | | |
| PF4 | A3, 21 | Free I/O | Analog input (ADC4); JTAG test clock (TCK) | | |
| PF1 | A4, 22 | Free I/O | Analog input (ADC1) | | |
| PF0 | A5, 23 | Free I/O | Analog input (ADC0) | | |
| RESET | Reset pushbutton | internally pulled high, active low |RESET | |
| AREF | - | - | Analog reference | AREF | |







> Written with [StackEdit](https://stackedit.io/).
