# small_calculator

#### Video Demo:  https://youtu.be/VTmvC6ha3DY
#### Description:
A small window sized calculator for Windows

This is my final project for CS50x course.  It is written in Free Pascal on Lazarus IDE.

So while I was thinking about what to do for my final project, I had to use Windows Calulator. I use a calculator ofter at the office where I work. A question popped into my head: Who uses a mouse to click on the buttons in a calculator app? If I'm using a keyboard, why can't the calculator just be a very small window that displays the answer?

That's where the idea for this app came from.

I started Googling for the best way to make a Windows application.  Lots of sites recommended Visual Studio, but I settled for Lazarus. Mostly because it is open source and small to download and install.

It also uses Free Pascal as the programming language. Something that I can learn relativly quickly, seeing as I learned Turbo Pascal in High School way back in the 90's.

The design of the app is relatively simple. A text box where you type your numbers and where the answers are displayed when you hit enter. Above the text box there's a label, that displays the mathamatical expression. Below the text box, there are two checkboxes to modify the apps behaviour.

One checkbox is called Only On Top, and when checked, will keep the app on to of other windows. Handy if you want to type in another app while you still want the calculator app to be visible.

The other one is named Copy Answer To Clipboard. When checked, the app will copy the answer to the clipboard when enter is pressed.

The app is operated with the keyboard and both checkboxes can be toggled with keyboard shortcuts (alt+a and alt+c). Calculations are made with the num pad on the keyboard. The backslash key is used to toggle ± and the delete key is used to clear everything, while the backspace key klears the text box.

Files of interest:
small_calculator.lpi    Lazarus Project file.  You can open this in Lazarus IDE.
unit1.lfm               The form (layout) of the app.
unit1.pas               The pascal source code for everything that happens in the app.
small_calculator.ico    An icon I made in MS Paint.
