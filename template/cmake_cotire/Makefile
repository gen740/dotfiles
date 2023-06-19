release:
	if [ -d ./build_release ]; then echo ; else mkdir build_release; fi
	cd build_release; cmake -DCMAKE_BUILD_TYPE=Release -GNinja .. && ninja

debug:
	if [ -d ./.build ]; then echo ; else mkdir .build; fi
	cd .build; cmake -DCMAKE_BUILD_TYPE=Debug -GNinja .. && ninja
	ln -sf .build/compile_commands.json

run: debug
	# ------------------------------------------------------------
	cd .build && ./main

clean:
	rm -rf .build build_release .cache
	rm -f compile_commands.json
