MSNP Helper API for .NET
----------------------------------------------------

The MSNP Helper API for .NET provides an easy to use
almost-full-featured API for connecting your .NET
application to the Microsoft(tm) MSN Messenger(tm)
instant messaging network.

This API was written in C#, but should work fine with
other languages.

It utilizes the MSNP2 protocol which isn't the latest,
but it's the only one MS has officially released.

Future releases of this API may support newer versions.



Building the MSNP Helper API for .NET
----------------------------------------------------

*) First, ensure you have the required environment:

   - .NET Framework SDK
   - NAnt Build Tool
   - HTML Help Workshop (for doc generation)

   The .NET Framework SDK can be found here:
   http://msdn.microsoft.com/downloads/sample.asp?url=/msdn-files/027/000/976/msdncompositedoc.xml
   (or just go to http://msdn.microsoft.com and click the .NET link in the upper right)

   The NAnt Build Tool can be found here:
   http://nant.sourceforge.net

   The HTML Help Workshop can be found here:
   http://msdn.microsoft.com/library/en-us/htmlhelp/html/hwMicrosoftHTMLHelpDownloads.asp?frame=true

*) Ensure you have both .NET, NAnt, and the HHW in your PATH environment variable

*) Open a cmd.exe prompt and CD to the directory where you have unzipped this zip file

*) Ensure that MSNP.build is in the current working directory

*) type: "nant" and let NAnt do the work for you.

*) Report any compile errors at http://msnphelper.sourceforge.net
   (please make sure everything is in your path as stated above)

*) Look in the build dir off the current dir for msnp.dll and the API
   docs in the build\docs dir

*) Add a reference to the msnp.dll assembly into your .NET project when
   compiling (or through Visual Studio.NET)

*) Read the docs to understand how to use the API.


Using the MSNP Helper API for .NET
----------------------------------------------------

 - Please refer to the API doc help file in the build\docs dir.

The starting main class is MSNP.MSNPHelper. Please refer to its
description in the API docs since it will be more up to date
than this readme could ever be.


Getting Support And Help
----------------------------------------------------

Please visit the MSNP Helper API web site at:
http://msnphelper.sourceforge.net

Or visit the sourceforge.net summary page for this project at:
http://sourceforge.net/projects/msnphelper

Please submit a bug request, feature request, or join our
mailing list if you have any questions, comments, or suggestions.


Supporting other Open Source Projects:
----------------------------------------------------

Please visit the helpful folks that run the following projects:

NAnt Team - Build Tool
http://nant.sourceforge.net

NDoc Team - Documentation Generator
http://ndoc.sourceforge.net



-- The MSNP Helper Team