Run this docker image and create a masquerade rule for making your linux to a router without sanction 
https://hub.docker.com/r/mrtzfrpr/singwarp

Note: This is for personal use only.

If you’re unsure about what this is or how it works, Leave Here!

If it doesn’t function correctly due to anti-sanction measures, just run it again—it should work!

It should run in --privileged mode because of routing

docker run -d --privileged --name singwarp --network host mrtzfrpr/singwarp:0.2
