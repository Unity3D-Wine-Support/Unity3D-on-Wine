Opening scripts with MonoDevelop (or other editors)
=================

Built-in (or any other native editor)
-

In Unity3d go to *Edit>Preferences>ExternalTools>* and under **External Script Editor** choose `unit3d_external_editor.sh`
with arguments `"$(File)" $(Line)`

you can alternatively use any other text editor by replacing `subl` in commented line:
```
#/bin/subl "`wine winepath -u "$1"`:$2"
```
but check how its command line arguments should be formatted!!


Native
-
When Unity opens files with builtin MonoDevelop.exe it sends additional .sln file along. To catch it, we have to pretend to be that MonoDevelop.exe

* Go to `~/.local/share/wineprefixes/unity3d/drive_c/Program Files/Unity/MonoDevelop/bin` (unity3d is wineprefix)
* Rename *MonoDevelop.exe* to *MonoDevelop.exeoriginal* to keep the file
* Rename script *native-MonoDevelop_exe* to `MonoDevelop.exe` and save it in that folder
* give it execution rights `chmod +x MonoDevelop.exe`

Thats it!  

Bugs
-
**Built-in MD** - [Issue #37](https://github.com/Unity3D-Wine-Support/Unity3D-on-Wine/issues/37) Modifier key `AltGr` (right alt) isn't registered when pressed. 
**Native MD** [Issue #39](https://github.com/Unity3D-Wine-Support/Unity3D-on-Wine/issues/39) Paths to references aren't correct