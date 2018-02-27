/*
Copyright (C) Stefan Buchali, UDG United Digital Group, www.udg.de

This software is licensed under a
Creative Commons GNU General Public License (http://creativecommons.org/licenses/GPL/2.0/)
Some rights reserved.

You should have received a copy of the GNU General Public License
along with cbrbList.  If not, see http://www.gnu.org/licenses/.
*/

// init plugin window
var cbrbWin;
function opencbrbWin(){
    var breite=450;
    var hoehe=350;
    var vonX = (screen.width-breite)/2;
    var vonY = (screen.height-hoehe)/2;
    cbrbWin = window.open("","cbrbWin","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width="+breite+",height="+hoehe+",screenX="+vonX+",screenY="+vonY+",left="+vonX+",top="+vonY);
	return true;
}