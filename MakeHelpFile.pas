program HycHelp(input, output);  { make help file for (DrillSim) HyCalc }


Type
HelpString = string[60];
HelpSet    = Record
               HelpText : array[1..200] of HelpString;
             End;
Var
HelpFile : File of HelpSet;
Help     : HelpSet;
Enter    : String[3];



Procedure SaveFile;
Begin
  Assign(HelpFile,'HYCALC.HLP');
  rewrite(HelpFile);
  write(HelpFile,Help);
  Close(HelpFile);
End;


Procedure InitialiseFile;
Var i,j : integer;
Begin
  With Help do
  Begin
    for i:=1 to 200 do HelpText[i]:='';
    for i:=1 to 200 do
    Begin
      for j:=1 to 60 do HelpText[i]:=HelpText[i] + ' ';
    End;
  End;
End;


Procedure SetHelp;
Begin
  With Help do
  Begin
                                          { max line length = col 74 }
    { HelpScreen #1 }

    HelpText[1]:='This is the Main Menu for HyCalc. You may :-';
    HelpText[2]:='CREATE   - make a new well file';
    HelpText[3]:='EDIT     - change the data in an existing well file';
    HelpText[4]:='OPTIMISE - interactively analyse hydraulic data';
    HelpText[5]:='DRILLSIM - load the drilling simulator';
    HelpText[6]:='PRINT    - produce a printed hydraulic and status report';
    HelpText[7]:='FILES    - change the current file and directory names';
    HelpText[8]:='SETUP    - define the default file and directory names';
    HelpText[9]:='';
    HelpText[10]:='Press a number or '+Enter+', use space or arrows to move bar';

    { HelpScreen #2 - edit }

    HelpText[11]:='            This is the EDIT menu';
    HelpText[12]:='* The options available allow you to change the data in';
    HelpText[13]:='  the Well Data File whose name is shown at the top';
    HelpText[14]:='  right corner of the screen.';
    HelpText[15]:='* To select an option, press the appropriate number';
    HelpText[16]:='  or '+Enter+', use the space bar or arrow keys to move bar';
    HelpText[17]:='* At all times the current Mode Indicator at the top';
    HelpText[18]:='  of the screen will tell you where you are in the';
    HelpText[19]:='  program.';
    HelpText[20]:='* You may also press ESC to return to the Main Menu.';

    { HelpScreen #3 - optimise }

    HelpText[21]:='             This is the OPTIMISE screen';
    HelpText[22]:='EDIT  - allows you to directly modify data in the left';
    HelpText[23]:='        hand box. Use the cursor keys {Up} and {Dn}.';
    HelpText[24]:='        Press ESC to return to the select prompt.';
    HelpText[25]:='';
    HelpText[26]:='MODEL - toggles between Power Law and Bingham models.';
    HelpText[27]:='PRINT - produces a printed report of all the data.';
    HelpText[28]:='SAVE  - saves your optimised parameters to disk.';
    HelpText[29]:='';
    HelpText[30]:='To return to the Main Menu press X or ESC';

    { HelpScreen #4 - print }

    HelpText[31]:='         This is the PRINT OPTIONS menu';
    HelpText[32]:='* Select the model you wish to use to calculate the';
    HelpText[33]:='   hydraulic data. This is printed together with a';
    HelpText[34]:='   summary profile of the well.';
    HelpText[35]:='';
    HelpText[36]:='* Be sure that the printer is ready before printing.';
    HelpText[37]:='';
    HelpText[38]:='* HYCALC.PRN must be in the logged directory.';
    HelpText[39]:='';
    HelpText[40]:='To return to the Main Menu press ESC';

    { HelpScreen #5 - file utils }

    HelpText[41]:='               This is the FILE UTILITIES menu';
    HelpText[42]:='LOAD FILE - make a named file the current file. If the';
    HelpText[43]:='            file  exists it  will be loaded. If not you';
    HelpText[44]:='            will be prompted to continue.';
    HelpText[45]:='';
    HelpText[46]:='LIST FILES - show all .WDF files in current directory.';
    HelpText[47]:='';
    HelpText[48]:='SET PATH   - set a path to a new directory. ';
    HelpText[49]:='';
    HelpText[50]:='Press ESC to exit to the Main Menu';

    { HelpScreen #6 - set defaults }

    HelpText[51]:='           This is the SET DEFAULTS menu';
    HelpText[52]:='DEFAULT DIRECTORY - sets the directory that HyCalc logs';
    HelpText[53]:='                    on to at start up.';
    HelpText[54]:='DEFAULT FILE      - sets the file which will be loaded';
    HelpText[55]:='                    automatically at start up.';
    HelpText[56]:='* These defaults  are saved in  a file in  your start';
    HelpText[57]:='  up directory  called  HYCALC.CFG';
    HelpText[58]:='* An  invalid  default path  will  result in an error';
    HelpText[59]:='  message  at start  up.  Invalid files  are ignored.';
    HelpText[60]:='Press ESC to exit to the Main Menu.';

    { HelpScreen #7 - general }

    HelpText[61]:='';
    HelpText[62]:='';
    HelpText[63]:='';
    HelpText[64]:='';
    HelpText[65]:='';
    HelpText[66]:='';
    HelpText[67]:='';
    HelpText[68]:='';
    HelpText[69]:='';
    HelpText[70]:='';

{    HelpText[61]:='This screen  is used to  enter the  general  data about';
    HelpText[62]:='the well. Type the correct response and press Enter.';
    HelpText[63]:='';
    HelpText[64]:='The name of the operating  company and  well  can be up';
    HelpText[65]:='to characters long.';
    HelpText[66]:='';
    HelpText[67]:='If you  select the  offshore option,  you will be asked';
    HelpText[68]:='for the type of  well head  and the  water depth.';
    HelpText[69]:='';
    HelpText[70]:='';
 }
    { HelpScreen #8 - hole }

    HelpText[71]:='';
    HelpText[72]:='';
    HelpText[73]:='';
    HelpText[74]:='';
    HelpText[75]:='';
    HelpText[76]:='';
    HelpText[77]:='';
    HelpText[78]:='';
    HelpText[79]:='';
    HelpText[80]:='Press ESC to exit to the Main Menu.';

    { HelpScreen #9 - pipe }

    HelpText[81]:='';
    HelpText[82]:='';
    HelpText[83]:='';
    HelpText[84]:='';
    HelpText[85]:='';
    HelpText[86]:='';
    HelpText[87]:='';
    HelpText[88]:='';
    HelpText[89]:='';
    HelpText[90]:='Press ESC to exit to the Main Menu.';

    { HelpScreen #10 - bit }

    HelpText[91]:='';
    HelpText[92]:='';
    HelpText[93]:='';
    HelpText[94]:='';
    HelpText[95]:='';
    HelpText[96]:='';
    HelpText[97]:='';
    HelpText[98]:='';
    HelpText[99]:='';
    HelpText[100]:='Press ESC to exit to the Main Menu.';

    { HelpScreen #11 - mud }

    HelpText[101]:='';
    HelpText[102]:='';
    HelpText[103]:='';
    HelpText[104]:='';
    HelpText[105]:='';
    HelpText[106]:='';
    HelpText[107]:='';
    HelpText[108]:='';
    HelpText[109]:='';
    HelpText[110]:='Press ESC to exit to the Main Menu.';

    { HelpScreen #12 - pump }

    HelpText[111]:='';
    HelpText[112]:='';
    HelpText[113]:='';
    HelpText[114]:='';
    HelpText[115]:='';
    HelpText[116]:='';
    HelpText[117]:='';
    HelpText[118]:='';
    HelpText[119]:='';
    HelpText[120]:='Press ESC to exit to the Main Menu.';

    { HelpScreen #13 - surf.equip }

    HelpText[121]:='';
    HelpText[122]:='';
    HelpText[123]:='';
    HelpText[124]:='';
    HelpText[125]:='';
    HelpText[126]:='';
    HelpText[127]:='';
    HelpText[128]:='';
    HelpText[129]:='';
    HelpText[130]:='Press ESC to exit to the Main Menu.';

    { HelpScreen #14 - units }

    HelpText[131]:='';
    HelpText[132]:='';
    HelpText[133]:='';
    HelpText[134]:='';
    HelpText[135]:='';
    HelpText[136]:='';
    HelpText[137]:='';
    HelpText[138]:='';
    HelpText[139]:='';
    HelpText[140]:='Press ESC to exit to the Main Menu.';

    { HelpScreen #15 - unused }

    HelpText[141]:='';
    HelpText[142]:='';
    HelpText[143]:='';
    HelpText[144]:='';
    HelpText[145]:='';
    HelpText[146]:='';
    HelpText[147]:='';
    HelpText[148]:='';
    HelpText[149]:='';
    HelpText[150]:='Press ESC to exit to the Main Menu.';

    { HelpScreen #16 - unused }

    HelpText[151]:='';
    HelpText[152]:='';
    HelpText[153]:='';
    HelpText[154]:='';
    HelpText[155]:='';
    HelpText[156]:='';
    HelpText[157]:='';
    HelpText[158]:='';
    HelpText[159]:='';
    HelpText[160]:='Press ESC to exit to the Main Menu.';

    { HelpScreen #17 - unused }

    HelpText[161]:='';
    HelpText[162]:='';
    HelpText[163]:='';
    HelpText[164]:='';
    HelpText[165]:='';
    HelpText[166]:='';
    HelpText[167]:='';
    HelpText[168]:='';
    HelpText[169]:='';
    HelpText[170]:='Press ESC to exit to the Main Menu.';

    { HelpScreen #18 - unused }

    HelpText[171]:='';
    HelpText[172]:='';
    HelpText[173]:='';
    HelpText[174]:='';
    HelpText[175]:='';
    HelpText[176]:='';
    HelpText[177]:='';
    HelpText[178]:='';
    HelpText[179]:='';
    HelpText[180]:='Press ESC to exit to the Main Menu.';

    { HelpScreen #19 - Demo error }

    HelpText[181]:='This is a  demonstration  version of HYCALC. It is';
    HelpText[182]:='not  possible to save a hole file.  For a fully';
    HelpText[183]:='functional copy of HYCALC please contact :';
    HelpText[184]:='';
    HelpText[185]:='Ambersoft Oilfield Applications,';
    HelpText[186]:='188 Warwick Road,';
    HelpText[187]:='Basingstoke,  Hampshire,';
    HelpText[188]:='United Kingdom, RG23 8EB';
    HelpText[189]:='Tel. (0256) 463009';
    HelpText[190]:='';

    { HelpScreen #20 - hole geometry / pipe geometry error }

    HelpText[191]:='There is an error in the configuration of the hole';
    HelpText[192]:='geometry or the drill string.';
    HelpText[193]:='';
    HelpText[194]:='This is due to one or both of the following :';
    HelpText[195]:='(i)  Pipe ID is greater than Pipe OD';
    HelpText[196]:='(ii) Pipe OD is greater than Hole ID';

    HelpText[197]:='';
    HelpText[198]:='Press any key to re-enter hole and pipe data.';
    HelpText[199]:='';
    HelpText[200]:='';

  End;
End;

Begin
  Enter := chr($11) + chr($cd) + chr($bc);
  writeln;
  writeln('writing HYCALC.HLP help file.');
  writeln;
  InitialiseFile;
  SaveFile;
  SetHelp;
  SaveFile;
End.
