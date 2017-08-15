How to build the PSP Pokemon editor

# Introduction

This covers my process of creating a PSP Pokemon Save Editor for Pokemon Fire Red. I’m sticking with Red at the moment, maybe I’ll cover more GBA games in the future. 

Note: I’m using the USA version of Pokemon Fire Red. I have not tested with other regions.

First I played about 2 hours of Pokemon. I got my first two Pokemon and evolved to Ivysaur and Metapod. 

My bag contained Antidote x2 and Poke Ball x 16. This is what I used as my baseline to search for in the save file.

As we are starting completely from scratch, I’m using HEX editing to manipulate the save files. I run OS X and decided to use HEX Fiend as it came up first on bing.

Since we are editing save files from the PSP I’ll be using UO GPsp Kai emulator which probably has a different save format that other emulators (VBA). So development and debugging will only work with this emulator.

Lets start..

# Finding the items

First on my list is to have the ability to edit how many items at each slot in the bag there are. For example, currently I have 2 Antidotes in my bag. I want to have 99, so let’s figure out how to get 99.

I took the save file from my PSP Go and make a couple of back ups on my desktop. I won’t start with developing on the PSP app yet. I want to have a proof of concept that what I’m doing works on a computer first. Faster debugging.

So I open up sublime, HEX Fiend and searched the internet for a Pokemon Fire Red (FR for now on) item HEX values. I don’t want to spend finding HEX values myself, I know it’s been done before.

So I found this resource: 
http://datacrystal.romhacking.net/wiki/Pokémon_FireRed_and_LeafGreen:Tutorials

Due to my experience with NDS development, I know how often resources like this get lost in the void. So I've also created a folder called documentation that contains copies of this kind of information. You'll thank me one day... someone poor programmer will.

So Antidote HEX value is 0E00 and Poke Ball HEX value is 0400... Both of these are useless as 0400 is actually CHARMANDERs HEX value too. So we need to find another key value.

Since we know we have 16 Poke Balls. I'm going to try finding 0400 and the HEX value for the number 16 (which I hope is how they number item counts). Of course, 16 HEX-ed(?) is 10... This is going to get tricky. So lets look for this 0400 first to see if we see a 10 somewhere near.

After about 10 minutes of looking up different 8 byte values of both 0400 and 0010... Still nothing that makes sense. So lets think out side the box...

#### Finding the bag(s ???)

I know I have TM-39 "Rock Tomb" because Brock just gave me it for beating him. So out of shear luck, there's only two spots that have TM-39 HEX value 4701. HEX Fiend gives me `4701920E` and `47010529`. This values are also accompanied by 920E and 0529 respectively. There's a lot of 920E and 0529 near each other. I think I'm looking at the HEX values for the BAG. For whatever reason there's two parts of the bag, we'll figure that out soon. 

I can verify this because I see 6C010529 which is the HEX value for teachy tv, which we are given at the start of the game.

So just to test things out let use HEX fiend and change TM-39 to TM27 (3B01). I'll change it first in one section see what happens and then see what happens if we do the other, then see what happens with both....

### What is the 0529 cluster: 

So I change 47010529 to 3B010529, transfer the save file to my PSP and open the game. The game boots up, and I get a nice "The save file is corrupted." message. Looks like, we might need to change both. 

but WAIT! I forgot, Pokemon Fire Red has an automatic backup system. I'm able to get right back to my save file and continue playing without any problems. So I bet 0529 is the 1st stage and 920E is the backup. The reason why I think 920E is the backup is because the game automatically reverted to having TM-39 which is exactly what we didn't change.


### Is 920E the backup bag?

Let's try only changing 920E and keeping 0529 as TM-39. Let see if we'll get the corrupted message but the game will revert to TM-27.



