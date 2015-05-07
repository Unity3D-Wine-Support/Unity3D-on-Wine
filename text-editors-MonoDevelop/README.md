Opening scripts with MonoDevelop 
=
Give execution right to .sh script with `chmod +x scriptname.sh` (notice the plus in **+**x)

In Unity3d go to *Edit>Preferences>ExternalTools>* and choose one of:
* unity3d_**native**_monodevelop.sh
* unity3d_**builtin**_monodevelop.sh
* unity3d_**custom**_editor.sh

with arguments `"$(File)" $(Line)`

That's it!

 *native* (issue [#42](https://github.com/Unity3D-Wine-Support/Unity3D-on-Wine/issues/42))
 *builtin* (issue [#37](https://github.com/Unity3D-Wine-Support/Unity3D-on-Wine/issues/37))
