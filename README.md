# Introduction
This is the repository for my work on the Tavernlight Games technical trial. As requested, the code for each of the questions have been split into their own files/folders/commits for easier parsing. Below I will leave the video reproductions for questions 5 & 7, as well as detail my process/issues working with the forgotten server 1.4/otclient.

# Question 5

[Question 5: ANSWERED!](/media/Question5Answered.mp4)

After discovering the magic effects command while watching [this](https://youtu.be/lHC2j7YPnOw?si=0-jG7-_gtljKKwnT) video, I got to work creating a variant of that command that would place multiple copies of the ice tornado animation around the player rather than on top of them. As noted in my [comments](/tfs-v1.4-windows-msvc-Release-luajit/data/talkactions/scripts/frigo.lua), I initially wanted to use a timer to periodically send magic effects out over a set duration of time, but I couldn't nail down lua's timing code and make it work with the while loop the execution would need to operate within, so i settled on a standard for loop that sent out a ton of tornadoes randomly around the player in rapid succession. This doesn't entirely match the demonstration video in terms of the tornadoes appearing/dissapearing at different times, but gets close enough to pass muster in my estimation. After locking in that functionality, I moved my work into its own script and created a new talk action in [talkactions.xml](/tfs-v1.4-windows-msvc-Release-luajit/data/talkactions/talkactions.xml) so the casting technique would match the demonstration.

# Question 6

This was the only task I could not complete in the time allotted, though I can see where my work would likely have mainly taken place. As many references to shaders and OpenGL are made within the client source code, and the demonstration focused on player movement, I think I would have to be modifying the creature class's draw/internalDrawOutfit implementations. "player" inherits from "creature" and so I'd imagine I could modify the draw calls to create the ghosting effect behind the player when their position is being updated in there. Then some work would be needed for the "walk" functions as well to get the player to zoom from point to point as in the demonstration rather than just doing their normal walking animations.

# Question 7

[Question 7: ANSWERED!](/media/Question7Answered.mp4)

Using the primary resource provided by the otclient devs describing the setup of new [module](https://github.com/edubart/otclient/wiki/Module-Tutorial), I got to work setting up the otmod, otui, and lua files needed to create the new window with the moving button. My biggest hurdle came from not understanding the necesity for two-space indentations in the otmod file in order for the client to recognize and ingest the new module properly, as opposed to four-space tabs that my editors default to. After some time scouring [the forums](https://otland.net/threads/support-loading-modules-with-interface-and-handling-storage-values-with-extended-opcode.255560/post-2478477) however I was able to resolve that issue and was quickly able to resolve lingering bugs with implementation to get to it to how it appears now.

# Miscellaneous

After wrapping up work on the first four questions a large chunk of time was spent setting up the client and server in preparation for questions 5-7, and while most of the work fell within the scope of the [provided](https://github.com/otland/forgottenserver/wiki) [guides](https://github.com/edubart/otclient/wiki/Compiling-on-Windows), there were still a few notable snags that fell outside of their perview. The biggest issue I found was that I was unable to compile the [1.4 source code](https://github.com/otland/forgottenserver/releases/tag/v1.4) as instructed via the guides. Initially I was having the same issues as [this user](https://otland.net/threads/26-08-2023-tfs-nekiro-7-72-fmt-lib-problem.286038/) when I attempted to compile, and then after applying the solution offered I ran into a linker error that I could find no solution for.
![the linker error in question](/media/LinkerError.PNG)
Thankfully none of the work I ended up doing required modification of the server-side source code, but nonetheless I am still frustrated I could not resolve this during the setup process. I did also try using versions 1.4.2 and 1.5, but they had their own issues either with compiling or connencting to the older client. Aside from this there was the issue of finding suitable [.dat and .spr files](https://downloads.ots.me/?dir=data/tibia-clients/dat_and_spr) to enable the client to run, as the guide mentioned their need but had no reference as to where any examples might be retrieved, as well as a pesky connection issue tied to a bad port number with an unhelpful error message. Thankfully I was able to exercise enough google-fu to find someone having [exactly the same problem I was](https://otland.net/threads/stuck-on-please-wait-connecting-to-login-server-error-got-a-network-message-with-invalid-checksum.288536/) in the latter's case, but both were outsized detours from the main tasking I thought were worth mentioning.