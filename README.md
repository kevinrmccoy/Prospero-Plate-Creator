# Prospero Plate Creator

![Screenshot of single plate viewed in OpenSCAD](ProsperoPlateMaker.png)

Makes custom-sized front panel plates for the [Prospero Cue Light Panel by Ben Peoples Industries.](https://benpeoples.com/stock-products/prospero-cue-light-system/)

[Posted on MakerWorld.](https://makerworld.com/en/models/1487187-prospero-plate-creator)

This customizer runs in OpenSCAD but if you want to do multicolor stuff with text or images that feature is only available on MakerWorld at the moment (or requires some knowledge of how to export separate objects from OpenSCAD.)

Colors are just set for visibility and object separation -- MakerWorld exports separately-colored objects as different filaments in the resulting 3MF, and the actual filaments can be chosen in the slicer before printing.

## Text Information

Places a single line of text on the plate according to the settings given.

If you're running in OpenSCAD and you'd like to use other fonts you can use the options at the end of the customizer, or edit the variables yourself with fonts found on your system.  When running on MakerWorld it uses their built-in font chooser.

## SVG Information

Allows you to place an SVG file on the plate.  The file interpreter treats all colors as the same and doesn't recognize things like masks.  If your file appears as a solid square or rectangle there's probably an invisible border being drawn in the file, check the SVG in a text editor to remove extra bits.  I've included a default.svg as an example in the github repo.

[Check this OpenSCAD page for information on SVG files.](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/SVG_Import)

## PNG Information

Allows you to place a PNG file on the plate.  At the default scaling parameter of 0.1, this appears as 1 mm per 10 pixels.  The PNG file is interpreted as a height map with white being a full emboss or deboss (scaled to the PNG effect depth parameter), black being no height change, and greys or colors interpreted in between.  I've included a default.png as an example in the github repo.

[Check this OpenSCAD page for information on PNG files and the calculation for the height based on colors.](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Importing_Geometry#surface)

## Other Information

Combining the text, SVG, and PNG features might result in strange results, check the 3MF in your slicer to make sure you've got what you wanted.

Suggested printing tips: Print with a stronger profile than usual for more stiffness in very thin plates.  (For example: Wall loops - 6, infill - 25%.)


![Photograph of single plate printed in black PLA](ProsperoPlate-Single.jpg)

![Photograph of quad plate with text mounted in Prospero unit](ProsperoPlate-4WideWithText.jpg)

## Version History

Version 1.2 - 2025-06-09

- Add SVG and PNG features

Version 1.1 - 2025-06-04

- Remove end plate feature (not needed in this configuration)

Version 1.0 - 2025-06-04

- Initial release
