# cbrbList
_Version 2.0_

"cbrbList" is a user interface enhancement for the Opentext Website Management Server allowing to edit standard fields via checkboxes or radio buttons in SmartEdit view. 

© Stefan Buchali, UDG United Digital Group, www.udg.de

This is third party software. The author is not affiliated in any manner with Open Text Corporation.

## Installation

### Installation on the server

Copy the "cbrbList" folder into the "plugins" folder of your CMS installation.  
It is not necessary to import the plugin to the Server Manager.

### Preparing the templates

In your master page template(s) (every template containing the `<head>` tag), include the following code within a `<!IoRangeRedDotMode>` section:

```html
<script type="text/javascript" src="/cms/plugins/cbrbList/cbrbList.js"></script>
```

### Preparing the elements

In every template where checkbox editing should be available for one or more elements, include this code for every such element within an `<!IoRangeRedDotEditOnly>` section: 

```html
<form action="/cms/plugins/cbrbList/cbrbList_dlg.asp" target="cbrbWin" method="post" onsubmit="opencbrbWin()">
  <input type="hidden" name="allItems" value="{all available items}" />
  <input type="hidden" name="selectedItems" value="{the RedDot element to be edited}" />
  <input type="hidden" name="saveEltTemplateName" value="{content class name of that element}" />
  <!-- Optional elements --> 
  <input type="hidden" name="pluginTitle" value="{optional window title}" />
  <input type="hidden" name="eltDescription" value="{optional element description}" />
  <input type="hidden" name="cbrbtype" value="[checkbox|radio]" />
  <input type="hidden" name="savetype" value="[std|txt]" />
  <!-- Session Data --> 
  <input type="hidden" name="Sessionkey" value="{corresponding info element}" />
  <input type="hidden" name="LoginGUID" value="{corresponding info element}" />
  <input type="hidden" name="PageGUID" value="{corresponding info element}" />
  <input type="image" src="/CMS/WebClient/App_Themes/Standard/Images/Icons/icon_reddot.png" />Edit element 
</form>
```

#### Parameters

The allItems parameter can be submitted in the following ways:

- comma separated list: 
   
```html
<input type="hidden" name="allItems" value="Germany,England,France" /> 
```
 
- comma separated list with value-label pairs (use `|` to separate – label will be shown in the dialogue, value will be saved in the element): 
 
```html
<input type="hidden" name="allItems" value="de|Germany,en|England,fr|France" /> 
```
 
- list of input fields (all must have the same name; values can optionally be value-label pairs as described above): 
 
```html
<input type="hidden" name="allItems" value="de|Germany" /> 
<input type="hidden" name="allItems" value="en|England" /> 
<input type="hidden" name="allItems" value="fr|France" /> 
```
 
This list can be built up manually, by a list element construction, database query, etc.

**You just have to ensure to avoid any comma within the values and labels!**

### Using fieldsets

To group your checkboxes, use the following syntax: 
 
```html
<input type="hidden" name="allItems" value="fieldset:{name of first fieldset}" />
<input type="hidden" name="allItems" value="{available item 1}" />
<input type="hidden" name="allItems" value="{available item 2}" />
<input type="hidden" name="allItems" value="fieldset:{name of second fieldset}" />
<input type="hidden" name="allItems" value="{available item 3}" />
```
 
Fieldsets are recognized by the "fieldset:" identifier, followed by the name (legend) of the fieldset.

They are just used to visually group the checkboxes within the dialog box. They have no effect on the element or the saved values.

## How to use

By clicking the submit button (shown as Edit RedDot), a dialog box opens showing every entry of the allItems parameter as a checkbox (or a radio button). Existing values are pre-checked.

After clicking the OK button, all checked values will be saved as a comma separated list in the given RedDot element.

Take care of the 255 character limitation of RedDot standard elements! If you need to save more characters, consider using a text element instead (to do so, change the field "savetype" to "txt").

If you submit the allItems parameter as value-label pairs, the values only will be saved.

## Changelog

**Version 2.0**  
Adapted for CMS version 11  
Added session data input fields  
Added support for txt elements

**Version 1.1**  
Fieldset added

## License and exclusion of liability

This software is licensed under a [Creative Commons GNU General Public License](http://creativecommons.org/licenses/GPL/2.0/). Some rights reserved.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but **without any warranty**; without even the implied warranty of **merchantability** or **fitness for a particular purpose**. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with TemplateDependenceChecker.  If not, see http://www.gnu.org/licenses.

The GNU General Public License is a Free Software license. Like any Free Software license, it grants to you the four following freedoms:

0. The freedom to run the program for any purpose.
1. The freedom to study how the program works and adapt it to your needs.
2. The freedom to redistribute copies so you can help your neighbor.
3. The freedom to improve the program and release your improvements to the public, so that the whole community benefits.

You may exercise the freedoms specified here provided that you comply with the express conditions of this license. The principal conditions are:

- You must conspicuously and appropriately publish on each copy distributed an appropriate copyright notice and disclaimer of warranty and keep intact all the notices that refer to this License and to the absence of any warranty; and give any other recipients of the Program a copy of the GNU General Public License along with the Program. Any translation of the GNU General Public License must be accompanied by the GNU General Public License.
- If you modify your copy or copies of the program or any portion of it, or develop a program based upon it, you may distribute the resulting work provided you do so under the GNU General Public License. Any translation of the GNU General Public License must be accompanied by the GNU General Public License.
- If you copy or distribute the program, you must accompany it with the complete corresponding machine-readable source code or with a written offer, valid for at least three years, to furnish the complete corresponding machine-readable source code.

Any of the above conditions can be waived if you get permission from the copyright holder.
