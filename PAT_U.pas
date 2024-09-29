unit PAT_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.Buttons, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    pgcPAT: TPageControl;
    tbsHome: TTabSheet;
    tbsMenu: TTabSheet;
    tbsGame: TTabSheet;
    tbsEnd: TTabSheet;
    imgBackGroundMenu: TImage;
    imgBackgroundHome: TImage;
    lblGameTitle: TLabel;
    btnPlay: TButton;
    imgMinus: TImage;
    imgTimes: TImage;
    imgEquals: TImage;
    imgDivide: TImage;
    imgPlus: TImage;
    imgGuy: TImage;
    rgpDifficulty: TRadioGroup;
    rgpAvatar: TRadioGroup;
    btnPlayMenu: TButton;
    imgCat: TImage;
    ImgDog: TImage;
    imgGoatinelli: TImage;
    btnBacktoHome: TButton;
    imgGameBackground: TImage;
    imgEndScreenBackground: TImage;
    pnlGame: TPanel;
    lblSign: TLabel;
    lblComment: TLabel;
    imgPause: TImage;
    imgComputer: TImage;
    ImgFinishLine: TImage;
    lblEndComment: TLabel;
    btnplayAgainY: TButton;
    btnplayAgainN: TButton;
    BitBtnCloseGame: TBitBtn;
    lblPlayAgain: TLabel;
    tbsInstructions: TTabSheet;
    imgBackgroudInstructions: TImage;
    lblHowToPlay: TLabel;
    bithowToPlay: TBitBtn;
    imgEnd: TImage;
    imgAvatarG: TImage;
    lblInstruction1: TLabel;
    lblInstruction2: TLabel;
    lblInstruction3: TLabel;
    lblInstruction4: TLabel;
    lblGoodluck: TLabel;
    btnbacktomenu: TButton;
    btnConfirm: TButton;
    lblDifficultyV: TLabel;
    lblAvatarV: TLabel;
    lblNo2: TLabel;
    lblNo1: TLabel;
    pnltimer: TPanel;
    tmrTime: TTimer;
    lblStart: TLabel;
    lblTimelefttitle: TLabel;
    lblTimeLeft: TLabel;
    chxQuestionTimer: TCheckBox;
    lblQuestionTimer: TLabel;
    tmrQuestionTime: TTimer;
    pnlPaused: TPanel;
    btnUnpause: TButton;
    btnPauseToMenu: TButton;
    sedAnswer: TSpinEdit;
    lblPauseTitle: TLabel;
    lblTimesUp: TLabel;
    bitCloseGamePause: TBitBtn;
    lblusernametitle: TLabel;
    edtUsername: TEdit;
    lblWelcome: TLabel;
    lblUsernameV: TLabel;
    lblUsernameLong: TLabel;
    lblCorrect: TLabel;
    procedure btnPlayClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnBacktoHomeClick(Sender: TObject);
    procedure btnbacktomenuClick(Sender: TObject);
    procedure bithowToPlayClick(Sender: TObject);
    procedure btnPlayMenuClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure tmrTimeTimer(Sender: TObject);
    procedure tmrQuestionTimeTimer(Sender: TObject);
    procedure imgPauseClick(Sender: TObject);
    procedure btnUnpauseClick(Sender: TObject);
    procedure btnPauseToMenuClick(Sender: TObject);
    procedure btnplayAgainYClick(Sender: TObject);
    procedure btnplayAgainNClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  bAll, bPaused: boolean;
  rSum: real;
  iDifficulty, iTime, iTotalTime, iComputerMovement, iTotalQtime, iQTime, iNo1,
    iNo2, iSign, iOGAvatarLeft, iOGComputerLeft, iTooEasyQuestion,
    iMaxEasyQuestion, iAnswer: integer;
  sUSername: string;

implementation

{$R *.dfm}

procedure TForm1.bithowToPlayClick(Sender: TObject);
begin
  pgcPAT.ActivePage := tbsInstructions; // Takes user to How To Play screen

end;

procedure TForm1.btnBacktoHomeClick(Sender: TObject);
begin // Takes user back to the home screen from the menu screen
  pgcPAT.ActivePage := tbsHome;

end;

procedure TForm1.btnbacktomenuClick(Sender: TObject);
begin // Takes user back to the menu screen from the How to Play screen
  pgcPAT.ActivePage := tbsHome;
end;

procedure TForm1.btnConfirmClick(Sender: TObject);
var
  iNo1, iNo2, iSign, iRange: integer;
begin
  if bAll = true then
  begin
    iAnswer := sedAnswer.value;
    sedAnswer.SetFocus;

    if rSum = iAnswer then
    begin
      lblComment.Font.Color := clLime;
      lblCorrect.Caption := '';
      lblComment.Caption := 'Correct!'; // Sutible message for correct answer
      imgAvatarG.Left := imgAvatarG.Left + 50;
      // User's Avatar moves towards finish line
      imgAvatarG.Repaint;
      sleep(100);
      Form1.Refresh;
    end
    else
    begin
      lblComment.Font.Color := clRed;
      lblComment.Caption := 'Wrong :/!'; // Sutible message for incorrect answer
      lblCorrect.Caption := 'Correct Answer : ' + floattostr(rSum);
      // Computer's Avatar moves towards finish line
      imgComputer.Left := imgComputer.Left + 50;
      imgComputer.Repaint;
      sleep(100);
      Form1.Refresh;
    end;
    iRange := 20;
    iNo1 := 0; // Initialising variable
    iNo2 := 0; // Initialising variable
    iSign := -1; // Initialising variable
    // Before process of getting the numbers and signs, the space must appear blank to the user
    lblNo1.Caption := '';
    lblNo2.Caption := '';
    lblSign.Caption := '';
    // Process of getting the numbers and operation for the question
    case iDifficulty of
      0:
        begin
          // Easy difficultly can only have addition and subtraction
          iSign := random(2) + 1;
          iNo1 := random(11); // Numbers are randomly chosen from 0-10
          iNo2 := random(11);
          iTotalQtime := 10; // Total time the user gets to answer a question

        end;
      1:
        begin
          iSign := random(4) + 1; // Medium difficultly uses 4 basic operations
          iNo1 := random(21); // Numbers are randomly chosen from 0-20
          iNo2 := random(21);
          iTotalQtime := 5; // Total time the user gets to answer a question
          iRange := 20;
        end;
      2:
        begin
          iSign := random(4) + 1; // Hard difficultly uses 4 basic operations
          iNo1 := random(51); // Numbers are randomly chosen from 0-50
          iNo2 := random(51);
          iTotalQtime := 5; // Total time the user gets to answer a question
          iRange := 50;
        end;

    end;

    case iSign of
      1:
        begin
          lblSign.Caption := '+'; // Sum is Addition
          // increases difficulty of Addition sums for Hard Diiculty
          if (iDifficulty = 2) and ((iNo1 < 20) or (iNo2 < 20)) then
          begin
            repeat
              iNo1 := random(100) + 1;
              iNo2 := random(100) + 1;
            until (iNo1 >= 20) and (iNo2 >= 20);

          end;
          rSum := iNo1 + iNo2;
        end;
      2:
        begin
          lblSign.Caption := '-'; // Sum is Subtraction
          // Makes sure easy difficulty doesn't have any negative answers
          if iDifficulty = 0 then
          begin
            repeat
              iNo1 := random(11);
              iNo2 := random(11);
            until iNo1 > iNo2;
          end;
          // increases difficulty of Subtraction sums for Hard Diiculty
          if (iDifficulty = 2) and ((iNo1 < 20) or (iNo2 < 20)) then
          begin
            repeat
              iNo1 := random(100) + 1;
              iNo2 := random(100) + 1;
            until (iNo1 >= 20) and (iNo2 >= 20);
          end;
          rSum := iNo1 - iNo2;
        end;

      3:
        begin
          lblSign.Caption := 'X'; // Sum is Multiplication
          // Makes iNo2 bigger to increse difficulty of the questions
          if iNo2 > 10 then
          begin
            repeat
              iNo2 := random(11);
            until iNo2 <= 10;
          end;

          // limits the amount of easy questions per game
          if (iNo2 in [0 .. 1]) or (iNo1 in [0 .. 1]) then
            // *1 and *0 are too easy
            inc(iTooEasyQuestion);

          if iTooEasyQuestion >= iMaxEasyQuestion then
          begin
            repeat
              iNo1 := random(iRange) + 1; // Range depends on difficulty
              iNo2 := random(iRange) + 1;

            until (iNo2 <> 1) and (iNo2 <> 0); // harder
          end;
          rSum := iNo1 * iNo2;
        end;

      4:
        begin
          lblSign.Caption := '÷'; // Sum is Division
          if iNo2 = 0 then
          begin
            iNo2 := random(iRange) + 1;
          end;
          { Makes sure answer to division questions are natural numbers,
            user won't have to input a decimal number.
            Makes sure user doesn't get a division by 0 question }
          if (iNo1 MOD iNo2 <> 0) or (iNo2 = 0) then
          begin
            repeat
              iNo1 := random(iRange) + 1;
              iNo2 := random(iRange) + 1;
            until (iNo1 MOD iNo2 = 0) and (iNo2 <> 0);

          end;

          // limits the amount of easy questions per game
          if (iNo1 = iNo2) or (iNo2 = 1) then
            inc(iTooEasyQuestion);
          // questions would be too easy
          if iTooEasyQuestion >= iMaxEasyQuestion then
          begin
            repeat
              iNo1 := random(iRange) + 1;
              iNo2 := random(iRange) + 1;

            until ((iNo1 <> iNo2) and (iNo2 <> 1)) and
              ((iNo1 MOD iNo2 = 0) and (iNo2 <> 0));
          end;
          rSum := iNo1 / iNo2;
        end;

    end;

    iQTime := 0; // sets/ resets question time for timer
    lblNo1.Caption := inttostr(iNo1); // Displays numbers for user
    lblNo2.Caption := inttostr(iNo2);
    sedAnswer.Clear; // resets and prepares spinedit for next question

    // If User avatar reaches finish line first, dispaly winning messages
    if (imgAvatarG.Left + imgAvatarG.Width >= ImgFinishLine.Left) then
    begin
      pgcPAT.ActivePage := tbsEnd;
      lblEndComment.Caption := 'Congradulations, ' + sUSername + '! YOU WON :)';
    end;

    // If Computer avatar reaches finish line first, dispaly losing messages
    if (imgComputer.Left + imgComputer.Width >= ImgFinishLine.Left) then
    begin
      imgEnd.Picture.LoadFromFile('Computer.png');
      lblEndComment.Caption := 'YOU LOST, ' + sUSername +
        ' Better luck next time :/';
      pgcPAT.ActivePage := tbsEnd;
    end;

  end;

end;

procedure TForm1.btnPauseToMenuClick(Sender: TObject);
begin
  { resetting Game Screen in preparation for next game,
    user will change settings in the menu }
  imgAvatarG.Left := iOGAvatarLeft;
  imgComputer.Left := iOGComputerLeft;
  iTime := 0;
  iQTime := 0;
  bPaused := false;
  pnlPaused.Visible := false;
  tmrTime.Enabled := true;
  tmrQuestionTime.Enabled := true;
  btnConfirm.Enabled := true;
  sedAnswer.Enabled := true;
  lblStart.Visible := true;
  lblStart.Caption := '';
  lblComment.Caption := '';
  rgpDifficulty.ItemIndex := -1;
  rgpAvatar.ItemIndex := -1;
  sedAnswer.Clear;
  chxQuestionTimer.Checked := false;
  lblWelcome.Caption := 'Welcome back, ' + sUSername + ' !';
  pgcPAT.ActivePage := tbsMenu;
  bAll := false;

end;

procedure TForm1.btnplayAgainNClick(Sender: TObject);
begin
  // resetting Game Screen
  imgAvatarG.Left := iOGAvatarLeft;
  imgComputer.Left := iOGComputerLeft;
  sedAnswer.Clear;
  iTime := 0;
  iQTime := 0;
  lblStart.Caption := '';
  lblStart.Visible := false;
  lblComment.Caption := '';
  rgpAvatar.ItemIndex := -1;
  rgpDifficulty.ItemIndex := -1;
  edtUsername.Clear;
  chxQuestionTimer.Checked := false;
  lblTimesUp.Caption := '';
  pgcPAT.ActivePage := tbsHome;
  edtUsername.SetFocus;
  bAll := false;
end;

procedure TForm1.btnplayAgainYClick(Sender: TObject);
begin
  // resetting Game Screen for next round that follows straight away
  btnConfirm.Visible := false;
  imgAvatarG.Left := iOGAvatarLeft;
  imgComputer.Left := iOGComputerLeft;
  sedAnswer.Clear;
  lblStart.Caption := '';
  lblComment.Caption := '';
  lblTimesUp.Caption := '';
  btnPlayMenu.Click; // process of finding numbers repeats
  pgcPAT.ActivePage := tbsGame;

end;

procedure TForm1.btnPlayClick(Sender: TObject);
var
  iUsernameLength: integer;
  bUsername: boolean;
begin
  // INPUT VALIDATION
  sUSername := edtUsername.Text;
  iUsernameLength := length(sUSername);
  // Username can't be blank or first chacater be a space
  if (edtUsername.Text = '') Or (edtUsername.Text[1] = ' ') then
    bUsername := false
  else
    bUsername := true;

  if iUsernameLength > 20 then
  // Username can't be longer than 20 characters
  begin
    bUsername := false;
    lblUsernameLong.Caption := '- Username Too Long';
  end;

  if bUsername = false then
  begin
    lblUsernameV.Caption := '- Enter Valid Username';
    // Error message in label
    edtUsername.SetFocus;
  end
  else
  begin
    // Username is valid and user can progress to next screen (Menu)
    pgcPAT.ActivePage := tbsMenu;
    lblUsernameV.Caption := '';
    lblUsernameLong.Caption := '';
    lblWelcome.Caption := 'Welcome, ' + sUSername + ' !';
  end;

end;

procedure TForm1.btnPlayMenuClick(Sender: TObject);
var
  iAvatar, iNo1, iNo2, iCountdown, iSign, iRange: integer;
  bAvatar, bDifficulty: boolean;

begin
  iDifficulty := rgpDifficulty.ItemIndex;
  iAvatar := rgpAvatar.ItemIndex;
  tmrTime.Enabled := true;
  iTime := 0;
  lblTimeLeft.Caption := '60';
  iNo1 := 0; // Initialising variables
  iNo2 := 0;
  iSign := -1;
  iQTime := 0;
  iTooEasyQuestion := 0;
  lblCorrect.Caption := '';

  if iAvatar = -1 then // User hasn't selected an avatar
    bAvatar := false
  else
    bAvatar := true;

  if bAvatar = false then
    lblAvatarV.Caption := '- Please select an Avatar'
    // Error message in label
  else
    lblAvatarV.Caption := '';

  if iDifficulty = -1 then // User hasn't selected a Difficulty
    bDifficulty := false
  else
    bDifficulty := true;

  if bDifficulty = false then
    lblDifficultyV.Caption := '- Please select a Difficulty'
    // Error message
  else
    lblDifficultyV.Caption := '';

  if (bAvatar = true) and (bDifficulty = true) then
    bAll := true;
  // User has chosen an avatar and difficulty, they may progress to Game Screen
  if bAll = true then
  begin
    btnConfirm.Visible := false;
    lblQuestionTimer.Visible := true;
    lblStart.Visible := true;
    iRange := 0;
    if chxQuestionTimer.Checked = true then
    begin
      tmrQuestionTime.Enabled := true
      // User chose to enable Question Timer
    end
    else
    begin
      tmrQuestionTime.Enabled := false;
      // User chose to not enable Question Timer
      iQTime := 0;
      lblQuestionTimer.Visible := false;

    end;
    // Load chosen avater into Game Screen and End Screen
    case iAvatar of
      0:
        begin
          imgAvatarG.Picture.LoadFromFile('Cat.jpg');
          imgEnd.Picture.LoadFromFile('Cat.jpg');
        end;
      1:
        begin
          imgAvatarG.Picture.LoadFromFile('Dog.jpg');
          imgEnd.Picture.LoadFromFile('Dog.jpg');
        end;
      2:
        begin
          imgAvatarG.Picture.LoadFromFile('Goatinelli.jpg');
          imgEnd.Picture.LoadFromFile('Goatinelli.jpg');
        end;

    end;

    // Properites differ per difiiculty
    case iDifficulty of
      0:
        begin
          iTotalTime := 60;
          iComputerMovement := 50; // Amount computer avatar moves
          iSign := random(2) + 1;
          iNo1 := random(11);
          iNo2 := random(11);
          iTotalQtime := 10; // Time to answer question

        end;
      1:
        begin
          iTotalTime := 50;
          iComputerMovement := 75; // Amount computer avatar moves
          iNo1 := random(21); // Numbers are randomly chosen from 0-20
          iNo2 := random(21);
          iSign := random(4) + 1; // Includes all 4 basic operations
          iTotalQtime := 5; // Time to answer question - harder
          iRange := 20; // Numbers are chosen from this range
          iMaxEasyQuestion := 3;
        end;
      2:
        begin
          iTotalTime := 50;
          iComputerMovement := 100; // Amount computer avatar moves
          iNo1 := random(51); // Numbers are randomly chosen from 0-50
          iNo2 := random(51);
          iSign := random(4) + 1; // Includes all 4 basic operations
          iTotalQtime := 5; // Time to answer question - harder
          iRange := 50; // Numbers are chosen from this range
          iMaxEasyQuestion := 1;
        end;

    end;

    // The operation used in each question is randomly chosen
    case iSign of
      1:
        begin
          lblSign.Caption := '+'; // Sum is Addition
          // increases difficulty of Addition  sums for Hard Diiculty
          if (iDifficulty = 2) and ((iNo1 < 20) or (iNo2 < 20)) then
          begin
            repeat
              iNo1 := random(100) + 1;
              iNo2 := random(100) + 1;
            until (iNo1 >= 20) and (iNo2 >= 20);

          end;
          rSum := iNo1 + iNo2;
        end;
      2:
        begin
          lblSign.Caption := '-'; // Sum is Subtraction

          if iDifficulty = 0 then
          begin
            repeat
              iNo1 := random(11);
              iNo2 := random(11);
            until iNo1 > iNo2;
          end;
          // increases difficulty of Subtraction sums for Hard Diiculty
          if (iDifficulty = 2) and ((iNo1 < 20) or (iNo2 < 20)) then
          begin
            repeat
              iNo1 := random(100) + 1;
              iNo2 := random(100) + 1;
            until (iNo1 >= 20) and (iNo2 >= 20);
          end;
          rSum := iNo1 - iNo2;
        end;

      3:
        begin
          lblSign.Caption := 'X';
          // Makes questions more difficult
          if iNo2 > 10 then
          begin
            repeat
              iNo2 := random(11);
            until iNo2 <= 10;
          end;
          // reduces amount of easy questions
          if (iNo2 in [0 .. 1]) or (iNo1 in [0 .. 1]) then
          begin
            inc(iTooEasyQuestion);
          end;
          rSum := iNo1 * iNo2;
        end;

      4:
        begin
          lblSign.Caption := '÷';
          if iNo2 = 0 then
          begin
            iNo2 := random(iRange) + 1;
          end;

          { Makes sure answer to division questions are whole numbers,
            user won't have to input a decimal number.
            Makes sure user doesn't get a division by 0 question }
          if (iNo1 MOD iNo2 <> 0) or (iNo2 = 0) then
          begin
            repeat
              iNo1 := random(iRange) + 1;
              iNo2 := random(iRange) + 1;
            until (iNo1 MOD iNo2 = 0) and (iNo2 <> 0);
          end;

          if (iNo1 = iNo2) or (iNo2 = 1) then
          begin
            inc(iTooEasyQuestion);
          end;

          rSum := iNo1 / iNo2;
        end;

    end;
    // user can see the numbers, sign and sum
    lblNo1.Caption := inttostr(iNo1);
    lblNo2.Caption := inttostr(iNo2);
    lblTimeLeft.Caption := inttostr(iTotalTime);
    lblQuestionTimer.Caption := inttostr(iTotalQtime);
    pgcPAT.ActivePage := tbsGame;
    // countdown for user to get ready
    for iCountdown := 5 Downto -1 do
    begin
      sleep(700);
      Form1.Refresh;
      lblStart.Caption := inttostr(iCountdown);
    end;
    { Prevents crashing - if button appears after loop in the case a useer
      constantly clicks the button while loop still runs }
    btnConfirm.Visible := true;
    lblStart.Visible := false;
    sedAnswer.SetFocus;
    if lblStart.Caption = '-1' then
      lblStart.Caption := '';

  end;

end;

procedure TForm1.btnUnpauseClick(Sender: TObject);
var
  iUnpauseCountDown: integer;
begin
  // resumes game
  bPaused := false;
  pnlPaused.Visible := false;;
  tmrTime.Enabled := true;
  if chxQuestionTimer.Checked = true then // resumes timer
  begin
    tmrQuestionTime.Enabled := true;
  end;
  btnConfirm.Enabled := true;
  sedAnswer.Enabled := true;
  // Countdown for user to get ready
  for iUnpauseCountDown := 3 Downto -1 do
  begin
    sleep(500);
    Form1.Refresh;
    lblStart.Visible := true;
    lblStart.Caption := inttostr(iUnpauseCountDown);
  end;
  lblStart.Visible := false;
  sedAnswer.SetFocus;

end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  pgcPAT.ActivePage := tbsHome;
  bAll := false;
  pnlPaused.Visible := false;
  iOGAvatarLeft := 24; // Values to use to reset the game for next round
  iOGComputerLeft := 24;
  sedAnswer.Button.Visible := false; // Removes buttons on spinedit
  sedAnswer.Clear;
  lblQuestionTimer.Visible := false;
  iTooEasyQuestion := 0; // initialising variable
  edtUsername.SetFocus;

end;

procedure TForm1.imgPauseClick(Sender: TObject); // User pauses game
begin
  pnlPaused.Color := clWebDarkOrange;
  pnlPaused.Visible := true; // Pause panel appears
  tmrTime.Enabled := false; // pauses timer
  tmrQuestionTime.Enabled := false; // pauses timer
  btnConfirm.Enabled := false; // Disables button - user can't click it
  sedAnswer.Enabled := false;
  // Disables spinedit - user can't input values
end;

procedure TForm1.tmrQuestionTimeTimer(Sender: TObject);
begin
  // Shows time left to answer  the question
  lblQuestionTimer.Caption := inttostr(iTotalQtime - iQTime);
  inc(iQTime); // increases value, thus decreasing time left

  // user gts question wrong, so Computer moves fowards
  if (pgcPAT.ActivePage = tbsGame) and (iTotalQtime - iQTime = -1) then
  begin
    imgComputer.Left := imgComputer.Left + 50;
    lblQuestionTimer.Caption := 'TOO SLOW';
    // Message telling user what happened
    iQTime := 0;
    iAnswer := -1000000; // impossible answer, so user gets question wrong
    btnConfirm.Click; // new numbers, signs, and sums will be called

  end;

end;

procedure TForm1.tmrTimeTimer(Sender: TObject);
begin
  // Shows time left to answer  the question
  lblTimeLeft.Caption := inttostr(iTotalTime - iTime);
  inc(iTime); // increases value, thus  decreasing time left

  // Computer avatar moves forward every 5 seconds
  if (pgcPAT.ActivePage = tbsGame) and (iTime Mod 5 = 0) then
    imgComputer.Left := imgComputer.Left + 50;

  // If computer reaches finishline first, user loses
  if (imgComputer.Left + imgComputer.Width >= ImgFinishLine.Left) then
  begin
    imgEnd.Picture.LoadFromFile('Computer.png');
    lblEndComment.Caption := 'YOU LOST, ' + sUSername +
      ' - Better luck next time :/';
    pgcPAT.ActivePage := tbsEnd;
  end;
  // If total time runs out, user loses
  if (pgcPAT.ActivePage = tbsGame) and (iTotalTime <= iTime) then
  begin

    lblTimesUp.Visible := true;
    lblTimesUp.Caption := 'TIME IS UP!';
    btnConfirm.Visible := false;

    if (iTotalTime + 2 <= iTime) then
    // Slight pause so user knows time is up.
    begin
      imgEnd.Picture.LoadFromFile('Computer.png');
      lblEndComment.Caption := 'YOU LOST, ' + sUSername +
        ' - Better luck next time :/';
      pgcPAT.ActivePage := tbsEnd;
    end;

  end;

end;

end.
