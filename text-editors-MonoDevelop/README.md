Opening scripts with MonoDevelop 
=

In Unity3d go to *Edit>Preferences>ExternalTools>* and choose either:

* *unity3d_**native**_monodevelop.sh*
* *unity3d_**builtin**_monodevelop.sh*  

with arguments `"$(File)" $(Line)`

you can alternatively use any other text editor by replacing `subl` in commented line of *unity3d_**builtin**_monodevelop.sh*:
```
#/bin/subl "`wine winepath -u "$1"`:$2"
```
but check how its command line arguments should be formatted!! (also uncomment and delete the rest of lines)


Thats it!  

* **Built-in MD ** - [Issue #37](https://github.com/Unity3D-Wine-Support/Unity3D-on-Wine/issues/37) Modifier key `AltGr` (right alt) isn't registered when pressed.