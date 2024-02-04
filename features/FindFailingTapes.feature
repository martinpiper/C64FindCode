Feature: Find tape files that fail to load
  
  This finds tape files that fail to load, either by causing the C64 to reset, or if the tape has stopped with the screen disabled.
  If the tape motor is on and the screen is on then this is fine, the loader is obviously displaying something.
  If the test succeeds then the screen datatext is dumped and screenshots are taken.
  If the test fails due to any timeout then a screenshot is taken.


  Scenario: Initialise the output directory
    Given initialise the output directory




  @TAPE1
  Scenario Outline: Test a specific tape file for failure to load: <filename>
    Given Vice emulator auto starts the file and connect via the remote monitor
    When getting to the point just after the filename display
    When monitoring the loading and game start process
    Then check for a successful game start

  Examples:
    | filename |
    | C:\temp\t.tap |
    | C:\work\c64\IRQTape\TapeTool\test.tap |
    | D:\Ultimate tape archive\Ultimate_Tape_Archive_V4.5\Ultimate_Tape_Archive_V4.5\Shoot'em-Up_Construction_Kit_(1989_Toolbox)_[3094]\Shoot'em-Up_Construction_Kit_a1.tap |
    | D:\Ultimate tape archive\Ultimate_Tape_Archive_V4.5\Ultimate_Tape_Archive_V4.5\Shoot'em-Up_Construction_Kit_(1992_Gremlin_Graphics_(GBH))_[6728]\Shoot'em-Up_Construction_Kit_Side_2.tap |
    | D:\Ultimate tape archive\Ultimate_Tape_Archive_V4.5\Ultimate_Tape_Archive_V4.5\Addicted_to_Fun_-_Ninja_Collection_(1991_Ocean_Software_Ltd)_[9901]\Addicted_to_Fun_-_Ninja_Collection_Tape_2_Side_1.tap |
    | D:\Ultimate tape archive\Ultimate_Tape_Archive_V4.5\Ultimate_Tape_Archive_V4.5\Altered_Beast_(1990_Hit_Squad)_[1442]\Altered_Beast_Side_1.tap |
    | D:\Ultimate tape archive\Ultimate_Tape_Archive_V4.5\Ultimate_Tape_Archive_V4.5\Anter-Planter_(1984_Romik_Software)_[305]\Anter-Planter.tap |
    | D:\Ultimate tape archive\Ultimate_Tape_Archive_V4.5\Ultimate_Tape_Archive_V4.5\Armageddon_(1984_Visions_Software_Factory)_[3062]\Armageddon.tap |
    | D:\Ultimate tape archive\Ultimate_Tape_Archive_V4.5\Ultimate_Tape_Archive_V4.5\Augie_Doggie_and_Doggie_Daddy_(1991_HiTEC_Software)_[7269]\Augie_Doggie_and_Doggie_Daddy.tap |
    | D:\Ultimate tape archive\Ultimate_Tape_Archive_V4.5\Ultimate_Tape_Archive_V4.5\Augie_Doggie_and_Doggie_Daddy_(1992_HiTEC_Software)_[1960]\Augie_Doggie_and_Doggie_Daddy.tap |
