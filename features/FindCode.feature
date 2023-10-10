Feature: Find interesting drive code

  

  @TC-1
  Scenario Outline: Find interesting drive code
    
    Given I run the command line ignoring return code: c:\SysTools\pskill x64sc
    # Although the ICU Vice version is faster, the debugger seems to only process when waving the mouse over the main window, which is quite useless...
#    Given I run the command line: cmd /c start C:\ICU64\x64.exe -warp -autostart-warp -truedrive -remotemonitor -autostart <filename>
    Given I run the command line: cmd /c start C:\Downloads\WinVICE-3.1-x86-r34062\WinVICE-3.1-x86-r34062\x64sc.exe -warp -autostart-warp -truedrive -remotemonitor -autostart "<filename>"

    Given set monitor reply timeout and continue to "10" seconds
    Given set monitor lifetime timeout and error to "30" seconds
    Given connect to remote monitor at TCP "127.0.0.1" port "6510"
    When send remote monitor command without parsing "watch store 2000"
    When remote monitor wait for 3 hits
    When remote monitor wait for hit
    # Hopefully the game will eventually run code that touches this memory area...
    When send remote monitor command without parsing "scrsh "%WCD%\target\temp\t${test.cukesplus.testIteration}_1.png" 2"
    When send remote monitor command without parsing "watch store 2000 8000"
    When remote monitor wait for hit
    When send remote monitor command without parsing "scrsh "%WCD%\target\temp\t${test.cukesplus.testIteration}_2.png" 2"
    When send remote monitor command without parsing "dev c:"
    When send remote monitor command without parsing "bank ram"
    When send remote monitor command without parsing "s "%WCD%\target\temp\t${test.cukesplus.testIteration}_c64.bin" 0 0 ffff"
    When send remote monitor command without parsing "d 0 ffff"
    Given I create file "target\temp\t${test.cukesplus.testIteration}_c64.txt" with
    """
    ${test.BDD6502.lastMonitorReply}
    """
    Given set property "test.c64" equal to "${test.BDD6502.lastMonitorReply}"


    When send remote monitor command without parsing "dev 8:"
    When send remote monitor command without parsing "s "%WCD%\target\temp\t${test.cukesplus.testIteration}_1541.bin" 0 0 07ff"
    When send remote monitor command without parsing "d 0 07ff"
    Given I create file "target\temp\t${test.cukesplus.testIteration}_1541.txt" with
    """
    ${test.BDD6502.lastMonitorReply}
    """
    Given set property "test.1541" equal to "${test.BDD6502.lastMonitorReply}"
    

    # Search for the interesting drive code receiver pattern in C64 memory
    * if string "${test.c64}" matches regex ".*LD[XY] \$DD00.*\R.*LDA \$....,[XY].*\R.*LD[XY] \$DD00.*\R.*ORA \$....,[XY].*\R.*LD[XY] \$DD00.*\R.*ORA \$....,[XY].*\R.*LD[XY] \$DD00.*\R.*ORA \$....,[XY].*\R"
      * debug print to scenario "matched!"
      Given I create file "target\temp\t${test.cukesplus.testIteration}_matched.txt" with
        """
		<filename>
        """
    * endif


  Examples:
    | filename |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\1943[capcom_1988](ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\1943[capcom_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\19_part_1_boot_camp_s1[cascade_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\19_part_1_boot_camp_s2[cascade_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\2_on_one[mastertronic_1988](la_swat-panther)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\3_on_1[mastertronic_1988](darts-pool-snooker).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4th_and_inches_team_construction[accolade_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4x4_offroad_racing_s1[epyx_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4x4_offroad_racing_s1[epyx_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4x4_offroad_racing_s2[epyx_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4x4_offroad_racing_s2[epyx_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\5th_gear[hewson_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\720_s1[mindscape_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\720_s2[mindscape_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\abyss[kingsoft_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\addictaball[alligata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\addictaball[alligata_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\advanced_tactical_fighter[digital_integration_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\afterburner[activision_1988](arcade_champions)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\afterburner[activision_sega_1988](para-v2)(pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\afterburner[activision_sega_1988](para-v2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\aiginas_prophecy[vic_tokai_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alcon[taito_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alcon[taito_1988](vmax3)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alcon[taito_1988](vmax3)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alf[box_office_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\altered_beast_s1[activision_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\altered_beast_s2[activision_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\altered_beast_s2[activision_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\apache_strike[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s1[br0derbund_1988](vmax0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s1[br0derbund_1988](vmax0)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s1[br0derbund_1988](vmax0)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s1[br0derbund_1988](vmax0)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s2[br0derbund_1988](vmax0)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s2[br0derbund_1988](vmax0)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s2[br0derbund_1988](vmax0)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s2[br0derbund_1988](vmax0)(alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s2[br0derbund_1988](vmax0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s3[br0derbund_1988](vmax0)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s3[br0derbund_1988](vmax0)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s3[br0derbund_1988](vmax0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s4[br0derbund_1988](vmax0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s4[br0derbund_1988](vmax0)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arkanoid[imagine_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arkanoid[imagine_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arkanoid_ii[taito_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\armalyte_s1[thalamus_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\armalyte_s2[thalamus_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\artura[arcadia_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\artura[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\atomic_robo-kid_s1[activision_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\atomic_robo-kid_s2[activision_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\atomic_robo-kid_s2[activision_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\awardware_new_graphics_disk[hi-tech_expressions_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\axe_of_rage_s1[epyx_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\axe_of_rage_s2[epyx_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bad_dudes_vs_dragon_ninja[data_east_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bad_dudes_vs_dragon_ninja[data_east_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bad_dudes_vs_dragon_ninja[data_east_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\ball-blasta[zeppelin_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\barbarian[melbourne_house_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\barbarian_ii_s1[palace_1988](pal)(cyan2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\barbarian_ii_s2[palace_1988](pal)(cyan2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_iii_s1_boot[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_iii_s2_char[ea_interplay_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_iii_s3_dungeon1[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_iii_s4_dungeon2[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\basket_manager[simulmondo_1988](pal)(bad-t7s18).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\batman[data_east_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\batman[ocean_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\batman[ocean_1988](pal)(alt1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battleship[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battles_of_napolean_s1[ssi_1988](v1_1)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battles_of_napolean_s2[ssi_1988](v1_1)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battles_of_napolean_s3[ssi_1988](v1_1)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battles_of_napoleon_scenario_1[ssi_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battles_of_napoleon_scenario_2[ssi_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_island[novagen_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_stations{aligate_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\better_dead_than_alien[elektra_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\beyond_the_ice_palace[elite_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\big_blue_reader_64[sogwap_1988](v2_00).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bingo_construction_kit[box_office_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bionic_commando[capcom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bionic_commando[capcom_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\black_lamp[firebird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\black_lamp[rainbird_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\block_busters[tv_games_1988](para_protect).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\blood_brothers[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bob_moran_rittertum[infogrames_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bob_moran_science_fiction[infogrames_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bombuzal[mirrorsoft_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\boot_camp[konami_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bozuma_s1[rainbow_arts_1988](german)(pal)(r1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bozuma_s2[rainbow_arts_1988](german)(pal)(r1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bozuma_s3[rainbow_arts_1988](german)(pal)(r1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bozuma_s4[rainbow_arts_1988](german)(pal)(r1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bubble_bobble[taito_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bubble_bobble[taito_1988](vmax3)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bubble_ghost[accolade_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bubble_ghost[eri_informatique_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bubble_ghost[eri_informatique_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cabal[capcom_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\california_raisins_s1[box_office_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\california_raisins_s1[box_office_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\california_raisins_s2[box_office_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\california_raisins_s2[box_office_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\candy_land_s1[gametek_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\candy_land_s2[gametek_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_blood[ere_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_blood[ere_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_blood[ere_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_blood[ere_1988](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_blood[ere_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_blood[mindscape_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_power[box_office_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\card_sharks_s1[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\card_sharks_s1[sharedata_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\card_sharks_s2[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\caveman_ugh-lympics_s1[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\caveman_ugh-lympics_s2[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\caveman_ugh-lympics_s3[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\caveman_ugh-lympics_s4[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chase_on_tom_sawyers_island[hitech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chernobyl[cosmi_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chernobyl[cosmi_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2100_s1[software_toolworks_1988](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2100_s1[software_toolworks_1988](multi_density)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2100_s1[software_toolworks_1988](patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2100_s2[software_toolworks_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chopper_commander[zeppelin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\circus_games[keypunch_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\circus_games_s1[tynesoft_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\circus_games_s2[tynesoft_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\classic_concentration_s1[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\classic_concentration_s2[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\clubhouse_sports_s1[mindscape_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\clubhouse_sports_s2[mindscape_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\color_64_bbs_s1[pfountz_1988](v7_3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\color_64_bbs_s2[pfountz_1988](v7_3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\color_64_bbs_s3[pfountz_1988](v7_3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\color_64_bbs_s4[pfountz_1988](v7_3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\combat_zone[keypunch_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\computer_classics_s1[beau_jolly_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\computer_classics_s2[beau_jolly_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\computer_maniacs_diary_1989[led_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\contra[konami_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64[central_point_1988](v3_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64[central_point_1988](v3_3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64_s1[central_point_1988](v4_0)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64_s1[central_point_1988](v4_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64_s2[central_point_1988](v4_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\corruption_s1[magnetic_scrolls_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\corruption_s2[magnetic_scrolls_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crossbow_s1[absolute_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cybernoid[hewson_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cybernoid_ii[hewson_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\daley_thompsons_olympic_challenge_s1[ocean_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\daley_thompsons_olympic_challenge_s1[ocean_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\daley_thompsons_olympic_challenge_s2[ocean_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\daley_thompsons_olympic_challenge_s2[ocean_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\danger_freak[rainbow_arts_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\danger_freak[rainbow_arts_1988](pal)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\danger_freak[rainbow_arts_1988](pal)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dan_dare_ii[virgin_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dark_fusion[gremlin_1988](cyan2)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dark_side[incentive_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\death_sword_s1[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\death_sword_s1[epyx_1988](maxx-out_promo_copy).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\death_sword_s2[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\death_sword_s2[epyx_1988](maxx-out_promo_copy).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\decisive_battles_of_american_civil_war_vol_iii[ssg_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\decisive_battles_of_american_civil_war_vol_ii[ssg_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deflektor[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demons_winter_s1[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demons_winter_s1[ssi_1988](v1_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demons_winter_s2[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demons_winter_s2[ssi_1988](v1_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demons_winter_s3[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demons_winter_s3[ssi_1988](v1_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\denaris_s1[rainbow_arts_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\denaris_s2[rainbow_arts_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\designasaurus_s1[britannica_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\designasaurus_s2[britannica_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\devon_aire[epyx_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diamond[destiny_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\die_erbshaft[infogrames_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dive_bomber[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dive_bomber[epyx_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\double_dare_s1[gametek_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\double_dare_s2[gametek_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\double_dare_s2[gametek_1988](alt1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\double_dragon[mastertronic_1988](ad)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\double_dragon[mastertronic_1988](to)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\downhill_challenge[br0derbund_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dream_warrior[us_gold_1988](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dropzone[microdaft_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dungeon_masters_assistant_vol1_disk3[ssi_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dungeon_masters_assistant_vol1_encounters[ssi_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dungeon_masters_assistant_vol1_monster[ssi_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dungeon_masters_assistant_vol1_program[ssi_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dynamite_dux_s1[activision_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dynamite_dux_s1[activision_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dynamite_dux_s2[activision_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dynamite_dux_s2[activision_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\easy_working_writer[spinnaker_1988](v2_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\electric_crayon_deluxe_holidays_and_seasons[polarware_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\eliminator[hewson_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\elite[firebird_1988](pal)(german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\elite_gold[firebird_1988](pal)(german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\emerald_mine_2[kingsoft_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\emlyn_hughes_international_soccer[audiogenic_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\empire_wargame_of_the_century_s1[interstel_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\empire_wargame_of_the_century_s2[interstel_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\energy_warrior[mastertronic_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\european_five-a-side[silverbird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\eye[cascade_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s1[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s1[activision_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s2[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s2[activision_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s3[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s3[activision_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s3[activision_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s4[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s4[activision_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f18_hornet[absolute_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\faery_tale_adventure_s1_boot[microillusions_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\faery_tale_adventure_s2_disk_a[microillusions_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\faery_tale_adventure_s3_disk_b[microillusions_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_break[accolade_1988](rl7)(ntsc)(alt1)(working).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_break[accolade_1988](rl7)(ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_break[accolade_1988](rl7)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_break[accolade_1988](rl7)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_hack_em[basement_boys_1988](v6_00).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_hack_em_128[basement_boys_1988](v6_00).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_hack_em_parms[basement_boys_1988](v6_00)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fernandez_must_die[mirrorsoft_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\final_assault[epyx_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\final_assault[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\final_blow[taito_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\final_blow[taito_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\firefly_s1[ocean_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\firefly_s2[ocean_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\firezone[pss_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fire_storm[omnisoft_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fish_s1[magnetic_scrolls_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fish_s2[magnetic_scrolls_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fist_plus[firebird_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\flintstones[grandslam_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\flintstones[grandslam_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fox_fights_back[image_works_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_over[dinamic_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_over_ii[dinamic_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamma_force_s1[infocom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamma_force_s1[infocom_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamma_force_s2[infocom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\garrison[rainbow_arts_1988](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.5_apps[berkeley_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.5_apps[berkeley_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.5_system[berkeley_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.5_system[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_128_2_0_s1_system[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_128_2_0_s2_demo[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_128_2_0_s3_backup[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_128_2_0_s4_apps[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_128_2_0_s5_write_utils[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_128_2_0_s6_geospell[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_2.0_apps[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_2.0_backup[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_2.0_demo[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_2.0_geospell[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_2.0_write_utils[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\golf-krise[multisoft_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graffiti_man[rainbow_arts_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graffiti_man[rainbow_arts_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grand_prix_circuit[accolade_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grand_prix_circuit[accolade_1988](ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grand_prix_circuit[accolade_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grand_prix_circuit[accolade_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\guerrilla_war[imagine_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hawkeye_s1[thalamus_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hawkeye_s2[thalamus_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hawkeye_s2[thalamus_1988](pal)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heavy_metal_s1[access_1988](v1)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heavy_metal_s1[access_1988](v1)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heavy_metal_s1[access_1988](v1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heavy_metal_s1[access_1988](v3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heavy_metal_s2[access_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hellfire[martech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hercules[cygnus_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s1[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s2[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s3[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s4[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s5[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s6[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s7[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hollywood_squares_s1[gametek_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hollywood_squares_s2[gametek_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\home_video_producer_s1[epyx_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\home_video_producer_s1[epyx_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\home_video_producer_s2[epyx_1988](alt)(bad-t9s0-t14s20-t16s0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\home_video_producer_s2[epyx_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\honeymooners_s1[first_run_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\honeymooners_s2[first_run_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_rod_s1[sega_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_shot[addictive_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_shot[addictive_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_shot[addictive_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\ikari_warriors[elite_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indiana_jones_temple_of_doom[mindscape_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indiana_jones_temple_of_doom[mindscape_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indiana_jones_temple_of_doom[mindscape_1988](vmax3)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indiana_jones_temple_of_doom[us_gold_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\inspector_gadget[melbourne_house_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\international_soccer[crl_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\international_soccer[crl_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\io[firebird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\its_a_kind_of_magic_s1[magic_bytes_1988](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\its_a_kind_of_magic_s2[magic_bytes_1988](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jack_nicklaus_golf_s1[accolade_1988](manual)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jack_nicklaus_golf_s2[accolade_1988](manual)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeopardy_new_second_edition_s1[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeopardy_new_second_edition_s2[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeopardy_new_sports_edition_s1[sharedata_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeopardy_new_sports_edition_s2[sharedata_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet_boys[avantage_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet_boys[avantage_1988](ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet_boys[avantage_1988](ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet_boys[avantage_1988](ntsc)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jocky_wilsons_darts_challenge[zeppelin_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\john_elways_quarterback[melbourne_house_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\john_elways_quarterback[melbourne_house_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jordan_vs_bird_s1[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jordan_vs_bird_s2[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jr_pac-man[thunder_mtn_1988](vmax3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\battles_of_napolean_s1[ssi_1988](v1_0)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\battles_of_napolean_s2[ssi_1988](v1_0)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\battles_of_napolean_s3[ssi_1988](v1_0)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\copy_ii_64[central_point_1988](v3_4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\disk-invader_s1[avantgarde64_1988](v9_9).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\disk-invader_s2[avantgarde64_1988](v9_9).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\fast_hack_em[basement_boys_1988](v6_04).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\fast_hack_em[basement_boys_1988](v9_0a).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\hercules[cygnus_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\hot_rod_s2[sega_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karnov[data_east_1988](ntsc)(newer)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karnov[data_east_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karnov_s1[electric_dreams_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karnov_s2[electric_dreams_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\katakis_s1[rainbow_arts_1988](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\katakis_s1[rainbow_arts_1988](r1)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\katakis_s2[rainbow_arts_1988](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\katakis_s2[rainbow_arts_1988](r1)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kayden_garth[eas_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kings_of_the_beach_s1[ea_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kings_of_the_beach_s2[ea_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kracker_jax_vol7[kjpb_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kracker_jax_vol7[kjpb_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\lancelot_s1[level9_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\lancelot_s2[level9_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lancelot_s1[datasoft_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lancelot_s2[datasoft_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lane_mastadon_s1[infocom_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lane_mastadon_s1[infocom_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lane_mastadon_s2[infocom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lane_mastodon_s1[infocom_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lane_mastodon_s2[infocom_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_duel[capcom_1988](pal)(cyan2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_duel[capcom_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s1[activision_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s1[system_1988](pal)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s1[system_1988](pal)(alt2)(noprot)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s1[system_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s2[activision_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s2[system_1988](pal)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s2[system_1988](pal)(alt2)(noprot).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s2[system_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\la_crackdown_s1[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\la_crackdown_s1[epyx_1988](patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\la_crackdown_s2[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_famous_course_iii_s1[access_1988](dongle).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_famous_course_iii_s2[access_1988](dongle).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s1[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s1[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s2[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s2[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s3[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s3[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s4[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s4[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\macarthurs_war_battle_for_korea[ssg_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\macarthurs_war_battle_for_korea[ssg_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\magnetron[firebird_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mainframe[microillusions_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mainframe[microillusions_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mars_saga_s1[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mars_saga_s2[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mars_saga_s2[ea_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mars_saga_s2[ea_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\matterhorn_screamer[disney_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\matterhorn_screamer[disney_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mega_play_vol1_s1[mastertronic_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mega_play_vol1_s2[mastertronic_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mega_play_vol1_s2[mastertronic_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\menace_s1[psyclapse_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\menace_s2[psyclapse_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\metaplex[prism_leisure_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\metaplex[prism_leisure_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\metro_cross[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\microprose_soccer[microprose_1988](comp)(budget)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\microprose_soccer_european[microprose_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\microprose_soccer_indoor[microprose_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_baseball-box_score-stat_compiler[micro_league_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_baseball-box_score-stat_compiler[micro_league_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s1_hogan_vs_savage[microprose_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s1_hogan_vs_savage[microprose_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s2_hogan_vs_orndorff[microprose_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s2_hogan_vs_orndorff[microprose_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s3_superstars_1[microprose_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s4_superstars_2[microprose_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s5_superstars_3[microprose_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s6_superstars_4[microprose_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_mud_s1[virgin_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_mud_s1[virgin_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_mud_s2[virgin_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_mud_s2[virgin_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mindfighter[abstract_concepts_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mindroll[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini-golf[magic_bytes_1988](shorter_sync_check)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\modem_wars[ea_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\monopoly_deluxe[leisure_genius_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\monopoly_deluxe[leisure_genius_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\morpheus[rainbird_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\morpheus[rainbird_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\morpheus[rainbird_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\motor_massacre[gremlin_1988](house_mix)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\ms_pac-man[thunder_mtn_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\ms_pacman[thunder_mtn_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\muncher_eats_chewits[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\murder_on_the_atlantic[intracorp_1988](v1_1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nav_com_6[cosmi_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nav_com_6[cosmi_1988](v3)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nav_com_6[cosmi_1988](v3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\netherworld[hewson_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\netherworld[hewson_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s1[interplay_1988](alt1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s1[interplay_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s1[interplay_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s1[interplay_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s2[interplay_1988](alt1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s2[interplay_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s2[interplay_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s3[interplay_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s3[interplay_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s4[interplay_1988](alt1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s4[interplay_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\night_raider[gremlin_1988](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\ninja_scooter_simulator[silverbird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nippon_s1[markt_technik_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nippon_s2[markt_technik_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nippon_s3[markt_technik_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nippon_s4[markt_technik_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nurse[free_spirit_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\ocean_ranger_s1[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\ocean_ranger_s2[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_feuersturm_s1[markt_technik_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_feuersturm_s2[markt_technik_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_wolf[ocean_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_wolf[taito_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_wolf[taito_1988](vmax3)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_wolf[taito_1988](vmax3)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\out_run_s1[us_gold_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\out_run_s2[us_gold_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pac-land[grandslam_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pac-man[thunder_mtn_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pacmania[grandslam_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\para_assault_course[zeppelin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\partyware_s1[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\partyware_s2[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pharoahs_revenge_s1[software_intl_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pharoahs_revenge_s2[software_intl_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pink_panther[magic_bytes_1988](kind_of_magic_collection)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\planetfall_s1[infocom_1988](r10).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\planetfall_s2[infocom_1988](r10).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\platou[kingsoft_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pocket_rockets[capcom_1988](ntsc)(cc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pocket_rockets[capcom_1988](ntsc)(pr).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pocket_rockets[capcom_1988](ntsc)(pr-alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pole_position_ii[mindscape_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pole_position_ii[mindscape_1988](vmax3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s1[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s1[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s2[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s2[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s3[ssi_1988](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s3[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s4[ssi_1988](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s4[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s5[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s5[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s6[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s6[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s7[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s7[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s7[ssi_1988](v1_1)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s8[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s8[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s8[ssi_1988](v1_1)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\powerplay_hockey[ea_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\powerplay_hockey[ea_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_pack_s1[melody_hall_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_pack_s1[melody_hall_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_pack_s2[melody_hall_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_pack_s2[melody_hall_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\predator_s1[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\predator_s2[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\president_elect_1988[ssi_1988](v2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\president_elect_1988[ssi_1988](v2)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\press_your_luck_s1[gametek_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\press_your_luck_s2[gametek_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\professional_ski_simulator[codemasters_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_firestart_s1[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_firestart_s2[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_firestart_s3[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_firestart_s4[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psycho_s1[box_office_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psycho_s2[box_office_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_football[software_sim_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_football[software_sim_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_football_1986_teams[software_sim_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\qix_s1[taito_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\qix_s1[taito_1988](vmax3)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\qix_s2[taito_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questron_ii_s1[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questron_ii_s1[ssi_1988](v1_2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questron_ii_s2[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questron_ii_s2[ssi_1988](v1_2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\r-type_s1[electric_dreams_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\r-type_s2[electric_dreams_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rack_em[accolade_1988](rl7)(ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rack_em[accolade_1988](rl7)(ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rack_em[accolade_1988](rl7)(ntsc)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rack_em[accolade_1988](rl7)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rack_em[accolade_1988](rl7)(pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rack_em[accolade_1988](rl7)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rambo_iii_s1[ocean_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rambo_iii_s2[ocean_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rampage[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rampage[activision_1988](power_hits)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rampage[activision_1988](power_hits)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rastan[taito_1988](vmax3)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rastan[taito_1988](vmax3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\raw_recruit[mastertronic_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt7).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt8).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt7).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt8).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_self_running_demo[microprose_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade[taito_1988](vmax3)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade[taito_1988](vmax3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_parms_1[kjpb_1988](v1_10).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_s1_program[kjpb_1988](v1_02).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_s1_program[kjpb_1988](v2_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_s1_program[kjpb_1988](v2_02).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_s2_upgrades[kjpb_1988](v1_02).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_s2_upgrades[kjpb_1988](v2_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_s2_upgrades[kjpb_1988](v2_02).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\revenge_of_defender[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\ringwars[cascade_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_raiders[mindscape_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_runner[mindscape_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_runner[mindscape_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_warrior[crl_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_wars[arcadia_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_wars[arcadia_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s1[cinemaware_1988](vmax2c)(ntsc)(newer)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s1[cinemaware_1988](vmax2c)(ntsc)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s1[cinemaware_1988](vmax2c)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s1[cinemaware_1988](vmax2c)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s2[cinemaware_1988](vmax2c)(ntsc)(newer)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s2[cinemaware_1988](vmax2c)(ntsc)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s2[cinemaware_1988](vmax2c)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s2[cinemaware_1988](vmax2c)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s3[cinemaware_1988](vmax2c)(ntsc)(newer)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s3[cinemaware_1988](vmax2c)(ntsc)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s3[cinemaware_1988](vmax2c)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s3[cinemaware_1988](vmax2c)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s4[cinemaware_1988](vmax2c)(ntsc)(newer)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s4[cinemaware_1988](vmax2c)(ntsc)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s4[cinemaware_1988](vmax2c)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s4[cinemaware_1988](vmax2c)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rockford[arcadia_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\roll-a-word[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rollerboard[kingsoft_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rommel[ssg_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\salamander[imagine_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\samurai_warrior[firebird_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\santa_paravia[keypunch_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\savage_s1[firebird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\savage_s1[microplay_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\savage_s2[firebird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\savage_s2[microplay_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\scotch_olympia_quiz[scotch_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\serve_and_volley[accolade_1988](rl7)(ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\serve_and_volley[accolade_1988](rl7)(ntsc)(bb-patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\serve_and_volley[accolade_1988](rl7)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\serve_and_volley[accolade_1988](rl7)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sesame_street_letter_go_round[hi-tech_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sesame_street_print_kit_s1[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sesame_street_print_kit_s2[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\seuck_s1[sensible_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\seuck_s2[sensible_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shackled[us_gold_1988](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sid_symphony-stereo_sid_music_collection_s1[cmd_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sid_symphony-stereo_sid_music_collection_s2[cmd_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silk_worm[sales_curve_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skate_crazy[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skate_crazy[mastertronic_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sky_shark[taito_1988](vmax3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sky_travel[microillusions_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\slam_dunk[mastertronic_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\slayer[hewson_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\soldier_of_fortune[firebird_1988](german)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\space_academy[elite_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\space_station_oblivion[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spartacus_the_swordslayer[players_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sporting_news_baseball[epyx_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sporting_news_baseball[epyx_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sporting_news_baseball[epyx_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sporting_news_baseball[epyx_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sports_a_roni_s1[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sports_a_roni_s2[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\starquake[sharedata_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_empire[first_row_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek-the_rebel_universe[simon_schuster_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_wars[br0derbund_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_wars[domark_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_wars[tengen_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_wars[tengen_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\steel_thunder[accolade_1988](rl7)(ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\steel_thunder[accolade_1988](rl7)(ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\steel_thunder[accolade_1988](rl7)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\steel_thunder[accolade_1988](rl7)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\stir_crazy_featuring_bobo[infogrames_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\stocker[capcom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\storm_warrior[elite_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_fighter[capcom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_fighter[capcom_1988](alt)(no_protection)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_sports_football_s1[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_sports_football_s2[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_sports_soccer[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_sports_soccer[epyx_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\st_pauli[svs_1988](german)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\subterranea[rack-it_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_challenge_s1[thunder_mtn_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_challenge_s2[thunder_mtn_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_olympiad_s1[tynesoft_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_olympiad_s2[tynesoft_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman_man_of_steel_s1[first_star_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman_man_of_steel_s1[first_star_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman_man_of_steel_s2[first_star_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman_man_of_steel_s2[first_star_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman_man_of_steel_s3[first_star_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman_man_of_steel_s3[first_star_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\supersports_s1[gremlin_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\supersports_s2[gremlin_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_pac-man[thunder_mtn_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_password_s1[gametek_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_password_s1[gametek_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_password_s2[gametek_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_ski[microids_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_ski[microids_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\supreme_challenge_s1[beau_jolly_1988](comp).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\supreme_challenge_s2[beau_jolly_1988](comp).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\swift_desktop_publishing[cosmi_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\takedown_s1[activision_1988](vmax2c).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\takedown_s2[activision_1988](vmax2c).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tanium[players_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tank_attack[artworx_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\technocop_s1[gremlin_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\technocop_s1[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\technocop_s2[gremlin_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\technocop_s2[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\terrafighter[zeppelin_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\terrafighter[zeppelin_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\terramex_s1[grandslam_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\terramex_s2[grandslam_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thalamus_hits_1986-1988_s1[thalamus_1989](delta-sanxion).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thalamus_hits_1986-1988_s2[thalamus_1989](hunters_moon-quedex).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_corporation[activision_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_deep[us_gold_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_empire_strikes_back[domark_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_fury[martech_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s1[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s1[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s1[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s2[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s2[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s2[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s3[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s3[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s3[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s1[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s1[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s1[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s2[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s2[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s2[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s3[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s3[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s3[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s1[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s2[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s3[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s4[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s5[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s6[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s7[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s8[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s1[cosmi_1988](manual)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s1[cosmi_1988](manual)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s1[cosmi_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s2[cosmi_1988](manual)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s2[cosmi_1988](manual)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s2[cosmi_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s3[cosmi_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s3[cosmi_1988](manual)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s4[cosmi_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s4[cosmi_1988](manual)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_vindicator[imagine_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thud_ridge[acme_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunderblade[us_gold_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](paraprotect)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt7).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\time_and_magik_s1[datasoft_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\time_and_magik_s2[datasoft_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\time_fighter[crl_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\time_fighter[crl_1988](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tko[accolade_1988](rl7)(ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tko[accolade_1988](rl7)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tko[accolade_1988](rl7)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tower_toppler[epyx_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\traz[cascade_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\triango[california_dreams_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trilogy[mastertronic_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_a_new_beginning_s1[domark_1988](german)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_a_new_beginning_s2[domark_1988](german)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_genus_edition_s1[domark_1988](german)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_genus_edition_s2[domark_1988](german)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\troll[palace_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trump_castle_s1[capstone_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trump_castle_s2[capstone_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s1_pacific[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s1_pacific[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s2_asia[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s2_asia[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s3_europe[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s3_europe[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s4[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s4[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_s1[imagine_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_s2[imagine_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s1_program[origin_1988](63).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s1_program[origin_1988](aa)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s1_program[origin_1988](aa)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s2_dungeon[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s3_britannia[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s4_underworld[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s4_underworld[origin_1988](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s5_towne[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s6_dwelling[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s7_castle[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s8_keep[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s8_keep[origin_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultrabyte_5_s1[ultrabyte_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultrabyte_5_s2[ultrabyte_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultrabyte_5_s3[ultrabyte_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\uninvited_s1[mindscape_1988](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\uninvited_s2[mindscape_1988](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\us_geography_facts[aec_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vampires_empire[magic_bytes_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vigilante[data_east_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vixen[martech_1988](pal)(paraprotect_v2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\volleyball_simulator[time_warp_1988](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\volleyball_simulator[time_warp_1988](r1)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\warhawk-caverns_of_eriban[firebird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\warlock[three_sixty_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wasteland_s1[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wasteland_s2[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wasteland_s3[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wasteland_s4[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wec_lemans[imagine_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wheel_of_fortune_new_2nd_edition[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wheel_of_fortune_new_3rd_edition[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\where_in_europe_is_carmen_sandiego_s1[br0derbund_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\where_in_europe_is_carmen_sandiego_s2[br0derbund_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\who_framed_roger_rabbit_s1[buena_vista_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\who_framed_roger_rabbit_s2[buena_vista_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\willow_s1[mindscape_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\willow_s2[mindscape_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\willow_s3[mindscape_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\willow_s4[mindscape_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_challenge_s1[thunder_mtn_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_challenge_s2[thunder_mtn_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_olympiad_88_s1[tynesoft_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_olympiad_88_s1[tynesoft_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_olympiad_88_s2[tynesoft_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_olympiad_88_s2[tynesoft_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s1[hi-tech_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s1[hi-tech_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s1[hi-tech_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s1[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s2[hi-tech_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s2[hi-tech_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s2[hi-tech_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s2[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wishbringer_s1[infocom_1988](r23)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wishbringer_s2[infocom_1988](r23)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_v_heart_of_the_maelstrom_boot[sirtech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_v_heart_of_the_maelstrom_disk_a[sirtech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_v_heart_of_the_maelstrom_disk_b[sirtech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_v_heart_of_the_maelstrom_disk_c[sirtech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_v_heart_of_the_maelstrom_disk_d[sirtech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_v_heart_of_the_maelstrom_disk_e[sirtech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizards_lair[prism_leisure_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\y\yuppis_revenge[ariolasoft_1988](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\y\yuppis_revenge[ariolasoft_1988](german)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_boot[activision_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_boot[activision_1988](manual)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s1[activision_1988](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s1[activision_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s1[activision_1988](manual)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s2[activision_1988](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s2[activision_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s2[activision_1988](manual)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s3[activision_1988](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zamzara[hewson_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zoom[discovery_1988](vmax3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zork_quest_i_assault_on_egreth_castle_s1[infocom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zork_quest_i_assault_on_egreth_castle_s2[infocom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zybex[zeppelin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\1943[capcom_1988](ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\1943[capcom_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\19_part_1_boot_camp_s1[cascade_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\19_part_1_boot_camp_s2[cascade_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\2_on_one[mastertronic_1988](la_swat-panther)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\3_on_1[mastertronic_1988](darts-pool-snooker).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4th_and_inches_team_construction[accolade_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4x4_offroad_racing_s1[epyx_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4x4_offroad_racing_s1[epyx_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4x4_offroad_racing_s2[epyx_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4x4_offroad_racing_s2[epyx_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\5th_gear[hewson_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\720_s1[mindscape_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\720_s2[mindscape_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\abyss[kingsoft_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\addictaball[alligata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\addictaball[alligata_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\advanced_tactical_fighter[digital_integration_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\afterburner[activision_1988](arcade_champions)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\afterburner[activision_sega_1988](para-v2)(pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\afterburner[activision_sega_1988](para-v2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\aiginas_prophecy[vic_tokai_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alcon[taito_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alcon[taito_1988](vmax3)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alcon[taito_1988](vmax3)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alf[box_office_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\altered_beast_s1[activision_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\altered_beast_s2[activision_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\altered_beast_s2[activision_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\apache_strike[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s1[br0derbund_1988](vmax0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s1[br0derbund_1988](vmax0)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s1[br0derbund_1988](vmax0)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s1[br0derbund_1988](vmax0)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s2[br0derbund_1988](vmax0)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s2[br0derbund_1988](vmax0)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s2[br0derbund_1988](vmax0)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s2[br0derbund_1988](vmax0)(alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s2[br0derbund_1988](vmax0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s3[br0derbund_1988](vmax0)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s3[br0derbund_1988](vmax0)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s3[br0derbund_1988](vmax0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s4[br0derbund_1988](vmax0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_game_construction_kit_s4[br0derbund_1988](vmax0)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arkanoid[imagine_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arkanoid[imagine_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arkanoid_ii[taito_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\armalyte_s1[thalamus_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\armalyte_s2[thalamus_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\artura[arcadia_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\artura[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\atomic_robo-kid_s1[activision_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\atomic_robo-kid_s2[activision_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\atomic_robo-kid_s2[activision_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\awardware_new_graphics_disk[hi-tech_expressions_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\axe_of_rage_s1[epyx_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\axe_of_rage_s2[epyx_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bad_dudes_vs_dragon_ninja[data_east_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bad_dudes_vs_dragon_ninja[data_east_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bad_dudes_vs_dragon_ninja[data_east_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\ball-blasta[zeppelin_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\barbarian[melbourne_house_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\barbarian_ii_s1[palace_1988](pal)(cyan2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\barbarian_ii_s2[palace_1988](pal)(cyan2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_iii_s1_boot[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_iii_s2_char[ea_interplay_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_iii_s3_dungeon1[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_iii_s4_dungeon2[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\basket_manager[simulmondo_1988](pal)(bad-t7s18).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\batman[data_east_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\batman[ocean_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\batman[ocean_1988](pal)(alt1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battleship[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battles_of_napolean_s1[ssi_1988](v1_1)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battles_of_napolean_s2[ssi_1988](v1_1)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battles_of_napolean_s3[ssi_1988](v1_1)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battles_of_napoleon_scenario_1[ssi_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battles_of_napoleon_scenario_2[ssi_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_island[novagen_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_stations{aligate_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\better_dead_than_alien[elektra_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\beyond_the_ice_palace[elite_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\big_blue_reader_64[sogwap_1988](v2_00).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bingo_construction_kit[box_office_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bionic_commando[capcom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bionic_commando[capcom_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\black_lamp[firebird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\black_lamp[rainbird_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\block_busters[tv_games_1988](para_protect).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\blood_brothers[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bob_moran_rittertum[infogrames_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bob_moran_science_fiction[infogrames_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bombuzal[mirrorsoft_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\boot_camp[konami_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bozuma_s1[rainbow_arts_1988](german)(pal)(r1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bozuma_s2[rainbow_arts_1988](german)(pal)(r1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bozuma_s3[rainbow_arts_1988](german)(pal)(r1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bozuma_s4[rainbow_arts_1988](german)(pal)(r1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bubble_bobble[taito_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bubble_bobble[taito_1988](vmax3)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bubble_ghost[accolade_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bubble_ghost[eri_informatique_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bubble_ghost[eri_informatique_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cabal[capcom_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\california_raisins_s1[box_office_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\california_raisins_s1[box_office_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\california_raisins_s2[box_office_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\california_raisins_s2[box_office_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\candy_land_s1[gametek_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\candy_land_s2[gametek_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_blood[ere_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_blood[ere_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_blood[ere_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_blood[ere_1988](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_blood[ere_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_blood[mindscape_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_power[box_office_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\card_sharks_s1[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\card_sharks_s1[sharedata_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\card_sharks_s2[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\caveman_ugh-lympics_s1[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\caveman_ugh-lympics_s2[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\caveman_ugh-lympics_s3[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\caveman_ugh-lympics_s4[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chase_on_tom_sawyers_island[hitech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chernobyl[cosmi_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chernobyl[cosmi_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2100_s1[software_toolworks_1988](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2100_s1[software_toolworks_1988](multi_density)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2100_s1[software_toolworks_1988](patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2100_s2[software_toolworks_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chopper_commander[zeppelin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\circus_games[keypunch_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\circus_games_s1[tynesoft_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\circus_games_s2[tynesoft_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\classic_concentration_s1[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\classic_concentration_s2[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\clubhouse_sports_s1[mindscape_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\clubhouse_sports_s2[mindscape_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\color_64_bbs_s1[pfountz_1988](v7_3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\color_64_bbs_s2[pfountz_1988](v7_3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\color_64_bbs_s3[pfountz_1988](v7_3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\color_64_bbs_s4[pfountz_1988](v7_3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\combat_zone[keypunch_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\computer_classics_s1[beau_jolly_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\computer_classics_s2[beau_jolly_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\computer_maniacs_diary_1989[led_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\contra[konami_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64[central_point_1988](v3_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64[central_point_1988](v3_3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64_s1[central_point_1988](v4_0)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64_s1[central_point_1988](v4_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64_s2[central_point_1988](v4_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\corruption_s1[magnetic_scrolls_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\corruption_s2[magnetic_scrolls_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crossbow_s1[absolute_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cybernoid[hewson_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cybernoid_ii[hewson_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\daley_thompsons_olympic_challenge_s1[ocean_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\daley_thompsons_olympic_challenge_s1[ocean_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\daley_thompsons_olympic_challenge_s2[ocean_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\daley_thompsons_olympic_challenge_s2[ocean_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\danger_freak[rainbow_arts_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\danger_freak[rainbow_arts_1988](pal)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\danger_freak[rainbow_arts_1988](pal)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dan_dare_ii[virgin_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dark_fusion[gremlin_1988](cyan2)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dark_side[incentive_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\death_sword_s1[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\death_sword_s1[epyx_1988](maxx-out_promo_copy).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\death_sword_s2[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\death_sword_s2[epyx_1988](maxx-out_promo_copy).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\decisive_battles_of_american_civil_war_vol_iii[ssg_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\decisive_battles_of_american_civil_war_vol_ii[ssg_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deflektor[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demons_winter_s1[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demons_winter_s1[ssi_1988](v1_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demons_winter_s2[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demons_winter_s2[ssi_1988](v1_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demons_winter_s3[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demons_winter_s3[ssi_1988](v1_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\denaris_s1[rainbow_arts_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\denaris_s2[rainbow_arts_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\designasaurus_s1[britannica_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\designasaurus_s2[britannica_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\devon_aire[epyx_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diamond[destiny_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\die_erbshaft[infogrames_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dive_bomber[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dive_bomber[epyx_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\double_dare_s1[gametek_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\double_dare_s2[gametek_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\double_dare_s2[gametek_1988](alt1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\double_dragon[mastertronic_1988](ad)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\double_dragon[mastertronic_1988](to)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\downhill_challenge[br0derbund_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dream_warrior[us_gold_1988](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dropzone[microdaft_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dungeon_masters_assistant_vol1_disk3[ssi_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dungeon_masters_assistant_vol1_encounters[ssi_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dungeon_masters_assistant_vol1_monster[ssi_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dungeon_masters_assistant_vol1_program[ssi_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dynamite_dux_s1[activision_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dynamite_dux_s1[activision_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dynamite_dux_s2[activision_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dynamite_dux_s2[activision_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\easy_working_writer[spinnaker_1988](v2_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\electric_crayon_deluxe_holidays_and_seasons[polarware_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\eliminator[hewson_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\elite[firebird_1988](pal)(german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\elite_gold[firebird_1988](pal)(german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\emerald_mine_2[kingsoft_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\emlyn_hughes_international_soccer[audiogenic_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\empire_wargame_of_the_century_s1[interstel_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\empire_wargame_of_the_century_s2[interstel_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\energy_warrior[mastertronic_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\european_five-a-side[silverbird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\eye[cascade_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s1[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s1[activision_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s2[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s2[activision_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s3[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s3[activision_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s3[activision_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s4[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f14_tomcat_s4[activision_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\f18_hornet[absolute_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\faery_tale_adventure_s1_boot[microillusions_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\faery_tale_adventure_s2_disk_a[microillusions_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\faery_tale_adventure_s3_disk_b[microillusions_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_break[accolade_1988](rl7)(ntsc)(alt1)(working).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_break[accolade_1988](rl7)(ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_break[accolade_1988](rl7)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_break[accolade_1988](rl7)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_hack_em[basement_boys_1988](v6_00).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_hack_em_128[basement_boys_1988](v6_00).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_hack_em_parms[basement_boys_1988](v6_00)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fernandez_must_die[mirrorsoft_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\final_assault[epyx_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\final_assault[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\final_blow[taito_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\final_blow[taito_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\firefly_s1[ocean_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\firefly_s2[ocean_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\firezone[pss_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fire_storm[omnisoft_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fish_s1[magnetic_scrolls_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fish_s2[magnetic_scrolls_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fist_plus[firebird_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\flintstones[grandslam_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\flintstones[grandslam_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fox_fights_back[image_works_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_over[dinamic_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_over_ii[dinamic_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamma_force_s1[infocom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamma_force_s1[infocom_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamma_force_s2[infocom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\garrison[rainbow_arts_1988](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.5_apps[berkeley_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.5_apps[berkeley_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.5_system[berkeley_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.5_system[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_128_2_0_s1_system[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_128_2_0_s2_demo[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_128_2_0_s3_backup[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_128_2_0_s4_apps[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_128_2_0_s5_write_utils[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_128_2_0_s6_geospell[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_2.0_apps[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_2.0_backup[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_2.0_demo[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_2.0_geospell[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_2.0_write_utils[berkeley_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\golf-krise[multisoft_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graffiti_man[rainbow_arts_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graffiti_man[rainbow_arts_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grand_prix_circuit[accolade_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grand_prix_circuit[accolade_1988](ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grand_prix_circuit[accolade_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grand_prix_circuit[accolade_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\guerrilla_war[imagine_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hawkeye_s1[thalamus_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hawkeye_s2[thalamus_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hawkeye_s2[thalamus_1988](pal)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heavy_metal_s1[access_1988](v1)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heavy_metal_s1[access_1988](v1)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heavy_metal_s1[access_1988](v1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heavy_metal_s1[access_1988](v3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heavy_metal_s2[access_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hellfire[martech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hercules[cygnus_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s1[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s2[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s3[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s4[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s5[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s6[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_sensation_s7[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hollywood_squares_s1[gametek_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hollywood_squares_s2[gametek_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\home_video_producer_s1[epyx_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\home_video_producer_s1[epyx_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\home_video_producer_s2[epyx_1988](alt)(bad-t9s0-t14s20-t16s0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\home_video_producer_s2[epyx_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\honeymooners_s1[first_run_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\honeymooners_s2[first_run_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_rod_s1[sega_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_shot[addictive_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_shot[addictive_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_shot[addictive_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\ikari_warriors[elite_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indiana_jones_temple_of_doom[mindscape_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indiana_jones_temple_of_doom[mindscape_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indiana_jones_temple_of_doom[mindscape_1988](vmax3)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indiana_jones_temple_of_doom[us_gold_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\inspector_gadget[melbourne_house_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\international_soccer[crl_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\international_soccer[crl_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\io[firebird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\its_a_kind_of_magic_s1[magic_bytes_1988](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\its_a_kind_of_magic_s2[magic_bytes_1988](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jack_nicklaus_golf_s1[accolade_1988](manual)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jack_nicklaus_golf_s2[accolade_1988](manual)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeopardy_new_second_edition_s1[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeopardy_new_second_edition_s2[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeopardy_new_sports_edition_s1[sharedata_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeopardy_new_sports_edition_s2[sharedata_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet_boys[avantage_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet_boys[avantage_1988](ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet_boys[avantage_1988](ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet_boys[avantage_1988](ntsc)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jocky_wilsons_darts_challenge[zeppelin_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\john_elways_quarterback[melbourne_house_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\john_elways_quarterback[melbourne_house_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jordan_vs_bird_s1[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jordan_vs_bird_s2[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jr_pac-man[thunder_mtn_1988](vmax3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\battles_of_napolean_s1[ssi_1988](v1_0)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\battles_of_napolean_s2[ssi_1988](v1_0)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\battles_of_napolean_s3[ssi_1988](v1_0)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\copy_ii_64[central_point_1988](v3_4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\disk-invader_s1[avantgarde64_1988](v9_9).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\disk-invader_s2[avantgarde64_1988](v9_9).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\fast_hack_em[basement_boys_1988](v6_04).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\fast_hack_em[basement_boys_1988](v9_0a).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\hercules[cygnus_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\hot_rod_s2[sega_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karnov[data_east_1988](ntsc)(newer)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karnov[data_east_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karnov_s1[electric_dreams_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karnov_s2[electric_dreams_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\katakis_s1[rainbow_arts_1988](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\katakis_s1[rainbow_arts_1988](r1)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\katakis_s2[rainbow_arts_1988](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\katakis_s2[rainbow_arts_1988](r1)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kayden_garth[eas_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kings_of_the_beach_s1[ea_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kings_of_the_beach_s2[ea_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kracker_jax_vol7[kjpb_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kracker_jax_vol7[kjpb_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\lancelot_s1[level9_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\lancelot_s2[level9_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lancelot_s1[datasoft_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lancelot_s2[datasoft_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lane_mastadon_s1[infocom_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lane_mastadon_s1[infocom_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lane_mastadon_s2[infocom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lane_mastodon_s1[infocom_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lane_mastodon_s2[infocom_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_duel[capcom_1988](pal)(cyan2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_duel[capcom_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s1[activision_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s1[system_1988](pal)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s1[system_1988](pal)(alt2)(noprot)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s1[system_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s2[activision_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s2[system_1988](pal)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s2[system_1988](pal)(alt2)(noprot).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_2_s2[system_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\la_crackdown_s1[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\la_crackdown_s1[epyx_1988](patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\la_crackdown_s2[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_famous_course_iii_s1[access_1988](dongle).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_famous_course_iii_s2[access_1988](dongle).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s1[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s1[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s2[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s2[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s3[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s3[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s4[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_blacksilver_s4[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\macarthurs_war_battle_for_korea[ssg_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\macarthurs_war_battle_for_korea[ssg_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\magnetron[firebird_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mainframe[microillusions_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mainframe[microillusions_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mars_saga_s1[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mars_saga_s2[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mars_saga_s2[ea_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mars_saga_s2[ea_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\matterhorn_screamer[disney_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\matterhorn_screamer[disney_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mega_play_vol1_s1[mastertronic_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mega_play_vol1_s2[mastertronic_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mega_play_vol1_s2[mastertronic_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\menace_s1[psyclapse_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\menace_s2[psyclapse_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\metaplex[prism_leisure_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\metaplex[prism_leisure_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\metro_cross[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\microprose_soccer[microprose_1988](comp)(budget)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\microprose_soccer_european[microprose_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\microprose_soccer_indoor[microprose_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_baseball-box_score-stat_compiler[micro_league_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_baseball-box_score-stat_compiler[micro_league_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s1_hogan_vs_savage[microprose_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s1_hogan_vs_savage[microprose_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s2_hogan_vs_orndorff[microprose_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s2_hogan_vs_orndorff[microprose_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s3_superstars_1[microprose_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s4_superstars_2[microprose_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s5_superstars_3[microprose_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_wwf_wrestling_s6_superstars_4[microprose_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_mud_s1[virgin_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_mud_s1[virgin_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_mud_s2[virgin_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_mud_s2[virgin_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mindfighter[abstract_concepts_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mindroll[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini-golf[magic_bytes_1988](shorter_sync_check)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\modem_wars[ea_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\monopoly_deluxe[leisure_genius_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\monopoly_deluxe[leisure_genius_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\morpheus[rainbird_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\morpheus[rainbird_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\morpheus[rainbird_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\motor_massacre[gremlin_1988](house_mix)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\ms_pac-man[thunder_mtn_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\ms_pacman[thunder_mtn_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\muncher_eats_chewits[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\murder_on_the_atlantic[intracorp_1988](v1_1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nav_com_6[cosmi_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nav_com_6[cosmi_1988](v3)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nav_com_6[cosmi_1988](v3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\netherworld[hewson_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\netherworld[hewson_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s1[interplay_1988](alt1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s1[interplay_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s1[interplay_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s1[interplay_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s2[interplay_1988](alt1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s2[interplay_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s2[interplay_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s3[interplay_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s3[interplay_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s4[interplay_1988](alt1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neuromancer_s4[interplay_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\night_raider[gremlin_1988](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\ninja_scooter_simulator[silverbird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nippon_s1[markt_technik_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nippon_s2[markt_technik_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nippon_s3[markt_technik_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nippon_s4[markt_technik_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nurse[free_spirit_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\ocean_ranger_s1[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\ocean_ranger_s2[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_feuersturm_s1[markt_technik_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_feuersturm_s2[markt_technik_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_wolf[ocean_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_wolf[taito_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_wolf[taito_1988](vmax3)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_wolf[taito_1988](vmax3)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\out_run_s1[us_gold_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\out_run_s2[us_gold_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pac-land[grandslam_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pac-man[thunder_mtn_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pacmania[grandslam_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\para_assault_course[zeppelin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\partyware_s1[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\partyware_s2[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pharoahs_revenge_s1[software_intl_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pharoahs_revenge_s2[software_intl_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pink_panther[magic_bytes_1988](kind_of_magic_collection)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\planetfall_s1[infocom_1988](r10).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\planetfall_s2[infocom_1988](r10).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\platou[kingsoft_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pocket_rockets[capcom_1988](ntsc)(cc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pocket_rockets[capcom_1988](ntsc)(pr).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pocket_rockets[capcom_1988](ntsc)(pr-alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pole_position_ii[mindscape_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pole_position_ii[mindscape_1988](vmax3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s1[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s1[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s2[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s2[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s3[ssi_1988](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s3[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s4[ssi_1988](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s4[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s5[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s5[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s6[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s6[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s7[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s7[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s7[ssi_1988](v1_1)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s8[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s8[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pool_of_radiance_s8[ssi_1988](v1_1)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\powerplay_hockey[ea_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\powerplay_hockey[ea_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_pack_s1[melody_hall_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_pack_s1[melody_hall_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_pack_s2[melody_hall_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_pack_s2[melody_hall_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\predator_s1[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\predator_s2[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\president_elect_1988[ssi_1988](v2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\president_elect_1988[ssi_1988](v2)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\press_your_luck_s1[gametek_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\press_your_luck_s2[gametek_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\professional_ski_simulator[codemasters_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_firestart_s1[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_firestart_s2[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_firestart_s3[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_firestart_s4[ea_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psycho_s1[box_office_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psycho_s2[box_office_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_football[software_sim_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_football[software_sim_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_football_1986_teams[software_sim_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\qix_s1[taito_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\qix_s1[taito_1988](vmax3)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\qix_s2[taito_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questron_ii_s1[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questron_ii_s1[ssi_1988](v1_2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questron_ii_s2[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questron_ii_s2[ssi_1988](v1_2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\r-type_s1[electric_dreams_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\r-type_s2[electric_dreams_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rack_em[accolade_1988](rl7)(ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rack_em[accolade_1988](rl7)(ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rack_em[accolade_1988](rl7)(ntsc)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rack_em[accolade_1988](rl7)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rack_em[accolade_1988](rl7)(pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rack_em[accolade_1988](rl7)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rambo_iii_s1[ocean_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rambo_iii_s2[ocean_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rampage[activision_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rampage[activision_1988](power_hits)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rampage[activision_1988](power_hits)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rastan[taito_1988](vmax3)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rastan[taito_1988](vmax3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\raw_recruit[mastertronic_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt7).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988](alt8).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s1[microprose_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt7).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988](alt8).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_s2[microprose_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_storm_rising_self_running_demo[microprose_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade[taito_1988](vmax3)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade[taito_1988](vmax3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_parms_1[kjpb_1988](v1_10).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_s1_program[kjpb_1988](v1_02).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_s1_program[kjpb_1988](v2_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_s1_program[kjpb_1988](v2_02).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_s2_upgrades[kjpb_1988](v1_02).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_s2_upgrades[kjpb_1988](v2_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade_s2_upgrades[kjpb_1988](v2_02).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\revenge_of_defender[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\ringwars[cascade_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_raiders[mindscape_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_runner[mindscape_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_runner[mindscape_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_warrior[crl_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_wars[arcadia_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_wars[arcadia_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s1[cinemaware_1988](vmax2c)(ntsc)(newer)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s1[cinemaware_1988](vmax2c)(ntsc)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s1[cinemaware_1988](vmax2c)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s1[cinemaware_1988](vmax2c)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s2[cinemaware_1988](vmax2c)(ntsc)(newer)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s2[cinemaware_1988](vmax2c)(ntsc)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s2[cinemaware_1988](vmax2c)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s2[cinemaware_1988](vmax2c)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s3[cinemaware_1988](vmax2c)(ntsc)(newer)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s3[cinemaware_1988](vmax2c)(ntsc)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s3[cinemaware_1988](vmax2c)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s3[cinemaware_1988](vmax2c)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s4[cinemaware_1988](vmax2c)(ntsc)(newer)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s4[cinemaware_1988](vmax2c)(ntsc)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s4[cinemaware_1988](vmax2c)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocket_ranger_s4[cinemaware_1988](vmax2c)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rockford[arcadia_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\roll-a-word[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rollerboard[kingsoft_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rommel[ssg_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\salamander[imagine_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\samurai_warrior[firebird_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\santa_paravia[keypunch_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\savage_s1[firebird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\savage_s1[microplay_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\savage_s2[firebird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\savage_s2[microplay_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\scotch_olympia_quiz[scotch_1988](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\serve_and_volley[accolade_1988](rl7)(ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\serve_and_volley[accolade_1988](rl7)(ntsc)(bb-patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\serve_and_volley[accolade_1988](rl7)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\serve_and_volley[accolade_1988](rl7)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sesame_street_letter_go_round[hi-tech_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sesame_street_print_kit_s1[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sesame_street_print_kit_s2[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\seuck_s1[sensible_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\seuck_s2[sensible_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shackled[us_gold_1988](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sid_symphony-stereo_sid_music_collection_s1[cmd_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sid_symphony-stereo_sid_music_collection_s2[cmd_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silk_worm[sales_curve_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skate_crazy[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skate_crazy[mastertronic_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sky_shark[taito_1988](vmax3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sky_travel[microillusions_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\slam_dunk[mastertronic_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\slayer[hewson_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\soldier_of_fortune[firebird_1988](german)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\space_academy[elite_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\space_station_oblivion[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spartacus_the_swordslayer[players_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sporting_news_baseball[epyx_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sporting_news_baseball[epyx_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sporting_news_baseball[epyx_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sporting_news_baseball[epyx_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sports_a_roni_s1[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sports_a_roni_s2[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\starquake[sharedata_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_empire[first_row_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek-the_rebel_universe[simon_schuster_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_wars[br0derbund_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_wars[domark_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_wars[tengen_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_wars[tengen_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\steel_thunder[accolade_1988](rl7)(ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\steel_thunder[accolade_1988](rl7)(ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\steel_thunder[accolade_1988](rl7)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\steel_thunder[accolade_1988](rl7)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\stir_crazy_featuring_bobo[infogrames_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\stocker[capcom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\storm_warrior[elite_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_fighter[capcom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_fighter[capcom_1988](alt)(no_protection)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_sports_football_s1[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_sports_football_s2[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_sports_soccer[epyx_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_sports_soccer[epyx_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\st_pauli[svs_1988](german)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\subterranea[rack-it_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_challenge_s1[thunder_mtn_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_challenge_s2[thunder_mtn_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_olympiad_s1[tynesoft_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_olympiad_s2[tynesoft_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman_man_of_steel_s1[first_star_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman_man_of_steel_s1[first_star_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman_man_of_steel_s2[first_star_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman_man_of_steel_s2[first_star_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman_man_of_steel_s3[first_star_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman_man_of_steel_s3[first_star_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\supersports_s1[gremlin_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\supersports_s2[gremlin_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_pac-man[thunder_mtn_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_password_s1[gametek_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_password_s1[gametek_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_password_s2[gametek_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_ski[microids_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_ski[microids_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\supreme_challenge_s1[beau_jolly_1988](comp).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\supreme_challenge_s2[beau_jolly_1988](comp).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\swift_desktop_publishing[cosmi_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\takedown_s1[activision_1988](vmax2c).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\takedown_s2[activision_1988](vmax2c).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tanium[players_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tank_attack[artworx_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\technocop_s1[gremlin_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\technocop_s1[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\technocop_s2[gremlin_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\technocop_s2[gremlin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\terrafighter[zeppelin_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\terrafighter[zeppelin_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\terramex_s1[grandslam_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\terramex_s2[grandslam_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thalamus_hits_1986-1988_s1[thalamus_1989](delta-sanxion).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thalamus_hits_1986-1988_s2[thalamus_1989](hunters_moon-quedex).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_corporation[activision_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_deep[us_gold_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_empire_strikes_back[domark_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_fury[martech_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s1[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s1[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s1[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s2[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s2[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s2[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s3[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s3[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_summer_edition_s3[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s1[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s1[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s1[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s2[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s2[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s2[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s3[epyx_1988](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s3[epyx_1988](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_games_winter_edition_s3[epyx_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s1[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s2[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s3[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s4[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s5[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s6[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s7[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_in_crowd_s8[ocean_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s1[cosmi_1988](manual)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s1[cosmi_1988](manual)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s1[cosmi_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s2[cosmi_1988](manual)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s2[cosmi_1988](manual)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s2[cosmi_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s3[cosmi_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s3[cosmi_1988](manual)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s4[cosmi_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_president_is_missing_s4[cosmi_1988](manual)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_vindicator[imagine_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thud_ridge[acme_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunderblade[us_gold_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](paraprotect)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\times_of_lore[origin_1988](vmax3)(alt7).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\time_and_magik_s1[datasoft_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\time_and_magik_s2[datasoft_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\time_fighter[crl_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\time_fighter[crl_1988](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tko[accolade_1988](rl7)(ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tko[accolade_1988](rl7)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tko[accolade_1988](rl7)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tower_toppler[epyx_1988](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\traz[cascade_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\triango[california_dreams_1988](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trilogy[mastertronic_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_a_new_beginning_s1[domark_1988](german)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_a_new_beginning_s2[domark_1988](german)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_genus_edition_s1[domark_1988](german)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_genus_edition_s2[domark_1988](german)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\troll[palace_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trump_castle_s1[capstone_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trump_castle_s2[capstone_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s1_pacific[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s1_pacific[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s2_asia[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s2_asia[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s3_europe[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s3_europe[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s4[ssi_1988](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_of_steel_s4[ssi_1988](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_s1[imagine_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\typhoon_s2[imagine_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s1_program[origin_1988](63).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s1_program[origin_1988](aa)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s1_program[origin_1988](aa)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s2_dungeon[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s3_britannia[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s4_underworld[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s4_underworld[origin_1988](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s5_towne[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s6_dwelling[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s7_castle[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s8_keep[origin_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_v_s8_keep[origin_1988](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultrabyte_5_s1[ultrabyte_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultrabyte_5_s2[ultrabyte_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultrabyte_5_s3[ultrabyte_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\uninvited_s1[mindscape_1988](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\uninvited_s2[mindscape_1988](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\us_geography_facts[aec_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vampires_empire[magic_bytes_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vigilante[data_east_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vixen[martech_1988](pal)(paraprotect_v2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\volleyball_simulator[time_warp_1988](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\volleyball_simulator[time_warp_1988](r1)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\warhawk-caverns_of_eriban[firebird_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\warlock[three_sixty_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wasteland_s1[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wasteland_s2[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wasteland_s3[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wasteland_s4[ea_interplay_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wec_lemans[imagine_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wheel_of_fortune_new_2nd_edition[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wheel_of_fortune_new_3rd_edition[sharedata_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\where_in_europe_is_carmen_sandiego_s1[br0derbund_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\where_in_europe_is_carmen_sandiego_s2[br0derbund_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\who_framed_roger_rabbit_s1[buena_vista_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\who_framed_roger_rabbit_s2[buena_vista_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\willow_s1[mindscape_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\willow_s2[mindscape_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\willow_s3[mindscape_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\willow_s4[mindscape_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_challenge_s1[thunder_mtn_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_challenge_s2[thunder_mtn_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_olympiad_88_s1[tynesoft_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_olympiad_88_s1[tynesoft_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_olympiad_88_s2[tynesoft_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_olympiad_88_s2[tynesoft_1988](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s1[hi-tech_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s1[hi-tech_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s1[hi-tech_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s1[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s2[hi-tech_1988](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s2[hi-tech_1988](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s2[hi-tech_1988](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\win_lose_or_draw_s2[hi-tech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wishbringer_s1[infocom_1988](r23)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wishbringer_s2[infocom_1988](r23)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_v_heart_of_the_maelstrom_boot[sirtech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_v_heart_of_the_maelstrom_disk_a[sirtech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_v_heart_of_the_maelstrom_disk_b[sirtech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_v_heart_of_the_maelstrom_disk_c[sirtech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_v_heart_of_the_maelstrom_disk_d[sirtech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_v_heart_of_the_maelstrom_disk_e[sirtech_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizards_lair[prism_leisure_1988](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\y\yuppis_revenge[ariolasoft_1988](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\y\yuppis_revenge[ariolasoft_1988](german)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_boot[activision_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_boot[activision_1988](manual)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s1[activision_1988](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s1[activision_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s1[activision_1988](manual)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s2[activision_1988](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s2[activision_1988](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s2[activision_1988](manual)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zak_mckracken_s3[activision_1988](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zamzara[hewson_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zoom[discovery_1988](vmax3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zork_quest_i_assault_on_egreth_castle_s1[infocom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zork_quest_i_assault_on_egreth_castle_s2[infocom_1988](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zybex[zeppelin_1988](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\007_the_living_daylights[domark_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\007_the_living_daylights[melbourne_house_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\100000_pyramid[box_office_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\100_percent_dynamite_s1[ocean_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\100_percent_dynamite_s1[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\100_percent_dynamite_s2[ocean_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\100_percent_dynamite_s2[ocean_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\100_percent_dynamite_s3[ocean_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\100_percent_dynamite_s4[ocean_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\100_percent_dynamite_s5[ocean_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\3-in-1_football_draft_trade_change_ratings[lance_haffner_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\3-in-1_football_standings_league_leaders[lance_haffner_1987](bad-t25s14).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4th_and_inches[accolade_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4th_and_inches[accolade_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4th_and_inches[accolade_1987](rl6)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\4th_and_inches[accolade_1987](rl6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\720[us_gold_1987](cyan2)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\accolades_comics_s1[accolade_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\accolades_comics_s2[accolade_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\accolades_comics_s3[accolade_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\accolades_comics_s4[accolade_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\accolades_comics_s5[accolade_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\accolades_comics_s6[accolade_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace_2[cascade_1987](v1_1l).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace_2[uxb_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace_2[uxb_1987](ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\action_thrillers[sharedata_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s1[microprose_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s1[microprose_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s1[microprose_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s1[microprose_1987](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s1[microprose_1987](alt5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s1[microprose_1987](alt6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s1[microprose_1987](alt_version).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s1[microprose_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s2[microprose_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s2[microprose_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s2[microprose_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s2[microprose_1987](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s2[microprose_1987](alt5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s2[microprose_1987](alt6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s2[microprose_1987](alt_version).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airborne_ranger_s2[microprose_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airwolf_ii[hitpak_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\aliens[electric_dreams_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alien_syndrome[sega_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alien_syndrome_s1[sega_1987](vmax3)(ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alien_syndrome_s1[sega_1987](vmax3)(ntsc)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alien_syndrome_s2[sega_1987](vmax3)(ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alien_syndrome_s2[sega_1987](vmax3)(ntsc)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\altered_beast[sega_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\altered_beast_s1[sega_1987](pal)(noprot).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\altered_beast_s2[sega_1987](pal)(noprot).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternate_reality_the_dungeon_s1[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternate_reality_the_dungeon_s1[datasoft_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternate_reality_the_dungeon_s2[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternate_reality_the_dungeon_s2[datasoft_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternate_reality_the_dungeon_s3[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternative_world_games_s1[gremlin_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternative_world_games_s2[gremlin_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_female_s1[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_female_s2[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_female_s3[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_female_s4[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_female_s5[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_female_s6[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_male_s1[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_male_s1[activision_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_male_s1[activision_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_male_s1[activision_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_male_s2[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_male_s3[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_male_s4[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_male_s5[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alter_ego_male_s6[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\amnesia_s1[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\amnesia_s2[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\amnesia_s3[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\amnesia_s4[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\andy_capp[mirrorsoft_1987)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\annals_of_rome[pss_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\annals_of_rome[pss_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\antics_s1[time_warp_1987](r1)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\antics_s2[time_warp_1987](r1)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\apollo_18_s1[accolade_1987](rl-unknown)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\apollo_18_s1[accolade_1987](rl6)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\apollo_18_s1[accolade_1987](rl6)(pal)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\apollo_18_s1[accolade_1987](rl6)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\apollo_18_s2[accolade_1987](pal)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\apollo_18_s2[accolade_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\apollo_18_s2[accolade_1987](rl-unknown)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\apollo_18_s2[accolade_1987](rl6)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_action[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_adventures[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ardok_the_barbarian[spinnaker_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arkanoid[taito_1987](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\armageddon_man[martech_1987](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\army_moves[imagine_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\army_moves[imagine_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\asterix_im_morgenland_s1[bomico_1987](german)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\asterix_im_morgenland_s2[bomico_1987](german)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\astro-grover[hi-tech_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\atv_simulator[codemasters_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\auf_wiedersehen_monty[gremlin_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\awardware_s1_program_disk[hi-tech_expressions_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\awardware_s1_program_disk[hi-tech_expressions_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\awardware_s1_program_disk[hi-tech_expressions_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\awardware_s1_program_disk[hi-tech_expressions_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\awardware_s2_graphics_disk[hi-tech_expressions_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\awardware_s2_graphics_disk[hi-tech_expressions_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\awardware_s2_graphics_disk[hi-tech_expressions_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\awardware_s2_graphics_disk[hi-tech_expressions_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\b-24[ssi_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\baby_of_can_guru[rainbow_arts_1987](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bad_cat_s1[rainbow_arts_1987](r1)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bad_cat_s1[rainbow_arts_1987](r1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bad_cat_s2[rainbow_arts_1987](r1)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bad_cat_s2[rainbow_arts_1987](r1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bad_street_brawler[mindscape_1987](vmax2c).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bangkok_knights_s1[system3_1987](bitstar_budget)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bangkok_knights_s1[system3_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bangkok_knights_s2[system3_1987](bitstar_budget)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bangkok_knights_s2[system3_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\barbarian_s1[palace_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\barbarian_s2[palace_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\basil_the_great_mouse_detective[gremlin_1987](cyan-early)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\basil_the_great_mouse_detective[gremlin_1987](cyan-early).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battlecruiser_i[ssi_1987).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battles_in_normandy[ssg_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_droidz[datasoft_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_droidz[datasoft_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_ships[hit_pak_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\batty[elite_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bazooka_bill[melbourne_house_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bazooka_bill[spinnaker_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\beyond_zork_s1[infocom_1987](c128)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\beyond_zork_s2[infocom_1987](c128)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\big_birds_special_delivery[hitech_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\big_birds_special_delivery[hitech_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\big_trouble_in_little_china[elec_dreams_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bismarck[datasoft_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\blackjack_academy[microillusions_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\black_magic[datasoft_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\blitz-krieg[ariolasoft_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\block_buster[mindscape_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\block_buster[mindscape_1987](vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bobsleigh[digital_integration_1987](bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bomb_jack_2[elite_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bonecruncher[superior_software_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bop_n_rumble[mindscape_1987](vmax2a)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bop_n_rumble[mindscape_1987](vmax2a)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\boulder_dash_construction_kit[epyx_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\breaker[radarsoft_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bride_of_frankenstein[ariolasoft_1987](tracksync)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bridge_5_0[artworx_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bridge_5_0[artworx_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bubble_bobble[firebird_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bubble_bobble[firebird_1987](pal)(rainbow_collection)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\buggy_boy[elite_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bulldog[epyx_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bureaucracy_s1[infocom_1987](r116)(c128).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bureaucracy_s1[infocom_1987](r86)(c128)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bureaucracy_s2[infocom_1987](r116)(c128).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bureaucracy_s2[infocom_1987](r86)(c128)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cadpak-64_s1[abacus_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cadpak-64_s2[abacus_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\california_games_s1[epyx_1987](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\california_games_s1[epyx_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\california_games_s2[epyx_1987](ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\california_games_s2[epyx_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\card_sharks[accolade_1987](rl6)(ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\card_sharks[accolade_1987](rl6)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\card_sharks[accolade_1987](rl6)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\catch_a_thief[tri-micro_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chain_reaction[durell_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chamonix_challenge[infogrames_1987](pal)(german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\childrens_collection[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cholo[firebird_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chop_n_drop[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chuck_yeagers_aft[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chuck_yeagers_aft[ea_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chuck_yeagers_aft[ea_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chuck_yeagers_aft[ea_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chuck_yeagers_aft[ea_1987](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\circus_charlie[action_city_1987](vmax2a)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\circus_charlie[action_city_1987](vmax2a)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\classix_1[softek_1987](compilation)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\coil_cop[epyx_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\colossus_bridge_4[cds_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\combat_lynx-white_viper[tri-micro_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\combat_school[ocean_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\combat_school[ocean_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\comm_term_64_128[anchor_automation_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cosmic_causeway[gremlin_1987](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\create_a_calendar_s1[epyx_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\create_a_calendar_s2[epyx_1987](bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cyrus_ii[alligata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\darkhorn[avalon_hill_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dark_castle_s1[three_sixty_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dark_castle_s2[three_sixty_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dark_lord_s1[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dark_lord_s2[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\das_komplette_schachprogramm[falken_1987](german)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deathlord_s1[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deathlord_s2[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deathlord_s3[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\death_or_glory[crl_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\decisive_battles_of_american_civil_war_vol_i[ssg_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deep_space[sir-tech_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\defcon_5_s1[cosmi_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\defcon_5_s1[cosmi_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\defcon_5_s1[cosmi_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\defcon_5_s2[cosmi_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\defcon_5_s2[cosmi_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\defcon_5_s2[cosmi_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\defender_of_the_crown_s1[cinemaware_1987](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\defender_of_the_crown_s1[cinemaware_1987](vmax2)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\defender_of_the_crown_s2[cinemaware_1987](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\defender_of_the_crown_s2[cinemaware_1987](vmax2)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deja_vu_s1[mindscape_1987](vmax2a)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deja_vu_s1[mindscape_1987](vmax2a)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deja_vu_s2[mindscape_1987](vmax2a)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\delta[thalamus_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\delta_patrol[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demon_stalkers_interactive_demo[ea_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demon_stalkers_s1[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demon_stalkers_s2[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demon_stalkers_s2[ea_1987](alt1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demon_stalkers_s2[ea_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\demon_stalkers_s2[ea_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diablo[diamond_games_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\discovery[crl_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dizzy_dice[players_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dizzy_dice[players_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\doc_the_destroyer[melbourne_house_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\doc_the_destroyer[thunder_mtn_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dogfight_2187[starlight_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\double_take[ocean_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dracula_s1[crl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dracula_s2[crl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dragons_lair_ii[ea_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\driller[activision_1987](pal)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\druid_ii_enlightenment[firebird_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\earth_orbit_station_s1_game[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\earth_orbit_station_s2_archive[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\earth_orbit_station_s3_mission[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\easy_working_filer[spinnaker_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\easy_working_filer[spinnaker_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\easy_working_planner[spinnaker_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\easy_working_planner[spinnaker_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\easy_working_writer_s1[spinnaker_1987](v1_02).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\easy_working_writer_s2[spinnaker_1987](v1_02)(bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\echelon_s1[access_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\echelon_s1[access_1987](alt1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\echelon_s1[access_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\echelon_s2[access_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\echelon_s2[access_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\echelon_s2[access_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\echelon_s2[access_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\electronic_checkbook[melody_hall_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\enduro_racer[activision_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\enduro_racer[hit_squad_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\escape_from_paradise[anco_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\eternal_dagger_s1[ssi_1987](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\eternal_dagger_s1[ssi_1987](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\eternal_dagger_s2[ssi_1987](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\exolon[hewson_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\express_raider[data_east_1987](pal)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\express_raider[data_east_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\express_raider[us_gold_1987](cyan1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\face_off_s1[gamestar_1987](ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\face_off_s1[gamestar_1987](ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\face_off_s1[gamestar_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\face_off_s2[gamestar_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\family_feud_s1[sharedata_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\family_feud_s1[sharedata_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\family_feud_s2[sharedata_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fantasia[svs_1987](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fearless_fred[cosmi_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\federation[crl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\feud[mastertronic_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\firetrap[electric_dreams_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fire_track[aardvark_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\first_over_germany_s1[ssi_1987](v1_0e).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\flexidraw_5_5_s1[inkwell_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\flexidraw_5_5_s2[inkwell_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\flight_simulation_games[sharedata_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\flying_shark[firebird_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\force_seven[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\frankenstein[crl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\freddy_hardest[imagine_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\frohn[kingsoft_1987](pal)(german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fruit_machine_simulator[codemasters_1987](bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\future_knight[epyx_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\galactic_games_s1[activision_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\galactic_games_s2[activision_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_set_and_match_ii_s1[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_set_and_match_ii_s2[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_set_and_match_ii_s3[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_set_and_match_ii_s4[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_set_and_match_ii_s5[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_set_and_match_ii_s6[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_set_and_match_ii_s7[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_set_and_match_ii_s8[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_set_and_match_s1[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_set_and_match_s2[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_set_and_match_s3[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\game_set_and_match_s4[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet[mindscape_1987](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet[mindscape_1987](vmax2)(090387).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet[mindscape_1987](vmax2)(111187)(bad-t37).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet[mindscape_1987](vmax2)(newer)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet[mindscape_1987](vmax2)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet[us_gold_1987](newer)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet_deeper_dungeons[us_gold_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet_deeper_dungeons[us_gold_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet_ii[us_gold_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gee_bee_air_rally[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gee_bee_air_rally[activision_1987](power_hits)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geospell_s1[berkeley_1987](bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geospell_s2[berkeley_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_font_pack_plus_s1[berkeley_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_font_pack_plus_s2[berkeley_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\global_commander[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gradius[konami_1987](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gradius[konami_1987](vmax2)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grand_slam_baseball[cosmi_1987](g1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grand_slam_baseball[cosmi_1987](g3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grand_slam_baseball[cosmi_1987](v4)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grand_slam_baseball[cosmi_1987](v6)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graphics_master[sharedata_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graphics_master[sharedata_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graphics_master[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\great_giana_sisters[time_warp_1987](pal)(r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grovers_animal_adventures[hi-tech_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gryzor[ocean_1987](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gryzor[ocean_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\guerrilla_war[data_east_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\guild_of_thieves_s1[magnetic_scrolls_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\guild_of_thieves_s2[magnetic_scrolls_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunsmoke_s1[capcom_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunsmoke_s2[capcom_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hacker_ii[activision_1987](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hades_nebula[paranoid_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\halls_of_montezuma[ssg_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\halls_of_montezuma[ssg_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hardball[accolade_1987](ntsc)(04)(rl5)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hardball[accolade_1987](ntsc)(04)(rl5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hardball[accolade_1987](ntsc)(05)(rl5)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hardball[accolade_1987](ntsc)(05)(rl5)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hardball[accolade_1987](ntsc)(05)(rl5)(bb-patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hardball[accolade_1987](ntsc)(05)(rl5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hat_trick[capcom_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\head_over_heels[mindscape_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\head_over_heels[ocean_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hellowoon_s1[ariolasoft_1987](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hellowoon_s2[ariolasoft_1987](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\herobotix[hewson_1987](prism_leisure_1992)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\high_diving_dan[micrograms_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_pak_trio_s1[hit_pak_1987](cataball).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hit_pak_trio_s2[hit_pal_1987)(airwolf_2-great_gurianos).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hollywood_hijinx[infocom_1987](r37)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hollywood_poker[golden_games_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hunters_moon[thalamus_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hunt_for_red_october[argos_1987](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hunt_for_red_october[argos_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hunt_for_red_october[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hyperrace[profiteam_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hyper_sports[action_city_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\ikari_warriors[data_east_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\ik_plus[system3_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\impact[audiogenic_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\implosion[cascade_1987](pal)(cyan2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\implosion[thunder_mtn_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\impossible_mission_ii[epyx_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indoor_sports_s1[mindscape_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indoor_sports_s1[mindscape_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indoor_sports_s1[mindscape_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indoor_sports_s2[mindscape_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\infiltrator_ii_s1[mindscape_1987](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\infiltrator_ii_s1[mindscape_1987](vmax2)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\infiltrator_ii_s2[mindscape_1987](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\instant_music_s1[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\instant_music_s2[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\interactive_adventures[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\international_karate[prism_leisure_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\in_80_days_around_the_world_s1[rainbow_arts_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\in_80_days_around_the_world_s2[rainbow_arts_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\i_alien[crl_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\i_ball[firebird_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jack_the_ripper[crl_1987](alt)(bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jack_the_ripper[crl_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeopardy_s1[sharedata_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeopardy_s1[sharedata_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeopardy_s2[sharedata_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet_boys[crl_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jinks[rainbow_arts_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jinxter_s1[magnetic_scrolls_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jinxter_s2[magnetic_scrolls_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jumpman_junior[epyx_1987](xmas_bonus)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jump_machine[kingsoft_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\blood_valley[gremlin_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\eternal_dagger_s2[ssi_1987](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\first_over_germany_s1[ssi_1987](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\first_over_germany_s2[ssi_1987](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\gnome_ranger_s1[level9_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\gnome_ranger_s2[level9_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kgb_agent[pirate_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kid_niki_radical_ninja[data_east_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kikstart_ii[mastertronic_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kinetik[firebird_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\knight_orc_s1[rainbird_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\knight_orc_s2[rainbird_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kracker_jax_vol5[kjpb_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kracker_jax_vol6[kjpb_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\krakout[gremlin_1987](pal)(cyan1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\roadwar_europa[ssi_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\land_of_neverwhere-return_of_space_warriors[powerhouse_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_s1[activision_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_s1[activision_1987](pal)(powerhits).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_s1[system3_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_s2[activision_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_s2[activision_1987](pal)(powerhits).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_ninja_s2[system3_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lazer_tag[probe_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_executive_s1[access_1987](dongle)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_executive_s2[access_1987](dongle)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_par_4_leaderboard[access_1987](dongle)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_par_4_world_class_s1[access_1987](dongle)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_par_4_world_class_s2[access_1987](dongle)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_par_4_world_class_s2[access_1987](dongle)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legacy_of_the_ancients_s1[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legacy_of_the_ancients_s1[ea_1987](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legacy_of_the_ancients_s2[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legacy_of_the_ancients_s2[ea_1987](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_kage[imagine_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\legend_of_knucker_hole[cosmi_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leisure_time_classics_s1[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leisure_time_classics_s2[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leviathan[thunder_mtn_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lifeforce[crl_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lightforce[ftl_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lucky_luke[coktel_vision_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lurking_horror[infocom_1987](r203)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mandroid[crl_1987](2a)(mandroid_files).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mandroid[crl_1987](2a).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\maniac_mansion_demo[lucasfilm_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\maniac_mansion_s1[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\maniac_mansion_s1[activision_1987](german)(manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\maniac_mansion_s2[activision_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\maniac_mansion_s2[activision_1987](german)(manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mario_bros[ocean_1987(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mask_ii[gremlin_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\masters_of_the_universe-terraquake[us_gold_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\master_blaster[keypunch_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\master_ninja_s1[paragon_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\master_ninja_s2[paragon_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\master_ninja_s3[paragon_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\master_ninja_s4[paragon_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\match_day_ii[ocean_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\math_magic[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mean_city[quicksilva_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mean_streak[mirrorsoft_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mega-apocalypse[martech_1987](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\merlin_128_macro_assembler[roger_wagner_pub_1987](v1_10)(c128).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\metro_cross[us_gold_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\microlawyer_s1[pps_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\microlawyer_s2[pps_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_baseball_1987_teams[micro_league_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\might_and_magic_s1[new_world_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\might_and_magic_s1[new_world_1987](v2_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\might_and_magic_s2[new_world_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\might_and_magic_s2[new_world_1987](v2_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\might_and_magic_s3[new_world_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\might_and_magic_s3[new_world_1987](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\might_and_magic_s3[new_world_1987](v2_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\might_and_magic_s4[new_world_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\might_and_magic_s4[new_world_1987](v2_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mikie[action_city_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_golf[capcom_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_office_ii_s1[database_1987](v1_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_office_ii_s1[database_1987](v1_2e)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_office_ii_s2[database_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_putt_s1[accolade_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_putt_s1[accolade_1987](rl6)(ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_putt_s1[accolade_1987](rl6)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_putt_s1[accolade_1987](rl6)(pal)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_putt_s1[accolade_1987](rl6)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_putt_s2[accolade_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_putt_s2[accolade_1987](rl6)(ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_putt_s2[accolade_1987](rl6)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_putt_s2[accolade_1987](rl6)(pal)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mini_putt_s2[accolade_1987](rl6)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mouse_quest[microvalue_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\multiplan_1_07_s1[epyx_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\multiplan_1_07_s2[epyx_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\napoleon_in_russia[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nba[avalon_hill_1987](rapidlok)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nba[avalon_hill_1987](rapidlok)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nebulus[hewson_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nemesis_the_warlock[martech_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\never_outside_s1[ordilogic_1987](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\never_outside_s2[ordilogic_1987](manual)(bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\never_outside_s3[ordilogic_1987](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\never_outside_s4[ordilogic_1987](manual)(bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\never_outside_s5[ordilogic_1987](manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\never_outside_s6[ordilogic_1987](manual)(bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\ninja_hamster[crl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nord_and_bert_s1[infocom_1987](r19)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nord_and_bert_s2[infocom_1987](r19)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\not_a_penny_more_less[domark_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nyt_crosswords_vol_3[sharedata_1987](bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\oink[crl_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\outrageous_pages_s1_program[batteries_incl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\outrageous_pages_s2_printer[batteries_incl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\outrageous_pages_s3_font[batteries_incl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\outrageous_pages_s4_cutout[batteries_incl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\outrageous_pages_s5_templates[batteries_incl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\outrageous_pages_s6_templates[batteries_incl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\out_run[sega_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\out_run_s1[sega_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\out_run_s2[sega_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\panzer_strike_s1_east[ssi_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\panzer_strike_s2_west[ssi_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\panzer_strike_s3_africa[ssi_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\panzer_strike_s4_scenarios[ssi_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperclip_iii_s1[batteries_included_1987](c128)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperclip_iii_s1[batteries_included_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperclip_iii_s2[batteries_included_1987](c128)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperclip_iii_s2[batteries_included_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperclip_publisher_demo[ea_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperclip_publisher_s1[batteries_incl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperclip_publisher_s2[batteries_incl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\parallax[mindscape_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\parameter_construction_set_s1[utilities_unlimited_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\parameter_construction_set_s2[utilities_unlimited_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pass_your_driving_test[supersoft_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\patton_vs_rommel[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\penetrator[spinnaker_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_iii_s1[ssi_1987](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_iii_s1[ssi_1987](v1_2)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_iii_s1[ssi_1987](v1_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_iii_s2[ssi_1987](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_iii_s2[ssi_1987](v1_2)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_iii_s2[ssi_1987](v1_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phm_pegasus_s1[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phm_pegasus_s2[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phoncentration[micrograms_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\ping_pong[action_city_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pirates_s1[microprose_1987](rl6)(ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pirates_s1[microprose_1987](rl6)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pirates_s1[microprose_1987](rl6)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pirates_s2[microprose_1987](rl6)(ntsc)(alt)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pirates_s2[microprose_1987](rl6)(ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pirates_s2[microprose_1987](rl6)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pirates_s2[microprose_1987](rl6)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\plasmatron[avantage_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\plasmatron[avantage_1987](ntsc)(rlok).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\plasmatron[crl_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\platoon_s1[ocean_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\platoon_s1[ocean_1987](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\platoon_s1[ocean_1987](v1_1)(ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\platoon_s2[ocean_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\platoon_s2[ocean_1987](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\platoon_s2[ocean_1987](v1_1)(ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\plundered_hearts[infocom_1987](r26)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pole_position[thunder_mtn_1987](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power[avantage_1987](ntsc)(rl6)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power[avantage_1987](ntsc)(rl6)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power[avantage_1987](ntsc)(rl6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_at_sea[accolade_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_pack_s1[unknown_1987](zoids-solo_flight-madness).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_pack_s2[unknown_1987](fist_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_pack_s3[unknown_1987](uchi_mata-magic_madness-war).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\power_pack_s4[unknown_1987](suicide_voyage-speed_boat_race-mission_elevator).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\printfox[scanntronik_1987](v1_2)(german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\print_power_s1[hi-tech_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\print_power_s2[hi-tech_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_space_station[avantage_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s1[microprose_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s1[microprose_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s1[microprose_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s1[microprose_1987](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s1[microprose_1987](alt5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s1[microprose_1987](noprot-budget).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s1[microprose_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s1[microprose_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s2[microprose_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s2[microprose_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s2[microprose_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s2[microprose_1987](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s2[microprose_1987](alt5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s2[microprose_1987](noprot-budget).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s2[microprose_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_stealth_fighter_s2[microprose_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\prowler[mastertronic_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psycastria[cosmi_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_college_basketball[software_simulations_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\quartet[sega_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\quedex[thalamus_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questprobe_fantastic_four[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questprobe_spider-man[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questprobe_the_hulk[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\racing_simulation_games[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rad_warrior[epyx_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rampage[activision_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\ranarama[hewson_1987](players_1990)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\ranarama[hewson_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\ransack[asl_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\realms_of_darkness_s1[ssi_1987](ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\realms_of_darkness_s1[ssi_1987](ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\realms_of_darkness_s1[ssi_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\realms_of_darkness_s2[ssi_1987](ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\realms_of_darkness_s2[ssi_1987](ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\realms_of_darkness_s2[ssi_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\realms_of_darkness_s3[ssi_1987](ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\realms_of_darkness_s3[ssi_1987](ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\realms_of_darkness_s3[ssi_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\real_ghostbusters[data_east_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\real_ghostbusters_s1[data_east_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\real_ghostbusters_s2[data_east_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rebel_charge_at_chickamauga[ssi_1987](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rebounder[gremlin_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\redled[starlight_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_led[starlight_1987](pal)(tracksync).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\renegade[imagine_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\return_of_the_jedi[tengen_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\revs_plus_6_track[firebird_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\revs_plus_gold_edition[firebird_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\risk[the_edge_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_runner[us_gold_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_to_moscow[gdw_1987](v2_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\robocop[data_east_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\robocop[data_east_1987](ntsc)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocky_horror_show[crl_1987](c128)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rubicon_alliance[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\russia[ssg_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sailing[activision_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\saracen[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\schatzjager_s1[ariolasoft_1987](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\schatzjager_s2[ariolasoft_1987](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\screen_fx[solutions_unlimited_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\scruples[leisure_genius_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sesame_st_pals_around_town[hitech_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shadows_of_mordor[addison_wesley_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sherlock_crown_jewels_s1[infocom_1987](r21)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sherlock_crown_jewels_s2[infocom_1987](r21)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shiloh_grants_trials_west_s1[ssi_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shiloh_grants_trials_west_s2[ssi_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shirley_muldowneys_top_fuel_challenge[cosmi_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shirley_muldowneys_top_fuel_challenge[cosmi_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shotgun_ii[kjpb_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shotgun_ii[kjpb_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sidearms[capcom_1987](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sidearms_s1[capcom_1987](vmax2)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sidearms_s1[capcom_1987](vmax2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sidearms_s2[capcom_1987](vmax2)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sidearms_s2[capcom_1987](vmax2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sidewize[firebird_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sigma_7[avantage_1987](rl6)(ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sigma_7[avantage_1987](rl6)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sinbad_s1[cinemaware_1987](vmax2)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sinbad_s1[cinemaware_1987](vmax2)(pal)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sinbad_s2[cinemaware_1987](vmax2)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sinbad_s2[cinemaware_1987](vmax2)(pal)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skariten_s1[balistic_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skariten_s2[balistic_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skate_or_die_s1[ea_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skate_or_die_s1[ea_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skate_or_die_s2[ea_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skate_or_die_s2[ea_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skate_rock[sharedata_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skyfox_ii[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\slaine[martech_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\slap_fight[imagine_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\snap_dragon-cave_fighter[sharedata_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\snooker[gremlin_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\snooker[gremlin_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\soko-ban_s1[spectrum_holobyte_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\soko-ban_s1[spectrum_holobyte_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\soko-ban_s2[spectrum_holobyte_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\soko-ban_s2[spectrum_holobyte_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\soko-ban_s2[spectrum_holobyte_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\solomons_key[us_gold_1987](poweplay)(cyan2)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sound_sampler_ii[datel_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\space_harrier[sega_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\space_pilot_compendium[kingsoft_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\speed_buggy[data_east_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\speed_rumbler_s1[capcom_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\speed_rumbler_s2[capcom_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spiderbot[epyx_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sports_simulation_games[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sport_games_4_s1[anco_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sport_games_4_s2[anco_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spys_adventures_in_north_america[polarware_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spy_vs_spy_arctic_antics[epyx_maxx_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spy_vs_spy_arctic_antics[first_star_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_paws[software_projects_1987](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_raiders_2[electric_dreams_1987](bitstar).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_raiders_2[electric_dreams_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_rank_boxing_ii[activision_1987](powerhits)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_rank_boxing_ii[activision_1987](powerhits)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_rank_boxing_ii[activision_1987](powerhits).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_rank_boxing_ii[activision_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trooper[spinnaker_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\stationfall[infocom_1987](r107)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\stealth_mission[sublogic_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\stein_der_weisen[kingsoft_1987](pal)(german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\stratton[imperial_designs_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_fighter[capcom_1987](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_gang[time_warp_1987](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_hassle[melbourne_house_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_sports_baseball[epyx_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_sports_basketball[epyx_1987](patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_sports_basketball[epyx_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\street_sports_basketball_preview[epyx_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\strike_fleet_s1[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\strike_fleet_s2[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sub_battle_simulator_preview[epyx_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sub_battle_simulator_s1[epyx_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sub_battle_simulator_s1[epyx_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sub_battle_simulator_s1[epyx_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sub_battle_simulator_s1[epyx_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sub_battle_simulator_s2[epyx_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\suicide_voyage[eurogold_1987](pal)(unclean).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_games[epyx_1987](xmas-bonus)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superbike_challenge[br0derbund_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superstar_ice_hockey[mindscape_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superstar_ice_hockey[mindscape_1987](para-protect)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superstar_ice_hockey[mindscape_1987](vmax)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superstar_ice_hockey[mindscape_1987](vmax)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superstar_ice_hockey[mindscape_1987](vmax)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superstar_ice_hockey[mindscape_1987](vmax).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superstar_ice_hockey[mindscape_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superstar_soccer[mindscape_1987](bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_bowl_sunday_general_manager[avalon_hill_1987](rl6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_parameters_100_pack_demo[utilities_unlimited_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_parameters_100_pack_disk_3[utilities_unlimited_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_parameters_100_pack_disk_4[utilities_unlimited_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_parameters_hp_free_pack_s1[utilities_unlimited_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_parameters_hp_free_pack_s1[utilities_unlimited_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_parameters_hp_free_pack_s1[utilities_unlimited_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_parameters_hp_free_pack_s1[utilities_unlimited_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_parameters_hp_free_pack_s2[utilities_unlimited_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_parameters_hp_free_pack_s2[utilities_unlimited_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_parameters_hp_free_pack_s2[utilities_unlimited_1987](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_parameters_hp_free_pack_s2[utilities_unlimited_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tai-pan[ocean_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tank-tnk_iii[ocean_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\temple_of_terror[us_gold_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\test_drive_s1[accolade_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\test_drive_s1[accolade_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\test_drive_s2[accolade_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\test_drive_s2[accolade_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tetris[spectrum_holobyte_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tetris[spectrum_holobyte_1987](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_mystery_of_the_nile[firebird_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_neverending_story[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_sentry[firebird_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_train[accolade_1987](rl6)(alt)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_train[accolade_1987](rl6)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_train[accolade_1987](rl6)(alt2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_train[accolade_1987](rl6)(bb-patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_train[accolade_1987](rl6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_writer_s1[spinnaker_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_writer_s1[spinnaker_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_writer_s2[spinnaker_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_writer_s2[spinnaker_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thing_on_a_spring[epyx_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_musketeers_s1[computer_novels_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_musketeers_s2[computer_novels_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_stooges_s1[cinemaware_1987](vmax2c)(ntsc)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_stooges_s1[cinemaware_1987](vmax2c)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_stooges_s1[cinemaware_1987](vmax2c)(pal)(newer)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_stooges_s1[cinemaware_1987](vmax2c)(pal)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_stooges_s2[cinemaware_1987](vmax2c)(ntsc)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_stooges_s2[cinemaware_1987](vmax2c)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_stooges_s2[cinemaware_1987](vmax2c)(pal)(newer)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_stooges_s2[cinemaware_1987](vmax2c)(pal)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_stooges_s3[cinemaware_1987](vmax2c)(ntsc)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_stooges_s3[cinemaware_1987](vmax2c)(ntsc)(older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_stooges_s3[cinemaware_1987](vmax2c)(pal)(newer)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\three_stooges_s3[cinemaware_1987](vmax2c)(pal)(newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thundercats[elite_1987](pal)(elite_platinum_comp_s2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thundercats[elite_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunderchopper[actionsoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_cross[crl_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_mtn_action_pak_vol1_s5[thunder_mtn_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_mtn_action_pak_vol2_s1[thunder_mtn_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_mtn_action_pak_vol2_s1[thunder_mtn_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_mtn_action_pak_vol2_s2[thunder_mtn_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_mtn_action_pak_vol2_s3[thunder_mtn_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_mtn_action_pak_vol2_s4[thunder_mtn_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_mtn_action_pak_vol2_s5[thunder_mtn_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_mtn_action_pak_vol2_s6[thunder_mtn_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tiebreaker[kingsoft_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tiger_mission[kele-line_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tiger_road[capcom_1987](cyan2)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tiger_road[capcom_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tobruk[datasoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tolteka[ariolasoft_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\top_fuel_eliminator[activision_1987](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\top_gun[thunder_mtn_1987](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\top_gun[thunder_mtn_1987](ntsc)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\top_gun[thunder_mtn_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\torchbearer_s1[free_spirit_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\torchbearer_s2[free_spirit_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\to_be_on_top[rainbow_arts_1987](r1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\to_be_on_top[rainbow_arts_1987](r1)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tracker[rainbird_1987](45).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tracker[rainbird_1987](pd)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tracker[rainbird_1987](pd)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tracker[rainbird_1987](rb).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trantor[probe_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trantor[probe_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_baby_boomer_edition_s1[domark_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_baby_boomer_edition_s2[domark_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\twas_the_night_before_christmas[microstar_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\twin_tornado[doctorsoft_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\type_s1[br0derbund_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\type_s2[br0derbund_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\up_periscope[actionsoft_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\up_periscope[actionsoft_1987](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\up_periscope[actionsoft_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vegas_gambler[california_dreams_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vengeance-herobotics[crl_1987](box_twenty_comp)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vengeance[crl_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vermeer[ariolasoft_1987](german)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vermeer[ariolasoft_1987](german)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vermeer[ariolasoft_1987](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\victory_road[data_east_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\video_title_shop[datasoft_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\viper_patrol[keypunch_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wargame_construction_set_s1[ssi_1987](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wargame_construction_set_s1[ssi_1987](v1_2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wargame_construction_set_s2[ssi_1987](v1_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wargame_construction_set_s2[ssi_1987](v1_2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\war_in_the_south_pacific[ssi_1987](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\war_in_the_south_pacific[ssi_1987](v1_1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\water_polo[gremlin_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\water_polo[mastertronic_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\western_games_s1[magic_bytes_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\western_games_s2[magic_bytes_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wheel_of_fortune[sharedata_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\where_in_usa_is_carmen_sandiego_s1[br0derbund_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\where_in_usa_is_carmen_sandiego_s2[br0derbund_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wild_kingdom[keypunch_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\willi_wacker[mirrorsoft_1987](pal)(german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_scenario_1_mad_overlord_boot[sirtech_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_scenario_1_mad_overlord_boot[sirtech_1987](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_scenario_1_mad_overlord_disk_a[sirtech_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_scenario_2_knight_of_diamonds_boot[sirtech_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_scenario_2_knight_of_diamonds_disk_a[sirtech_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_scenario_3_legacy_of_llylgamyn_boot[sirtech_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizardry_scenario_3_legacy_of_llylgamyn_disk_a[sirtech_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizball[mindscape_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizball[ocean_1987](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wiz[melbourne_house_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wolfman_s1[crl_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wolfman_s1[crl_1987](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wolfman_s1[crl_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wolfman_s2[crl_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wolfman_s2[crl_1987](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wonderboy[activision_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_cup_soccer[sharedata_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_cup_soccer[sharedata_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_tour_golf_s1[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_tour_golf_s2[ea_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wrath_of_nikademus_s1[ssi_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wrath_of_nikademus_s2[ssi_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\x\xevious[mindscape_1987](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\x\xevious[mindscape_1987](vmax2)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\y\yes_prime_minister_s1[oxford_digital_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\y\yes_prime_minister_s2[oxford_digital_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\y\yie_ar_kung_fu_2[konami_1987](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\y\yie_ar_kung_fu_2[konami_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zig_zag[spectrum_holobyte_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zork_quest_ii_crystal_of_doom_s1[infocom_1987](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zork_quest_ii_crystal_of_doom_s1[infocom_1987].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zork_quest_ii_crystal_of_doom_s2[infocom_1987](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zynaps[hewson_1987](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\10th_frame[access_1986](dongle)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\10th_frame[access_1986](dongle)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\10th_frame[access_1986](dongle)(alt2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\1942[capcom_1986](rl).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\1942[elite_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\1942[elite_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\221b_baker_street_s1[datasoft_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\221b_baker_street_s2[datasoft_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\2_on_one[mastertronic_1986](bump_set_spike-olympic_skier).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\2_on_one[mastertronic_1986](streetsurfer-hollywood_or_bust)(01)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\2_on_one[mastertronic_1986](streetsurfer-hollywood_or_bust)(df).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\2_on_one_3[mastertronic_1986](one_man_and_his_droid-nonterraqueous)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\2_on_one_5[mastertronic_1986](phantom_of_the_asteroid-hektik)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\3d_golf[mastertronic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace[uxb_1986](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace[uxb_1986](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace[uxb_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace_of_aces[accolade_1986](ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace_of_aces[accolade_1986](ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace_of_aces[accolade_1986](ntsc)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace_of_aces[accolade_1986](ntsc)(alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace_of_aces[accolade_1986](ntsc)(rl5)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace_of_aces[accolade_1986](ntsc)(rl5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace_of_aces[us_gold_1986](cyan1)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\acrojet[microprose_1986](rl2)(pal)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\acrojet[microprose_1986](rl2)(pal)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\acrojet[microprose_1986](rl2)(pal)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\acrojet[microprose_1986](rl2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\acrojet[microprose_1986](rl6)(ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\acrojet[microprose_1986](rl6)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\action_games[real_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\advanced_art_studio[rainbird_1986](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\advanced_art_studio[rainbird_1986](manual)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\advanced_art_studio[rainbird_1986](manual)(version-alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\age_of_adventure_s1[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\age_of_adventure_s2[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\aliens[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alleykat[thunder_mtn_1986](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\americas_cup[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arac[addictive_games_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_action[gvp_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcticfox[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\assault_machine[nexus_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\avenger[gremlin_1986](cyan1)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\back_to_the_future[electric_dreams_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bank_street_speller[br0derbund_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_ii_s1_boot[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_ii_s2_char[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_ii_s3_dungeon1[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_ii_s4_dungeon2[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battlefront[ssg_1986](v1_1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battlefront[ssg_1986](v1_2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_for_midway[firebird_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_group[ssi_1986](v1_7).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_of_britain[firebird_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\biggles[mirrorsoft_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\blazing_paddles[baudville_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bomb_jack[elite_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\booty[firebird_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bop_n_wrestle[mindscape_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bop_n_wrestle[mindscape_1986](ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\boulder_dash_construction_kit[first_star_1986](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\boulder_dash_construction_kit[first_star_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bounder[mastertronic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\breakers_s1[br0derbund_1986](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\breakers_s2[br0derbund_1986](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\breakers_s3[br0derbund_1986](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\breakers_s4[br0derbund_1986](manual)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\breakthru[data_east_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bridge_4_0[artworx_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bugsy[crl_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bugsy[crl_1986](alt)(noprot).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bulldog[gremlin_1986](pal)(cyan1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\buzzword[buzzword_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cadpak-128_s1[abacus_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cadpak-128_s2[abacus_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_zzap_s1[mastertronic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\captain_zzap_s2[mastertronic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cardware[hi-tech_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\casino_craps[casino_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cauldron[br0derbund_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cauldron_ii[br0derbund_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cauldron_ii[palace_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\certificate_maker_s1[springboard_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\certificate_maker_s2[springboard_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\certificate_maker_s3[springboard_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\certificate_maker_s4[springboard_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\championship_baseball[activision_1986](vmax1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\championship_basketball[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\championship_wrestling[epyx_1986](ntsc)(!)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\championship_wrestling[epyx_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2000_s1[ea_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2000_s1[software_country_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2000_s1[software_toolworks_1986](v1_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2000_s1[software_toolworks_1986](v1_3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2000_s1[software_toolworks_1986](v1_4)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2000_s2[ea_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2000_s2[software_country_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2000_s2[software_country_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chessmaster_2000_s2[software_toolworks_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cholo[firebird_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cleanup_time[players_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cobra[ocean_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\colossus_chess_4[firebird_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\commando[data_east_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\computerized_publishing_company[cosmi_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\conflict_in_vietnam[microprose_1986](rl)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\conflict_in_vietnam[microprose_1986](rl2)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\conflict_in_vietnam[microprose_1986](rl2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\create_with_garfield[ahead_designs_1986](g2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cyborg[crl_1986](2a)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cyborg[crl_1986](at).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cyborg[crl_1986](d1)(mandroid_files).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cylu[firebird_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cyrus_ii[alligata_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\danse_macabre[funlight_1986](french).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dan_dare[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dark_tower[spinnaker_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deceptor[avantage_1986](rl5)(ntsc)(alt1)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deceptor[avantage_1986](rl5)(ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deceptor[avantage_1986](rl5)(ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deceptor[avantage_1986](rl5)(ntsc)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deceptor[avantage_1986](rl5)(ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deceptor[avantage_1986](rl5)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deceptor[us_gold_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deep_strike[durell_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\desert_fox[avantage_1986](rl5)(ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\desert_fox[avantage_1986](rl5)(ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\destroyer[epyx_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\destroyer[epyx_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\destroyer[epyx_1986](vorpal_newer).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diskbusters[db_1986](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diskbusters[db_1986](v2_0)(tracksync-added).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diskmaker_plus_s1[basix_1986](60ms_skew)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diskmaker_plus_s1[basix_1986](60ms_skewed_for_emu).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diskmaker_plus_s2[basix_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diskmaker_plus_s2[basix_1986](60ms_skewed_for_emu).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diskmaker_toolkit[basix_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\disk_drive_alignment_system_s1[free_spirit_1986] .zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\disk_drive_alignment_system_s2[free_spirit_1986] .zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\disk_manager[melody_hall_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\disk_manager[melody_hall_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\doctor_who_and_the_mines_of_terror[micro-power_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\donkey_kong[ocean_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dragons_lair[ea_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dragons_lair[software_projects_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dragons_lair_ii[software_projects_1986](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dragons_lair_ii[software_projects_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\druid[firebird_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\druid[firebird_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dr_ruths_computer_game_of_good_sex_s1[avalon_hill_1986](rl3)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dr_ruths_computer_game_of_good_sex_s1[avalon_hill_1986](rl3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dr_ruths_computer_game_of_good_sex_s2[avalon_hill_1986](rl3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\early_education_2[kidware_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\educator_ii[melody_hall_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\elektraglide[mastertronic_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\elite[firebird_1986](ntsc)(v060186)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\elite[firebird_1986](pal)(v040486).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\empire[firebird_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\empire[firebird_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\enchanter[infocom_1986](r29)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\equinox[tynesoft_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\expeditions[mecc_1986](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\expeditions[mecc_1986](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\expeditions[mecc_1986](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\expeditions[mecc_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\express_raider[data_east_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fairlight[mindscape_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fairlight[the_edge_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_hack_em[basement_boys_1986](v3_0a).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_hack_em[basement_boys_1986](v4_1a).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_hack_em[basement_boys_1986](v4_5a).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_hack_em_params[basement_boys_1986](v4_0a).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_hack_em_params[basement_boys_1986](v4_1a)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_hack_em_params[basement_boys_1986](v4_5a).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\firelord[hewson_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fish-ed[alan_buchanan_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fist_the_legend_continues[mindscape_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fist_the_legend_continues[mindscape_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\footballer_of_the_year[gremlin_1986](cyan1)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\football[sublogic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\football[sublogic_1986](alt_july_1986).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\frankie_goes_to_hollywood[firebird_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\friday_the_13th[domark_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\future_knight[gremlin_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\galactic_frontier[free_spirit_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\galivan[imagine_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamemaker_science_fiction[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamemaker_sports[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet[us_gold_1986](cyan1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet[us_gold_1986](cyan2)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet[us_gold_1986](cyan2)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gauntlet[us_gold_1986](cyan2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gemstone_healer_s1[ssi_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gemstone_healer_s2[ssi_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.3_apps[berkeley_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.3_system[berkeley_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_font_pack_i[berkeley_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gerry_the_germ[firebird_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gettysburg[ssi_1986](v1_2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gfl_championship_football[activision_1986](bigbox-comp).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gfl_championship_football[activision_1986](vmax1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\ghosts_and_goblins[elite_1986](02)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\ghosts_and_goblins[elite_1986](cc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\ghosts_and_goblins[elite_1986](rl6)(ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\ghosts_and_goblins[elite_1986](rl6)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\ghosts_n_goblins[elite_1986](wg).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gold_medal_games[celery_cosmi_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gold_medal_games[celery_cosmi_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\golfs_best[one_step_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graphics_integrator_2_s1[inkwell_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graphics_integrator_2_s2[inkwell_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graphics_scrapbook_off_the_wall_s1[epyx_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graphics_scrapbook_off_the_wall_s2[epyx_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graphics_scrapbook_sports_s1[epyx_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graphics_scrapbook_sports_s2[epyx_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\green_beret[ocean_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\guderian[avalon_hill_1986](rl6)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\guderian[avalon_hill_1986](rl6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hacker_ii[activision_1986](bitstar)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hacker_ii[activision_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hanse[ariolasoft_1986](german)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hanse[ariolasoft_1986](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\harrier_combat_simulator[mindscape_1986](vmax2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\head_coach[addictive_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heartland[firebird_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heartland[ocg_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heartware[hi-tech_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\high_noon[cosmi_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\high_roller[mindscape_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\house_on_a_disk[activision_1986](arnold).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\house_on_a_disk[activision_1986](billy_bob_binkle-unused).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\house_on_a_disk[activision_1986](david).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\house_on_a_disk[activision_1986](unused).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\howard_the_duck[activision_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\howard_the_duck[activision_1986](vmax1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hypa-ball[odin_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\icon_factory[solutions_unlimited_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\image_system[crl_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\infiltrator_s1[mindscape_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\infiltrator_s1[mindscape_1986](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\infiltrator_s1[mindscape_1986](alt2-older).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\infiltrator_s1[us_gold_1986](cyan1)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\infiltrator_s2[mindscape_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\infiltrator_s2[us_gold_1986](cyan1)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\infodroid[beyond_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\international_karate[system3_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\into_the_eagles_nest[mindscape_1986](vmax2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\into_the_eagles_nest[mindscape_1986](vmax2)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\intrigue_s1[spectrum_holobyte_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\intrigue_s2[spectrum_holobyte_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\invaders_of_the_lost_tomb[spinnaker_1986](dm)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\invaders_of_the_lost_tomb[spinnaker_1986](dm).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\invaders_of_the_lost_tomb[spinnaker_1986](vx)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jack_the_nipper[gremlin_1986](cyan1)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet[sublogic_1986](v2.00)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jingle_disk_86[hitech_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\captured[american_action_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\diskbusters[db_1986](v2_0)(missing_prot).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\elektraglide[mastertronic_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\fast_hack_em[basement_boys_1986](v3_99).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\fast_hack_em[basement_boys_1986](v4_1a)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\fast_hack_em_parms[basement_boys_1986](v4_1a).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karate_chop[melbourne_house_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\killed_until_dead_s1[accolade_1986](rl5)(ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\killed_until_dead_s1[accolade_1986](rl5)(ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\killed_until_dead_s1[accolade_1986](rl5)(ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\killed_until_dead_s1[accolade_1986](rl5)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\killed_until_dead_s1[accolade_1986](rl5)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\killed_until_dead_s1[us_gold_1986](cyan1)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\killed_until_dead_s2[accolade_1986](rl5)(ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\killed_until_dead_s2[accolade_1986](rl5)(ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\killed_until_dead_s2[accolade_1986](rl5)(ntsc)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\killed_until_dead_s2[accolade_1986](rl5)(ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\killed_until_dead_s2[accolade_1986](rl5)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\killed_until_dead_s2[us_gold_1986](cyan1)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\knight_games_s1[english_1986](cyan1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\knight_games_s1[mastertronic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\knight_games_s2[english_1986](cyan1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\knight_games_s2[mastertronic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\knuckle_busters[melbourne_house_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\konflikte[pss_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kracker_jax_vol1[kjpb_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kracker_jax_vol2[kjpb_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kracker_jax_vol3[kjpb_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kracker_jax_vol4[kjpb_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kung_fu_ii_sticks_of_death[uxb_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kung_fu_ii_sticks_of_death[uxb_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\leaderboard_world_class_famous_course_ii_s1[access_1986](dongle).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\leaderboard_world_class_famous_course_ii_s2[access_1986](dongle).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\mediator[english_1986](alt)(maybe-patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\powerplay[arcana_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\rings_of_zilfin_s1[ssi_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\rings_of_zilfin_s2[ssi_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\labyrinth_s1[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\labyrinth_s1[activision_1986](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\labyrinth_s1[activision_1986](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\labyrinth_s1[activision_1986](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\labyrinth_s1[activision_1986](six_sizzlers)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\labyrinth_s2[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\labyrinth_s2[activision_1986](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\labyrinth_s2[activision_1986](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\labyrinth_s2[activision_1986](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\labyrinth_s2[activision_1986](six_sizzlers)(bad-t13s0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\last_mission[data_east_1986](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard[acccess_1986](softgold)(cyan)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard[access_1986](dongle)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard[access_1986](dongle)(ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard[unknown_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard[us_gold_1986](dongle)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_exec_tourn_1[access_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_tournament_1[access_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_triple_pack_s1[access_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_triple_pack_s2[access_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_famous_course_i_s1[access_1986](dongle)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_famous_course_i_s1[access_1986](dongle)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_famous_course_i_s1[access_1986](dongle).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_famous_course_i_s2[access_1986](dongle)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_famous_course_i_s2[access_1986](dongle)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_s1[access_1986](dongle)(01)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_s1[access_1986](dongle)(01)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_s1[access_1986](dongle)(01)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_s1[access_1986](dongle)(01)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_s1[access_1986](dongle)(la).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_s2[access_1986](dongle)(01)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_s2[access_1986](dongle)(01)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_s2[access_1986](dongle)(01)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_s2[access_1986](dongle)(01)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leaderboard_world_class_s2[access_1986](dongle)(la).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leather_goddesses_of_phobos[infocom_1986](r59)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leather_goddesses_of_phobos_s1[infocom_1986](r4)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\leather_goddesses_of_phobos_s2[infocom_1986](r4)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lets_make_signs_banners[melody_hall_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lifeforce[konami_1986](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lords_of_conquest[ea_1986](newer)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lords_of_conquest[ea_1986](older)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\madness[happy_software_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\make_your_own_murder_party_s1[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\make_your_own_murder_party_s2[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\marble_madness_s1[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\marble_madness_s2[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\market_place[mecc_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mastertypes_writer_s1[scarborough_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mastertypes_writer_s2[scarborough_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\master_of_magic[mastertronic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mediator[english_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mercenary[datasoft_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mercenary_the_second_city[novagen_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mermaid_madness[electric_dreams_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\miami_vice[ocean_1986](cyan1)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\microcosm[firebird_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_baseball-box_score-stat_compiler[micro_league_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_baseball_world_series_teams_1980-85[micro_league_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mind_mirror_s1[ea_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mind_mirror_s2[ea_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mind_mirror_s3[ea_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mind_pursuit_s1[datasoft_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mind_pursuit_s2[datasoft_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mission_asteroid[gvp_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mission_asteroid[gvp_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mission_asteroid[impulse_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mission_elevator[eurogold_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mission_elevator[eurogold_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mission_on_thunderhead[avalon_hill_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mission_x14_s1[eurogold_1986](pal)(german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mission_x14_s2[eurogold_1986](pal)(german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moonmist[infocom_1986](r4)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mord_an_bord_s1[ariolasoft_1986](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mord_an_bord_s2[ariolasoft_1986](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\motor_mania[cosmi_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\motor_mania[cosmi_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\movie_monster_game_s1[epyx_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\movie_monster_game_s2[epyx_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\multi-term_5.0[steve_thompson_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\murder_on_the_mississippi[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\murder_on_the_mississippi[activision_1986](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\murder_on_the_mississippi[activision_1986](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\murder_on_the_mississippi[activision_1986](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nam[ssi_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nam[thunder_mtn_1986](v1_0)(vmax3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nemesis[ariolasoft_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nexus[nexus_1986](french).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\ninja[mastertronic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\ninja[mastertronic_1986](atari_data)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\ninja[mastertronic_1986](atari_data)(alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nuclear_embargo[raysoft_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\ocp_art_studio[rainbird_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\ocp_art_studio[rainbird_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\odell_lake[mecc_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\ogre[origin_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\oo-topos[polarware_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\oo-topos[polarware_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_hongkong_s1[golden_games_1986](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\operation_hongkong_s2[golden_games_1986](german)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\out_on_the_tiles[firebird_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paintbrush[hes_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperboy[elite_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperboy[mindscape_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperboy[mindscape_1986](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperboy[mindscape_1986](vmax2)(ntsc)(082887).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperboy[mindscape_1986](vmax2)(ntsc)(090387)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperboy[mindscape_1986](vmax2)(ntsc)(090387)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paper_models_the_christmas_kit[activision_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paradroid[hewson_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paradroid[thunder_mtn_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\parallax[ocean_1986](pal)(cyan1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\petspeed_128[systems_software_1986](v2_2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_ii_s1[ssi_1986](v1_0)(alt)(g2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_ii_s1[ssi_1986](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_ii_s1[ssi_1986](v1_2)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_ii_s1[ssi_1986](v1_2)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_ii_s1[ssi_1986](v1_2)(never_used).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_ii_s2[ssi_1986](v1_0)(alt)(g2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_ii_s2[ssi_1986](v1_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_ii_s2[ssi_1986](v1_2)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_ii_s2[ssi_1986](v1_2)(never_used)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pineview_southern_golf_tradition[1_step_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pirates_of_the_barbary_coast[starsoft_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\planners_choice[activision_1986](xemag2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pocket_writer_2_s1[digital_solutions_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pocket_writer_2_s2[digital_solutions_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\polar_pierre[databyte_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\police_cadet[artworx_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\portal_s1[activision_1986](ntsc)(never_played)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\portal_s2[activision_1986](ntsc)(never_played)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\portal_s3[activision_1986](ntsc)(never_played)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\portal_s4[activision_1986](ntsc)(never_played)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\portal_s5[activision_1986](ntsc)(never_played)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\potty_pigeon[cosmi_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\powerama[hewson_1986](prism_budget)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\printmaster_plus[berkeley_softworks_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\printmaster_plus[berkeley_softworks_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\prodigy[electric_dreams_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\productivity_pak_ii[rerun_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psi5_trading_co_s1[accolade_1986](f1)(rl1)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psi5_trading_co_s1[accolade_1986](f1)(rl1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psi5_trading_co_s1[accolade_1986](f2)(rl2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psi5_trading_co_s1[accolade_1986](f4)(rl5)(alt)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psi5_trading_co_s1[accolade_1986](f4)(rl5)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psi5_trading_co_s2[accolade_1986](f1)(rl1)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psi5_trading_co_s2[accolade_1986](f1)(rl1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psi5_trading_co_s2[accolade_1986](f2)(rl2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psi5_trading_co_s2[accolade_1986](f4)(rl5)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\psi5_trading_co_s2[accolade_1986](f4)(rl5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pub_games_s1[alligata_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pub_games_s2[alligata_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_baseball[software_simulations_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_baseball[sublogic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_baseball[sublogic_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_baseball_1985_teams[software_simulations_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_baseball_1985_teams[sublogic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_baseball_1985_teams[sublogic_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_baseball_american_league_stadiums[quest_1986](bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_baseball_natl_league_stadiums_and_classic_teams[quest_1986](bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_football_1986_teams[software_sim_1988].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questprobe_the_hulk[gvp_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rastan[imagine_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\reach_for_the_stars[ssg_1986](v2_0)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\reach_for_the_stars[ssg_1986](v2_0)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\reach_for_the_stars[ssg_1986](v3_0).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\real_utilities_volume_1[real_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rebel_planet[adventure_soft_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rhythm_king[supersoft_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rings_of_zilfin_s1[ssi_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rings_of_zilfin_s2[ssi_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rings_of_zilfin_s3[ssi_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rings_of_zilfin_s4[ssi_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rms_titanic[electric_dreams_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\roadblasters[atari_1986](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\roadwar_2000_s1[ssi_1986](v1_2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\roadwar_2000_s2[ssi_1986](v1_2)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\robot_rascals[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\robot_rascals[ea_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rogue_trooper[uxb_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\room_ten[crl_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\room_ten[crl_1986](box_twenty_comp).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rush_n_attack[konami_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\saboteur[durell_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sanxion[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sanxion[thalamus_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\scooby_doo[elite_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\scooby_doo[elite_1986](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\scrabble_deluxe[leisure_genius_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\scrabble_deluxe[leisure_genius_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\seabase_delta[firebird_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\seeraeuber[svs_1986](german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sentinel[firebird_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shackled[data_east_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shanghai[activision_1986](ntsc)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shanghai[activision_1986](ntsc)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shanghai[activision_1986](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shanghai[activision_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shanghai[activision_1986](pal)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shao_lins_road[the_edge_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shard_of_spring_s1[ssi_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shard_of_spring_s1[ssi_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shard_of_spring_s2[ssi_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shogun[mastertronic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\short_circuit[ocean_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sigma_seven[durell_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silicon_dreams[firebird_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silicon_dreams[level9_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sky_runner[cascade_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\solar_star[microdaft_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\space_the_ultimate_frontier[gvp_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\space_the_ultimate_frontier[ufland_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spanish[artworx_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\speech[superior_software_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\speed_king[mastertronic_1986](atari_data).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\speed_king[mastertronic_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spell_right_s1[activision_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spell_right_s2[activision_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spindizzy[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spindizzy[electric_dreams_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spite_and_malice[cosmi_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\starglider[rainbird_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\starglider[rainbird_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\starship_andromeda_s1[ariolasoft_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\starship_andromeda_s2[ariolasoft_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_fleet_i[interstel_1986](2nd_edition)(manual)(alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_fleet_i[interstel_1986](2nd_edition)(manual)(alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_fleet_i[interstel_1986](2nd_edition)(manual)(alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_fleet_i[interstel_1986](2nd_edition)(manual).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_painter[cybex_1986](pal)(german).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trekking_ii[ufland_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_promethean_prophecy_s1[simon-schuster_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_promethean_prophecy_s1[simon-schuster_1986](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_promethean_prophecy_s2[simon-schuster_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_promethean_prophecy_s2[simon-schuster_1986](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\storm[mastertronic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\strike_force_cobra[uxb_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\strike_force_harrier[mirrorsoft_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superkit_2_0_s1[prism_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superkit_2_0_s2[prism_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superstar_ping_pong[silvertime_1986](cyan1)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_boulder_dash_s1[ea_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_boulder_dash_s2[ea_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_cycle[epyx_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_huey_ii[cosmi_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_sprint[electric_dreams_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_sunday_stat_compiler_trade_player[quest_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tarzan[martech_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tass_times_in_tonetown_s1[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tass_times_in_tonetown_s1[activision_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tass_times_in_tonetown_s2[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tau_ceti[crl_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\terra_cresta[imagine_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thai_boxing[anco_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thai_boxing[anco_1986](c128)(fat).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thalamus_hits_1986-1988_s1[thalamus_1989](delta-sanxion).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thalamus_hits_1986-1988_s2[thalamus_1989](hunters_moon-quedex).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\theatre_europe[datasoft_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_eidolon[activision_1986](pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_great_escape[ocean_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_great_escape[thunder_mtn_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_musician[melody_hall_1986](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_musician[melody_hall_1986](alt2)(bad).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_musician[melody_hall_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_pawn_s1[magnetic_scrolls_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_pawn_s2[magnetic_scrolls_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\through_the_trapdoor[macmillan_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thrust-ninja_master[firebird_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thrust[firebird_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_mtn_action_pak_vol1_s1[thunder_mtn_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_mtn_action_pak_vol1_s2[thunder_mtn_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_mtn_action_pak_vol1_s3[thunder_mtn_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\thunder_mtn_action_pak_vol1_s4[thunder_mtn_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tomahawk[datasoft_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tomahawk[datasoft_1986](ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tomahawk[digital_integration_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tomahawk[digital_integration_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\top_gunner_collection_s1[microprose_1986](rl4)(maybe_patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\top_gunner_collection_s1[microprose_1986](rl4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\top_gunner_collection_s2[microprose_1986](rl4)(maybe_patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\top_gunner_collection_s2[microprose_1986](rl4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\top_gun[ocean_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\touchdown-10pin[tri-micro_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\touchdown_football[ea_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\toy_shop_s1[br0derbund_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\toy_shop_s2[br0derbund_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\toy_shop_s3[br0derbund_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\toy_shop_s4[br0derbund_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\toy_shop_s5[br0derbund_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\toy_shop_s6[br0derbund_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trailblazer[gremlin_1986](cyan2)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trailblazer[mindscape_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trailblazer[mindscape_1986](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\transformers_s1[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\transformers_s2[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trinity_s1[infocom_1986](c128)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trinity_s1[infocom_1986](c128)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trinity_s2[infocom_1986](c128)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trinity_s2[infocom_1986](c128)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\triple_pack_s1[access_1986](beach-head_i_and_ii)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\triple_pack_s1[access_1986](beach-head_i_and_ii)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\triple_pack_s2[access_1986](raid_over_moscow)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_genus_edition_s1[domark_1986](08-20-86)(pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_genus_edition_s1[domark_1986](10-09-86)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trivial_pursuit_genus_edition_s2[domark_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\turbo_esprit[durell_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\turbo_mirv[cosmi_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\two_for_one[mastertronic_1986](phantom_asteroid-hektik)(pal)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\uchi-mata[martech_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\uchi_mata[mindscape_1986](ntsc).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_iv_s1_program[origin_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_iv_s2_towne[origin_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_iv_s3_britannia[origin_1986](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_iv_s3_britannia[origin_1986](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_iv_s3_britannia[origin_1986](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_iv_s3_britannia[origin_1986](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_iv_s3_britannia[origin_1986](alt5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_iv_s3_britannia[origin_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_iv_s4_underworld[origin_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_iv_s4_underworld[origin_1986](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_i[origin_1986](alt1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_i[origin_1986](alt2).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_i[origin_1986](alt3).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_i[origin_1986](alt4).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_i[origin_1986](alt5).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_i[origin_1986](alt6).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_i[origin_1986](alt7).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultima_i[origin_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultrabyte_3_s1[ultrabyte_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ultrabyte_3_s2[ultrabyte_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\uridium[hewson_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\uridium[mindscape_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\valucalc[melody_hall_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\video_poker-vegas_jackpot[mastertronic_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\video_vegas[baudville_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vorpal_utility_kit[epyx_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vorpal_utility_kit[epyx_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\war[martech_1986](tracksync)(patched).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\war[martech_1986](tracksync).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\war_play[anco_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\werner_mach_hin_s1[ariolasoft_1986](pal)(tracksync)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\werner_mach_hin_s2[ariolasoft_1986](pal)(tracksync).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\where_in_world_is_carmen_sandiego_s1[br0derbund_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\where_in_world_is_carmen_sandiego_s1[br0derbund_1986](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\where_in_world_is_carmen_sandiego_s2[br0derbund_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\where_in_world_is_carmen_sandiego_s2[br0derbund_1986](alt)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizards_crown_s1[ssi_1986](v1_1)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizards_crown_s1[ssi_1986](v1_3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizards_crown_s2[ssi_1986](v1_3)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizards_crown_s2[ssi_1986](v1_x).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizard_and_the_princess[impulse_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wordpro_s1[spinnaker_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wordpro_s2[spinnaker_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\word_zapper_i[micrograms_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\worlds_greatest_baseball_enhanced_s1[epyx_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\worlds_greatest_baseball_enhanced_s2[epyx_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\worlds_greatest_baseball_enhanced_s3[epyx_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\worlds_greatest_baseball_enhanced_s4[epyx_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_games[cosmi_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_games_s1[epyx_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_games_s1[epyx_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_games_s1[epyx_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_games_s2[epyx_1986](alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_games_s2[epyx_1986](ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_games_s2[epyx_1986](pal).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_karate_champ[epyx_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wrath_of_denethenor_s1[sierra_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wrath_of_denethenor_s2[sierra_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wrath_of_denethenor_s3[sierra_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wrath_of_denethenor_s4[sierra_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\x\xevious[us_gold_1986](pal)(cyan1).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\z-pilot[spinnaker_1986](cyan1)(ntsc)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\z-pilot[spinnaker_1986](cyan1)(ntsc)(alt).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zippyfloppy[trillium_1986].zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zoids[activision_1986](!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zork_i_s1[infocom_1986](r52)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zork_i_s2[infocom_1986](r52)(!).zip |
#    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zyron[kingsoft_1986](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\2_on_one_4[mastertronic](bmx_trials-1985)(#4)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\2_on_one_4[mastertronic](bmx_trials-1985)(#4)(alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\2_on_one_4[mastertronic](bmx_trials-1985)(#4)(alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\0\2_on_one_4[mastertronic](bmx_trials-1985)(df)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\abc_caterpillar[avalon_hill_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ace[cascade_1985](plus4).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\acrojet[microprose_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\action_biker[mastertronic_1985](aj)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\action_biker[mastertronic_1985](atari)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\action_biker[mastertronic_1985](pp)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\activision_demo_1[activision_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\activision_demo_1[activision_1985](alt)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\activision_demo_3[activision_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\advanced_music_system_s1[firebird_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\advanced_music_system_s2[firebird_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\adventures_of_buckaroo_banzai_s1[adventure_intl_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\adventures_of_buckaroo_banzai_s2[adventure_intl_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\adventure_master[gvp_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\adventure_master[gvp_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\adventure_master[gvp_1985](alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\adventure_master[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airwolf[elite_1985](encore)(pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\airwolf[elite_1985](encore)(pal)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alcazar[activision_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alge-blaster_s1[davidson_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alge-blaster_s2[davidson_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alice_in_wonderland_s1[windham_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alice_in_wonderland_s1[windham_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alice_in_wonderland_s1[windham_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alice_in_wonderland_s2[windham_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alice_in_wonderland_s2[windham_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alien[gvp_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alien[gvp_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alpine_encounter_s1[random_house_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alpine_encounter_s2[random_house_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternate_reality_the_city_s1[datasoft_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternate_reality_the_city_s1[datasoft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternate_reality_the_city_s2[datasoft_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternate_reality_the_city_s2[datasoft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternate_reality_the_city_s3[datasoft_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\alternate_reality_the_city_s3[datasoft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\anter_planter[romik_software_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ant_attack[mastertronic_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\ant_attack[mastertronic_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\apollo[fss_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arcade_action[gvp_1985](ntsc)(alt)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\archon_ii[ea_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\archon_ii[ea_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\arc_of_yesod[firebird_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\asylum[screenplay_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\asylum[screenplay_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\atlantis_s1[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\atlantis_s1[ariolasoft_1985](german)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\atlantis_s2[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\atomic_challenger[gvp_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\atomic_challenger[gvp_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\autoduel_s1[origin_1985](03)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\autoduel_s1[origin_1985](aa)(alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\autoduel_s1[origin_1985](aa)(alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\autoduel_s1[origin_1985](aa).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\autoduel_s2[origin_1985](0b)(alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\autoduel_s2[origin_1985](0b)(alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\autoduel_s2[origin_1985](0b)(alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\autoduel_s2[origin_1985](0b).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\a_mind_forever_voyaging_s1[infocom_1985](c128)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\a_mind_forever_voyaging_s2[infocom_1985](c128)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\a_pac_a_lips_now[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\a\a_view_to_a_kill[domark_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\ballblazer[activision_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\ballblazer[epyx_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\ballblazer[epyx_1985](ntsc)(alt)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\ballyhoo[infocom_1985](r97)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\baltic_1985_when_superpowers_collide[ssi_1984].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bank_street_filer[br0derbund_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bank_street_writer[br0derbund_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_s1_boot[ea_1985](newer)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_s1_boot[ea_1985](older)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_s1_boot[ea_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_s2_city[ea_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_s2_city[ea_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bards_tale_s3_dungeon[ea_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\basic-128[abacus_1985](v1_03).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_of_antietam[ssi_1985](v1_2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_of_the_bulge[gvp_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_of_the_bulge[gvp_1985](alt)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\battle_of_the_parthian_kings[avalon_hill_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\beach-head_ii[access_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\better_working_word_processor_s1[spinnaker_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\better_working_word_processor_s2[spinnaker_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\beyond_forbidden_forest[cosmi_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\beyond_forbidden_forest[us_gold_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bike_hike[learning_technologies_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bits_pieces_and_clues[gvp_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bits_pieces_and_clues[gvp_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bits_pieces_and_clues[gvp_1985](alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bits_pieces_and_clues[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\black_thunder[avalon_hill_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\black_thunder[quicksilva_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\board_game_challengers[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bobsterm_pro[pps_1985](v1_9).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\body_transparent[designware_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\booga-boo[quicksilva_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\border_zone_s1[infocom_1985](r9).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\border_zone_s2[infocom_1985](r9).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\borrowed_time_s1[activision_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\borrowed_time_s2[activision_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\borrowed_time_s2[activision_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\borrowed_time_s2[activision_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\boulder_dash_ii[first_star_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\boulder_dash_ii[ozisoft_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bounder-metabolis[gremlin_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bounty_bob_strikes_back[big_five_1985](v1_2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bounty_bob_strikes_back[ozisoft_1985](pal)(australia).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bounty_bob_strikes_back[us_gold_1985](gs)(pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bounty_bob_strikes_back[us_gold_1985](mi)(pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\bridge_baron[thomas_throop_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\brimstone_s1[synapse_1985](manual)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\brimstone_s2[synapse_1985](manual)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\b\brimstone_s3[synapse_1985](manual)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cadpak_2[abacus_1985](light_pen)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cartoon_programmer[fisher-price_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\caverns_of_xydrahpur[gepo_soft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\championship_boxing[sierra_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\championship_boxing[sierra_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chess_champion[gvp_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chess_champion[gvp_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chickin_chase[firebird_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chimera[firebird_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chipwits[epyx_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\chipwits[epyx_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\codename_mat_ii[domark_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\colonial_conquest_s1[ssi_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\colonial_conquest_s2[ssi_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\color_me[mindscape_1985](patched-fixed_syncs).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\color_me[mindscape_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\color_me_kids_picture_disk[mindscape_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\color_me_rainbow_brite_picture_disk[mindscape_1985](bad-t19s11-t20s11).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\colossus_chess_4[cds_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\com-drum_digital_drum_system[datel_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\commando[elite_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\commodore_128_tutorial[cbm_1985[.zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\common_sense[cbm_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\complete_fireworks_celebration_kit[activision_1985](dealer_demo).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\computer_ambush[ssi_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cops_and_robbers[atlantis_1985](g2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64[central_point_1985](v1_5).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64[central_point_1985](v2_6).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64[central_point_1985](v2_7)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64[central_point_1985](v2_8).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64[central_point_1985](v3_0).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_ii_64[central_point_1985](v3_1)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\copy_q_ii[q-rd_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cosmic_balance[ssi_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\countdown_to_shutdown[activision_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\countdown_to_shutdown[activision_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\countdown_to_shutdown[activision_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\countdown_to_shutdown[activision_1985](alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\countdown_to_shutdown[activision_1985](alt4).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\court_side_college_basketball_game[lance_haffner_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\court_side_college_current_teams[lance_haffner_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\court_side_draft_trade_change_ratings[lance_haffner_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\court_side_standings_league_leaders[lance_haffner_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\court_side_teams_of_f4_tourney[lance_haffner_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cpm_3_0_system_s1[commodore_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cpm_3_0_system_s2[commodore_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\creative_contraptions[firebird_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crimson_crown_s1[penguin_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crimson_crown_s1[penguin_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crimson_crown_s1[penguin_1985](alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crimson_crown_s1[penguin_1985](v2)(alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crimson_crown_s1[penguin_1985](v2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crimson_crown_s1[penguin_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crimson_crown_s2[penguin_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crimson_crown_s2[penguin_1985](v2)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\cromwell_house[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crosscheck[datasoft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crossword_magic[mindscape_1985](sync_length_check)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crossword_magic[mindscape_1985](sync_length_check).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\c\crusade_in_europe[microprose_1985](manual)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dallas_quest[us_gold_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dave_winfields_batter_up_s1_practice_slugfest[avant-garde_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dave_winfields_batter_up_s2_tutorial_lesson[avant-garde_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deactivators[tigress_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\decision_in_the_desert[microprose_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\decision_in_the_desert[microprose_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deja_vu_s1[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deja_vu_s2[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deja_vu_s3[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\deja_vu_s4[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\desert_fox[us_gold_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\destiny_s1[destiny_1985](rl2)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\destiny_s1[destiny_1985](rl2)(bb-patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\destiny_s1[destiny_1985](rl2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\destiny_s2[destiny_1985](rl2)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\destiny_s2[destiny_1985](rl2)(bb-patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\destiny_s2[destiny_1985](rl2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\di-sector_v3_0[starpoint_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diskmaker[basix_softworx_1985](v2_2)(black_disk)(track_sync).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diskmaker[basix_softworx_1985](v2_2)(red_disk)(track_sync).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diskmaker[basix_softworx_1985](v2_2)(red_disk_alt)(track_sync).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diskmaker[basix_softworx_1985](v3_3)(black_disk).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\diskmaker[basix_softworx_1985](v3_3)(green_disk).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\d\dolphins_rune[mindscape_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\eagles[hewson_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\educator[melody_hall_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\educator[melody_hall_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\elite[firebird_1985](ntsc)(v103085).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\elite[firebird_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\entertainer[melody_hall_1985](melody_hall).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\entertainer[melody_hall_1985](value_time).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\entertainer[melody_hall_1985](value_ware)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\entertainer[melody_hall_1985](value_ware).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\entertainer_2_brain_games[melody_hall_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\entertainer_3_action_adventure[melody_hall_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\epyx_sports_preview[epyx_1985](stand-alone)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\epyx_sports_preview[epyx_1985](vorpal_side_2)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\epyx_toolkit_basic[epyx_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\ernies_big_splash[cbs_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\essex_s1[synapse_1985](manual)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\essex_s2[synapse_1985](manual)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\essex_s3[synapse_1985](manual)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\euphany_2[tco_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\europe_ablaze[ssg_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\e\europe_ablaze[ssg_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fantasy_five[commodore_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fast_tracks[activision_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fellowship_of_the_ring_s1[addison_wesley_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fellowship_of_the_ring_s1[addison_wesley_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fellowship_of_the_ring_s2[addison_wesley_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fellowship_of_the_ring_s2[addison_wesley_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fighting_warrior[melbourne_house_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fight_night[accolade_1985](rl1)(ntsc)(patched)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fight_night[accolade_1985](rl1)(ntsc)(patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fight_night[accolade_1985](rl1)(ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fight_night[accolade_1985](rl6)(ntsc)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fight_night[accolade_1985](rl6)(ntsc)(patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fight_night[accolade_1985](rl6)(ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\fight_night[us_gold_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\finance_i[green_valley_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\five-a-side_soccer[mastertronic_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\forbidden_castle[laing_marketing_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\frak[state_soft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\frankie_crashed_on_jupiter[kingsoft_1985](multi_density).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\frankie_crashed_on_jupiter[kingsoft_1985](patched)(density-t1s20).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\frankie_goes_to_hollywood[ocean_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\frank_brunos_boxing_s1[elite_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\frank_brunos_boxing_s2[elite_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\f\freedom_fighters[gvp_1985](ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\galactic_empire_builder[gvp_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\galactic_empire_builder[gvp_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\galactic_empire_builder[gvp_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamemaker_s1[activision_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamemaker_s1[activision_1985](ntsc)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamemaker_s2[activision_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamemaker_s3[activision_1985](ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gamemaker_s4[activision_1985](ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gato[spectrum_holobyte_1985](ntsc)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gato[spectrum_holobyte_1985](ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.2_apps[berkeley_1985](pal)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.2_apps[berkeley_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.2_apps[berkeley_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.2_system[berkeley_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.2_system[berkeley_1985](pal)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.2_system[berkeley_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\geos_1.2_system[berkeley_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\ghost_mansion_ii[laing_marketing_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\give_my_regards_to_broad_street[mastertronic_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gi_joe_s1[epyx_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gi_joe_s2[epyx_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\golden_oldies_v1_s1[software_creations_1985](ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\golden_oldies_v1_s2[software_creations_1985](ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\golf_construction_set[ariolasoft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\graphic_adventure_creator[incentive_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\great_american_cc_road_race[activision_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\great_american_cc_road_race[activision_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\great_american_cc_road_race[activision_1985](alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\great_american_cc_road_race[activision_1985](alt4).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\great_american_cc_road_race[activision_1985](alt5).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\great_american_cc_road_race[activision_1985](alt6).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\great_american_cc_road_race[activision_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\great_graphic_adventure[incentive_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gridrunner[hesware_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\grolier_educalc[intentional_educations_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gryphon[avalon_hill_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s1[microprose_1985](rl5)(ntsc)(alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s1[microprose_1985](rl5)(ntsc)(alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s1[microprose_1985](rl5)(ntsc)(alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s1[microprose_1985](rl5)(ntsc)(alt4).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s1[microprose_1985](rl5)(ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s1[microprose_1985](rl6)(pal)(patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s1[microprose_1985](rl6)(pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s2[microprose_1985](rl5)(ntsc)(alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s2[microprose_1985](rl5)(ntsc)(alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s2[microprose_1985](rl5)(ntsc)(alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s2[microprose_1985](rl5)(ntsc)(alt4).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s2[microprose_1985](rl5)(ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s2[microprose_1985](rl6)(pal)(patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\g\gunship_s2[microprose_1985](rl6)(pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hacker[activision_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\halley_project[mindscape_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\halley_project[mindscape_1985](diff_version).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\harcon_s1[ariolasoft_1985](pal)(german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\harcon_s1[ariolasoft_1985](pal)(german)(alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\harcon_s2[ariolasoft_1985](pal)(german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hardball[accolade_1985](ntsc)(0c)(patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hardball[accolade_1985](ntsc)(0c).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hardball[accolade_1985](pal)(p4)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hardball[accolade_1985](pal)(p4)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heart_of_africa[ea_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\heart_of_africa[ea_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hero_of_the_golden_talisman[mastertronic_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\highway_encounter[vortex_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hitchhikers_guide[infocom_1985](r58)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hole_in_one_golf[artworx_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\homework_helper_math_s1[spinnaker_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\homework_helper_math_s2[spinnaker_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\homework_helper_math_s3[spinnaker_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\homework_helper_math_s4[spinnaker_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\homework_helper_writing_s1[spinnaker_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\homework_helper_writing_s2[spinnaker_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\homework_helper_writing_s3[spinnaker_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\homework_helper_writing_s4[spinnaker_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\homework_helper_writing_s5[spinnaker_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\home_expense_manager[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\home_finance_organizer_i[one_step_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\home_manager[melody_hall_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\home_manager[melody_hall_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hotel[ariolasoft_1985](german)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hotel[ariolasoft_1985](german).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_wheels[epyx_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_wheels[epyx_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_wheels[epyx_1985](alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_wheels[epyx_1985](alt4).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_wheels[epyx_1985](alt5).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\h\hot_wheels[epyx_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\indians_indians[orange_cherry_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\international_hockey[advantage_artworx_1985](alt)(bad).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\international_hockey[artworx_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\i\isepic[starpoint_1985](v1_2)(sn_4401).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jane__s1_application_disk[cbm_1985](c128).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jane__s2_help_disk[cbm_1985](c128).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeremy_silmans_complete_guide_to_chess_openings_s1[enlightenment_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeremy_silmans_complete_guide_to_chess_openings_s2[enlightenment_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeremy_silmans_complete_guide_to_chess_openings_s3[enlightenment_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeremy_silmans_complete_guide_to_chess_openings_s4[enlightenment_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jeremy_silmans_complete_guide_to_chess_openings_s5[enlightenment_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet[sublogic_1985](v1)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet[sublogic_1985](v1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jet_combat_simulator[epyx_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jingle_disk[thoughtware_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jingle_disk[thoughtware_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jingle_disk[thoughtware_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jingle_disk_85[hitech_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\jump_jet[anco_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\j\just_games-with_a_twist![gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\frank_brunos_boxing_s1[elite_1985](pal)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\frank_brunos_boxing_s2[elite_1985](pal)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\germany_1985[keating_ssi_1983].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kampfgruppe[ssi_1985](v1_2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kampfgruppe[ssi_1985](v1_4)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kampfgruppe[ssi_1985](v1_4).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karateka[br0derbund_1985](ac)(xelock1)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karateka[br0derbund_1985](ka).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karate_champ[data_east_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\karate_champ[data_east_1985](alt)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kennedy_approach[microprose_1985](ac).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kennedy_approach[microprose_1985](cc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kennedy_approach[microprose_1985](de)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\keyboard_cadet_s1[mindscape_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\keyboard_cadet_s2[mindscape_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\keymaster[fss_1985](v1_0).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\keymaster_s1_boot[fss_1985](v1_1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\keymaster_s2_keys[fss_1985](v1_1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kidwriter[spinnaker_1985](6-13-85).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kikstart[mastertronic_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kikstart[mastertronic_1985](atari_data)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kikstart_2[mr_chip_1985](c128).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kitchen_manager[melody_hall_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\koronis_rift[activision_1985](pal)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\koronis_rift[activision_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\koronis_rift[epyx_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\koronis_rift[epyx_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kung-fu_way_of_the_exploding_fist[melbourne_house_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kung-fu_way_of_the_exploding_fist[uxb_1985](08-15-85)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kung-fu_way_of_the_exploding_fist[uxb_1985](09-09-85).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kwik-check[datamost_1985](v_3g)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kwik-check[datamost_1985](v_3h).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kwik-file[datamost_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kwik-pad[datamost_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\kwik-paint[datamost_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\mirror[compumed_1985](v3_0).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\k\seastalker[infocom_1985](r15).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\land_sea_air_adventures[gvp_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\land_sea_air_adventures[gvp_1985](ntsc)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lapis_philisophorum[ariolasoft_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\laser_basic[oasis_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\law_of_the_west_s1[accolade_1985](rl1)(ntsc)(f2)(patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\law_of_the_west_s1[accolade_1985](rl1)(ntsc)(f2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\law_of_the_west_s1[accolade_1985](rl1)(ntsc)(fc)(patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\law_of_the_west_s1[accolade_1985](rl1)(ntsc)(fc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\law_of_the_west_s2[accolade_1985](rl1)(ntsc)(f2)(patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\law_of_the_west_s2[accolade_1985](rl1)(ntsc)(f2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\law_of_the_west_s2[accolade_1985](rl1)(ntsc)(fc)(patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\law_of_the_west_s2[accolade_1985](rl1)(ntsc)(fc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\law_of_the_west_s2[accolade_1985](rl1)(ntsc)(fc-alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lazer_zone[hesware_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lets_count[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\little_computer_people[activision_1985](billy_bob-neal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\little_computer_people[activision_1985](dave_miller-conway).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\little_computer_people[activision_1985](dustin_lyons-mark).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\living_chess_library_play_the_white_pieces_s1[enlightment_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\living_chess_library_play_the_white_pieces_s2[enlightment_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\living_chess_library_play_the_white_pieces_s3[enlightment_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\logo_robot[scholastic_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lord_of_the_rings_s1[melbourne_house_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lord_of_the_rings_s2[melbourne_house_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lunar_outpost[epyx_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lunar_outpost[epyx_1985](ntsc)(alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lunar_outpost[epyx_1985](ntsc)(alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lunar_outpost[epyx_1985](ntsc)(alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\l\lunar_outpost[epyx_1985](ntsc)(alt4).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\macadam_bumper[ere_informatique_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\macadam_bumper[ere_informatique_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mach_128[access_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\maestro[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mandragore[infogrames_1985](french).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mandragore[infogrames_1985](german).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\masters_of_time[cosmi_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\masters_of_time[cosmi_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\master_of_the_lamps[activision_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\master_of_the_lamps_sampler[activision_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\maze_madness[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\megasoft_bbs[megasoft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mercenary[novagen_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\microscribe_light_pen[amicron_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_baseball-gm-owners[micro_league_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_baseball-gm-owners[micro_league_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\micro_league_baseball_1985_teams[micro_league_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mindwheel_s1[synapse_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mindwheel_s2[synapse_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mindwheel_s3[synapse_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\minnesota_fats_pool_challenge[hesware_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\modem_master[video_7_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moebius_s1[origin_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moebius_s1[origin_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moebius_s1[origin_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moebius_s2[origin_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moebius_s2[origin_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moebius_s2[origin_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moebius_s3[origin_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moebius_s3[origin_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moebius_s3[origin_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moebius_s4[origin_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moebius_s4[origin_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\moebius_s4[origin_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\monopoly[leisure_genius_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\movie_creator[fisher-price_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\movie_maker_s1[ea_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\movie_maker_s2[ea_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\movie_maker_s3[ea_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\movie_maker_s4[ea_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mr_do[datasoft_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mr_pixels_cartoon_kit[mindscape_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mr_pixels_programming_paint_set[mindscape_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\music_maker_playalong_pop_classics[commodore_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\music_studio[activision_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\music_studio[activision_1985](earlier).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\music_system_s1[firebird_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\music_system_s2[firebird_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mythos_s1[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\m\mythos_s2[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\neutral_corners_3d_boxing[kab_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\newsroom[springboard_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\newsroom[springboard_1985](newer).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\newsroom_clipart_s1[springboard_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\newsroom_clipart_s1[springboard_1985](newer).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\newsroom_clipart_s2[springboard_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\newsroom_clipart_s2[springboard_1985](newer).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\newsroom_clipart_vol1_s1[springboard_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\newsroom_clipart_vol1_s2[springboard_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\newsroom_clipart_vol2_s1[springboard_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\newsroom_clipart_vol2_s2[springboard_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\newsroom_clipart_vol3_s1[springboard_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\newsroom_clipart_vol3_s2[springboard_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nibelungen_s1[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nibelungen_s2[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nibelungen_s3[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nibelungen_s4[ariolasoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nick_hardy_adventures[real_software_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nine_princes_in_amber_s1[telarium_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nine_princes_in_amber_s1[telarium_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nine_princes_in_amber_s2[telarium_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nine_princes_in_amber_s2[telarium_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nine_princes_in_amber_s2[telarium_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nine_princes_in_amber_s3[telarium_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nine_princes_in_amber_s3[telarium_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nine_princes_in_amber_s4[telarium_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nine_princes_in_amber_s4[telarium_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nine_princes_in_amber_s4[telarium_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nodes_of_yesod[firebird_1985](ntsc)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\nodes_of_yesod[firebird_1985](ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\n\number_tumblers[fisher-price_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\on-track_racing[gamestar_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\o\open_golfing_at_royal_st_georges[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\panzer_grenadier[ssi_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperback_writer_128[digital_solutions_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperback_writer_128[digital_solutions_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperback_writer_128[digital_solutions_1985](alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperback_writer_128[digital_solutions_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperback_writer_dictionary_s1[digital_solutions_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paperback_writer_dictionary_s2[digital_solutions_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paper_airplane_construction_kit_s1[simon-schuster_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paper_airplane_construction_kit_s2[simon-schuster_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paradroid[hewson_1985](pal)(patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paradroid[hewson_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\party_songs[john_henry_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\passport_to_london[green_valley_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paul_whitehead_teaches_chess_s1[enlightenment_1985](german).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paul_whitehead_teaches_chess_s1[enlightenment_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paul_whitehead_teaches_chess_s2[enlightenment_1985](german).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paul_whitehead_teaches_chess_s2[enlightenment_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paul_whitehead_teaches_chess_s3[enlightenment_1985](german).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paul_whitehead_teaches_chess_s3[enlightenment_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\paul_whitehead_teaches_chess_s4[enlightenment_1985](german).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\peek_a_byte_64[quantum_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\peg_out[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\perry_mason_s1[telarium_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\perry_mason_s1[telarium_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\perry_mason_s1[telarium_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\perry_mason_s2[telarium_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\perry_mason_s2[telarium_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\perry_mason_s2[telarium_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\perry_mason_s3[telarium_1985](alt)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\perry_mason_s3[telarium_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\perry_mason_s4[telarium_1985](alt)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\perry_mason_s4[telarium_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_s1[ssi_1985](v1_0)(ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_s1[ssi_1985](v1_1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_s1[ssi_1985](v1_2)(ntsc)(g2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_s1[ssi_1985](v1_3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_s1[ssi_1985](v1_4)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_s1[ssi_1985](v1_4).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_s2[ssi_1985](v1_0)(ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_s2[ssi_1985](v1_1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_s2[ssi_1985](v1_3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_s2[ssi_1985](v1_4)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\phantasie_s2[ssi_1985](v1_4).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pitstop[epyx_1985](atari_data).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\planetfall[infocom_1985](r37)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\plus-paket_64 [kingsoft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pocket_filer_128[digital_solutions_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pocket_filer_2[digital_solutions_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pocket_filer_64[digital_solutions_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\printmaster[berkeley_softworks_1985](g2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\printmaster_art_gallery_i[berkeley_softworks_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\printmaster_art_gallery_i[berkeley_softworks_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_space_station[hes_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\project_space_station[hes_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pro_boxing[artworx_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_baseball_1985_teams[software_simulations_1986].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_baseball_1985_teams[sublogic_1986](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pure-stat_baseball_1985_teams[sublogic_1986](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\p\pyros_pyramid[omega_enterprises_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\q-bert[data_east_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\quake_minus_one[mindscape_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questprobe_fantastic_four[gvp_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\questprobe_spider-man[gvp_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\q\quiwi[kingsoft_1985](german)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\racing_destruction_set_s1[ea_1985](newer)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\racing_destruction_set_s2[ea_1985](newer)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\raid_on_bungeling_bay[ariolasoft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rambo_first_blood_part_ii[ocean_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rambo_first_blood_part_ii[thunder_mtn_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rasputin[firebird_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\recipe_box[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\red_arrows[database_software_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\remember[designware_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rescue_on_fractalus[activision_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rescue_on_fractalus[epyx_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rescue_on_fractalus[epyx_1985](ntsc)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\revs[firebird_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\road_rally_usa[bantam_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rocky_horror_show[crl_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rock_n_bolt[activision_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rock_n_wrestle[melbourne_house_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\r\rock_n_wrestle[prism_leisure_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\scarabaeus[ariolasoft_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\scarab[gepo_soft_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\seastalker[infocom_1985](r16)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\shadowfire[mindscape_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sherlock_holmes[firebird_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sideways[timeworks_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silent_service[microprose_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silent_service[microprose_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silent_service[microprose_1985](alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silent_service[microprose_1985](rl1)(ntsc)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silent_service[microprose_1985](rl1)(ntsc)(patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silent_service[microprose_1985](rl1)(ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silent_service[microprose_1985](rl6)(ntsc)(alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silent_service[microprose_1985](rl6)(ntsc).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silent_service[microprose_1985](rl6)(pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\silent_service[microprose_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sixgun_shootout[ssi_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\ski_writer[mastertronic_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\skyfox[ea_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sky_fighters[gvp_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sky_fighters[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\slot_car_racer[thunder_mtn_1985](vmax2)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\slot_car_racer[thunder_mtn_1985](vmax2)(patched).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\slugger[mastertronic_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\snoopy_writer_s1[random_house_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\snoopy_writer_s2[random_house_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\solo_flight_2[microprose_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\solo_flight_2[microprose_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\solo_flight_2[microprose_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\souls_of_darkon[taskset_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\speedy_delivery[litag_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spellbreaker[infocom_1985](r63)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spell_of_destruction[mindscape_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spitfire_40[avalon_hill_1985](rl2)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spitfire_40[avalon_hill_1985](rl2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spitfire_40[mirrorsoft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spooks[mastertronic_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spooks[mastertronic_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spooks[mastertronic_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\spy_vs_spy_the_island_caper[first_star_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\stardatei[cybex_1985](pal)(german).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\starion[melbourne_house_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_rank_boxing[activision_1985](vmax1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_rank_boxing[gamestar_1985](vmax0)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_rank_boxing[gamestar_1985](vmax0)(alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_rank_boxing[gamestar_1985](vmax0)(alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_evolution[gvp_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_evolution[gvp_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_evolution[gvp_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_evolution[gvp_1985](alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_kobayashi_alternative_s1[simon-schuster_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_kobayashi_alternative_s1[simon-schuster_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_kobayashi_alternative_s1[simon-schuster_1985](v1_2)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_kobayashi_alternative_s2[simon-schuster_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_kobayashi_alternative_s2[simon-schuster_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\star_trek_kobayashi_alternative_s2[simon-schuster_1985](v1_2)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\steve_davis_snooker[cds_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\stickybear_typing[optimum_resource_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\stinger[cygnus_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\story_tree_s1[scholastic_1985](v1_3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\story_tree_s2[scholastic_1985](v1_3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\strike_force_cobra[uxb_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\strike_force_cobra[uxb_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\strip_poker_ii[data_stream_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\stunt_flyer[sierra_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sublogic_scenery_11[sublogic_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sublogic_scenery_3[sublogic_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sublogic_scenery_4[sublogic_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sublogic_scenery_5[sublogic_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sublogic_scenery_7[sublogic_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_games_ii_s1[epyx_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_games_ii_s1[epyx_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_games_ii_s1[us_gold_1985](gs-3disk)(pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_games_ii_s1[us_gold_1985](gs-3disk)(pal)(alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_games_ii_s1[us_gold_1985](xx-2disk)(pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_games_ii_s2[epyx_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_games_ii_s2[epyx_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_games_ii_s2[us_gold_1985](gs-3disk)(pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_games_ii_s2[us_gold_1985](xx-2disk)(pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\summer_games_ii_s3[us_gold_1985](gs-3disk)(pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superman[first_star_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\superscript_64[precision_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_bowl_sunday[avalon_hill_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_bowl_sunday[avalon_hill_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_bowl_sunday[avalon_hill_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_bowl_sunday_1985_teams[avalon_hill_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_c[data_becker_1985](v2_01).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_c_128_[data_becker_1985](v3_02).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_huey[cosmi_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_sunday_s1[avalon_hill_1985](v2_3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\super_sunday_s2[avalon_hill_1985](v2_3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\survival_instinct[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\swiftcalc[cosmi_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\swiftserver[cosmi_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\swiftsheet[cosmi_1985](c128).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\sword_of_kadash[dynamix_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\s\syn_calc[synapse_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\temple_of_apshai_trilogy[epyx_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_artist[melody_hall_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_artist[melody_hall_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_artist[melody_hall_1985](alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_artist[melody_hall_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_captive[mastertronic_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_eidolon[lucasfilm_epyx_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_eidolon[lucasfilm_epyx_1985](alt)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_fourth_protocol[bantam_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_goonies[datasoft_1985](original_music)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_goonies[us_gold_1985](new_music)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_last_v8[mastertronic_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_last_v8[mastertronic_1985](c128).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\the_real_you[collins_soft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\time_tunnel[us_gold_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\time_tunnel[us_gold_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\tinks_subtraction_fair[mindscape_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\transylvania[polarware_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\transylvania[polarware_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\transylvania[polarware_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\treasure_island_s1[windham_classics_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\treasure_island_s1[windham_classics_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\treasure_island_s2[windham_classics_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\treasure_island_s2[windham_classics_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\treasure_island_s3[windham_classics_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\treasure_island_s3[windham_classics_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\treasure_island_s4[windham_classics_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\treasure_island_s4[windham_classics_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trio[softsync_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\trolls_and_tribulations[creative_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\turtle_jump[romik_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\t\two_for_one[mastertronic_1985](ice_palace-hopto)(pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\ulysses_and_the_golden_fleece[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\under_fire_s1[avalon_hill_1985](rl6).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\u\under_fire_s2[avalon_hill_1985](rl6).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vizawrite_classic_s1[viza_1985](c128)(pal)(requires_cart).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\vizawrite_classic_s2[viza_1985](c128)(pal)(requires_cart).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\voodoo_castle[adventure_international_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\v\voodoo_castle[adventure_international_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wacky_stories[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\warp_rangers[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\web_dimension[activision_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wild_west[ariolasoft_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\william_wobbler[wizard_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\willow_pattern[firebird_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\willow_pattern_happiest_days[firebird_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\willow_pattern_happiest_days[mrmicro_1985](pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wings_of_war[ssi_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wings_of_war[ssi_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_games_s1[epyx_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_games_s1[epyx_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_games_s1[epyx_1985](xmas-bonus)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_games_s2[epyx_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_games_s2[epyx_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_games_s2[epyx_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\winter_games_s2[epyx_1985](xmas-bonus)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wishbringer[infocom_1985](r68)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wishbringer[infocom_1985](r69)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizard_and_the_princess[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizard_of_oz_s1[windham_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizard_of_oz_s2[windham_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizard_of_oz_s3[windham_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wizard_of_oz_s4[windham_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wordmaster_senior[gvp_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wordmatch_s1[olt_ltd_1985](german).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\wordmatch_s2[olt_ltd_1985](german).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\word_challenge[spinnaker_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\word_writer_128_s1[timeworks_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\word_writer_128_s1[timeworks_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\word_writer_128_s2[timeworks_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\word_writer_128_s2[timeworks_1985].zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\worlds_greatest_football_s1[epyx_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\worlds_greatest_football_s1[epyx_1985](alt).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\worlds_greatest_football_s2[epyx_1985](!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\worlds_greatest_football_s2[epyx_1985](alt1).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\worlds_greatest_football_s2[epyx_1985](alt2).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\worlds_greatest_football_s2[epyx_1985](alt3).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\w\world_geography[ariolasoft_1985](german)(pal).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\y\yaks_progress[llamasoft_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\y\yie_ar_kung_fu[imagine_1985](pal)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\y\yie_ar_kung_fu[konami_1985](ntsc)(!).zip |
    | e:\C64_Preservation_Project_10th_Anniversary_Collection_G64\c64pp-g64-zip\z\zorro[datasoft_1985](!).zip |