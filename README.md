How to build the PSP Pokemon editor

# Introduction

This covers my process of creating a PSP Pokemon Save Editor for Pokemon Fire Red. I’m sticking with Red at the moment, maybe I’ll cover more GBA games in the future. 

Note: I’m using the USA version of Pokemon Fire Red. I have not tested with other regions.

First I played about 2 hours of Pokemon. I got my first two Pokemon and evolved to Ivysaur and Metapod. 

My bag contained Antidote x2 and Poke Ball x 16. This is what I used as my baseline to search for in the save file.

As we are starting completely from scratch, I’m using HEX editing to manipulate the save files. I run OS X and decided to use HEX Fiend as it came up first on bing.

Since we are editing save files from the PSP I’ll be using UO GPsp Kai emulator which probably has a different save format that other emulators (VBA). So development and debugging will only work with this emulator.

Lets start..

TLDR; PSP app to edit Pokemon GBA games

# Finding the items (sort of)

First on my list is to have the ability to edit how many items at each slot in the bag there are. For example, currently I have 2 Antidotes in my bag. I want to have 99, so let’s figure out how to get 99.

I took the save file from my PSP Go and make a couple of back ups on my desktop. I won’t start with developing on the PSP app yet. I want to have a proof of concept that what I’m doing works on a computer first. Faster debugging.

So I open up sublime, HEX Fiend and searched the internet for a Pokemon Fire Red (FR for now on) item HEX values. I don’t want to spend finding HEX values myself, I know it’s been done before.

So I found this resource: 
http://datacrystal.romhacking.net/wiki/Pokémon_FireRed_and_LeafGreen:Tutorials

Due to my experience with NDS development, I know how often resources like this get lost in the void. So I've also created a folder called documentation that contains copies of this kind of information. You'll thank me one day... someone poor programmer will.

So Antidote HEX value is 0E00 and Poke Ball HEX value is 0400... Both of these are useless as 0400 is actually CHARMANDERs HEX value too. So we need to find another key value.

Since we know we have 16 Poke Balls. I'm going to try finding 0400 and the HEX value for the number 16 (which I hope is how they number item counts). Of course, 16 HEX-ed(?) is 10... This is going to get tricky. So lets look for this 0400 first to see if we see a 10 somewhere near.

After about 10 minutes of looking up different 8 byte values of both 0400 and 0010... Still nothing that makes sense. So lets think out side the box...

TLDR; tools and resource for HEX values

#### Finding the bag(s ???) (confusingly did it)

I know I have TM-39 "Rock Tomb" because Brock just gave me it for beating him. So out of shear luck, there's only two spots that have TM-39 HEX value 4701. HEX Fiend gives me `4701920E` and `47010529`. This values are also accompanied by 920E and 0529 respectively. There's a lot of 920E and 0429 near each other. I think I'm looking at the HEX values for the BAG. For whatever reason there's two parts of the bag, we'll figure that out soon. 

I can verify this because I see 6C010529 which is the HEX value for teachy tv, which we are given at the start of the game.

So just to test things out let use HEX fiend and change TM-39 to TM27 (3B01). I'll change it first in one section see what happens and then see what happens if we do the other, then see what happens with both....

TLDR; found a two sections that are probably the bag at least the key items bag + TM/HMs

### What is the 0529 cluster..

So I change 47010529 to 3B010529, transfer the save file to my PSP and open the game. The game boots up, and I get a nice "The save file is corrupted." message. Looks like, we might need to change both. 

but WAIT! I forgot, Pokemon Fire Red has an automatic backup system. I'm able to get right back to my save file and continue playing without any problems. So I bet 0529 is the 1st stage and 920E is the backup. The reason why I think 920E is the backup is because the game automatically reverted to having TM-39 which is exactly what we didn't change.

TLDR; oh, a backup system is fighting me

### Is 920E the backup bag? (failed)

Let's try only changing 920E and keeping 0529 as TM-39. Let see if we'll get the corrupted message but the game will revert to TM-27 (3B01).

So I boot up FR, I get the corrupted message again but I continue. The previous saved game loads, shows the cutscene of "previously on your quest...". I go to my TM CASE, and I still have Rock Tomb.... TM-39.

Regardless, my mission isn't to figure out how to use the backup system (yet). So lets move on.

TLDR; no, well maybe

### Changing TM-39 to TM-27 (failed)

So instead of chasing the workings of the backup system in FR, lets just figure out how to change this TM. The easiest explaination, lets change both 920E and 0529 places in the save file.

So I do that and... and... "The save file has been deleted..."

Obviously, there's something I missing. So with HEX Fiend, I manually revert to TM-39 (4701) to see if the save will load up. and it... works fine. 

So two thoughts:

1. The TM-27 HEX value is incorrect
2. Since TM's are in it's own bag, there might be something else I'm missing
3. Also, I'm not seeing anything about the number of items.
4. lets try adding another tm instead of replacing a tm...

TLDR; This isn't work

### Adding 2nd item (failed)

So lets take the section of HEX values next to TM-39 and see if we can add TM-35 (4301), a different TM.

What happens? "The save file has been deleted..."

So new thoughts, I think I might have to figure out this backup system. Obvously the small changes I'm making on both sections are causing problems. but if I change one side it fixes it self. 

Let do the 920E vs 0529 test again. I might have done that incorrect.

TLDR; I wasted two hours finding items and not changing them


### 920E vs 0529 confusion 

I think it's time we figure out what 920E and 0529 sections really are.

If we actually look at the HEX in the save correctly, the section containing 920E is only 920E when an item exists, else all the HEX values are 930E. Same observation in 0529, the section contins 0549 on empty items. Just worth noting.

So I search for 0529 just to count how many times it appears. It appears exactly how many items unique items exist but a new value appears, 0529A5D5. I look up 920E, same thing but another new value appears 920E512D once. These seem very specific, but looking it up on Bing I get no results. So I boot up my VPN and try Google. Unfortunately nothing. I have more questions then answers at this point.





