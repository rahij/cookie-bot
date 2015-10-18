absolute_dir="/Users/Dhruv/code/cookie-bot/public/generated"
svg2scad $absolute_dir/$1.svg
echo "linear_extrude(height=10) include <$1.scad>" > $absolute_dir/$1_extruded.scad
/Applications/MacPorts/OpenSCAD.app/Contents/MacOS/OpenSCAD $absolute_dir/$1_extruded.scad -o $absolute_dir/$1_extruded.stl
openjscad $absolute_dir/$1_extruded.stl -of amf -o $absolute_dir/$1.amf
