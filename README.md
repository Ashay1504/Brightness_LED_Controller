# LED Controller Brightness

This repository contains a VHDL-based project for controlling the brightness of LEDs on the DE10 Standard board, utilizing its FPGA capabilities. Additionally, it includes a showcase game developed in SCOMP assembly language to demonstrate the functionality of the project in an interactive and fun way. A "Whack-a-Mole" game is also included to effectively showcase the interactive functionality of the LEDs.

---

## Features

- **FPGA-Based Brightness Control**: Purely hardware-level implementation using VHDL.
- **PWM Implementation**: Control LED brightness with variable duty cycles.
- **SCOMP-Based Games**: A set of games developed in SCOMP assembly language to showcase LED brightness functionality, including a "Whack-a-Mole" game.
- **Optimized for DE10 Standard Board**: Fully tailored for the FPGA hardware on the DE10 Standard.
- **Scalable Design**: Easily extendable to control multiple LEDs.
- **Efficient Utilization of FPGA Resources**: Designed to minimize resource usage.

---

## Hardware Requirements

- **DE10 Standard Board**: An FPGA development board featuring Intel's Cyclone V SoC.
- **LEDs**: Either on-board LEDs or external LEDs connected via GPIO pins.
- **Power Source**: Required to power the DE10 Standard board.

---

## Getting Started

### Prerequisites

1. **Quartus Prime**: Ensure you have Intel Quartus Prime software installed for compiling and programming the FPGA.
2. **SCOMP Emulator**: If you are testing the game outside the DE10 Standard board, use an emulator for the SCOMP assembly language.
3. **DE10 Standard Board Setup**: Connect your DE10 Standard board to your development machine via USB-Blaster.
4. **VHDL and Assembly Knowledge**: Familiarity with VHDL and SCOMP assembly language is recommended to understand or extend the code.

---

## Project Structure

The repository includes the following files:
- **`PWM_Controller.vhd`**: The main module implementing PWM functionality.
- **`Top_Level_Design.vhd`**: The top-level VHDL file connecting the PWM module to the DE10 Standard board's GPIO pins.
- **`constraints.qsf`**: The pin assignment file for the DE10 Standard board.
- **`game.scomp`**: The SCOMP assembly language game that showcases the LED brightness functionality.
- **`whack_a_mole.scomp`**: The "Whack-a-Mole" game implemented in SCOMP assembly language to demonstrate the interactive functionality of the LEDs.
- **`README.md`**: This documentation file.

---

## Implementation Details

### PWM Controller

The PWM controller adjusts the brightness by varying the duty cycle of the PWM signal:
- **Duty Cycle**: The percentage of time the signal is HIGH during one period.
- **Frequency**: The PWM signal frequency can be adjusted as per the requirements.

### Top-Level Design

The top-level design maps the PWM output signal to the appropriate GPIO pins of the DE10 Standard board, which are connected to the LEDs.

### SCOMP Assembly Games

#### Main Game
The primary game is developed in SCOMP assembly language and interacts with the LED brightness controller. It demonstrates real-time changes in LED brightness based on game logic. The game logic includes:
- **Interactive Controls**: Use switches or buttons on the DE10 Standard board to interact with the game.
- **Dynamic Brightness Changes**: Game events trigger changes in LED brightness levels.
- **User Feedback**: LEDs provide visual feedback for game progress.

#### Whack-a-Mole
The "Whack-a-Mole" game is designed to showcase the responsiveness and interactivity of the LED brightness controller. Gameplay involves:
- **Randomized LED Activation**: LEDs light up in a random sequence to represent the "moles."
- **Player Interaction**: Use buttons or switches on the DE10 Standard board to "whack" the active LED.
- **Scoring**: Successful hits increase the score, while missed opportunities may decrease it or reset the score.

---

## Usage

### 1. Cloning the Repository

Clone this repository to your local machine:
```bash
git clone https://github.com/Ashay1504/led-controller-brightness.git
cd led-controller-brightness
```

### 2. Pin Assignments

Update the `constraints.qsf` file with the correct pin assignments for your DE10 Standard board setup. Ensure the pins used for LEDs are correctly mapped.

### 3. Compilation

1. Open the project in Intel Quartus Prime.
2. Compile the project to generate the programming file (`.sof`).

### 4. Programming the FPGA

1. Connect the DE10 Standard board to your PC via USB-Blaster.
2. Use Quartus Programmer to load the `.sof` file onto the FPGA.

### 5. Running the Games

1. Open the `game.scomp` or `whack_a_mole.scomp` file in your SCOMP emulator or load it directly onto the DE10 Standard board.
2. Follow the game instructions to interact with the LEDs.

---

## Example Code

### PWM Controller (Snippet)

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM_Controller is
    Port (
        clk : in STD_LOGIC;
        brightness : in UNSIGNED(7 downto 0);
        pwm_out : out STD_LOGIC
    );
end PWM_Controller;

architecture Behavioral of PWM_Controller is
    signal counter : UNSIGNED(7 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            counter <= counter + 1;
            if counter < brightness then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;
end Behavioral;
```

### Whack-a-Mole Game (Snippet)

```assembly
; Whack-a-Mole game in SCOMP assembly
START:  LDI R1, 0      ; Initialize score
        LDI R2, 0      ; Initialize LED state
LOOP:   RANDOM R3       ; Generate random LED
        OUT R3, LED     ; Light up random LED
        IN R4, SWITCH   ; Read player input
        CMP R3, R4      ; Check if correct LED was hit
        BEQ HIT         ; If hit, branch to HIT
MISS:   JMP LOOP        ; If missed, continue
HIT:    ADD R1, 1       ; Increment score
        JMP LOOP        ; Continue game
```

---

## Contributing

Contributions to enhance this project or adapt it for other FPGA boards and games are welcome! Feel free to fork the repository, create feature branches, and submit pull requests.

---

## License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute this project in accordance with the terms of the license.

---

## Support

For questions, issues, or feature requests, please open an [issue](https://github.com/Ashay1504/led-controller-brightness/issues) or reach out via email.

---

## Acknowledgments

- Thanks to Intel for providing excellent tools and documentation for FPGA development.
- Special thanks to the open-source community for their support and inspiration.

---

Enjoy exploring FPGA development and interactive LED control! 💡✨
