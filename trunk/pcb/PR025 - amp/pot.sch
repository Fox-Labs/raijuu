<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="6.5.0">
<drawing>
<settings>
<setting alwaysvectorfont="yes"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="50" name="dxf" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="53" name="tGND_GNDA" color="7" fill="9" visible="no" active="no"/>
<layer number="54" name="bGND_GNDA" color="1" fill="9" visible="no" active="no"/>
<layer number="56" name="wert" color="7" fill="1" visible="no" active="no"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
<layer number="100" name="Muster" color="7" fill="1" visible="no" active="no"/>
<layer number="101" name="Patch_Top" color="12" fill="4" visible="yes" active="yes"/>
<layer number="102" name="Vscore" color="7" fill="1" visible="yes" active="yes"/>
<layer number="103" name="fp3" color="7" fill="1" visible="no" active="yes"/>
<layer number="104" name="Name" color="7" fill="1" visible="yes" active="yes"/>
<layer number="105" name="Beschreib" color="9" fill="1" visible="yes" active="yes"/>
<layer number="106" name="BGA-Top" color="4" fill="1" visible="yes" active="yes"/>
<layer number="107" name="BD-Top" color="5" fill="1" visible="yes" active="yes"/>
<layer number="108" name="fp8" color="7" fill="1" visible="no" active="yes"/>
<layer number="109" name="fp9" color="7" fill="1" visible="no" active="yes"/>
<layer number="110" name="fp0" color="7" fill="1" visible="no" active="yes"/>
<layer number="111" name="LPC17xx" color="7" fill="1" visible="no" active="yes"/>
<layer number="112" name="tSilk" color="7" fill="1" visible="no" active="yes"/>
<layer number="116" name="Patch_BOT" color="9" fill="4" visible="yes" active="yes"/>
<layer number="121" name="_tsilk" color="7" fill="1" visible="yes" active="yes"/>
<layer number="122" name="_bsilk" color="7" fill="1" visible="yes" active="yes"/>
<layer number="123" name="tTestmark" color="7" fill="1" visible="no" active="yes"/>
<layer number="124" name="bTestmark" color="7" fill="1" visible="no" active="yes"/>
<layer number="125" name="_tNames" color="7" fill="1" visible="yes" active="yes"/>
<layer number="126" name="_bNames" color="7" fill="1" visible="no" active="yes"/>
<layer number="127" name="_tValues" color="7" fill="1" visible="no" active="yes"/>
<layer number="128" name="_bValues" color="7" fill="1" visible="no" active="yes"/>
<layer number="131" name="tAdjust" color="7" fill="1" visible="no" active="yes"/>
<layer number="132" name="bAdjust" color="7" fill="1" visible="no" active="yes"/>
<layer number="144" name="Drill_legend" color="7" fill="1" visible="yes" active="yes"/>
<layer number="151" name="HeatSink" color="7" fill="1" visible="yes" active="yes"/>
<layer number="152" name="_bDocu" color="7" fill="1" visible="no" active="yes"/>
<layer number="199" name="Contour" color="7" fill="1" visible="yes" active="yes"/>
<layer number="200" name="200bmp" color="1" fill="10" visible="no" active="no"/>
<layer number="201" name="201bmp" color="2" fill="1" visible="no" active="no"/>
<layer number="202" name="202bmp" color="3" fill="1" visible="no" active="no"/>
<layer number="203" name="203bmp" color="4" fill="10" visible="yes" active="yes"/>
<layer number="204" name="204bmp" color="5" fill="10" visible="yes" active="yes"/>
<layer number="205" name="205bmp" color="6" fill="10" visible="yes" active="yes"/>
<layer number="206" name="206bmp" color="7" fill="10" visible="yes" active="yes"/>
<layer number="207" name="207bmp" color="8" fill="10" visible="yes" active="yes"/>
<layer number="208" name="208bmp" color="9" fill="10" visible="yes" active="yes"/>
<layer number="209" name="209bmp" color="7" fill="1" visible="no" active="yes"/>
<layer number="210" name="210bmp" color="7" fill="1" visible="no" active="yes"/>
<layer number="211" name="211bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="212" name="212bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="213" name="213bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="214" name="214bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="215" name="215bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="216" name="216bmp" color="7" fill="1" visible="yes" active="yes"/>
<layer number="217" name="217bmp" color="18" fill="1" visible="no" active="no"/>
<layer number="218" name="218bmp" color="19" fill="1" visible="no" active="no"/>
<layer number="219" name="219bmp" color="20" fill="1" visible="no" active="no"/>
<layer number="220" name="220bmp" color="21" fill="1" visible="no" active="no"/>
<layer number="221" name="221bmp" color="22" fill="1" visible="no" active="no"/>
<layer number="222" name="222bmp" color="23" fill="1" visible="no" active="no"/>
<layer number="223" name="223bmp" color="24" fill="1" visible="no" active="no"/>
<layer number="224" name="224bmp" color="25" fill="1" visible="no" active="no"/>
<layer number="248" name="Housing" color="7" fill="1" visible="no" active="yes"/>
<layer number="249" name="Edge" color="7" fill="1" visible="no" active="yes"/>
<layer number="250" name="Descript" color="3" fill="1" visible="no" active="no"/>
<layer number="251" name="SMDround" color="12" fill="11" visible="no" active="no"/>
<layer number="254" name="cooling" color="7" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="amp">
<packages>
<package name="22-23-2031">
<description>.100" (2.54mm) Center Header - 3 Pin</description>
<wire x1="-3.81" y1="3.175" x2="3.81" y2="3.175" width="0.254" layer="21"/>
<wire x1="3.81" y1="3.175" x2="3.81" y2="1.27" width="0.254" layer="21"/>
<wire x1="3.81" y1="1.27" x2="3.81" y2="-3.175" width="0.254" layer="21"/>
<wire x1="3.81" y1="-3.175" x2="-3.81" y2="-3.175" width="0.254" layer="21"/>
<wire x1="-3.81" y1="-3.175" x2="-3.81" y2="1.27" width="0.254" layer="21"/>
<wire x1="-3.81" y1="1.27" x2="-3.81" y2="3.175" width="0.254" layer="21"/>
<wire x1="-3.81" y1="1.27" x2="3.81" y2="1.27" width="0.254" layer="21"/>
<pad name="1" x="-2.54" y="0" drill="1.1" shape="long" rot="R90"/>
<pad name="2" x="0" y="0" drill="1.1" shape="long" rot="R90"/>
<pad name="3" x="2.54" y="0" drill="1.1" shape="long" rot="R90"/>
<text x="-3.81" y="3.81" size="1.016" layer="25" ratio="14">&gt;NAME</text>
<text x="-3.81" y="-5.08" size="1.016" layer="27" ratio="14">&gt;VALUE</text>
</package>
<package name="1X02">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-1.905" y1="1.27" x2="-0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="1.27" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="0.635" x2="0" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="-0.635" x2="-0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="0.635" x2="-2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="1.27" x2="-2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="-0.635" x2="-1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="-1.27" x2="-1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="0" y1="0.635" x2="0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="1.27" x2="1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="1.27" x2="2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="0.635" x2="2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-0.635" x2="1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="-1.27" x2="0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="-1.27" x2="0" y2="-0.635" width="0.1524" layer="21"/>
<pad name="1" x="-1.27" y="0" drill="1.1" diameter="1.778" shape="long" rot="R90"/>
<pad name="2" x="1.27" y="0" drill="1.1" diameter="1.778" shape="long" rot="R90"/>
<text x="-2.6162" y="1.8288" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.524" y1="-0.254" x2="-1.016" y2="0.254" layer="51"/>
<rectangle x1="1.016" y1="-0.254" x2="1.524" y2="0.254" layer="51"/>
</package>
<package name="SO16W">
<description>&lt;b&gt;Wide Small Outline package&lt;/b&gt; 300 mil</description>
<wire x1="4.8514" y1="3.7338" x2="-4.8514" y2="3.7338" width="0.1524" layer="21"/>
<wire x1="4.8514" y1="-3.7338" x2="5.2324" y2="-3.3528" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.2324" y1="3.3528" x2="-4.8514" y2="3.7338" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.8514" y1="3.7338" x2="5.2324" y2="3.3528" width="0.1524" layer="21" curve="-90"/>
<wire x1="-5.2324" y1="-3.3528" x2="-4.8514" y2="-3.7338" width="0.1524" layer="21" curve="90"/>
<wire x1="-4.8514" y1="-3.7338" x2="4.8514" y2="-3.7338" width="0.1524" layer="21"/>
<wire x1="5.2324" y1="-3.3528" x2="5.2324" y2="3.3528" width="0.1524" layer="21"/>
<wire x1="-5.2324" y1="3.3528" x2="-5.2324" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-5.2324" y1="1.27" x2="-5.2324" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-5.2324" y1="-1.27" x2="-5.2324" y2="-3.3528" width="0.1524" layer="21"/>
<wire x1="-5.207" y1="-3.3782" x2="5.207" y2="-3.3782" width="0.0508" layer="21"/>
<wire x1="-5.2324" y1="1.27" x2="-5.2324" y2="-1.27" width="0.1524" layer="21" curve="-180"/>
<smd name="1" x="-4.445" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="2" x="-3.175" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="3" x="-1.905" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="4" x="-0.635" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="5" x="0.635" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="6" x="1.905" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="7" x="3.175" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="8" x="4.445" y="-5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="9" x="4.445" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="10" x="3.175" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="11" x="1.905" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="12" x="0.635" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="13" x="-0.635" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="14" x="-1.905" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="15" x="-3.175" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<smd name="16" x="-4.445" y="5.0292" dx="0.6604" dy="2.032" layer="1"/>
<text x="-3.302" y="-0.762" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="-5.588" y="-3.81" size="1.27" layer="25" ratio="10" rot="R90">&gt;NAME</text>
<rectangle x1="-4.699" y1="-3.8608" x2="-4.191" y2="-3.7338" layer="21"/>
<rectangle x1="-4.699" y1="-5.334" x2="-4.191" y2="-3.8608" layer="51"/>
<rectangle x1="-3.429" y1="-3.8608" x2="-2.921" y2="-3.7338" layer="21"/>
<rectangle x1="-3.429" y1="-5.334" x2="-2.921" y2="-3.8608" layer="51"/>
<rectangle x1="-2.159" y1="-3.8608" x2="-1.651" y2="-3.7338" layer="21"/>
<rectangle x1="-2.159" y1="-5.334" x2="-1.651" y2="-3.8608" layer="51"/>
<rectangle x1="-0.889" y1="-3.8608" x2="-0.381" y2="-3.7338" layer="21"/>
<rectangle x1="-0.889" y1="-5.334" x2="-0.381" y2="-3.8608" layer="51"/>
<rectangle x1="0.381" y1="-5.334" x2="0.889" y2="-3.8608" layer="51"/>
<rectangle x1="0.381" y1="-3.8608" x2="0.889" y2="-3.7338" layer="21"/>
<rectangle x1="1.651" y1="-3.8608" x2="2.159" y2="-3.7338" layer="21"/>
<rectangle x1="1.651" y1="-5.334" x2="2.159" y2="-3.8608" layer="51"/>
<rectangle x1="2.921" y1="-3.8608" x2="3.429" y2="-3.7338" layer="21"/>
<rectangle x1="2.921" y1="-5.334" x2="3.429" y2="-3.8608" layer="51"/>
<rectangle x1="4.191" y1="-3.8608" x2="4.699" y2="-3.7338" layer="21"/>
<rectangle x1="4.191" y1="-5.334" x2="4.699" y2="-3.8608" layer="51"/>
<rectangle x1="-4.699" y1="3.8608" x2="-4.191" y2="5.334" layer="51"/>
<rectangle x1="-4.699" y1="3.7338" x2="-4.191" y2="3.8608" layer="21"/>
<rectangle x1="-3.429" y1="3.7338" x2="-2.921" y2="3.8608" layer="21"/>
<rectangle x1="-3.429" y1="3.8608" x2="-2.921" y2="5.334" layer="51"/>
<rectangle x1="-2.159" y1="3.7338" x2="-1.651" y2="3.8608" layer="21"/>
<rectangle x1="-2.159" y1="3.8608" x2="-1.651" y2="5.334" layer="51"/>
<rectangle x1="-0.889" y1="3.7338" x2="-0.381" y2="3.8608" layer="21"/>
<rectangle x1="-0.889" y1="3.8608" x2="-0.381" y2="5.334" layer="51"/>
<rectangle x1="0.381" y1="3.7338" x2="0.889" y2="3.8608" layer="21"/>
<rectangle x1="0.381" y1="3.8608" x2="0.889" y2="5.334" layer="51"/>
<rectangle x1="1.651" y1="3.7338" x2="2.159" y2="3.8608" layer="21"/>
<rectangle x1="1.651" y1="3.8608" x2="2.159" y2="5.334" layer="51"/>
<rectangle x1="2.921" y1="3.7338" x2="3.429" y2="3.8608" layer="21"/>
<rectangle x1="2.921" y1="3.8608" x2="3.429" y2="5.334" layer="51"/>
<rectangle x1="4.191" y1="3.7338" x2="4.699" y2="3.8608" layer="21"/>
<rectangle x1="4.191" y1="3.8608" x2="4.699" y2="5.334" layer="51"/>
</package>
<package name="C025-025X050">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 2.5 mm, outline 2.5 x 5 mm</description>
<wire x1="-2.159" y1="1.27" x2="2.159" y2="1.27" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-1.27" x2="-2.159" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.159" y1="1.27" x2="2.413" y2="1.016" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.413" y1="1.016" x2="-2.159" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.159" y1="-1.27" x2="2.413" y2="-1.016" width="0.1524" layer="21" curve="90"/>
<wire x1="-2.413" y1="-1.016" x2="-2.159" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="0.762" y1="0" x2="0.381" y2="0" width="0.1524" layer="51"/>
<wire x1="0.381" y1="0" x2="0.254" y2="0" width="0.1524" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="0.762" width="0.254" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0.762" x2="-0.254" y2="0" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.381" y2="0" width="0.1524" layer="21"/>
<wire x1="-0.381" y1="0" x2="-0.762" y2="0" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="1.1" shape="octagon"/>
<text x="-2.286" y="1.524" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-2.794" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C102-043X133">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 10.2 mm, outline 4.3 x 13.3 mm</description>
<wire x1="-3.175" y1="1.27" x2="-3.175" y2="0" width="0.4064" layer="21"/>
<wire x1="-2.286" y1="1.27" x2="-2.286" y2="0" width="0.4064" layer="21"/>
<wire x1="3.81" y1="0" x2="-2.286" y2="0" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="0" x2="-2.286" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-3.81" y1="0" x2="-3.175" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="0" x2="-3.175" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-6.096" y1="2.032" x2="6.096" y2="2.032" width="0.1524" layer="21"/>
<wire x1="6.604" y1="1.524" x2="6.604" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="6.096" y1="-2.032" x2="-6.096" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-6.604" y1="-1.524" x2="-6.604" y2="1.524" width="0.1524" layer="21"/>
<wire x1="6.096" y1="2.032" x2="6.604" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="6.096" y1="-2.032" x2="6.604" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="-6.604" y1="-1.524" x2="-6.096" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="-6.604" y1="1.524" x2="-6.096" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-5.08" y="0" drill="1.1" diameter="1.9304" shape="octagon"/>
<pad name="2" x="5.08" y="0" drill="1.1" diameter="1.9304" shape="octagon"/>
<text x="-6.096" y="2.413" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.524" y="-1.651" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C0805">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;</description>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="-0.381" y1="0.66" x2="0.381" y2="0.66" width="0.1016" layer="51"/>
<wire x1="-0.356" y1="-0.66" x2="0.381" y2="-0.66" width="0.1016" layer="51"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<smd name="1" x="-0.95" y="0" dx="1.3" dy="1.5" layer="1"/>
<smd name="2" x="0.95" y="0" dx="1.3" dy="1.5" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.0922" y1="-0.7239" x2="-0.3421" y2="0.7262" layer="51"/>
<rectangle x1="0.3556" y1="-0.7239" x2="1.1057" y2="0.7262" layer="51"/>
<rectangle x1="-0.1001" y1="-0.4001" x2="0.1001" y2="0.4001" layer="35"/>
</package>
<package name="C0805K">
<description>&lt;b&gt;Ceramic Chip Capacitor KEMET 0805 reflow solder&lt;/b&gt;&lt;p&gt;
Metric Code Size 2012</description>
<wire x1="-0.925" y1="0.6" x2="0.925" y2="0.6" width="0.1016" layer="51"/>
<wire x1="0.925" y1="-0.6" x2="-0.925" y2="-0.6" width="0.1016" layer="51"/>
<smd name="1" x="-1" y="0" dx="1.3" dy="1.6" layer="1"/>
<smd name="2" x="1" y="0" dx="1.3" dy="1.6" layer="1"/>
<text x="-1" y="0.875" size="1.016" layer="25">&gt;NAME</text>
<text x="-1" y="-1.9" size="1.016" layer="27">&gt;VALUE</text>
<rectangle x1="-1" y1="-0.65" x2="-0.5" y2="0.65" layer="51"/>
<rectangle x1="0.5" y1="-0.65" x2="1" y2="0.65" layer="51"/>
</package>
<package name="C050-025X075">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 5 mm, outline 2.5 x 7.5 mm</description>
<wire x1="-0.3048" y1="0.635" x2="-0.3048" y2="0" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-0.3048" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="0.3302" y1="0.635" x2="0.3302" y2="0" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="0.3302" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.683" y1="1.016" x2="-3.683" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="-1.27" x2="3.429" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="3.683" y1="-1.016" x2="3.683" y2="1.016" width="0.1524" layer="21"/>
<wire x1="3.429" y1="1.27" x2="-3.429" y2="1.27" width="0.1524" layer="21"/>
<wire x1="3.429" y1="1.27" x2="3.683" y2="1.016" width="0.1524" layer="21" curve="-90"/>
<wire x1="3.429" y1="-1.27" x2="3.683" y2="-1.016" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="-1.016" x2="-3.429" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="1.016" x2="-3.429" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-2.54" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="1.1" shape="octagon"/>
<text x="-3.429" y="1.651" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.429" y="-2.794" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C050-045X075">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 5 mm, outline 4.5 x 7.5 mm</description>
<wire x1="-0.3048" y1="0.635" x2="-0.3048" y2="0" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-0.3048" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="0.3302" y1="0.635" x2="0.3302" y2="0" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="0.3302" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.683" y1="2.032" x2="-3.683" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="-2.286" x2="3.429" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="3.683" y1="-2.032" x2="3.683" y2="2.032" width="0.1524" layer="21"/>
<wire x1="3.429" y1="2.286" x2="-3.429" y2="2.286" width="0.1524" layer="21"/>
<wire x1="3.429" y1="2.286" x2="3.683" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="3.429" y1="-2.286" x2="3.683" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="-2.032" x2="-3.429" y2="-2.286" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="2.032" x2="-3.429" y2="2.286" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-2.54" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="1.1" shape="octagon"/>
<text x="-3.556" y="2.667" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.556" y="-3.81" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="SOT223">
<description>&lt;b&gt;Small Outline Transistor 223&lt;/b&gt;&lt;p&gt;
PLASTIC PACKAGE CASE 318E-04&lt;br&gt;
Source: http://www.onsemi.co.jp .. LM137M-D.PDF</description>
<wire x1="3.277" y1="1.778" x2="3.277" y2="-1.778" width="0.2032" layer="21"/>
<wire x1="3.277" y1="-1.778" x2="-3.277" y2="-1.778" width="0.2032" layer="21"/>
<wire x1="-3.277" y1="-1.778" x2="-3.277" y2="1.778" width="0.2032" layer="21"/>
<wire x1="-3.277" y1="1.778" x2="3.277" y2="1.778" width="0.2032" layer="21"/>
<wire x1="0" y1="-0.7" x2="0" y2="0.6" width="0.127" layer="48"/>
<wire x1="0" y1="0.6" x2="-0.2" y2="0.2" width="0.127" layer="48"/>
<wire x1="-0.2" y1="0.2" x2="0.2" y2="0.2" width="0.127" layer="48"/>
<wire x1="0.2" y1="0.2" x2="0" y2="0.6" width="0.127" layer="48"/>
<wire x1="0" y1="-0.7" x2="0.2" y2="-0.3" width="0.127" layer="48"/>
<wire x1="0.2" y1="-0.3" x2="-0.2" y2="-0.3" width="0.127" layer="48"/>
<wire x1="-0.2" y1="-0.3" x2="0" y2="-0.7" width="0.127" layer="48"/>
<smd name="1" x="-2.3" y="-3.15" dx="1.5" dy="2" layer="1"/>
<smd name="2" x="0" y="-3.15" dx="1.5" dy="2" layer="1"/>
<smd name="3" x="2.3" y="-3.15" dx="1.5" dy="2" layer="1"/>
<smd name="4" x="0" y="3.15" dx="3.8" dy="2" layer="1"/>
<text x="-2.54" y="0.0508" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-1.3208" size="1.27" layer="27">&gt;VALUE</text>
<text x="0.4" y="0.4" size="0.254" layer="48">direction of pcb</text>
<text x="0.4" y="-0.05" size="0.254" layer="48">transportation for</text>
<text x="0.4" y="-0.5" size="0.254" layer="48">wavesoldering</text>
<rectangle x1="-0.9271" y1="1.1303" x2="0.9271" y2="4.3307" layer="51" rot="R270"/>
<rectangle x1="-0.9271" y1="-3.1623" x2="0.9271" y2="-2.2987" layer="51" rot="R270"/>
<rectangle x1="-3.2385" y1="-3.1623" x2="-1.3843" y2="-2.2987" layer="51" rot="R270"/>
<rectangle x1="1.3843" y1="-3.1623" x2="3.2385" y2="-2.2987" layer="51" rot="R270"/>
<rectangle x1="-0.9271" y1="1.1303" x2="0.9271" y2="4.3307" layer="51" rot="R270"/>
<rectangle x1="-0.9271" y1="-3.1623" x2="0.9271" y2="-2.2987" layer="51" rot="R270"/>
<rectangle x1="-3.2385" y1="-3.1623" x2="-1.3843" y2="-2.2987" layer="51" rot="R270"/>
<rectangle x1="1.3843" y1="-3.1623" x2="3.2385" y2="-2.2987" layer="51" rot="R270"/>
</package>
<package name="0207/10">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 10 mm</description>
<wire x1="5.08" y1="0" x2="4.064" y2="0" width="0.6096" layer="51"/>
<wire x1="-5.08" y1="0" x2="-4.064" y2="0" width="0.6096" layer="51"/>
<wire x1="-3.175" y1="0.889" x2="-2.921" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-2.921" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="-1.143" x2="3.175" y2="-0.889" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="1.143" x2="3.175" y2="0.889" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-3.175" y2="0.889" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="1.143" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="-1.143" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="-1.016" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="-2.413" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.921" y1="1.143" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.921" y1="-1.143" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-0.889" x2="3.175" y2="0.889" width="0.1524" layer="21"/>
<pad name="1" x="-5.08" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="5.08" y="0" drill="1.1" shape="octagon"/>
<text x="-3.048" y="1.524" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.2606" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="3.175" y1="-0.3048" x2="4.0386" y2="0.3048" layer="21"/>
<rectangle x1="-4.0386" y1="-0.3048" x2="-3.175" y2="0.3048" layer="21"/>
</package>
<package name="0207/2V">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 2.5 mm</description>
<wire x1="-1.27" y1="0" x2="-0.381" y2="0" width="0.6096" layer="51"/>
<wire x1="-0.254" y1="0" x2="0.254" y2="0" width="0.6096" layer="21"/>
<wire x1="0.381" y1="0" x2="1.27" y2="0" width="0.6096" layer="51"/>
<circle x="-1.27" y="0" radius="1.27" width="0.1524" layer="21"/>
<circle x="-1.27" y="0" radius="1.016" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="1.1" shape="octagon"/>
<text x="-0.0508" y="1.016" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.0508" y="-2.2352" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="0207/7">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 7.5 mm</description>
<wire x1="-3.81" y1="0" x2="-3.429" y2="0" width="0.6096" layer="51"/>
<wire x1="-3.175" y1="0.889" x2="-2.921" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-2.921" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="-1.143" x2="3.175" y2="-0.889" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="1.143" x2="3.175" y2="0.889" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-3.175" y2="0.889" width="0.1524" layer="51"/>
<wire x1="-2.921" y1="1.143" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="-1.143" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="-1.016" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="-2.413" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.921" y1="1.143" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.921" y1="-1.143" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-0.889" x2="3.175" y2="0.889" width="0.1524" layer="51"/>
<wire x1="3.429" y1="0" x2="3.81" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-3.81" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="3.81" y="0" drill="1.1" shape="octagon"/>
<text x="-2.54" y="1.397" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-0.5588" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-3.429" y1="-0.3048" x2="-3.175" y2="0.3048" layer="51"/>
<rectangle x1="3.175" y1="-0.3048" x2="3.429" y2="0.3048" layer="51"/>
</package>
<package name="R0805">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;</description>
<wire x1="-0.41" y1="0.635" x2="0.41" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-0.41" y1="-0.635" x2="0.41" y2="-0.635" width="0.1524" layer="51"/>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-0.95" y="0" dx="1.3" dy="1.5" layer="1"/>
<smd name="2" x="0.95" y="0" dx="1.3" dy="1.5" layer="1"/>
<text x="-0.635" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="0.4064" y1="-0.6985" x2="1.0564" y2="0.7015" layer="51"/>
<rectangle x1="-1.0668" y1="-0.6985" x2="-0.4168" y2="0.7015" layer="51"/>
<rectangle x1="-0.1999" y1="-0.5001" x2="0.1999" y2="0.5001" layer="35"/>
</package>
<package name="22-23-2021">
<description>.100" (2.54mm) Center Headers - 2 Pin</description>
<wire x1="-2.54" y1="3.175" x2="2.54" y2="3.175" width="0.254" layer="21"/>
<wire x1="2.54" y1="3.175" x2="2.54" y2="1.27" width="0.254" layer="21"/>
<wire x1="2.54" y1="1.27" x2="2.54" y2="-3.175" width="0.254" layer="21"/>
<wire x1="2.54" y1="-3.175" x2="-2.54" y2="-3.175" width="0.254" layer="21"/>
<wire x1="-2.54" y1="-3.175" x2="-2.54" y2="1.27" width="0.254" layer="21"/>
<pad name="1" x="-1.27" y="0" drill="1.1" shape="long" rot="R90"/>
<pad name="2" x="1.27" y="0" drill="1.1" shape="long" rot="R90"/>
<text x="-2.54" y="3.81" size="1.016" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.54" y="-5.08" size="1.016" layer="27" ratio="10">&gt;VALUE</text>
<wire x1="-2.54" y1="1.27" x2="-2.54" y2="3.175" width="0.254" layer="21"/>
<wire x1="0.3175" y1="1.27" x2="-0.3175" y2="1.27" width="0.254" layer="21"/>
<wire x1="2.54" y1="1.27" x2="2.2225" y2="1.27" width="0.254" layer="21"/>
<wire x1="-2.54" y1="1.27" x2="-2.2225" y2="1.27" width="0.254" layer="21"/>
<wire x1="-2.2225" y1="1.27" x2="-0.3175" y2="1.27" width="0.254" layer="51"/>
<wire x1="0.3175" y1="1.27" x2="2.2225" y2="1.27" width="0.254" layer="51"/>
</package>
<package name="1X06">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="0.635" y1="1.27" x2="1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="1.27" x2="2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="0.635" x2="2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-0.635" x2="1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="2.54" y1="0.635" x2="3.175" y2="1.27" width="0.1524" layer="21"/>
<wire x1="3.175" y1="1.27" x2="4.445" y2="1.27" width="0.1524" layer="21"/>
<wire x1="4.445" y1="1.27" x2="5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="0.635" x2="5.08" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-0.635" x2="4.445" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="4.445" y1="-1.27" x2="3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-1.27" x2="2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="0.635" x2="-1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="1.27" x2="-0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="1.27" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="0.635" x2="0" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="-0.635" x2="-0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="-1.27" x2="-1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="-1.27" x2="-2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="0.635" y1="1.27" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="-0.635" x2="0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="-1.27" x2="0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="1.27" x2="-5.715" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="1.27" x2="-5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0.635" x2="-5.08" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-0.635" x2="-5.715" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0.635" x2="-4.445" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="1.27" x2="-3.175" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="1.27" x2="-2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="0.635" x2="-2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="-0.635" x2="-3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="-1.27" x2="-4.445" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="-1.27" x2="-5.08" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="0.635" x2="-7.62" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="1.27" x2="-7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="-0.635" x2="-6.985" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="-1.27" x2="-6.985" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="5.715" y1="1.27" x2="6.985" y2="1.27" width="0.1524" layer="21"/>
<wire x1="6.985" y1="1.27" x2="7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="7.62" y1="0.635" x2="7.62" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="7.62" y1="-0.635" x2="6.985" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="5.715" y1="1.27" x2="5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-0.635" x2="5.715" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="6.985" y1="-1.27" x2="5.715" y2="-1.27" width="0.1524" layer="21"/>
<pad name="1" x="-6.35" y="0" drill="1.1" diameter="1.778" shape="long" rot="R90"/>
<pad name="2" x="-3.81" y="0" drill="1.1" diameter="1.778" shape="long" rot="R90"/>
<pad name="3" x="-1.27" y="0" drill="1.1" diameter="1.778" shape="long" rot="R90"/>
<pad name="4" x="1.27" y="0" drill="1.1" diameter="1.778" shape="long" rot="R90"/>
<pad name="5" x="3.81" y="0" drill="1.1" diameter="1.778" shape="long" rot="R90"/>
<pad name="6" x="6.35" y="0" drill="1.1" diameter="1.778" shape="long" rot="R90"/>
<text x="-7.6962" y="1.8288" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-7.62" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="3.556" y1="-0.254" x2="4.064" y2="0.254" layer="51"/>
<rectangle x1="1.016" y1="-0.254" x2="1.524" y2="0.254" layer="51"/>
<rectangle x1="-1.524" y1="-0.254" x2="-1.016" y2="0.254" layer="51"/>
<rectangle x1="-4.064" y1="-0.254" x2="-3.556" y2="0.254" layer="51"/>
<rectangle x1="-6.604" y1="-0.254" x2="-6.096" y2="0.254" layer="51"/>
<rectangle x1="6.096" y1="-0.254" x2="6.604" y2="0.254" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="+12V">
<wire x1="1.27" y1="-1.905" x2="0" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="-1.27" y2="-1.905" width="0.254" layer="94"/>
<wire x1="1.27" y1="-0.635" x2="0" y2="1.27" width="0.254" layer="94"/>
<wire x1="0" y1="1.27" x2="-1.27" y2="-0.635" width="0.254" layer="94"/>
<text x="-2.54" y="-5.08" size="1.778" layer="96" rot="R90">&gt;VALUE</text>
<pin name="+12V" x="0" y="-2.54" visible="off" length="short" direction="sup" rot="R90"/>
</symbol>
<symbol name="-12V">
<wire x1="-1.27" y1="1.905" x2="0" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="1.27" y2="1.905" width="0.254" layer="94"/>
<wire x1="-1.27" y1="0.635" x2="0" y2="-1.27" width="0.254" layer="94"/>
<wire x1="0" y1="-1.27" x2="1.27" y2="0.635" width="0.254" layer="94"/>
<text x="-2.54" y="-2.54" size="1.778" layer="96" rot="R90">&gt;VALUE</text>
<pin name="-12V" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
</symbol>
<symbol name="PINHD3">
<wire x1="-6.35" y1="-5.08" x2="1.27" y2="-5.08" width="0.4064" layer="94"/>
<wire x1="1.27" y1="-5.08" x2="1.27" y2="5.08" width="0.4064" layer="94"/>
<wire x1="1.27" y1="5.08" x2="-6.35" y2="5.08" width="0.4064" layer="94"/>
<wire x1="-6.35" y1="5.08" x2="-6.35" y2="-5.08" width="0.4064" layer="94"/>
<text x="-6.35" y="5.715" size="1.778" layer="95">&gt;NAME</text>
<text x="-6.35" y="-7.62" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-2.54" y="2.54" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="2" x="-2.54" y="0" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="3" x="-2.54" y="-2.54" visible="pad" length="short" direction="pas" function="dot"/>
</symbol>
<symbol name="PINHD2">
<wire x1="-6.35" y1="-2.54" x2="1.27" y2="-2.54" width="0.4064" layer="94"/>
<wire x1="1.27" y1="-2.54" x2="1.27" y2="5.08" width="0.4064" layer="94"/>
<wire x1="1.27" y1="5.08" x2="-6.35" y2="5.08" width="0.4064" layer="94"/>
<wire x1="-6.35" y1="5.08" x2="-6.35" y2="-2.54" width="0.4064" layer="94"/>
<text x="-6.35" y="5.715" size="1.778" layer="95">&gt;NAME</text>
<text x="-6.35" y="-5.08" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-2.54" y="2.54" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="2" x="-2.54" y="0" visible="pad" length="short" direction="pas" function="dot"/>
</symbol>
<symbol name="AGND">
<wire x1="-1.905" y1="0" x2="1.905" y2="0" width="0.254" layer="94"/>
<wire x1="-1.0922" y1="-0.508" x2="1.0922" y2="-0.508" width="0.254" layer="94"/>
<text x="-2.54" y="-5.08" size="1.778" layer="96" rot="R90">&gt;VALUE</text>
<pin name="AGND" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
</symbol>
<symbol name="PGA2311">
<wire x1="-10.16" y1="-12.7" x2="10.16" y2="-12.7" width="0.254" layer="94"/>
<wire x1="10.16" y1="-12.7" x2="10.16" y2="10.16" width="0.254" layer="94"/>
<wire x1="10.16" y1="10.16" x2="-10.16" y2="10.16" width="0.254" layer="94"/>
<wire x1="-10.16" y1="10.16" x2="-10.16" y2="-12.7" width="0.254" layer="94"/>
<pin name="DGND" x="-12.7" y="-2.54" visible="pin" length="short"/>
<pin name="VCC" x="-12.7" y="0" visible="pin" length="short"/>
<pin name="ZCEN" x="-12.7" y="7.62" visible="pin" length="short"/>
<pin name="/CS" x="-12.7" y="5.08" visible="pin" length="short"/>
<pin name="SDI" x="-12.7" y="2.54" visible="pin" length="short"/>
<pin name="VOUTL" x="12.7" y="2.54" visible="pin" length="short" rot="R180"/>
<pin name="VA-" x="12.7" y="0" visible="pin" length="short" rot="R180"/>
<pin name="AGNDL" x="12.7" y="5.08" visible="pin" length="short" rot="R180"/>
<pin name="SCLK" x="-12.7" y="-5.08" visible="pin" length="short"/>
<pin name="SDO" x="-12.7" y="-7.62" visible="pin" length="short"/>
<pin name="/MUTE" x="-12.7" y="-10.16" visible="pin" length="short"/>
<pin name="VINL" x="12.7" y="7.62" visible="pin" length="short" rot="R180"/>
<pin name="VA+" x="12.7" y="-2.54" visible="pin" length="short" rot="R180"/>
<pin name="VOUTR" x="12.7" y="-5.08" visible="pin" length="short" rot="R180"/>
<pin name="AGNDR" x="12.7" y="-7.62" visible="pin" length="short" rot="R180"/>
<pin name="VINR" x="12.7" y="-10.16" visible="pin" length="short" rot="R180"/>
</symbol>
<symbol name="C-EU">
<wire x1="0" y1="0" x2="0" y2="-0.508" width="0.1524" layer="94"/>
<wire x1="0" y1="-2.54" x2="0" y2="-2.032" width="0.1524" layer="94"/>
<text x="1.524" y="0.381" size="1.778" layer="95">&gt;NAME</text>
<text x="1.524" y="-4.699" size="1.778" layer="96">&gt;VALUE</text>
<rectangle x1="-2.032" y1="-2.032" x2="2.032" y2="-1.524" layer="94"/>
<rectangle x1="-2.032" y1="-1.016" x2="2.032" y2="-0.508" layer="94"/>
<pin name="1" x="0" y="2.54" visible="off" length="short" direction="pas" swaplevel="1" rot="R270"/>
<pin name="2" x="0" y="-5.08" visible="off" length="short" direction="pas" swaplevel="1" rot="R90"/>
</symbol>
<symbol name="78ADJ">
<wire x1="-5.08" y1="-5.08" x2="5.08" y2="-5.08" width="0.4064" layer="94"/>
<wire x1="5.08" y1="-5.08" x2="5.08" y2="2.54" width="0.4064" layer="94"/>
<wire x1="5.08" y1="2.54" x2="-5.08" y2="2.54" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="2.54" x2="-5.08" y2="-5.08" width="0.4064" layer="94"/>
<text x="2.54" y="-7.62" size="1.778" layer="95">&gt;NAME</text>
<text x="2.54" y="-10.16" size="1.778" layer="96">&gt;VALUE</text>
<text x="-4.572" y="-4.318" size="1.524" layer="95">ADJ/GND</text>
<text x="-4.445" y="-0.635" size="1.524" layer="95">IN</text>
<text x="0.127" y="-0.635" size="1.524" layer="95">OUT</text>
<pin name="IN" x="-7.62" y="0" visible="off" length="short" direction="in"/>
<pin name="ADJ" x="0" y="-7.62" visible="off" length="short" direction="in" rot="R90"/>
<pin name="OUT" x="7.62" y="0" visible="off" length="short" direction="pas" rot="R180"/>
</symbol>
<symbol name="79ADJ">
<wire x1="-5.08" y1="-5.08" x2="5.08" y2="-5.08" width="0.4064" layer="94"/>
<wire x1="5.08" y1="-5.08" x2="5.08" y2="2.54" width="0.4064" layer="94"/>
<wire x1="5.08" y1="2.54" x2="-5.08" y2="2.54" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="2.54" x2="-5.08" y2="-5.08" width="0.4064" layer="94"/>
<text x="2.54" y="-7.62" size="1.778" layer="95">&gt;NAME</text>
<text x="2.54" y="-10.16" size="1.778" layer="96">&gt;VALUE</text>
<text x="-4.572" y="0" size="1.524" layer="95">ADJ/GND</text>
<text x="-4.445" y="-3.175" size="1.524" layer="95">IN</text>
<text x="0.127" y="-3.175" size="1.524" layer="95">OUT</text>
<pin name="IN" x="-7.62" y="-2.54" visible="off" length="short" direction="in"/>
<pin name="ADJ" x="0" y="5.08" visible="off" length="short" direction="in" rot="R270"/>
<pin name="OUT" x="7.62" y="-2.54" visible="off" length="short" direction="pas" rot="R180"/>
</symbol>
<symbol name="R-EU">
<wire x1="-2.54" y1="-0.889" x2="2.54" y2="-0.889" width="0.254" layer="94"/>
<wire x1="2.54" y1="0.889" x2="-2.54" y2="0.889" width="0.254" layer="94"/>
<wire x1="2.54" y1="-0.889" x2="2.54" y2="0.889" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-0.889" x2="-2.54" y2="0.889" width="0.254" layer="94"/>
<text x="-3.81" y="1.4986" size="1.778" layer="95">&gt;NAME</text>
<text x="-3.81" y="-3.302" size="1.778" layer="96">&gt;VALUE</text>
<pin name="2" x="5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
<pin name="1" x="-5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1"/>
</symbol>
<symbol name="+5V">
<wire x1="1.27" y1="-1.905" x2="0" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="-1.27" y2="-1.905" width="0.254" layer="94"/>
<text x="-2.54" y="-5.08" size="1.778" layer="96" rot="R90">&gt;VALUE</text>
<pin name="+5V" x="0" y="-2.54" visible="off" length="short" direction="sup" rot="R90"/>
</symbol>
<symbol name="GND-1">
<wire x1="-1.905" y1="0" x2="1.905" y2="0" width="0.254" layer="94"/>
<text x="-2.54" y="-2.54" size="1.778" layer="96">&gt;VALUE</text>
<pin name="GND" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
</symbol>
<symbol name="PINHD6">
<wire x1="-6.35" y1="-7.62" x2="1.27" y2="-7.62" width="0.4064" layer="94"/>
<wire x1="1.27" y1="-7.62" x2="1.27" y2="10.16" width="0.4064" layer="94"/>
<wire x1="1.27" y1="10.16" x2="-6.35" y2="10.16" width="0.4064" layer="94"/>
<wire x1="-6.35" y1="10.16" x2="-6.35" y2="-7.62" width="0.4064" layer="94"/>
<text x="-6.35" y="10.795" size="1.778" layer="95">&gt;NAME</text>
<text x="-6.35" y="-10.16" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-2.54" y="7.62" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="2" x="-2.54" y="5.08" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="3" x="-2.54" y="2.54" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="4" x="-2.54" y="0" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="5" x="-2.54" y="-2.54" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="6" x="-2.54" y="-5.08" visible="pad" length="short" direction="pas" function="dot"/>
</symbol>
<symbol name="VCC">
<wire x1="1.27" y1="-1.905" x2="0" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="-1.27" y2="-1.905" width="0.254" layer="94"/>
<text x="-2.54" y="-5.08" size="1.778" layer="96" rot="R90">&gt;VALUE</text>
<pin name="VCC" x="0" y="-2.54" visible="off" length="short" direction="sup" rot="R90"/>
</symbol>
<symbol name="-5V">
<wire x1="-1.27" y1="1.905" x2="0" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="1.27" y2="1.905" width="0.254" layer="94"/>
<text x="-2.54" y="-2.54" size="1.778" layer="96" rot="R90">&gt;VALUE</text>
<pin name="-5V" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="+12V" prefix="P+">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="+12V" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="-12V" prefix="P-">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="-12V" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="22-23-2031" prefix="X">
<description>.100" (2.54mm) Center Header - 3 Pin</description>
<gates>
<gate name="G$1" symbol="PINHD3" x="0" y="0"/>
</gates>
<devices>
<device name="" package="22-23-2031">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
<connect gate="G$1" pin="3" pad="3"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="PINHD-1X2" prefix="JP" uservalue="yes">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="PINHD2" x="0" y="0"/>
</gates>
<devices>
<device name="" package="1X02">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="AGND" prefix="AGND">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="VR1" symbol="AGND" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="PGA2311" prefix="U" uservalue="yes">
<gates>
<gate name="G$1" symbol="PGA2311" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SO16W">
<connects>
<connect gate="G$1" pin="/CS" pad="2"/>
<connect gate="G$1" pin="/MUTE" pad="8"/>
<connect gate="G$1" pin="AGNDL" pad="15"/>
<connect gate="G$1" pin="AGNDR" pad="10"/>
<connect gate="G$1" pin="DGND" pad="5"/>
<connect gate="G$1" pin="SCLK" pad="6"/>
<connect gate="G$1" pin="SDI" pad="3"/>
<connect gate="G$1" pin="SDO" pad="7"/>
<connect gate="G$1" pin="VA+" pad="12"/>
<connect gate="G$1" pin="VA-" pad="13"/>
<connect gate="G$1" pin="VCC" pad="4"/>
<connect gate="G$1" pin="VINL" pad="16"/>
<connect gate="G$1" pin="VINR" pad="9"/>
<connect gate="G$1" pin="VOUTL" pad="14"/>
<connect gate="G$1" pin="VOUTR" pad="11"/>
<connect gate="G$1" pin="ZCEN" pad="1"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="C-EU" prefix="C" uservalue="yes">
<description>&lt;B&gt;CAPACITOR&lt;/B&gt;, European symbol</description>
<gates>
<gate name="G$1" symbol="C-EU" x="0" y="0"/>
</gates>
<devices>
<device name="025-025X050" package="C025-025X050">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="102-043X133" package="C102-043X133">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="C0805" package="C0805">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="C0805K" package="C0805K">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="050-025X075" package="C050-025X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="050-045X075" package="C050-045X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="LM317" prefix="IC">
<gates>
<gate name="G$1" symbol="78ADJ" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SOT223">
<connects>
<connect gate="G$1" pin="ADJ" pad="1"/>
<connect gate="G$1" pin="IN" pad="3"/>
<connect gate="G$1" pin="OUT" pad="2 4"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="LM337" prefix="IC">
<gates>
<gate name="G$1" symbol="79ADJ" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SOT223">
<connects>
<connect gate="G$1" pin="ADJ" pad="1"/>
<connect gate="G$1" pin="IN" pad="2 4"/>
<connect gate="G$1" pin="OUT" pad="3"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="R-EU_" prefix="R" uservalue="yes">
<description>&lt;B&gt;RESISTOR&lt;/B&gt;, European symbol</description>
<gates>
<gate name="G$1" symbol="R-EU" x="0" y="0"/>
</gates>
<devices>
<device name="0207/10" package="0207/10">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0207/2V" package="0207/2V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0207/7" package="0207/7">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="" package="R0805">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="+5V" prefix="P+">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="+5V" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="GND" prefix="GND">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="GND-1" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="22-23-2021" prefix="X">
<description>.100" (2.54mm) Center Header - 2 Pin</description>
<gates>
<gate name="X1" symbol="PINHD2" x="0" y="-2.54"/>
</gates>
<devices>
<device name="" package="22-23-2021">
<connects>
<connect gate="X1" pin="1" pad="1"/>
<connect gate="X1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="PINHD-1X6" prefix="JP" uservalue="yes">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="A" symbol="PINHD6" x="0" y="-2.54"/>
</gates>
<devices>
<device name="" package="1X06">
<connects>
<connect gate="A" pin="1" pad="1"/>
<connect gate="A" pin="2" pad="2"/>
<connect gate="A" pin="3" pad="3"/>
<connect gate="A" pin="4" pad="4"/>
<connect gate="A" pin="5" pad="5"/>
<connect gate="A" pin="6" pad="6"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="VCC" prefix="P+">
<gates>
<gate name="G$1" symbol="VCC" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="-5V" prefix="P-">
<gates>
<gate name="G$1" symbol="-5V" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="X1" library="amp" deviceset="22-23-2031" device="" value=""/>
<part name="P+3" library="amp" deviceset="+12V" device=""/>
<part name="P-3" library="amp" deviceset="-12V" device=""/>
<part name="JP3" library="amp" deviceset="PINHD-1X2" device=""/>
<part name="JP2" library="amp" deviceset="PINHD-1X2" device=""/>
<part name="JP5" library="amp" deviceset="PINHD-1X2" device=""/>
<part name="JP4" library="amp" deviceset="PINHD-1X2" device=""/>
<part name="AGND2" library="amp" deviceset="AGND" device=""/>
<part name="AGND7" library="amp" deviceset="AGND" device="" value="AGND"/>
<part name="AGND11" library="amp" deviceset="AGND" device="" value="AGND"/>
<part name="AGND6" library="amp" deviceset="AGND" device="" value="AGND"/>
<part name="AGND10" library="amp" deviceset="AGND" device="" value="AGND"/>
<part name="U1" library="amp" deviceset="PGA2311" device=""/>
<part name="AGND4" library="amp" deviceset="AGND" device="" value="AGND"/>
<part name="C5" library="amp" deviceset="C-EU" device="C0805K" value="100nF"/>
<part name="C6" library="amp" deviceset="C-EU" device="C0805K" value="10uF"/>
<part name="C7" library="amp" deviceset="C-EU" device="C0805K" value="100nF"/>
<part name="C8" library="amp" deviceset="C-EU" device="C0805K" value="10uF"/>
<part name="IC1" library="amp" deviceset="LM317" device=""/>
<part name="IC2" library="amp" deviceset="LM337" device=""/>
<part name="R3" library="amp" deviceset="R-EU_" device=""/>
<part name="P+7" library="amp" deviceset="+5V" device=""/>
<part name="P+8" library="amp" deviceset="+5V" device=""/>
<part name="AGND5" library="amp" deviceset="AGND" device="" value="AGND"/>
<part name="AGND8" library="amp" deviceset="AGND" device="" value="AGND"/>
<part name="AGND9" library="amp" deviceset="AGND" device="" value="AGND"/>
<part name="AGND12" library="amp" deviceset="AGND" device="" value="AGND"/>
<part name="P+6" library="amp" deviceset="+5V" device=""/>
<part name="R1" library="amp" deviceset="R-EU_" device=""/>
<part name="R2" library="amp" deviceset="R-EU_" device=""/>
<part name="R4" library="amp" deviceset="R-EU_" device=""/>
<part name="P+1" library="amp" deviceset="+12V" device=""/>
<part name="P-1" library="amp" deviceset="-12V" device=""/>
<part name="P+2" library="amp" deviceset="+5V" device=""/>
<part name="C1" library="amp" deviceset="C-EU" device="C0805K"/>
<part name="C2" library="amp" deviceset="C-EU" device="C0805K"/>
<part name="C4" library="amp" deviceset="C-EU" device="C0805K"/>
<part name="C3" library="amp" deviceset="C-EU" device="C0805K"/>
<part name="AGND1" library="amp" deviceset="AGND" device=""/>
<part name="GND2" library="amp" deviceset="GND" device=""/>
<part name="R5" library="amp" deviceset="R-EU_" device=""/>
<part name="AGND3" library="amp" deviceset="AGND" device="" value="AGND"/>
<part name="GND1" library="amp" deviceset="GND" device=""/>
<part name="X2" library="amp" deviceset="22-23-2021" device="" value=""/>
<part name="GND3" library="amp" deviceset="GND" device=""/>
<part name="C9" library="amp" deviceset="C-EU" device="C0805K"/>
<part name="C10" library="amp" deviceset="C-EU" device="C0805K"/>
<part name="GND4" library="amp" deviceset="GND" device=""/>
<part name="GND5" library="amp" deviceset="GND" device=""/>
<part name="JP1" library="amp" deviceset="PINHD-1X6" device=""/>
<part name="P+4" library="amp" deviceset="VCC" device=""/>
<part name="P+5" library="amp" deviceset="VCC" device=""/>
<part name="P+9" library="amp" deviceset="VCC" device=""/>
<part name="P+10" library="amp" deviceset="VCC" device=""/>
<part name="P-2" library="amp" deviceset="-5V" device=""/>
<part name="P-4" library="amp" deviceset="-5V" device=""/>
<part name="P-5" library="amp" deviceset="-5V" device=""/>
<part name="P-6" library="amp" deviceset="-5V" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="X1" gate="G$1" x="66.04" y="170.18" smashed="yes">
<attribute name="NAME" x="59.69" y="175.895" size="1.778" layer="95"/>
<attribute name="VALUE" x="59.69" y="162.56" size="1.778" layer="96"/>
</instance>
<instance part="P+3" gate="1" x="53.34" y="177.8" smashed="yes">
<attribute name="VALUE" x="50.8" y="180.34" size="1.778" layer="96"/>
</instance>
<instance part="P-3" gate="1" x="53.34" y="162.56" smashed="yes">
<attribute name="VALUE" x="55.88" y="160.02" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="JP3" gate="G$1" x="139.7" y="147.32" smashed="yes">
<attribute name="NAME" x="133.35" y="153.035" size="1.778" layer="95"/>
<attribute name="VALUE" x="133.35" y="142.24" size="1.778" layer="96"/>
</instance>
<instance part="JP2" gate="G$1" x="139.7" y="167.64" smashed="yes">
<attribute name="NAME" x="133.35" y="173.355" size="1.778" layer="95"/>
<attribute name="VALUE" x="133.35" y="162.56" size="1.778" layer="96"/>
</instance>
<instance part="JP5" gate="G$1" x="162.56" y="147.32" smashed="yes">
<attribute name="NAME" x="156.21" y="153.035" size="1.778" layer="95"/>
<attribute name="VALUE" x="156.21" y="142.24" size="1.778" layer="96"/>
</instance>
<instance part="JP4" gate="G$1" x="162.56" y="167.64" smashed="yes">
<attribute name="NAME" x="156.21" y="173.355" size="1.778" layer="95"/>
<attribute name="VALUE" x="156.21" y="162.56" size="1.778" layer="96"/>
</instance>
<instance part="AGND2" gate="VR1" x="40.64" y="165.1" smashed="yes">
<attribute name="VALUE" x="38.1" y="162.56" size="1.778" layer="96"/>
</instance>
<instance part="AGND7" gate="VR1" x="129.54" y="142.24" smashed="yes">
<attribute name="VALUE" x="127" y="139.7" size="1.778" layer="96"/>
</instance>
<instance part="AGND11" gate="VR1" x="152.4" y="142.24" smashed="yes">
<attribute name="VALUE" x="149.86" y="139.7" size="1.778" layer="96"/>
</instance>
<instance part="AGND6" gate="VR1" x="129.54" y="162.56" smashed="yes">
<attribute name="VALUE" x="127" y="160.02" size="1.778" layer="96"/>
</instance>
<instance part="AGND10" gate="VR1" x="152.4" y="162.56" smashed="yes">
<attribute name="VALUE" x="149.86" y="160.02" size="1.778" layer="96"/>
</instance>
<instance part="U1" gate="G$1" x="71.12" y="127" smashed="yes"/>
<instance part="AGND4" gate="VR1" x="104.14" y="114.3" smashed="yes">
<attribute name="VALUE" x="101.6" y="111.76" size="1.778" layer="96"/>
</instance>
<instance part="C5" gate="G$1" x="124.46" y="124.46" smashed="yes">
<attribute name="NAME" x="125.984" y="124.841" size="1.778" layer="95"/>
<attribute name="VALUE" x="125.984" y="119.761" size="1.778" layer="96"/>
</instance>
<instance part="C6" gate="G$1" x="137.16" y="124.46" smashed="yes">
<attribute name="NAME" x="138.684" y="124.841" size="1.778" layer="95"/>
<attribute name="VALUE" x="138.684" y="119.761" size="1.778" layer="96"/>
</instance>
<instance part="C7" gate="G$1" x="149.86" y="124.46" smashed="yes">
<attribute name="NAME" x="151.384" y="124.841" size="1.778" layer="95"/>
<attribute name="VALUE" x="151.384" y="119.761" size="1.778" layer="96"/>
</instance>
<instance part="C8" gate="G$1" x="162.56" y="124.46" smashed="yes">
<attribute name="NAME" x="164.084" y="124.841" size="1.778" layer="95"/>
<attribute name="VALUE" x="164.084" y="119.761" size="1.778" layer="96"/>
</instance>
<instance part="IC1" gate="G$1" x="-2.54" y="165.1" smashed="yes">
<attribute name="NAME" x="-7.62" y="170.18" size="1.778" layer="95"/>
<attribute name="VALUE" x="-7.62" y="167.64" size="1.778" layer="96"/>
</instance>
<instance part="IC2" gate="G$1" x="-2.54" y="127" smashed="yes">
<attribute name="NAME" x="-7.62" y="119.38" size="1.778" layer="95"/>
<attribute name="VALUE" x="-7.62" y="116.84" size="1.778" layer="96"/>
</instance>
<instance part="R3" gate="G$1" x="7.62" y="160.02" smashed="yes" rot="R90">
<attribute name="NAME" x="6.1214" y="156.21" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="10.922" y="156.21" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="P+7" gate="1" x="124.46" y="132.08" smashed="yes">
<attribute name="VALUE" x="127" y="134.62" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="P+8" gate="1" x="137.16" y="132.08" smashed="yes">
<attribute name="VALUE" x="139.7" y="134.62" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="AGND5" gate="VR1" x="124.46" y="114.3" smashed="yes">
<attribute name="VALUE" x="121.92" y="111.76" size="1.778" layer="96"/>
</instance>
<instance part="AGND8" gate="VR1" x="137.16" y="114.3" smashed="yes">
<attribute name="VALUE" x="134.62" y="111.76" size="1.778" layer="96"/>
</instance>
<instance part="AGND9" gate="VR1" x="149.86" y="114.3" smashed="yes">
<attribute name="VALUE" x="147.32" y="111.76" size="1.778" layer="96"/>
</instance>
<instance part="AGND12" gate="VR1" x="162.56" y="114.3" smashed="yes">
<attribute name="VALUE" x="160.02" y="111.76" size="1.778" layer="96"/>
</instance>
<instance part="P+6" gate="1" x="99.06" y="121.92" smashed="yes" rot="R180">
<attribute name="VALUE" x="96.52" y="119.38" size="1.778" layer="96"/>
</instance>
<instance part="R1" gate="G$1" x="-2.54" y="149.86" smashed="yes" rot="R90">
<attribute name="NAME" x="-4.0386" y="146.05" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="0.762" y="146.05" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R2" gate="G$1" x="-2.54" y="139.7" smashed="yes" rot="R90">
<attribute name="NAME" x="-4.0386" y="135.89" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="0.762" y="135.89" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R4" gate="G$1" x="7.62" y="129.54" smashed="yes" rot="R90">
<attribute name="NAME" x="6.1214" y="125.73" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="10.922" y="125.73" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="P+1" gate="1" x="-12.7" y="170.18" smashed="yes">
<attribute name="VALUE" x="-15.24" y="172.72" size="1.778" layer="96"/>
</instance>
<instance part="P-1" gate="1" x="-12.7" y="119.38" smashed="yes">
<attribute name="VALUE" x="-10.16" y="116.84" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="P+2" gate="1" x="15.24" y="170.18" smashed="yes">
<attribute name="VALUE" x="17.78" y="172.72" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="C1" gate="G$1" x="-12.7" y="154.94" smashed="yes">
<attribute name="NAME" x="-11.176" y="155.321" size="1.778" layer="95"/>
<attribute name="VALUE" x="-11.176" y="150.241" size="1.778" layer="96"/>
</instance>
<instance part="C2" gate="G$1" x="-12.7" y="134.62" smashed="yes" rot="R180">
<attribute name="NAME" x="-14.224" y="134.239" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="-14.224" y="139.319" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="C4" gate="G$1" x="15.24" y="134.62" smashed="yes" rot="R180">
<attribute name="NAME" x="13.716" y="134.239" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="13.716" y="139.319" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="C3" gate="G$1" x="15.24" y="154.94" smashed="yes">
<attribute name="NAME" x="16.764" y="155.321" size="1.778" layer="95"/>
<attribute name="VALUE" x="16.764" y="150.241" size="1.778" layer="96"/>
</instance>
<instance part="AGND1" gate="VR1" x="-20.32" y="139.7" smashed="yes">
<attribute name="VALUE" x="-22.86" y="137.16" size="1.778" layer="96"/>
</instance>
<instance part="GND2" gate="1" x="60.96" y="149.86" smashed="yes">
<attribute name="VALUE" x="58.42" y="147.32" size="1.778" layer="96"/>
</instance>
<instance part="R5" gate="G$1" x="68.58" y="152.4" smashed="yes" rot="R180">
<attribute name="NAME" x="72.39" y="150.9014" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="72.39" y="155.702" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="AGND3" gate="VR1" x="76.2" y="149.86" smashed="yes">
<attribute name="VALUE" x="73.66" y="147.32" size="1.778" layer="96"/>
</instance>
<instance part="GND1" gate="1" x="53.34" y="111.76" smashed="yes">
<attribute name="VALUE" x="50.8" y="109.22" size="1.778" layer="96"/>
</instance>
<instance part="X2" gate="X1" x="93.98" y="170.18" smashed="yes">
<attribute name="NAME" x="87.63" y="175.895" size="1.778" layer="95"/>
<attribute name="VALUE" x="87.63" y="165.1" size="1.778" layer="96"/>
</instance>
<instance part="GND3" gate="1" x="81.28" y="165.1" smashed="yes">
<attribute name="VALUE" x="78.74" y="162.56" size="1.778" layer="96"/>
</instance>
<instance part="C9" gate="G$1" x="175.26" y="124.46" smashed="yes">
<attribute name="NAME" x="176.784" y="124.841" size="1.778" layer="95"/>
<attribute name="VALUE" x="176.784" y="119.761" size="1.778" layer="96"/>
</instance>
<instance part="C10" gate="G$1" x="185.42" y="124.46" smashed="yes">
<attribute name="NAME" x="186.944" y="124.841" size="1.778" layer="95"/>
<attribute name="VALUE" x="186.944" y="119.761" size="1.778" layer="96"/>
</instance>
<instance part="GND4" gate="1" x="175.26" y="114.3" smashed="yes">
<attribute name="VALUE" x="172.72" y="111.76" size="1.778" layer="96"/>
</instance>
<instance part="GND5" gate="1" x="185.42" y="114.3" smashed="yes">
<attribute name="VALUE" x="182.88" y="111.76" size="1.778" layer="96"/>
</instance>
<instance part="JP1" gate="A" x="40.64" y="124.46" smashed="yes">
<attribute name="NAME" x="34.29" y="135.255" size="1.778" layer="95"/>
<attribute name="VALUE" x="34.29" y="114.3" size="1.778" layer="96"/>
</instance>
<instance part="P+4" gate="G$1" x="53.34" y="139.7" smashed="yes">
<attribute name="VALUE" x="55.88" y="142.24" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="P+5" gate="G$1" x="81.28" y="177.8" smashed="yes">
<attribute name="VALUE" x="83.82" y="180.34" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="P+9" gate="G$1" x="175.26" y="132.08" smashed="yes">
<attribute name="VALUE" x="177.8" y="134.62" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="P+10" gate="G$1" x="185.42" y="132.08" smashed="yes">
<attribute name="VALUE" x="187.96" y="134.62" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="P-2" gate="G$1" x="15.24" y="119.38" smashed="yes">
<attribute name="VALUE" x="12.7" y="116.84" size="1.778" layer="96"/>
</instance>
<instance part="P-4" gate="G$1" x="99.06" y="129.54" smashed="yes" rot="R180">
<attribute name="VALUE" x="96.52" y="129.54" size="1.778" layer="96"/>
</instance>
<instance part="P-5" gate="G$1" x="149.86" y="132.08" smashed="yes" rot="R180">
<attribute name="VALUE" x="152.4" y="134.62" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="P-6" gate="G$1" x="162.56" y="132.08" smashed="yes" rot="R180">
<attribute name="VALUE" x="165.1" y="134.62" size="1.778" layer="96" rot="R180"/>
</instance>
</instances>
<busses>
</busses>
<nets>
<net name="+12V" class="0">
<segment>
<wire x1="63.5" y1="172.72" x2="53.34" y2="172.72" width="0.1524" layer="91"/>
<wire x1="53.34" y1="172.72" x2="53.34" y2="175.26" width="0.1524" layer="91"/>
<pinref part="X1" gate="G$1" pin="1"/>
<pinref part="P+3" gate="1" pin="+12V"/>
</segment>
<segment>
<pinref part="IC1" gate="G$1" pin="IN"/>
<pinref part="P+1" gate="1" pin="+12V"/>
<wire x1="-10.16" y1="165.1" x2="-12.7" y2="165.1" width="0.1524" layer="91"/>
<wire x1="-12.7" y1="165.1" x2="-12.7" y2="167.64" width="0.1524" layer="91"/>
<junction x="-12.7" y="165.1"/>
<pinref part="C1" gate="G$1" pin="1"/>
<wire x1="-12.7" y1="157.48" x2="-12.7" y2="165.1" width="0.1524" layer="91"/>
</segment>
</net>
<net name="-12V" class="0">
<segment>
<wire x1="53.34" y1="165.1" x2="53.34" y2="167.64" width="0.1524" layer="91"/>
<wire x1="53.34" y1="167.64" x2="63.5" y2="167.64" width="0.1524" layer="91"/>
<pinref part="P-3" gate="1" pin="-12V"/>
<pinref part="X1" gate="G$1" pin="3"/>
</segment>
<segment>
<pinref part="P-1" gate="1" pin="-12V"/>
<wire x1="-12.7" y1="121.92" x2="-12.7" y2="124.46" width="0.1524" layer="91"/>
<pinref part="IC2" gate="G$1" pin="IN"/>
<wire x1="-12.7" y1="124.46" x2="-10.16" y2="124.46" width="0.1524" layer="91"/>
<junction x="-12.7" y="124.46"/>
<pinref part="C2" gate="G$1" pin="1"/>
<wire x1="-12.7" y1="132.08" x2="-12.7" y2="124.46" width="0.1524" layer="91"/>
</segment>
</net>
<net name="IN_L" class="0">
<segment>
<wire x1="124.46" y1="149.86" x2="137.16" y2="149.86" width="0.1524" layer="91"/>
<label x="124.46" y="149.86" size="1.778" layer="95"/>
<pinref part="JP3" gate="G$1" pin="1"/>
</segment>
<segment>
<pinref part="U1" gate="G$1" pin="VINL"/>
<wire x1="83.82" y1="134.62" x2="93.98" y2="134.62" width="0.1524" layer="91"/>
<label x="86.36" y="134.62" size="1.778" layer="95"/>
</segment>
</net>
<net name="IN_R" class="0">
<segment>
<wire x1="124.46" y1="170.18" x2="137.16" y2="170.18" width="0.1524" layer="91"/>
<label x="124.46" y="170.18" size="1.778" layer="95"/>
<pinref part="JP2" gate="G$1" pin="1"/>
</segment>
<segment>
<pinref part="U1" gate="G$1" pin="VINR"/>
<wire x1="83.82" y1="116.84" x2="93.98" y2="116.84" width="0.1524" layer="91"/>
<label x="86.36" y="116.84" size="1.778" layer="95"/>
</segment>
</net>
<net name="OUT_R" class="0">
<segment>
<wire x1="147.32" y1="170.18" x2="160.02" y2="170.18" width="0.1524" layer="91"/>
<label x="147.32" y="170.18" size="1.778" layer="95"/>
<pinref part="JP4" gate="G$1" pin="1"/>
</segment>
<segment>
<pinref part="U1" gate="G$1" pin="VOUTR"/>
<wire x1="83.82" y1="121.92" x2="93.98" y2="121.92" width="0.1524" layer="91"/>
<label x="86.36" y="121.92" size="1.778" layer="95"/>
</segment>
</net>
<net name="OUT_L" class="0">
<segment>
<wire x1="147.32" y1="149.86" x2="160.02" y2="149.86" width="0.1524" layer="91"/>
<label x="147.32" y="149.86" size="1.778" layer="95"/>
<pinref part="JP5" gate="G$1" pin="1"/>
</segment>
<segment>
<pinref part="U1" gate="G$1" pin="VOUTL"/>
<wire x1="83.82" y1="129.54" x2="93.98" y2="129.54" width="0.1524" layer="91"/>
<label x="86.36" y="129.54" size="1.778" layer="95"/>
</segment>
</net>
<net name="AGND" class="0">
<segment>
<wire x1="63.5" y1="170.18" x2="40.64" y2="170.18" width="0.1524" layer="91"/>
<wire x1="40.64" y1="170.18" x2="40.64" y2="167.64" width="0.1524" layer="91"/>
<pinref part="X1" gate="G$1" pin="2"/>
<pinref part="AGND2" gate="VR1" pin="AGND"/>
</segment>
<segment>
<wire x1="129.54" y1="144.78" x2="129.54" y2="147.32" width="0.1524" layer="91"/>
<wire x1="129.54" y1="147.32" x2="137.16" y2="147.32" width="0.1524" layer="91"/>
<pinref part="JP3" gate="G$1" pin="2"/>
<pinref part="AGND7" gate="VR1" pin="AGND"/>
</segment>
<segment>
<wire x1="152.4" y1="144.78" x2="152.4" y2="147.32" width="0.1524" layer="91"/>
<wire x1="152.4" y1="147.32" x2="160.02" y2="147.32" width="0.1524" layer="91"/>
<pinref part="JP5" gate="G$1" pin="2"/>
<pinref part="AGND11" gate="VR1" pin="AGND"/>
</segment>
<segment>
<wire x1="137.16" y1="167.64" x2="129.54" y2="167.64" width="0.1524" layer="91"/>
<wire x1="129.54" y1="167.64" x2="129.54" y2="165.1" width="0.1524" layer="91"/>
<pinref part="JP2" gate="G$1" pin="2"/>
<pinref part="AGND6" gate="VR1" pin="AGND"/>
</segment>
<segment>
<wire x1="152.4" y1="165.1" x2="152.4" y2="167.64" width="0.1524" layer="91"/>
<wire x1="152.4" y1="167.64" x2="160.02" y2="167.64" width="0.1524" layer="91"/>
<pinref part="JP4" gate="G$1" pin="2"/>
<pinref part="AGND10" gate="VR1" pin="AGND"/>
</segment>
<segment>
<pinref part="U1" gate="G$1" pin="AGNDR"/>
<pinref part="AGND4" gate="VR1" pin="AGND"/>
<wire x1="83.82" y1="119.38" x2="104.14" y2="119.38" width="0.1524" layer="91"/>
<wire x1="104.14" y1="119.38" x2="104.14" y2="116.84" width="0.1524" layer="91"/>
<pinref part="U1" gate="G$1" pin="AGNDL"/>
<wire x1="83.82" y1="132.08" x2="104.14" y2="132.08" width="0.1524" layer="91"/>
<wire x1="104.14" y1="132.08" x2="104.14" y2="119.38" width="0.1524" layer="91"/>
<junction x="104.14" y="119.38"/>
</segment>
<segment>
<pinref part="AGND12" gate="VR1" pin="AGND"/>
<pinref part="C8" gate="G$1" pin="2"/>
<wire x1="162.56" y1="116.84" x2="162.56" y2="119.38" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="AGND9" gate="VR1" pin="AGND"/>
<pinref part="C7" gate="G$1" pin="2"/>
<wire x1="149.86" y1="116.84" x2="149.86" y2="119.38" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="AGND8" gate="VR1" pin="AGND"/>
<pinref part="C6" gate="G$1" pin="2"/>
<wire x1="137.16" y1="116.84" x2="137.16" y2="119.38" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="AGND5" gate="VR1" pin="AGND"/>
<pinref part="C5" gate="G$1" pin="2"/>
<wire x1="124.46" y1="116.84" x2="124.46" y2="119.38" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="R1" gate="G$1" pin="1"/>
<pinref part="R2" gate="G$1" pin="2"/>
<junction x="-2.54" y="144.78"/>
<pinref part="C2" gate="G$1" pin="2"/>
<wire x1="-2.54" y1="144.78" x2="-12.7" y2="144.78" width="0.1524" layer="91"/>
<wire x1="-12.7" y1="144.78" x2="-12.7" y2="139.7" width="0.1524" layer="91"/>
<pinref part="C4" gate="G$1" pin="2"/>
<wire x1="-2.54" y1="144.78" x2="15.24" y2="144.78" width="0.1524" layer="91"/>
<wire x1="15.24" y1="144.78" x2="15.24" y2="139.7" width="0.1524" layer="91"/>
<junction x="-12.7" y="144.78"/>
<junction x="15.24" y="144.78"/>
<pinref part="C1" gate="G$1" pin="2"/>
<wire x1="-12.7" y1="149.86" x2="-12.7" y2="144.78" width="0.1524" layer="91"/>
<pinref part="C3" gate="G$1" pin="2"/>
<wire x1="15.24" y1="149.86" x2="15.24" y2="144.78" width="0.1524" layer="91"/>
<pinref part="AGND1" gate="VR1" pin="AGND"/>
<wire x1="-12.7" y1="144.78" x2="-20.32" y2="144.78" width="0.1524" layer="91"/>
<wire x1="-20.32" y1="144.78" x2="-20.32" y2="142.24" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="R5" gate="G$1" pin="1"/>
<pinref part="AGND3" gate="VR1" pin="AGND"/>
<wire x1="73.66" y1="152.4" x2="76.2" y2="152.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+5V" class="0">
<segment>
<pinref part="C5" gate="G$1" pin="1"/>
<pinref part="P+7" gate="1" pin="+5V"/>
<wire x1="124.46" y1="127" x2="124.46" y2="129.54" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="P+8" gate="1" pin="+5V"/>
<pinref part="C6" gate="G$1" pin="1"/>
<wire x1="137.16" y1="129.54" x2="137.16" y2="127" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="U1" gate="G$1" pin="VA+"/>
<pinref part="P+6" gate="1" pin="+5V"/>
<wire x1="83.82" y1="124.46" x2="99.06" y2="124.46" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="P+2" gate="1" pin="+5V"/>
<wire x1="15.24" y1="167.64" x2="15.24" y2="165.1" width="0.1524" layer="91"/>
<pinref part="R3" gate="G$1" pin="2"/>
<pinref part="IC1" gate="G$1" pin="OUT"/>
<wire x1="7.62" y1="165.1" x2="5.08" y2="165.1" width="0.1524" layer="91"/>
<junction x="7.62" y="165.1"/>
<wire x1="15.24" y1="165.1" x2="7.62" y2="165.1" width="0.1524" layer="91"/>
<junction x="15.24" y="165.1"/>
<pinref part="C3" gate="G$1" pin="1"/>
<wire x1="15.24" y1="157.48" x2="15.24" y2="165.1" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="R2" gate="G$1" pin="1"/>
<pinref part="IC2" gate="G$1" pin="ADJ"/>
<wire x1="-2.54" y1="134.62" x2="-2.54" y2="132.08" width="0.1524" layer="91"/>
<junction x="-2.54" y="134.62"/>
<pinref part="R4" gate="G$1" pin="2"/>
<wire x1="7.62" y1="134.62" x2="-2.54" y2="134.62" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="R1" gate="G$1" pin="2"/>
<junction x="-2.54" y="154.94"/>
<pinref part="R3" gate="G$1" pin="1"/>
<wire x1="7.62" y1="154.94" x2="-2.54" y2="154.94" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="ADJ"/>
<wire x1="-2.54" y1="157.48" x2="-2.54" y2="154.94" width="0.1524" layer="91"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<pinref part="R5" gate="G$1" pin="2"/>
<pinref part="GND2" gate="1" pin="GND"/>
<wire x1="63.5" y1="152.4" x2="60.96" y2="152.4" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="X2" gate="X1" pin="2"/>
<pinref part="GND3" gate="1" pin="GND"/>
<wire x1="91.44" y1="170.18" x2="81.28" y2="170.18" width="0.1524" layer="91"/>
<wire x1="81.28" y1="170.18" x2="81.28" y2="167.64" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C9" gate="G$1" pin="2"/>
<pinref part="GND4" gate="1" pin="GND"/>
<wire x1="175.26" y1="116.84" x2="175.26" y2="119.38" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C10" gate="G$1" pin="2"/>
<pinref part="GND5" gate="1" pin="GND"/>
<wire x1="185.42" y1="116.84" x2="185.42" y2="119.38" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="U1" gate="G$1" pin="DGND"/>
<wire x1="58.42" y1="124.46" x2="53.34" y2="124.46" width="0.1524" layer="91"/>
<pinref part="GND1" gate="1" pin="GND"/>
<wire x1="53.34" y1="114.3" x2="53.34" y2="124.46" width="0.1524" layer="91"/>
</segment>
</net>
<net name="ZCEN" class="0">
<segment>
<pinref part="U1" gate="G$1" pin="ZCEN"/>
<wire x1="58.42" y1="134.62" x2="43.18" y2="134.62" width="0.1524" layer="91"/>
<wire x1="43.18" y1="134.62" x2="43.18" y2="132.08" width="0.1524" layer="91"/>
<pinref part="JP1" gate="A" pin="1"/>
<wire x1="43.18" y1="132.08" x2="38.1" y2="132.08" width="0.1524" layer="91"/>
</segment>
</net>
<net name="/CS" class="0">
<segment>
<pinref part="U1" gate="G$1" pin="/CS"/>
<wire x1="58.42" y1="132.08" x2="45.72" y2="132.08" width="0.1524" layer="91"/>
<wire x1="45.72" y1="132.08" x2="45.72" y2="129.54" width="0.1524" layer="91"/>
<pinref part="JP1" gate="A" pin="2"/>
<wire x1="45.72" y1="129.54" x2="38.1" y2="129.54" width="0.1524" layer="91"/>
</segment>
</net>
<net name="SDI" class="0">
<segment>
<pinref part="U1" gate="G$1" pin="SDI"/>
<wire x1="58.42" y1="129.54" x2="48.26" y2="129.54" width="0.1524" layer="91"/>
<wire x1="48.26" y1="129.54" x2="48.26" y2="127" width="0.1524" layer="91"/>
<pinref part="JP1" gate="A" pin="3"/>
<wire x1="48.26" y1="127" x2="38.1" y2="127" width="0.1524" layer="91"/>
</segment>
</net>
<net name="/MUTE" class="0">
<segment>
<pinref part="U1" gate="G$1" pin="/MUTE"/>
<wire x1="58.42" y1="116.84" x2="43.18" y2="116.84" width="0.1524" layer="91"/>
<wire x1="43.18" y1="116.84" x2="43.18" y2="119.38" width="0.1524" layer="91"/>
<pinref part="JP1" gate="A" pin="6"/>
<wire x1="43.18" y1="119.38" x2="38.1" y2="119.38" width="0.1524" layer="91"/>
</segment>
</net>
<net name="SDO" class="0">
<segment>
<pinref part="U1" gate="G$1" pin="SDO"/>
<wire x1="58.42" y1="119.38" x2="45.72" y2="119.38" width="0.1524" layer="91"/>
<wire x1="45.72" y1="119.38" x2="45.72" y2="121.92" width="0.1524" layer="91"/>
<pinref part="JP1" gate="A" pin="5"/>
<wire x1="45.72" y1="121.92" x2="38.1" y2="121.92" width="0.1524" layer="91"/>
</segment>
</net>
<net name="SCLK" class="0">
<segment>
<pinref part="U1" gate="G$1" pin="SCLK"/>
<wire x1="58.42" y1="121.92" x2="48.26" y2="121.92" width="0.1524" layer="91"/>
<wire x1="48.26" y1="121.92" x2="48.26" y2="124.46" width="0.1524" layer="91"/>
<pinref part="JP1" gate="A" pin="4"/>
<wire x1="48.26" y1="124.46" x2="38.1" y2="124.46" width="0.1524" layer="91"/>
</segment>
</net>
<net name="VCC" class="0">
<segment>
<pinref part="U1" gate="G$1" pin="VCC"/>
<wire x1="58.42" y1="127" x2="53.34" y2="127" width="0.1524" layer="91"/>
<wire x1="53.34" y1="127" x2="53.34" y2="137.16" width="0.1524" layer="91"/>
<pinref part="P+4" gate="G$1" pin="VCC"/>
</segment>
<segment>
<pinref part="X2" gate="X1" pin="1"/>
<wire x1="91.44" y1="172.72" x2="81.28" y2="172.72" width="0.1524" layer="91"/>
<wire x1="81.28" y1="172.72" x2="81.28" y2="175.26" width="0.1524" layer="91"/>
<pinref part="P+5" gate="G$1" pin="VCC"/>
</segment>
<segment>
<pinref part="C9" gate="G$1" pin="1"/>
<wire x1="175.26" y1="127" x2="175.26" y2="129.54" width="0.1524" layer="91"/>
<pinref part="P+9" gate="G$1" pin="VCC"/>
</segment>
<segment>
<pinref part="C10" gate="G$1" pin="1"/>
<wire x1="185.42" y1="127" x2="185.42" y2="129.54" width="0.1524" layer="91"/>
<pinref part="P+10" gate="G$1" pin="VCC"/>
</segment>
</net>
<net name="-5V" class="0">
<segment>
<pinref part="R4" gate="G$1" pin="1"/>
<pinref part="IC2" gate="G$1" pin="OUT"/>
<wire x1="7.62" y1="124.46" x2="5.08" y2="124.46" width="0.1524" layer="91"/>
<junction x="7.62" y="124.46"/>
<wire x1="7.62" y1="124.46" x2="15.24" y2="124.46" width="0.1524" layer="91"/>
<wire x1="15.24" y1="124.46" x2="15.24" y2="121.92" width="0.1524" layer="91"/>
<junction x="15.24" y="124.46"/>
<pinref part="C4" gate="G$1" pin="1"/>
<wire x1="15.24" y1="132.08" x2="15.24" y2="124.46" width="0.1524" layer="91"/>
<pinref part="P-2" gate="G$1" pin="-5V"/>
</segment>
<segment>
<pinref part="U1" gate="G$1" pin="VA-"/>
<wire x1="99.06" y1="127" x2="83.82" y2="127" width="0.1524" layer="91"/>
<pinref part="P-4" gate="G$1" pin="-5V"/>
</segment>
<segment>
<pinref part="C7" gate="G$1" pin="1"/>
<wire x1="149.86" y1="127" x2="149.86" y2="129.54" width="0.1524" layer="91"/>
<pinref part="P-5" gate="G$1" pin="-5V"/>
</segment>
<segment>
<pinref part="C8" gate="G$1" pin="1"/>
<wire x1="162.56" y1="127" x2="162.56" y2="129.54" width="0.1524" layer="91"/>
<pinref part="P-6" gate="G$1" pin="-5V"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
