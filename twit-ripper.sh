#!/bin/bash

#echo "**************************************"
#echo "twit.tv Ripper v0.2"
#echo "esc0rtd3w / crackacademy.com"
#echo "**************************************"


#echo "**************************************"

# TO DO LIST:

# - Fix url links for older files

#echo "**************************************"




setWindowTitle(){

title='echo -ne "\033]0;twit.tv Media Ripper\007"'

$title


#case $TERM in
#    xterm*)
#        PS1="\[\033]0;\u@\h: \w\007\]bash\\$ "
#        ;;
#    *)
#        PS1="bash\\$ "
#        ;;
#esac

}


setDefaults(){

# Page variable used for navigation, and returning to previous page
#page="0"

# Use padding for episodes to download correctly (Example: 15 -> 0015)
padding=""

# URLs for newer files (2012-2013???)
baseURL="http://twit.cachefly.net"
baseURLAudio="http://twit.cachefly.net/audio"
#baseURLAudio="http://www.podtrac.com/pts/redirect.mp3/twit.cachefly.net/audio"
baseURLVideo="http://twit.cachefly.net/video"
#baseURLVideo="http://dts.podtrac.com/redirect.mp4/twit.cachefly.net/video"
baseURLWebView="http://twit.tv/show"

# URLs for older files
baseURLAOL="http://aolradio.podcast.aol.com"
baseURLOld1=""
baseURLOld2=""

# These are the finalized URLs built from all other variables (set blank as deault)
fullURLAudio=""
fullURLVideoHD=""
fullURLVideoSDS=""
fullURLVideoSDL=""

# Set link status to switch base URLs
linkStatus="default"

# Default 404 status
status404="0"

# Set failed URLs
failedLinkDefault="0"
failedLinkAOL="0"
failedLinkLegacy1="0"
failedLinkLegacy2="0"

# Video tags. These are for direct downloads of video files
videoSize=""
videoSizeHD="_h264m_1280x720_1872"
videoSizeSDLarge="_h264m_864x480_500"
videoSizeSDSmall="_h264b_640x368_256"

# Default show name and episode (0 for episode as default for proper initial incrementing)
showName=""
showEpisode="0"

# Default audio and video filename extensions
extAudio="mp3"
extVideo="mp4"

}


setShowNames(){

# Web page view example: http://twit.tv/show/this-week-in-youtube/1
# HTML link example: <a href=" http://twit.cachefly.net/audio/yt/yt0001/yt0001.mp3">yt0001.mp3</a>
# Direct download example (audio): http://twit.cachefly.net/audio/yt/yt0001/yt0001.mp3
# Direct download example (HD): http://twit.cachefly.net/video/yt/yt0001/yt0001_h264m_1280x720_1872.mp4
# Direct download example (SD Large): http://twit.cachefly.net/video/yt/yt0001/yt0001_h264m_864x480_500.mp4
# Direct download example (SD Small): http://twit.cachefly.net/video/yt/yt0001/yt0001_h264b_640x368_256.mp4

# Filename Examples (Original Links):
# Audio: http://www.podtrac.com/pts/redirect.mp3/twit.cachefly.net/audio/yt/yt0001/yt0001.mp3
# Audio (AOL): http://www.podtrac.com/pts/redirect.mp3/aolradio.podcast.aol.com/twit/twit0304.mp3
# HD Video: http://dts.podtrac.com/redirect.mp4/twit.cachefly.net/video/yt/yt0001/yt0001_h264m_1280x720_1872.mp4
# Audio (Oldest): http://www.podtrac.com/pts/redirect.mp3/twit.cachefly.net/aaa0001.mp3
# SD Video Large: http://dts.podtrac.com/redirect.mp4/twit.cachefly.net/video/yt/yt0001/yt0001_h264m_864x480_500.mp4
# SD Video Small: http://dts.podtrac.com/redirect.mp4/twit.cachefly.net/video/yt/yt0001/yt0001_h264b_640x368_256.mp4


# Show Names (in formatted readable text)
showNameAllAboutAndroid="All About Android"
showNameAndroidAppArena="Android App Arena"
showNameBeforeYouBuy="Before You Buy"
showNameFlossWeekly="FLOSS Weekly"
showNameHamNation="Ham Nation"
showNameHomeTheaterGeeks="Home Theater Geeks"
showNameIfiveForTheIphone="iFive For The iPhone"
showNameIpadToday="iPad Today"
showNameKnowHow="Know How"
showNameMacBreakWeekly="MacBreak Weekly"
showNameOMGCraft="OMGCraft"
showNamePadresCorner="Padres Corner"
showNameRadioLeo="Radio Leo"
showNameSecurityNow="Security Now"
showNameTechNewsTonight="Tech News Tonight"
showNameTechNewsToday="Tech News Today"
showNameTheGizWiz="The Giz Wiz"
showNameTheSocialHour="The Social Hour"
showNameTheTechGuy="The Tech Guy"
showNameThisWeekInComputerHardware="This Week In Computer Hardware"
showNameThisWeekInEnterpriseTech="This Week In Enterprise Tech"
showNameThisWeekInGoogle="This Week In Google"
showNameThisWeekInLaw="This Week In Law"
showNameThisWeekInTech="This Week In Tech"
showNameTriangulation="Triangulation"
showNameTwitBits="Twit Bits"
showNameTwitLiveSpecials="TWiT Live Specials"
showNameWindowsWeekly="Windows Weekly"

# Link Names (used in webpage links for viewing in browser)
showLinkNameWebAllAboutAndroid="all-about-android"
showLinkNameWebAndroidAppArena="android-app-arena"
showLinkNameWebBeforeYouBuy="before-you-buy"
showLinkNameWebFlossWeekly="floss-weekly"
showLinkNameWebHamNation="ham-nation"
showLinkNameWebHomeTheaterGeeks="home-theater-geeks"
showLinkNameWebIfiveForTheIphone="ifive-iphone"
showLinkNameWebIpadToday="ipad-today"
showLinkNameWebKnowHow="know-how"
showLinkNameWebMacBreakWeekly="macbreak-weekly"
showLinkNameWebOMGCraft="omgcraft"
showLinkNameWebPadresCorner="padres-corner"
showLinkNameWebRadioLeo="leos-audio-appearances-this-week"
showLinkNameWebSecurityNow="security-now"
showLinkNameWebTechNewsToday="tech-news-2night"
showLinkNameWebTechNewsToday="tech-news-today"
showLinkNameWebTheGizWiz="weekly-daily-giz-wiz"
showLinkNameWebTheSocialHour="social-hour"
showLinkNameWebTheTechGuy="the-tech-guy"
showLinkNameWebThisWeekInComputerHardware="this-week-in-computer-hardware"
showLinkNameWebThisWeekInEnterpriseTech="this-week-in-enterprise-tech"
showLinkNameWebThisWeekInGoogle="this-week-in-google"
showLinkNameWebThisWeekInLaw="this-week-in-law"
showLinkNameWebThisWeekInTech="this-week-in-tech"
showLinkNameWebTriangulation="triangulation"
showLinkNameWebTwitBits="twit-bits"
showLinkNameWebTwitLiveSpecials="twit-live-specials"
showLinkNameWebWindowsWeekly="windows-weekly"

# Abbreviated Show Names (used in direct downloads and for prefix on filenames)
showLinkNameDirectAllAboutAndroid="aaa"
showLinkNameDirectAllAboutAndroid="arena"
showLinkNameDirectBeforeYouBuy="byb"
showLinkNameDirectFlossWeekly="floss"
showLinkNameDirectHamNation="hn"
showLinkNameDirectHomeTheaterGeeks="htg"
showLinkNameDirectIfiveForTheIphone="ifive"
showLinkNameDirectIpadToday="ipad"
showLinkNameDirectKnowHow="kh"
showLinkNameDirectMacBreakWeekly="mbw"
showLinkNameDirectOMGCraft="omgcraft"
showLinkNameDirectPadresCorner="padre"
showLinkNameDirectRadioLeo=""
showLinkNameDirectSecurityNow="sn"
showLinkNameDirectTechNewsTonight="tn2n"
showLinkNameDirectTechNewsToday="tnt"
showLinkNameDirectTheGizWiz="dgw"
showLinkNameDirectTheSocialHour="tsh"
showLinkNameDirectTheTechGuy="ttg"
showLinkNameDirectThisWeekInComputerHardware="twich"
showLinkNameDirectThisWeekInEnterpriseTech="twiet"
showLinkNameDirectThisWeekInGoogle="twig"
showLinkNameDirectThisWeekInLaw="twil"
showLinkNameDirectThisWeekInTech="twit"
showLinkNameDirectTriangulation="tri"
showLinkNameDirectTwitBits="bits"
showLinkNameDirectTwitLiveSpecials="specials"
showLinkNameDirectWindowsWeekly="ww"


}


setShowNamesRetired(){

# Retired Shows Go Here

# Show Names (in formatted readable text)
showNameAbbysRoad="Abbys Road"
showNameCurrentGeekWeekly="Current Geek Weekly"
showNameDrKikisScienceHour="Dr Kikis Science Hour"
showNameFrameRate="Frame Rate"
showNameFuturesInBiotech="Futures In Biotech"
showNameGameOn="Game On"
showNameJumpingMonkeys="Jumping Monkeys"
showNameMacBreak="MacBreak"
showNameMaxwellsHouse="Maxwells House"
showNameNetAtNight="Net At Night"
showNameNSFW="NSFW"
showNameRozRowsThePacific="Roz Rows The Pacific"
showNameTechHistoryToday="Tech History Today"
showNameLaPorteReport="The Laporte Report"
showNameThisWeekInFun="This Week In Fun"
showNameThisWeekInYoutube="This Week In Youtube"
showNameTreysVarietyHour="Treys Variety Hour"
showNameTwitPhoto="TWiT Photo"

# Link Names (used in webpage links for viewing in browser)
showLinkNameWebAbbysRoad="abbys-road"
showLinkNameWebCurrentGeekWeekly="current-geek-weekly"
showLinkNameWebDrKikisScienceHour="dr-kikis-science-hour"
showLinkNameWebFrameRate="frame-rate"
showLinkNameWebFuturesInBiotech="futures-in-biotech"
showLinkNameWebGameOn="game-on"
showLinkNameWebJumpingMonkeys="jumping-monkeys"
showLinkNameWebMacBreak="macbreak"
showLinkNameWebMaxwellsHouse="maxwells-house"
showLinkNameWebNetAtNight="netnight-amber-and-leo"
showLinkNameWebNSFW="nsfw"
showLinkNameWebRozRowsThePacific="roz-rows-the-pacific"
showLinkNameWebTechHistoryToday="tech-history-today"
showLinkNameWebLaPorteReport="the-laporte-report"
showLinkNameWebThisWeekInFun="this-week-in-fun"
showLinkNameWebThisWeekInYoutube="this-week-in-youtube"
showLinkNameWebTreysVarietyHour="treys-variety-hour"
showLinkNameWebTwitPhoto="twit-photo"

# Abbreviated Show Names (used in direct downloads and for prefix on filenames)
showLinkNameDirectAbbysRoad="abby"
showLinkNameDirectCurrentGeekWeekly="cgw"
showLinkNameDirectDrKikisScienceHour="dksh"
showLinkNameDirectFrameRate="fr"
showLinkNameDirectFuturesInBiotech="fib"
showLinkNameDirectGameOn="go"
showLinkNameDirectJumpingMonkeys="jm"
showLinkNameDirectMacBreak="macbreak"
showLinkNameDirectMaxwellsHouse="mh"
showLinkNameDirectNetAtNight="natn"
showLinkNameDirectNSFW="nsfw"
showLinkNameDirectRozRowsThePacific="roz"
showLinkNameDirectTechHistoryToday="tht"
showLinkNameDirectLaPorteReport="tlr"
showLinkNameDirectThisWeekInFun="twif"
showLinkNameDirectThisWeekInYoutube="yt"
showLinkNameDirectTreysVarietyHour="tvh"
showLinkNameDirectTwitPhoto="photo"

}


setShowNamesAOL(){

# These are for older file naming schemes (oldest)

linkStatus="aol"

echo "setShowNamesAOL"
read

#showLinkDirect="$showLinkDirect-"

fullURLAudio="$baseURLAOL/$showLinkDirect/$showLinkDirect$padding$showEpisode.$extAudio"
#fullURLVideoHD="$baseURL/$showLinkDirect$padding$showEpisode$videoSizeHD.$extVideo"
#fullURLVideoSDL="$baseURLV/$showLinkDirect$padding$showEpisode$videoSizeSDLarge.$extVideo"
#fullURLVideoSDS="$baseURL/$showLinkDirect$padding$showEpisode$videoSizeSDSmall.$extVideo"

# set linkStatus for next available format
#linkStatus="legacy1"

}


setShowNamesLegacy1(){

# These are for older file naming schemes (oldest)

linkStatus="legacy1"

echo "setShowNamesLegacy1"
read

#showLinkDirect="$showLinkDirect-"

fullURLAudio="$baseURL/$showLinkDirect-$padding$showEpisode.$extAudio"
#fullURLVideoHD="$baseURL/$showLinkDirect$padding$showEpisode$videoSizeHD.$extVideo"
#fullURLVideoSDL="$baseURLV/$showLinkDirect$padding$showEpisode$videoSizeSDLarge.$extVideo"
#fullURLVideoSDS="$baseURL/$showLinkDirect$padding$showEpisode$videoSizeSDSmall.$extVideo"

# set linkStatus for next available format
#linkStatus="legacy2"

}


setShowNamesLegacy2(){

# These are for older file naming schemes (2nd oldest)

linkStatus="legacy2"

echo "setShowNamesLegacy2"
read

fullURLAudio="$baseURL/$showLinkDirect$padding$showEpisode.$extAudio"
#fullURLVideoHD="$baseURL/$showLinkDirect$padding$showEpisode$videoSizeHD.$extVideo"
#fullURLVideoSDL="$baseURLV/$showLinkDirect$padding$showEpisode$videoSizeSDLarge.$extVideo"
#fullURLVideoSDS="$baseURL/$showLinkDirect$padding$showEpisode$videoSizeSDSmall.$extVideo"

# set linkStatus for next available format
#linkStatus="default"

}


banner(){

# This is the default header and can be displayed anywhere

setWindowTitle

clear
echo "**************************************"
echo "twit.tv Ripper v0.3"
echo "esc0rtd3w / crackacademy.com"
echo "**************************************"
echo ""

}


menuMain(){

page="1"

banner
setDefaults

echo "Select a Show"
echo ""
echo "1) $showNameAllAboutAndroid"
echo "2) $showNameBeforeYouBuy"
echo "3) $showNameFlossWeekly"
echo "4) $showNameFrameRate"
echo "5) $showNameHamNation"
echo "6) $showNameHomeTheaterGeeks"
echo "7) $showNameIfiveForTheIphone"
echo "8) $showNameIpadToday"
echo "9) $showNameKnowHow"
echo ""
echo "N) Next Page"
echo "X) Exit"
echo ""
echo ""

read doTask

case "$doTask" in

"")
menuMain
;;

"1")
showName="$showNameAllAboutAndroid"
showLinkDirect="$showLinkNameDirectAllAboutAndroid"
showLinkWeb="$showLinkNameWebAllAboutAndroid"
processShow
;;

"2")
showName="$showNameBeforeYouBuy"
showLinkDirect="$showLinkNameDirectBeforeYouBuy"
showLinkWeb="$showLinkNameWebBeforeYouBuy"
processShow
;;

"3")
showName="$showNameFlossWeekly"
showLinkDirect="$showLinkNameDirectFlossWeekly"
showLinkWeb="$showLinkNameWebFlossWeekly"
processShow
;;

"4")
showName="$showNameFrameRate"
showLinkDirect="$showLinkNameDirectFrameRate"
showLinkWeb="$showLinkNameWebFrameRate"
processShow
;;

"5")
showName="$showNameHamNation"
showLinkDirect="$showLinkNameDirectHamNation"
showLinkWeb="$showLinkNameWebHamNation"
processShow
;;

"6")
showName="$showNameHomeTheaterGeeks"
showLinkDirect="$showLinkNameDirectHomeTheaterGeeks"
showLinkWeb="$showLinkNameWebHomeTheaterGeeks"
processShow
;;

"7")
showName="$showNameIfiveForTheIphone"
showLinkDirect="$showLinkNameDirectIfiveForTheIphone"
showLinkWeb="$showLinkNameWebIfiveForTheIphone"
processShow
;;

"8")
showName="$showNameIpadToday"
showLinkDirect="$showLinkNameDirectIpadToday"
showLinkWeb="$showLinkNameWebIpadToday"
processShow
;;

"9")
showName="$showNameKnowHow"
showLinkDirect="$showLinkNameDirectKnowHow"
showLinkWeb="$showLinkNameWebKnowHow"
processShow
;;

"N" | "n")
menuMainSubPage1
;;

"X" | "x")
exit
;;

*)
menuMain
;;

esac

}


menuMainSubPage1(){

page="2"

banner
setDefaults

echo "Select a Show"
echo ""
echo "1) $showNameMacBreakWeekly"
echo "2) $showNameNSFW"
echo "3) $showNameOMGCraft"
echo "4) $showNameRadioLeo"
echo "5) $showNameSecurityNow"
echo "6) $showNameTechNewsToday"
echo "7) $showNameTheGizWiz"
echo "8) $showNameTheSocialHour"
echo "9) $showNameTheTechGuy"
echo ""
echo "N) Next Page"
echo "P) Previous Page"
echo "X) Exit"
echo ""
echo ""

read doTask

case "$doTask" in

"")
menuMainSubPage1
;;

"1")
showName="$showNameMacBreakWeekly"
showLinkDirect="$showLinkNameDirectMacBreakWeekly"
showLinkWeb="$showLinkNameWebMacBreakWeekly"
processShow
;;

"2")
showName="$showNameNSFW"
showLinkDirect="$showLinkNameDirectNSFW"
showLinkWeb="$showLinkNameWebNSFW"
processShow
;;

"3")
showName="$showNameOMGCraft"
showLinkDirect="$showLinkNameDirectOMGCraft"
showLinkWeb="$showLinkNameWebOMGCraft"
processShow
;;

"4")
showName="$showNameRadioLeo"
showLinkDirect="$showLinkNameDirectRadioLeo"
showLinkWeb="$showLinkNameWebRadioLeo"
processShow
;;

"5")
showName="$showNameSecurityNow"
showLinkDirect="$showLinkNameDirectSecurityNow"
showLinkWeb="$showLinkNameWebSecurityNow"
processShow
;;

"6")
showName="$showNameTechNewsToday"
showLinkDirect="$showLinkNameDirectTechNewsToday"
showLinkWeb="$showLinkNameWebTechNewsToday"
processShow
;;

"7")
showName="$showNameTheGizWiz"
showLinkDirect="$showLinkNameDirectTheGizWiz"
showLinkWeb="$showLinkNameWebTheGizWiz"
processShow
;;

"8")
showName="$showNameTheSocialHour"
showLinkDirect="$showLinkNameDirectTheSocialHour"
showLinkWeb="$showLinkNameWebTheSocialHour"
processShow
;;

"9")
showName="$showNameTheTechGuy"
showLinkDirect="$showLinkNameDirectTheTechGuy"
showLinkWeb="$showLinkNameWebTheTechGuy"
processShow
;;

"N" | "n")
menuMainSubPage2
;;

"P" | "p")
menuMain
;;

"X" | "x")
exit
;;

*)
menuMainSubPage1
;;

esac

}


menuMainSubPage2(){

page="3"

banner
setDefaults

echo "Select a Show"
echo ""
echo "1) $showNameThisWeekInComputerHardware"
echo "2) $showNameThisWeekInEnterpriseTech"
echo "3) $showNameThisWeekInGoogle"
echo "4) $showNameThisWeekInLaw"
echo "5) $showNameThisWeekInTech"
echo "6) $showNameThisWeekInYoutube"
echo "7) $showNameTriangulation"
echo "8) $showNameTwitLiveSpecials"
echo "9) $showNameWindowsWeekly"
echo ""
echo "P) Previous Page"
echo "X) Exit"
echo ""
echo ""

read doTask

case "$doTask" in

"")
menuMainSubPage2
;;

"1")
showName="$showNameThisWeekInComputerHardware"
showLinkDirect="$showLinkNameDirectThisWeekInComputerHardware"
showLinkWeb="$showLinkNameWebThisWeekInComputerHardware"
processShow
;;

"2")
showName="$showNameThisWeekInEnterpriseTech"
showLinkDirect="$showLinkNameDirectThisWeekInEnterpriseTech"
showLinkWeb="$showLinkNameWebThisWeekInEnterpriseTech"
processShow
;;

"3")
showName="$showNameThisWeekInGoogle"
showLinkDirect="$showLinkNameDirectThisWeekInGoogle"
showLinkWeb="$showLinkNameWebThisWeekInGoogle"
processShow
;;

"4")
showName="$showNameThisWeekInLaw"
showLinkDirect="$showLinkNameDirectThisWeekInLaw"
showLinkWeb="$showLinkNameWebThisWeekInLaw"
processShow
;;

"5")
showName="$showNameThisWeekInTech"
showLinkDirect="$showLinkNameDirectThisWeekInTech"
showLinkWeb="$showLinkNameWebThisWeekInTech"
processShow
;;

"6")
showName="$showNameThisWeekInYoutube"
showLinkDirect="$showLinkNameDirectThisWeekInYoutube"
showLinkWeb="$showLinkNameWebThisWeekInYoutube"
processShow
;;

"7")
showName="$showNameTriangulation"
showLinkDirect="$showLinkNameDirectTriangulation"
showLinkWeb="$showLinkNameWebTriangulation"
processShow
;;

"8")
showName="$showNameTwitLiveSpecials"
showLinkDirect="$showLinkNameDirectTwitLiveSpecials"
showLinkWeb="$showLinkNameWebTwitLiveSpecials"
processShow
;;

"9")
showName="$showNameWindowsWeekly"
showLinkDirect="$showLinkNameDirectWindowsWeekly"
showLinkWeb="$showLinkNameWebWindowsWeekly"
processShow
;;

"P" | "p")
menuMainSubPage1
;;

"X" | "x")
exit
;;

*)
menuMainSubPage2
;;

esac

}


getNewURL(){

case "$linkStatus" in

"default")
fullURLAudio="$baseURLAudio/$showLinkDirect/$showLinkDirect$padding$showEpisode/$showLinkDirect$padding$showEpisode.$extAudio"
#failedLinkDefault="0"
;;

"aol")
fullURLAudio="$baseURLAOL/$showLinkDirect/$showLinkDirect$padding$showEpisode.$extAudio"
#failedLinkAOL="0"
;;

"legacy1")
fullURLAudio="$baseURL/$showLinkDirect-$padding$showEpisode.$extAudio"
#failedLinkLegacy1="0"
;;

"legacy2")
fullURLAudio="$baseURL/$showLinkDirect-$padding$showEpisode.$extAudio"
#failedLinkLegacy2="0"
;;

esac

#fullURLAudio="$baseURLAudio/$showLinkDirect/$showLinkDirect$padding$showEpisode/$showLinkDirect$padding$showEpisode.$extAudio"
fullURLVideoHD="$baseURLVideo/$showLinkDirect/$showLinkDirect$padding$showEpisode/$showLinkDirect$padding$showEpisode$videoSizeHD.$extVideo"
fullURLVideoSDL="$baseURLVideo/$showLinkDirect/$showLinkDirect$padding$showEpisode/$showLinkDirect$padding$showEpisode$videoSizeSDLarge.$extVideo"
fullURLVideoSDS="$baseURLVideo/$showLinkDirect/$showLinkDirect$padding$showEpisode/$showLinkDirect$padding$showEpisode$videoSizeSDSmall.$extVideo"
fullURLWebpage="$baseURLWebView/$showLinkWeb/$showEpisode"

}


getEpisodeNumber(){

if (($showEpisodeTemp > 9999)); then

padding=""

fi

if (($showEpisodeTemp > 999)); then

padding=""

fi

if (($showEpisodeTemp > 99)); then

padding="0"

fi

if (($showEpisodeTemp < 10)); then

padding="000"

fi

if (($showEpisodeTemp > 9)); then

padding="00"

fi

if (($showEpisodeTemp > 99)); then

padding="0"

fi

if (($showEpisodeTemp > 999)); then

padding=""

fi

if (($showEpisodeTemp > 9999)); then

padding=""

fi

showEpisode="$showEpisodeTemp"

}


episodeNumberInc(){

showEpisodeTemp=$(($showEpisode+1))

}


episodeNumberDec(){

showEpisodeTemp=$(($showEpisode-1))

}


processShow(){

#echo "$fullURLAudio"
#read

# Remove zero byte and other bad or incomplete files
cleanBadFiles

if [ $failedLinkDefault == 1 ]; then

linkStatus="aol"
failedLinkDefault="0"
getNewURL

fi

if [ $failedLinkAOL == 1 ]; then

linkStatus="legacy1"
failedLinkAOL="0"
getNewURL

fi

if [ $failedLinkLegacy1 == 1 ]; then

linkStatus="legacy2"
failedLinkLegacy1="0"
getNewURL

fi


if [ $failedLinkLegacy2 == 1 ]; then

linkStatus="default"
failedLinkLegacy2="0"
getNewURL

fi


# Increment episode number (use "episodeDec" to decrease)
episodeNumberInc

# Gets the current episode number
getEpisodeNumber

# Get the new url built from arguments
#checkBadURL
getNewURL


# Test variables
#echo "Audio: $fullURLAudio"
#echo "Video HD: $fullURLVideoHD"
#echo "Video SD Large: $fullURLVideoSDL"
#echo "Video SD Small: $fullURLVideoSDS"
#echo "Web Page View: $fullURLWebpage"

banner
echo "Current Show: $showName"
echo "Current Episode Number: $showEpisode"
echo ""
echo ""
echo "ENTER) Load Next Episode Number"
echo ""
echo "C) Choose Episode Number"
echo ""
echo "W) Open Webpage In Default Browser"
echo "A) Download Current Audio File"
echo "H) Download Current HD Video File"
echo "L) Download Current SD Large Video File"
echo "S) Download Current SD Small Video File"
echo ""
echo "P) Previous Page"
echo "X) Exit"
echo ""
echo ""

read getAction

case "$getAction" in

"")
processShow
;;

"C" | "c")
setManualEpisodeNumber
processShow
;;

"W" | "w")
openFileInWebBrowser
;;

"A" | "a")
downloadCurrentFileAudio
check404Status
;;

"H" | "h")
downloadCurrentFileVideoHD
check404Status
;;

"L" | "l")
downloadCurrentFileVideoSDLarge
check404Status
;;

"S" | "s")
downloadCurrentFileVideoSDSmall
check404Status
;;

"P" | "p")
getCurrentPageAndGoBack
;;

"X" | "x")
exit
;;

*)
processShow
;;

esac

}


check404Status(){

# Check 404 status on failed direct links

# Failed WGET returns errorlevel 8

status404="$?"

echo "status404: $status404"

if [ $status404 == 8 ]; then
linkStatus="aol"
failedLinkAOL="1"
processShow
fi


#echo "after jump"
#read tmp

#checkZeroByteFiles

#echo "showZeroByteFiles: $showZeroByteFiles"

#status404="$?"

#wget $1 2>/dev/null
#if (( $status404 -ne 0 )); then
#setShowNamesLegacy1
#fi

#setDefaults
#processShow

#episodeNumberDec

}


checkBadURL(){

case "$linkStatus" in

"aol")
getNewURL
processShow

status404="$?"

echo "status404: $status404"

if [ $status404 == 8 ]; then
linkStatus="legacy1"
processShow
fi
;;

"legacy1")
getNewURL
processShow

status404="$?"

echo "status404: $status404"

if [ $status404 == 8 ]; then
linkStatus="legacy2"
processShow
fi
;;

"legacy2")
getNewURL
processShow

status404="$?"

echo "status404: $status404"

if [ $status404 == 8 ]; then
linkStatus="default"
echo "ALL URL LINKS FAILED!"
read pause
fi
;;

esac

}


setManualEpisodeNumber(){

# Set manual episode number
banner
echo "Enter an Episode Number and press ENTER:"
echo ""
echo ""

read showEpisode

showEpisode=$(($showEpisode - 1))

}


openFileInWebBrowser(){

# Open current file episode number in web browser
firefox "$fullURLWebpage"

}


downloadCurrentFileAudio(){

# Download files
mkdir "$showLinkWeb"
banner
echo "Downloading $showLinkWeb-$padding$showEpisode.$extAudio...."
echo ""
echo ""
wget -O "$showLinkWeb/$showLinkWeb-$padding$showEpisode.$extAudio" "$fullURLAudio"

check404Status

processShow

}


downloadCurrentFileVideoHD(){

# Download files
mkdir "$showLinkWeb"
banner
echo "Downloading $showLinkWeb-$padding$showEpisode.$extVideo...."
echo ""
echo ""
wget "$showLinkWeb/$showLinkWeb-$padding$showEpisode.$extVideo" "$fullURLVideoHD"

#check404Status

processShow

}


downloadCurrentFileVideoSDLarge(){

# Download files
mkdir "$showLinkWeb"
banner
echo "Downloading $showLinkWeb-$padding$showEpisode.$extVideo...."
echo ""
echo ""
wget "$showLinkWeb/$showLinkWeb-$padding$showEpisode.$extVideo" "$fullURLVideoSDL"

#check404Status

processShow

}


downloadCurrentFileVideoSDSmall(){

# Download files
mkdir "$showLinkWeb"
banner
echo "Downloading $showLinkWeb-$padding$showEpisode.$extVideo...."
echo ""
echo ""
wget "$showLinkWeb/$showLinkWeb-$padding$showEpisode.$extVideo" "$fullURLVideoSDS"

#check404Status

processShow

}


getCurrentPageAndGoBack(){


if (( $page > 2)); then
menuMainSubPage2
fi

if (( $page > 1)); then
menuMainSubPage1
fi

if (( $page > 0)); then
menuMain
fi
}


cleanBadFiles(){

#find . -type f -size 0 | xargs rm

deleteZeroByteFiles=$(find . -type f -size 0 | xargs rm)

banner

}


checkZeroByteFiles(){

showZeroByteFiles=$(find . -type f -size 0)

}


cleanBadFiles
setDefaults
setShowNames
setShowNamesRetired
menuMain

