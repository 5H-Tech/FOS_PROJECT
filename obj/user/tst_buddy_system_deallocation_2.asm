
obj/user/tst_buddy_system_deallocation_2:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 ce 0c 00 00       	call   800d04 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int GetPowOf2(int size);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 04 01 00 00    	sub    $0x104,%esp
	int freeFrames1 = sys_calculate_free_frames() ;
  800042:	e8 81 22 00 00       	call   8022c8 <sys_calculate_free_frames>
  800047:	89 45 b4             	mov    %eax,-0x4c(%ebp)
	int usedDiskPages1 = sys_pf_calculate_allocated_pages() ;
  80004a:	e8 fc 22 00 00       	call   80234b <sys_pf_calculate_allocated_pages>
  80004f:	89 45 b0             	mov    %eax,-0x50(%ebp)

	char line[100];
	int N = 100;
  800052:	c7 45 ac 64 00 00 00 	movl   $0x64,-0x54(%ebp)
	assert(N * sizeof(int) <= BUDDY_LIMIT);
  800059:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80005c:	c1 e0 02             	shl    $0x2,%eax
  80005f:	3d 00 08 00 00       	cmp    $0x800,%eax
  800064:	76 16                	jbe    80007c <_main+0x44>
  800066:	68 20 2a 80 00       	push   $0x802a20
  80006b:	68 3f 2a 80 00       	push   $0x802a3f
  800070:	6a 0d                	push   $0xd
  800072:	68 54 2a 80 00       	push   $0x802a54
  800077:	e8 cd 0d 00 00       	call   800e49 <_panic>
	int M = 1000;
  80007c:	c7 45 a8 e8 03 00 00 	movl   $0x3e8,-0x58(%ebp)
	assert(M * sizeof(uint8) <= BUDDY_LIMIT);
  800083:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800086:	3d 00 08 00 00       	cmp    $0x800,%eax
  80008b:	76 16                	jbe    8000a3 <_main+0x6b>
  80008d:	68 7c 2a 80 00       	push   $0x802a7c
  800092:	68 3f 2a 80 00       	push   $0x802a3f
  800097:	6a 0f                	push   $0xf
  800099:	68 54 2a 80 00       	push   $0x802a54
  80009e:	e8 a6 0d 00 00       	call   800e49 <_panic>

	uint8 ** arr = malloc(N * sizeof(int)) ;
  8000a3:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8000a6:	c1 e0 02             	shl    $0x2,%eax
  8000a9:	83 ec 0c             	sub    $0xc,%esp
  8000ac:	50                   	push   %eax
  8000ad:	e8 c3 1d 00 00       	call   801e75 <malloc>
  8000b2:	83 c4 10             	add    $0x10,%esp
  8000b5:	89 45 a4             	mov    %eax,-0x5c(%ebp)
	int expectedNumOfAllocatedFrames = GetPowOf2(N * sizeof(int));
  8000b8:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8000bb:	c1 e0 02             	shl    $0x2,%eax
  8000be:	83 ec 0c             	sub    $0xc,%esp
  8000c1:	50                   	push   %eax
  8000c2:	e8 fb 0b 00 00       	call   800cc2 <GetPowOf2>
  8000c7:	83 c4 10             	add    $0x10,%esp
  8000ca:	89 45 f4             	mov    %eax,-0xc(%ebp)

	for (int i = 0; i < N; ++i)
  8000cd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000d4:	eb 6f                	jmp    800145 <_main+0x10d>
	{
		arr[i] = malloc(M) ;
  8000d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000e0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8000e3:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  8000e6:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8000e9:	83 ec 0c             	sub    $0xc,%esp
  8000ec:	50                   	push   %eax
  8000ed:	e8 83 1d 00 00       	call   801e75 <malloc>
  8000f2:	83 c4 10             	add    $0x10,%esp
  8000f5:	89 03                	mov    %eax,(%ebx)
		expectedNumOfAllocatedFrames += GetPowOf2(M);
  8000f7:	83 ec 0c             	sub    $0xc,%esp
  8000fa:	ff 75 a8             	pushl  -0x58(%ebp)
  8000fd:	e8 c0 0b 00 00       	call   800cc2 <GetPowOf2>
  800102:	83 c4 10             	add    $0x10,%esp
  800105:	01 45 f4             	add    %eax,-0xc(%ebp)
		for (int j = 0; j < M; ++j)
  800108:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80010f:	eb 29                	jmp    80013a <_main+0x102>
		{
			arr[i][j] = i % 255;
  800111:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800114:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80011b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80011e:	01 d0                	add    %edx,%eax
  800120:	8b 10                	mov    (%eax),%edx
  800122:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800125:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800128:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80012b:	bb ff 00 00 00       	mov    $0xff,%ebx
  800130:	99                   	cltd   
  800131:	f7 fb                	idiv   %ebx
  800133:	89 d0                	mov    %edx,%eax
  800135:	88 01                	mov    %al,(%ecx)

	for (int i = 0; i < N; ++i)
	{
		arr[i] = malloc(M) ;
		expectedNumOfAllocatedFrames += GetPowOf2(M);
		for (int j = 0; j < M; ++j)
  800137:	ff 45 ec             	incl   -0x14(%ebp)
  80013a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80013d:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  800140:	7c cf                	jl     800111 <_main+0xd9>
	assert(M * sizeof(uint8) <= BUDDY_LIMIT);

	uint8 ** arr = malloc(N * sizeof(int)) ;
	int expectedNumOfAllocatedFrames = GetPowOf2(N * sizeof(int));

	for (int i = 0; i < N; ++i)
  800142:	ff 45 f0             	incl   -0x10(%ebp)
  800145:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800148:	3b 45 ac             	cmp    -0x54(%ebp),%eax
  80014b:	7c 89                	jl     8000d6 <_main+0x9e>
		for (int j = 0; j < M; ++j)
		{
			arr[i][j] = i % 255;
		}
	}
	expectedNumOfAllocatedFrames = ROUNDUP(expectedNumOfAllocatedFrames, PAGE_SIZE) / PAGE_SIZE;
  80014d:	c7 45 a0 00 10 00 00 	movl   $0x1000,-0x60(%ebp)
  800154:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800157:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80015a:	01 d0                	add    %edx,%eax
  80015c:	48                   	dec    %eax
  80015d:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800160:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800163:	ba 00 00 00 00       	mov    $0x0,%edx
  800168:	f7 75 a0             	divl   -0x60(%ebp)
  80016b:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80016e:	29 d0                	sub    %edx,%eax
  800170:	85 c0                	test   %eax,%eax
  800172:	79 05                	jns    800179 <_main+0x141>
  800174:	05 ff 0f 00 00       	add    $0xfff,%eax
  800179:	c1 f8 0c             	sar    $0xc,%eax
  80017c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int freeFrames2 = sys_calculate_free_frames() ;
  80017f:	e8 44 21 00 00       	call   8022c8 <sys_calculate_free_frames>
  800184:	89 45 98             	mov    %eax,-0x68(%ebp)
	int usedDiskPages2 = sys_pf_calculate_allocated_pages() ;
  800187:	e8 bf 21 00 00       	call   80234b <sys_pf_calculate_allocated_pages>
  80018c:	89 45 94             	mov    %eax,-0x6c(%ebp)
	if(freeFrames1 - freeFrames2 != 1 + 1 + expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in MEMORY."); //1 for page table + 1 for disk table
  80018f:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800192:	2b 45 98             	sub    -0x68(%ebp),%eax
  800195:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800198:	83 c2 02             	add    $0x2,%edx
  80019b:	39 d0                	cmp    %edx,%eax
  80019d:	74 14                	je     8001b3 <_main+0x17b>
  80019f:	83 ec 04             	sub    $0x4,%esp
  8001a2:	68 a0 2a 80 00       	push   $0x802aa0
  8001a7:	6a 20                	push   $0x20
  8001a9:	68 54 2a 80 00       	push   $0x802a54
  8001ae:	e8 96 0c 00 00       	call   800e49 <_panic>
	if(usedDiskPages2 - usedDiskPages1 != expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in PAGE FILE.");
  8001b3:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8001b6:	2b 45 b0             	sub    -0x50(%ebp),%eax
  8001b9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8001bc:	74 14                	je     8001d2 <_main+0x19a>
  8001be:	83 ec 04             	sub    $0x4,%esp
  8001c1:	68 d0 2a 80 00       	push   $0x802ad0
  8001c6:	6a 21                	push   $0x21
  8001c8:	68 54 2a 80 00       	push   $0x802a54
  8001cd:	e8 77 0c 00 00       	call   800e49 <_panic>

	for (int i = 0; i < N; ++i)
  8001d2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8001d9:	eb 59                	jmp    800234 <_main+0x1fc>
	{
		for (int j = 0; j < M; ++j)
  8001db:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8001e2:	eb 45                	jmp    800229 <_main+0x1f1>
		{
			assert(arr[i][j] == i % 255);
  8001e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001e7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001ee:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8001f1:	01 d0                	add    %edx,%eax
  8001f3:	8b 10                	mov    (%eax),%edx
  8001f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001f8:	01 d0                	add    %edx,%eax
  8001fa:	8a 00                	mov    (%eax),%al
  8001fc:	0f b6 c8             	movzbl %al,%ecx
  8001ff:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800202:	bb ff 00 00 00       	mov    $0xff,%ebx
  800207:	99                   	cltd   
  800208:	f7 fb                	idiv   %ebx
  80020a:	89 d0                	mov    %edx,%eax
  80020c:	39 c1                	cmp    %eax,%ecx
  80020e:	74 16                	je     800226 <_main+0x1ee>
  800210:	68 00 2b 80 00       	push   $0x802b00
  800215:	68 3f 2a 80 00       	push   $0x802a3f
  80021a:	6a 27                	push   $0x27
  80021c:	68 54 2a 80 00       	push   $0x802a54
  800221:	e8 23 0c 00 00       	call   800e49 <_panic>
	if(freeFrames1 - freeFrames2 != 1 + 1 + expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in MEMORY."); //1 for page table + 1 for disk table
	if(usedDiskPages2 - usedDiskPages1 != expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in PAGE FILE.");

	for (int i = 0; i < N; ++i)
	{
		for (int j = 0; j < M; ++j)
  800226:	ff 45 e4             	incl   -0x1c(%ebp)
  800229:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80022c:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  80022f:	7c b3                	jl     8001e4 <_main+0x1ac>
	int freeFrames2 = sys_calculate_free_frames() ;
	int usedDiskPages2 = sys_pf_calculate_allocated_pages() ;
	if(freeFrames1 - freeFrames2 != 1 + 1 + expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in MEMORY."); //1 for page table + 1 for disk table
	if(usedDiskPages2 - usedDiskPages1 != expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in PAGE FILE.");

	for (int i = 0; i < N; ++i)
  800231:	ff 45 e8             	incl   -0x18(%ebp)
  800234:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800237:	3b 45 ac             	cmp    -0x54(%ebp),%eax
  80023a:	7c 9f                	jl     8001db <_main+0x1a3>
			assert(arr[i][j] == i % 255);
		}
	}

	//[1] Freeing the allocated arrays + checking the BuddyLevels content + free frames after free
	for (int i = 0; i < N; ++i)
  80023c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800243:	eb 20                	jmp    800265 <_main+0x22d>
	{
		free(arr[i]);
  800245:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800248:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80024f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800252:	01 d0                	add    %edx,%eax
  800254:	8b 00                	mov    (%eax),%eax
  800256:	83 ec 0c             	sub    $0xc,%esp
  800259:	50                   	push   %eax
  80025a:	e8 26 1e 00 00       	call   802085 <free>
  80025f:	83 c4 10             	add    $0x10,%esp
			assert(arr[i][j] == i % 255);
		}
	}

	//[1] Freeing the allocated arrays + checking the BuddyLevels content + free frames after free
	for (int i = 0; i < N; ++i)
  800262:	ff 45 e0             	incl   -0x20(%ebp)
  800265:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800268:	3b 45 ac             	cmp    -0x54(%ebp),%eax
  80026b:	7c d8                	jl     800245 <_main+0x20d>
	{
		free(arr[i]);
	}
	free(arr);
  80026d:	83 ec 0c             	sub    $0xc,%esp
  800270:	ff 75 a4             	pushl  -0x5c(%ebp)
  800273:	e8 0d 1e 00 00       	call   802085 <free>
  800278:	83 c4 10             	add    $0x10,%esp
	int i;
	for(i = BUDDY_LOWER_LEVEL; i < BUDDY_UPPER_LEVEL; i++)
  80027b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
  800282:	eb 49                	jmp    8002cd <_main+0x295>
	{
		if(LIST_SIZE(&BuddyLevels[i]) != 0)
  800284:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800287:	c1 e0 04             	shl    $0x4,%eax
  80028a:	05 4c 40 80 00       	add    $0x80404c,%eax
  80028f:	8b 00                	mov    (%eax),%eax
  800291:	85 c0                	test   %eax,%eax
  800293:	74 35                	je     8002ca <_main+0x292>
		{
			cprintf("Level # = %d - # of nodes = %d\n", i, LIST_SIZE(&BuddyLevels[i]));
  800295:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800298:	c1 e0 04             	shl    $0x4,%eax
  80029b:	05 4c 40 80 00       	add    $0x80404c,%eax
  8002a0:	8b 00                	mov    (%eax),%eax
  8002a2:	83 ec 04             	sub    $0x4,%esp
  8002a5:	50                   	push   %eax
  8002a6:	ff 75 dc             	pushl  -0x24(%ebp)
  8002a9:	68 18 2b 80 00       	push   $0x802b18
  8002ae:	e8 38 0e 00 00       	call   8010eb <cprintf>
  8002b3:	83 c4 10             	add    $0x10,%esp
			panic("The BuddyLevels at level <<%d>> is not freed ... !!", i);
  8002b6:	ff 75 dc             	pushl  -0x24(%ebp)
  8002b9:	68 38 2b 80 00       	push   $0x802b38
  8002be:	6a 37                	push   $0x37
  8002c0:	68 54 2a 80 00       	push   $0x802a54
  8002c5:	e8 7f 0b 00 00       	call   800e49 <_panic>
	{
		free(arr[i]);
	}
	free(arr);
	int i;
	for(i = BUDDY_LOWER_LEVEL; i < BUDDY_UPPER_LEVEL; i++)
  8002ca:	ff 45 dc             	incl   -0x24(%ebp)
  8002cd:	83 7d dc 0a          	cmpl   $0xa,-0x24(%ebp)
  8002d1:	7e b1                	jle    800284 <_main+0x24c>
		{
			cprintf("Level # = %d - # of nodes = %d\n", i, LIST_SIZE(&BuddyLevels[i]));
			panic("The BuddyLevels at level <<%d>> is not freed ... !!", i);
		}
	}
	int freeFrames3 = sys_calculate_free_frames() ;
  8002d3:	e8 f0 1f 00 00       	call   8022c8 <sys_calculate_free_frames>
  8002d8:	89 45 90             	mov    %eax,-0x70(%ebp)
	int usedDiskPages3 = sys_pf_calculate_allocated_pages() ;
  8002db:	e8 6b 20 00 00       	call   80234b <sys_pf_calculate_allocated_pages>
  8002e0:	89 45 8c             	mov    %eax,-0x74(%ebp)
	if(freeFrames1 - freeFrames3 != 1) panic("Extra or less frames are freed from the MEMORY.");
  8002e3:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8002e6:	2b 45 90             	sub    -0x70(%ebp),%eax
  8002e9:	83 f8 01             	cmp    $0x1,%eax
  8002ec:	74 14                	je     800302 <_main+0x2ca>
  8002ee:	83 ec 04             	sub    $0x4,%esp
  8002f1:	68 6c 2b 80 00       	push   $0x802b6c
  8002f6:	6a 3c                	push   $0x3c
  8002f8:	68 54 2a 80 00       	push   $0x802a54
  8002fd:	e8 47 0b 00 00       	call   800e49 <_panic>
	if(usedDiskPages3 - usedDiskPages1 != 0) panic("Extra or less frames are freed from PAGE FILE.");
  800302:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800305:	3b 45 b0             	cmp    -0x50(%ebp),%eax
  800308:	74 14                	je     80031e <_main+0x2e6>
  80030a:	83 ec 04             	sub    $0x4,%esp
  80030d:	68 9c 2b 80 00       	push   $0x802b9c
  800312:	6a 3d                	push   $0x3d
  800314:	68 54 2a 80 00       	push   $0x802a54
  800319:	e8 2b 0b 00 00       	call   800e49 <_panic>

	//[2] Creating new arrays after FREEing the created ones + checking no extra frames are taken + checking content + BuddyLevels
	uint8 ** arr2 = malloc(N * sizeof(int)) ;
  80031e:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800321:	c1 e0 02             	shl    $0x2,%eax
  800324:	83 ec 0c             	sub    $0xc,%esp
  800327:	50                   	push   %eax
  800328:	e8 48 1b 00 00       	call   801e75 <malloc>
  80032d:	83 c4 10             	add    $0x10,%esp
  800330:	89 45 88             	mov    %eax,-0x78(%ebp)
	for (int i = 0; i < N; ++i)
  800333:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  80033a:	eb 5f                	jmp    80039b <_main+0x363>
	{
		arr2[i] = malloc(M) ;
  80033c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80033f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800346:	8b 45 88             	mov    -0x78(%ebp),%eax
  800349:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  80034c:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80034f:	83 ec 0c             	sub    $0xc,%esp
  800352:	50                   	push   %eax
  800353:	e8 1d 1b 00 00       	call   801e75 <malloc>
  800358:	83 c4 10             	add    $0x10,%esp
  80035b:	89 03                	mov    %eax,(%ebx)
		for (int j = 0; j < M; ++j)
  80035d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  800364:	eb 2a                	jmp    800390 <_main+0x358>
		{
			arr2[i][j] = (i + 1)%255;
  800366:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800369:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800370:	8b 45 88             	mov    -0x78(%ebp),%eax
  800373:	01 d0                	add    %edx,%eax
  800375:	8b 10                	mov    (%eax),%edx
  800377:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80037a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80037d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800380:	40                   	inc    %eax
  800381:	bb ff 00 00 00       	mov    $0xff,%ebx
  800386:	99                   	cltd   
  800387:	f7 fb                	idiv   %ebx
  800389:	89 d0                	mov    %edx,%eax
  80038b:	88 01                	mov    %al,(%ecx)
	//[2] Creating new arrays after FREEing the created ones + checking no extra frames are taken + checking content + BuddyLevels
	uint8 ** arr2 = malloc(N * sizeof(int)) ;
	for (int i = 0; i < N; ++i)
	{
		arr2[i] = malloc(M) ;
		for (int j = 0; j < M; ++j)
  80038d:	ff 45 d4             	incl   -0x2c(%ebp)
  800390:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800393:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  800396:	7c ce                	jl     800366 <_main+0x32e>
	if(freeFrames1 - freeFrames3 != 1) panic("Extra or less frames are freed from the MEMORY.");
	if(usedDiskPages3 - usedDiskPages1 != 0) panic("Extra or less frames are freed from PAGE FILE.");

	//[2] Creating new arrays after FREEing the created ones + checking no extra frames are taken + checking content + BuddyLevels
	uint8 ** arr2 = malloc(N * sizeof(int)) ;
	for (int i = 0; i < N; ++i)
  800398:	ff 45 d8             	incl   -0x28(%ebp)
  80039b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80039e:	3b 45 ac             	cmp    -0x54(%ebp),%eax
  8003a1:	7c 99                	jl     80033c <_main+0x304>
		for (int j = 0; j < M; ++j)
		{
			arr2[i][j] = (i + 1)%255;
		}
	}
	int freeFrames4 = sys_calculate_free_frames() ;
  8003a3:	e8 20 1f 00 00       	call   8022c8 <sys_calculate_free_frames>
  8003a8:	89 45 84             	mov    %eax,-0x7c(%ebp)
	int usedDiskPages4 = sys_pf_calculate_allocated_pages() ;
  8003ab:	e8 9b 1f 00 00       	call   80234b <sys_pf_calculate_allocated_pages>
  8003b0:	89 45 80             	mov    %eax,-0x80(%ebp)

	//Check that no extra frames are taken
	if(freeFrames4 - freeFrames2 != 0) panic("Creating new arrays after FREE is failed.");
  8003b3:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8003b6:	3b 45 98             	cmp    -0x68(%ebp),%eax
  8003b9:	74 14                	je     8003cf <_main+0x397>
  8003bb:	83 ec 04             	sub    $0x4,%esp
  8003be:	68 cc 2b 80 00       	push   $0x802bcc
  8003c3:	6a 4d                	push   $0x4d
  8003c5:	68 54 2a 80 00       	push   $0x802a54
  8003ca:	e8 7a 0a 00 00       	call   800e49 <_panic>
	if(usedDiskPages4 - usedDiskPages2 != 0) panic("Creating new arrays after FREE is failed.");
  8003cf:	8b 45 80             	mov    -0x80(%ebp),%eax
  8003d2:	3b 45 94             	cmp    -0x6c(%ebp),%eax
  8003d5:	74 14                	je     8003eb <_main+0x3b3>
  8003d7:	83 ec 04             	sub    $0x4,%esp
  8003da:	68 cc 2b 80 00       	push   $0x802bcc
  8003df:	6a 4e                	push   $0x4e
  8003e1:	68 54 2a 80 00       	push   $0x802a54
  8003e6:	e8 5e 0a 00 00       	call   800e49 <_panic>

	//Check the array content
	for (int i = 0; i < N; ++i)
  8003eb:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  8003f2:	eb 58                	jmp    80044c <_main+0x414>
	{
		for (int j = 0; j < M; ++j)
  8003f4:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  8003fb:	eb 44                	jmp    800441 <_main+0x409>
		{
			if(arr2[i][j] != (i + 1)%255) panic("Wrong content in the created arrays.");
  8003fd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800400:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800407:	8b 45 88             	mov    -0x78(%ebp),%eax
  80040a:	01 d0                	add    %edx,%eax
  80040c:	8b 10                	mov    (%eax),%edx
  80040e:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800411:	01 d0                	add    %edx,%eax
  800413:	8a 00                	mov    (%eax),%al
  800415:	0f b6 c8             	movzbl %al,%ecx
  800418:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80041b:	40                   	inc    %eax
  80041c:	bb ff 00 00 00       	mov    $0xff,%ebx
  800421:	99                   	cltd   
  800422:	f7 fb                	idiv   %ebx
  800424:	89 d0                	mov    %edx,%eax
  800426:	39 c1                	cmp    %eax,%ecx
  800428:	74 14                	je     80043e <_main+0x406>
  80042a:	83 ec 04             	sub    $0x4,%esp
  80042d:	68 f8 2b 80 00       	push   $0x802bf8
  800432:	6a 55                	push   $0x55
  800434:	68 54 2a 80 00       	push   $0x802a54
  800439:	e8 0b 0a 00 00       	call   800e49 <_panic>
	if(usedDiskPages4 - usedDiskPages2 != 0) panic("Creating new arrays after FREE is failed.");

	//Check the array content
	for (int i = 0; i < N; ++i)
	{
		for (int j = 0; j < M; ++j)
  80043e:	ff 45 cc             	incl   -0x34(%ebp)
  800441:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800444:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  800447:	7c b4                	jl     8003fd <_main+0x3c5>
	//Check that no extra frames are taken
	if(freeFrames4 - freeFrames2 != 0) panic("Creating new arrays after FREE is failed.");
	if(usedDiskPages4 - usedDiskPages2 != 0) panic("Creating new arrays after FREE is failed.");

	//Check the array content
	for (int i = 0; i < N; ++i)
  800449:	ff 45 d0             	incl   -0x30(%ebp)
  80044c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80044f:	3b 45 ac             	cmp    -0x54(%ebp),%eax
  800452:	7c a0                	jl     8003f4 <_main+0x3bc>
		}
	}

	//Check the lists content of the BuddyLevels array
	{
	int L = BUDDY_LOWER_LEVEL;
  800454:	c7 85 7c ff ff ff 01 	movl   $0x1,-0x84(%ebp)
  80045b:	00 00 00 
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  80045e:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800464:	c1 e0 04             	shl    $0x4,%eax
  800467:	05 4c 40 80 00       	add    $0x80404c,%eax
  80046c:	8b 00                	mov    (%eax),%eax
  80046e:	85 c0                	test   %eax,%eax
  800470:	74 2b                	je     80049d <_main+0x465>
  800472:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800478:	c1 e0 04             	shl    $0x4,%eax
  80047b:	05 4c 40 80 00       	add    $0x80404c,%eax
  800480:	8b 00                	mov    (%eax),%eax
  800482:	83 ec 0c             	sub    $0xc,%esp
  800485:	50                   	push   %eax
  800486:	ff b5 7c ff ff ff    	pushl  -0x84(%ebp)
  80048c:	68 20 2c 80 00       	push   $0x802c20
  800491:	6a 5c                	push   $0x5c
  800493:	68 54 2a 80 00       	push   $0x802a54
  800498:	e8 ac 09 00 00       	call   800e49 <_panic>
  80049d:	ff 85 7c ff ff ff    	incl   -0x84(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8004a3:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8004a9:	c1 e0 04             	shl    $0x4,%eax
  8004ac:	05 4c 40 80 00       	add    $0x80404c,%eax
  8004b1:	8b 00                	mov    (%eax),%eax
  8004b3:	85 c0                	test   %eax,%eax
  8004b5:	74 2b                	je     8004e2 <_main+0x4aa>
  8004b7:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8004bd:	c1 e0 04             	shl    $0x4,%eax
  8004c0:	05 4c 40 80 00       	add    $0x80404c,%eax
  8004c5:	8b 00                	mov    (%eax),%eax
  8004c7:	83 ec 0c             	sub    $0xc,%esp
  8004ca:	50                   	push   %eax
  8004cb:	ff b5 7c ff ff ff    	pushl  -0x84(%ebp)
  8004d1:	68 20 2c 80 00       	push   $0x802c20
  8004d6:	6a 5d                	push   $0x5d
  8004d8:	68 54 2a 80 00       	push   $0x802a54
  8004dd:	e8 67 09 00 00       	call   800e49 <_panic>
  8004e2:	ff 85 7c ff ff ff    	incl   -0x84(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8004e8:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8004ee:	c1 e0 04             	shl    $0x4,%eax
  8004f1:	05 4c 40 80 00       	add    $0x80404c,%eax
  8004f6:	8b 00                	mov    (%eax),%eax
  8004f8:	85 c0                	test   %eax,%eax
  8004fa:	74 2b                	je     800527 <_main+0x4ef>
  8004fc:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800502:	c1 e0 04             	shl    $0x4,%eax
  800505:	05 4c 40 80 00       	add    $0x80404c,%eax
  80050a:	8b 00                	mov    (%eax),%eax
  80050c:	83 ec 0c             	sub    $0xc,%esp
  80050f:	50                   	push   %eax
  800510:	ff b5 7c ff ff ff    	pushl  -0x84(%ebp)
  800516:	68 20 2c 80 00       	push   $0x802c20
  80051b:	6a 5e                	push   $0x5e
  80051d:	68 54 2a 80 00       	push   $0x802a54
  800522:	e8 22 09 00 00       	call   800e49 <_panic>
  800527:	ff 85 7c ff ff ff    	incl   -0x84(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  80052d:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800533:	c1 e0 04             	shl    $0x4,%eax
  800536:	05 4c 40 80 00       	add    $0x80404c,%eax
  80053b:	8b 00                	mov    (%eax),%eax
  80053d:	85 c0                	test   %eax,%eax
  80053f:	74 2b                	je     80056c <_main+0x534>
  800541:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800547:	c1 e0 04             	shl    $0x4,%eax
  80054a:	05 4c 40 80 00       	add    $0x80404c,%eax
  80054f:	8b 00                	mov    (%eax),%eax
  800551:	83 ec 0c             	sub    $0xc,%esp
  800554:	50                   	push   %eax
  800555:	ff b5 7c ff ff ff    	pushl  -0x84(%ebp)
  80055b:	68 20 2c 80 00       	push   $0x802c20
  800560:	6a 5f                	push   $0x5f
  800562:	68 54 2a 80 00       	push   $0x802a54
  800567:	e8 dd 08 00 00       	call   800e49 <_panic>
  80056c:	ff 85 7c ff ff ff    	incl   -0x84(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800572:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800578:	c1 e0 04             	shl    $0x4,%eax
  80057b:	05 4c 40 80 00       	add    $0x80404c,%eax
  800580:	8b 00                	mov    (%eax),%eax
  800582:	85 c0                	test   %eax,%eax
  800584:	74 2b                	je     8005b1 <_main+0x579>
  800586:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  80058c:	c1 e0 04             	shl    $0x4,%eax
  80058f:	05 4c 40 80 00       	add    $0x80404c,%eax
  800594:	8b 00                	mov    (%eax),%eax
  800596:	83 ec 0c             	sub    $0xc,%esp
  800599:	50                   	push   %eax
  80059a:	ff b5 7c ff ff ff    	pushl  -0x84(%ebp)
  8005a0:	68 20 2c 80 00       	push   $0x802c20
  8005a5:	6a 60                	push   $0x60
  8005a7:	68 54 2a 80 00       	push   $0x802a54
  8005ac:	e8 98 08 00 00       	call   800e49 <_panic>
  8005b1:	ff 85 7c ff ff ff    	incl   -0x84(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8005b7:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8005bd:	c1 e0 04             	shl    $0x4,%eax
  8005c0:	05 4c 40 80 00       	add    $0x80404c,%eax
  8005c5:	8b 00                	mov    (%eax),%eax
  8005c7:	85 c0                	test   %eax,%eax
  8005c9:	74 2b                	je     8005f6 <_main+0x5be>
  8005cb:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8005d1:	c1 e0 04             	shl    $0x4,%eax
  8005d4:	05 4c 40 80 00       	add    $0x80404c,%eax
  8005d9:	8b 00                	mov    (%eax),%eax
  8005db:	83 ec 0c             	sub    $0xc,%esp
  8005de:	50                   	push   %eax
  8005df:	ff b5 7c ff ff ff    	pushl  -0x84(%ebp)
  8005e5:	68 20 2c 80 00       	push   $0x802c20
  8005ea:	6a 61                	push   $0x61
  8005ec:	68 54 2a 80 00       	push   $0x802a54
  8005f1:	e8 53 08 00 00       	call   800e49 <_panic>
  8005f6:	ff 85 7c ff ff ff    	incl   -0x84(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8005fc:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800602:	c1 e0 04             	shl    $0x4,%eax
  800605:	05 4c 40 80 00       	add    $0x80404c,%eax
  80060a:	8b 00                	mov    (%eax),%eax
  80060c:	85 c0                	test   %eax,%eax
  80060e:	74 2b                	je     80063b <_main+0x603>
  800610:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800616:	c1 e0 04             	shl    $0x4,%eax
  800619:	05 4c 40 80 00       	add    $0x80404c,%eax
  80061e:	8b 00                	mov    (%eax),%eax
  800620:	83 ec 0c             	sub    $0xc,%esp
  800623:	50                   	push   %eax
  800624:	ff b5 7c ff ff ff    	pushl  -0x84(%ebp)
  80062a:	68 20 2c 80 00       	push   $0x802c20
  80062f:	6a 62                	push   $0x62
  800631:	68 54 2a 80 00       	push   $0x802a54
  800636:	e8 0e 08 00 00       	call   800e49 <_panic>
  80063b:	ff 85 7c ff ff ff    	incl   -0x84(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800641:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800647:	c1 e0 04             	shl    $0x4,%eax
  80064a:	05 4c 40 80 00       	add    $0x80404c,%eax
  80064f:	8b 00                	mov    (%eax),%eax
  800651:	85 c0                	test   %eax,%eax
  800653:	74 2b                	je     800680 <_main+0x648>
  800655:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  80065b:	c1 e0 04             	shl    $0x4,%eax
  80065e:	05 4c 40 80 00       	add    $0x80404c,%eax
  800663:	8b 00                	mov    (%eax),%eax
  800665:	83 ec 0c             	sub    $0xc,%esp
  800668:	50                   	push   %eax
  800669:	ff b5 7c ff ff ff    	pushl  -0x84(%ebp)
  80066f:	68 20 2c 80 00       	push   $0x802c20
  800674:	6a 63                	push   $0x63
  800676:	68 54 2a 80 00       	push   $0x802a54
  80067b:	e8 c9 07 00 00       	call   800e49 <_panic>
  800680:	ff 85 7c ff ff ff    	incl   -0x84(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800686:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  80068c:	c1 e0 04             	shl    $0x4,%eax
  80068f:	05 4c 40 80 00       	add    $0x80404c,%eax
  800694:	8b 00                	mov    (%eax),%eax
  800696:	83 f8 01             	cmp    $0x1,%eax
  800699:	74 2b                	je     8006c6 <_main+0x68e>
  80069b:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8006a1:	c1 e0 04             	shl    $0x4,%eax
  8006a4:	05 4c 40 80 00       	add    $0x80404c,%eax
  8006a9:	8b 00                	mov    (%eax),%eax
  8006ab:	83 ec 0c             	sub    $0xc,%esp
  8006ae:	50                   	push   %eax
  8006af:	ff b5 7c ff ff ff    	pushl  -0x84(%ebp)
  8006b5:	68 20 2c 80 00       	push   $0x802c20
  8006ba:	6a 64                	push   $0x64
  8006bc:	68 54 2a 80 00       	push   $0x802a54
  8006c1:	e8 83 07 00 00       	call   800e49 <_panic>
  8006c6:	ff 85 7c ff ff ff    	incl   -0x84(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8006cc:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8006d2:	c1 e0 04             	shl    $0x4,%eax
  8006d5:	05 4c 40 80 00       	add    $0x80404c,%eax
  8006da:	8b 00                	mov    (%eax),%eax
  8006dc:	83 f8 01             	cmp    $0x1,%eax
  8006df:	74 2b                	je     80070c <_main+0x6d4>
  8006e1:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8006e7:	c1 e0 04             	shl    $0x4,%eax
  8006ea:	05 4c 40 80 00       	add    $0x80404c,%eax
  8006ef:	8b 00                	mov    (%eax),%eax
  8006f1:	83 ec 0c             	sub    $0xc,%esp
  8006f4:	50                   	push   %eax
  8006f5:	ff b5 7c ff ff ff    	pushl  -0x84(%ebp)
  8006fb:	68 20 2c 80 00       	push   $0x802c20
  800700:	6a 65                	push   $0x65
  800702:	68 54 2a 80 00       	push   $0x802a54
  800707:	e8 3d 07 00 00       	call   800e49 <_panic>
  80070c:	ff 85 7c ff ff ff    	incl   -0x84(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800712:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800718:	c1 e0 04             	shl    $0x4,%eax
  80071b:	05 4c 40 80 00       	add    $0x80404c,%eax
  800720:	8b 00                	mov    (%eax),%eax
  800722:	83 f8 01             	cmp    $0x1,%eax
  800725:	74 2b                	je     800752 <_main+0x71a>
  800727:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  80072d:	c1 e0 04             	shl    $0x4,%eax
  800730:	05 4c 40 80 00       	add    $0x80404c,%eax
  800735:	8b 00                	mov    (%eax),%eax
  800737:	83 ec 0c             	sub    $0xc,%esp
  80073a:	50                   	push   %eax
  80073b:	ff b5 7c ff ff ff    	pushl  -0x84(%ebp)
  800741:	68 20 2c 80 00       	push   $0x802c20
  800746:	6a 66                	push   $0x66
  800748:	68 54 2a 80 00       	push   $0x802a54
  80074d:	e8 f7 06 00 00       	call   800e49 <_panic>
  800752:	ff 85 7c ff ff ff    	incl   -0x84(%ebp)
	}

	//[3] Freeing the allocated arrays + checking the frames
	for (int i = 0; i < N; ++i)
  800758:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  80075f:	eb 20                	jmp    800781 <_main+0x749>
	{
		free(arr2[i]);
  800761:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800764:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80076b:	8b 45 88             	mov    -0x78(%ebp),%eax
  80076e:	01 d0                	add    %edx,%eax
  800770:	8b 00                	mov    (%eax),%eax
  800772:	83 ec 0c             	sub    $0xc,%esp
  800775:	50                   	push   %eax
  800776:	e8 0a 19 00 00       	call   802085 <free>
  80077b:	83 c4 10             	add    $0x10,%esp
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
	}

	//[3] Freeing the allocated arrays + checking the frames
	for (int i = 0; i < N; ++i)
  80077e:	ff 45 c8             	incl   -0x38(%ebp)
  800781:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800784:	3b 45 ac             	cmp    -0x54(%ebp),%eax
  800787:	7c d8                	jl     800761 <_main+0x729>
	{
		free(arr2[i]);
	}
	free(arr2);
  800789:	83 ec 0c             	sub    $0xc,%esp
  80078c:	ff 75 88             	pushl  -0x78(%ebp)
  80078f:	e8 f1 18 00 00       	call   802085 <free>
  800794:	83 c4 10             	add    $0x10,%esp

	int freeFrames5 = sys_calculate_free_frames() ;
  800797:	e8 2c 1b 00 00       	call   8022c8 <sys_calculate_free_frames>
  80079c:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
	int usedDiskPages5 = sys_pf_calculate_allocated_pages() ;
  8007a2:	e8 a4 1b 00 00       	call   80234b <sys_pf_calculate_allocated_pages>
  8007a7:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
	if(freeFrames5 - freeFrames3 != 0) panic("Extra or less frames are freed from the MEMORY.");
  8007ad:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8007b3:	3b 45 90             	cmp    -0x70(%ebp),%eax
  8007b6:	74 14                	je     8007cc <_main+0x794>
  8007b8:	83 ec 04             	sub    $0x4,%esp
  8007bb:	68 6c 2b 80 00       	push   $0x802b6c
  8007c0:	6a 72                	push   $0x72
  8007c2:	68 54 2a 80 00       	push   $0x802a54
  8007c7:	e8 7d 06 00 00       	call   800e49 <_panic>
	if(usedDiskPages5 - usedDiskPages3 != 0) panic("Extra or less frames are freed from the DISK.");
  8007cc:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8007d2:	3b 45 8c             	cmp    -0x74(%ebp),%eax
  8007d5:	74 14                	je     8007eb <_main+0x7b3>
  8007d7:	83 ec 04             	sub    $0x4,%esp
  8007da:	68 58 2c 80 00       	push   $0x802c58
  8007df:	6a 73                	push   $0x73
  8007e1:	68 54 2a 80 00       	push   $0x802a54
  8007e6:	e8 5e 06 00 00       	call   800e49 <_panic>

	//[5] Creating new arrays with DIFFERENT sizes than the old ones + checking BuddyLevels + checking free frames + checking content
	N = 70;
  8007eb:	c7 45 ac 46 00 00 00 	movl   $0x46,-0x54(%ebp)
	M = 1;
  8007f2:	c7 45 a8 01 00 00 00 	movl   $0x1,-0x58(%ebp)
	uint8 ** arr3 = malloc(N * sizeof(int)) ;
  8007f9:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8007fc:	c1 e0 02             	shl    $0x2,%eax
  8007ff:	83 ec 0c             	sub    $0xc,%esp
  800802:	50                   	push   %eax
  800803:	e8 6d 16 00 00       	call   801e75 <malloc>
  800808:	83 c4 10             	add    $0x10,%esp
  80080b:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
	expectedNumOfAllocatedFrames = GetPowOf2(N * sizeof(int));
  800811:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800814:	c1 e0 02             	shl    $0x2,%eax
  800817:	83 ec 0c             	sub    $0xc,%esp
  80081a:	50                   	push   %eax
  80081b:	e8 a2 04 00 00       	call   800cc2 <GetPowOf2>
  800820:	83 c4 10             	add    $0x10,%esp
  800823:	89 45 f4             	mov    %eax,-0xc(%ebp)
	for (int i = 0; i < N; ++i)
  800826:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
  80082d:	eb 7b                	jmp    8008aa <_main+0x872>
	{
		arr3[i] = malloc(M+1) ;
  80082f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800832:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800839:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80083f:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  800842:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800845:	40                   	inc    %eax
  800846:	83 ec 0c             	sub    $0xc,%esp
  800849:	50                   	push   %eax
  80084a:	e8 26 16 00 00       	call   801e75 <malloc>
  80084f:	83 c4 10             	add    $0x10,%esp
  800852:	89 03                	mov    %eax,(%ebx)
		expectedNumOfAllocatedFrames += GetPowOf2(M+1);
  800854:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800857:	40                   	inc    %eax
  800858:	83 ec 0c             	sub    $0xc,%esp
  80085b:	50                   	push   %eax
  80085c:	e8 61 04 00 00       	call   800cc2 <GetPowOf2>
  800861:	83 c4 10             	add    $0x10,%esp
  800864:	01 45 f4             	add    %eax,-0xc(%ebp)
		for (int j = 0; j < M; ++j)
  800867:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
  80086e:	eb 2f                	jmp    80089f <_main+0x867>
		{
			arr3[i][j] = (i + 2)%255;
  800870:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800873:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80087a:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800880:	01 d0                	add    %edx,%eax
  800882:	8b 10                	mov    (%eax),%edx
  800884:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800887:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80088a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80088d:	83 c0 02             	add    $0x2,%eax
  800890:	bb ff 00 00 00       	mov    $0xff,%ebx
  800895:	99                   	cltd   
  800896:	f7 fb                	idiv   %ebx
  800898:	89 d0                	mov    %edx,%eax
  80089a:	88 01                	mov    %al,(%ecx)
	expectedNumOfAllocatedFrames = GetPowOf2(N * sizeof(int));
	for (int i = 0; i < N; ++i)
	{
		arr3[i] = malloc(M+1) ;
		expectedNumOfAllocatedFrames += GetPowOf2(M+1);
		for (int j = 0; j < M; ++j)
  80089c:	ff 45 c0             	incl   -0x40(%ebp)
  80089f:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8008a2:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  8008a5:	7c c9                	jl     800870 <_main+0x838>
	//[5] Creating new arrays with DIFFERENT sizes than the old ones + checking BuddyLevels + checking free frames + checking content
	N = 70;
	M = 1;
	uint8 ** arr3 = malloc(N * sizeof(int)) ;
	expectedNumOfAllocatedFrames = GetPowOf2(N * sizeof(int));
	for (int i = 0; i < N; ++i)
  8008a7:	ff 45 c4             	incl   -0x3c(%ebp)
  8008aa:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8008ad:	3b 45 ac             	cmp    -0x54(%ebp),%eax
  8008b0:	0f 8c 79 ff ff ff    	jl     80082f <_main+0x7f7>
			arr3[i][j] = (i + 2)%255;
		}
	}
	//Check the lists content of the BuddyLevels array
	{
	int L = BUDDY_LOWER_LEVEL;
  8008b6:	c7 85 6c ff ff ff 01 	movl   $0x1,-0x94(%ebp)
  8008bd:	00 00 00 
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8008c0:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8008c6:	c1 e0 04             	shl    $0x4,%eax
  8008c9:	05 4c 40 80 00       	add    $0x80404c,%eax
  8008ce:	8b 00                	mov    (%eax),%eax
  8008d0:	85 c0                	test   %eax,%eax
  8008d2:	74 2e                	je     800902 <_main+0x8ca>
  8008d4:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8008da:	c1 e0 04             	shl    $0x4,%eax
  8008dd:	05 4c 40 80 00       	add    $0x80404c,%eax
  8008e2:	8b 00                	mov    (%eax),%eax
  8008e4:	83 ec 0c             	sub    $0xc,%esp
  8008e7:	50                   	push   %eax
  8008e8:	ff b5 6c ff ff ff    	pushl  -0x94(%ebp)
  8008ee:	68 20 2c 80 00       	push   $0x802c20
  8008f3:	68 86 00 00 00       	push   $0x86
  8008f8:	68 54 2a 80 00       	push   $0x802a54
  8008fd:	e8 47 05 00 00       	call   800e49 <_panic>
  800902:	ff 85 6c ff ff ff    	incl   -0x94(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800908:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80090e:	c1 e0 04             	shl    $0x4,%eax
  800911:	05 4c 40 80 00       	add    $0x80404c,%eax
  800916:	8b 00                	mov    (%eax),%eax
  800918:	83 f8 01             	cmp    $0x1,%eax
  80091b:	74 2e                	je     80094b <_main+0x913>
  80091d:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800923:	c1 e0 04             	shl    $0x4,%eax
  800926:	05 4c 40 80 00       	add    $0x80404c,%eax
  80092b:	8b 00                	mov    (%eax),%eax
  80092d:	83 ec 0c             	sub    $0xc,%esp
  800930:	50                   	push   %eax
  800931:	ff b5 6c ff ff ff    	pushl  -0x94(%ebp)
  800937:	68 20 2c 80 00       	push   $0x802c20
  80093c:	68 87 00 00 00       	push   $0x87
  800941:	68 54 2a 80 00       	push   $0x802a54
  800946:	e8 fe 04 00 00       	call   800e49 <_panic>
  80094b:	ff 85 6c ff ff ff    	incl   -0x94(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800951:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800957:	c1 e0 04             	shl    $0x4,%eax
  80095a:	05 4c 40 80 00       	add    $0x80404c,%eax
  80095f:	8b 00                	mov    (%eax),%eax
  800961:	85 c0                	test   %eax,%eax
  800963:	74 2e                	je     800993 <_main+0x95b>
  800965:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80096b:	c1 e0 04             	shl    $0x4,%eax
  80096e:	05 4c 40 80 00       	add    $0x80404c,%eax
  800973:	8b 00                	mov    (%eax),%eax
  800975:	83 ec 0c             	sub    $0xc,%esp
  800978:	50                   	push   %eax
  800979:	ff b5 6c ff ff ff    	pushl  -0x94(%ebp)
  80097f:	68 20 2c 80 00       	push   $0x802c20
  800984:	68 88 00 00 00       	push   $0x88
  800989:	68 54 2a 80 00       	push   $0x802a54
  80098e:	e8 b6 04 00 00       	call   800e49 <_panic>
  800993:	ff 85 6c ff ff ff    	incl   -0x94(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800999:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80099f:	c1 e0 04             	shl    $0x4,%eax
  8009a2:	05 4c 40 80 00       	add    $0x80404c,%eax
  8009a7:	8b 00                	mov    (%eax),%eax
  8009a9:	83 f8 01             	cmp    $0x1,%eax
  8009ac:	74 2e                	je     8009dc <_main+0x9a4>
  8009ae:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8009b4:	c1 e0 04             	shl    $0x4,%eax
  8009b7:	05 4c 40 80 00       	add    $0x80404c,%eax
  8009bc:	8b 00                	mov    (%eax),%eax
  8009be:	83 ec 0c             	sub    $0xc,%esp
  8009c1:	50                   	push   %eax
  8009c2:	ff b5 6c ff ff ff    	pushl  -0x94(%ebp)
  8009c8:	68 20 2c 80 00       	push   $0x802c20
  8009cd:	68 89 00 00 00       	push   $0x89
  8009d2:	68 54 2a 80 00       	push   $0x802a54
  8009d7:	e8 6d 04 00 00       	call   800e49 <_panic>
  8009dc:	ff 85 6c ff ff ff    	incl   -0x94(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8009e2:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8009e8:	c1 e0 04             	shl    $0x4,%eax
  8009eb:	05 4c 40 80 00       	add    $0x80404c,%eax
  8009f0:	8b 00                	mov    (%eax),%eax
  8009f2:	83 f8 01             	cmp    $0x1,%eax
  8009f5:	74 2e                	je     800a25 <_main+0x9ed>
  8009f7:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8009fd:	c1 e0 04             	shl    $0x4,%eax
  800a00:	05 4c 40 80 00       	add    $0x80404c,%eax
  800a05:	8b 00                	mov    (%eax),%eax
  800a07:	83 ec 0c             	sub    $0xc,%esp
  800a0a:	50                   	push   %eax
  800a0b:	ff b5 6c ff ff ff    	pushl  -0x94(%ebp)
  800a11:	68 20 2c 80 00       	push   $0x802c20
  800a16:	68 8a 00 00 00       	push   $0x8a
  800a1b:	68 54 2a 80 00       	push   $0x802a54
  800a20:	e8 24 04 00 00       	call   800e49 <_panic>
  800a25:	ff 85 6c ff ff ff    	incl   -0x94(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800a2b:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800a31:	c1 e0 04             	shl    $0x4,%eax
  800a34:	05 4c 40 80 00       	add    $0x80404c,%eax
  800a39:	8b 00                	mov    (%eax),%eax
  800a3b:	83 f8 01             	cmp    $0x1,%eax
  800a3e:	74 2e                	je     800a6e <_main+0xa36>
  800a40:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800a46:	c1 e0 04             	shl    $0x4,%eax
  800a49:	05 4c 40 80 00       	add    $0x80404c,%eax
  800a4e:	8b 00                	mov    (%eax),%eax
  800a50:	83 ec 0c             	sub    $0xc,%esp
  800a53:	50                   	push   %eax
  800a54:	ff b5 6c ff ff ff    	pushl  -0x94(%ebp)
  800a5a:	68 20 2c 80 00       	push   $0x802c20
  800a5f:	68 8b 00 00 00       	push   $0x8b
  800a64:	68 54 2a 80 00       	push   $0x802a54
  800a69:	e8 db 03 00 00       	call   800e49 <_panic>
  800a6e:	ff 85 6c ff ff ff    	incl   -0x94(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800a74:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800a7a:	c1 e0 04             	shl    $0x4,%eax
  800a7d:	05 4c 40 80 00       	add    $0x80404c,%eax
  800a82:	8b 00                	mov    (%eax),%eax
  800a84:	85 c0                	test   %eax,%eax
  800a86:	74 2e                	je     800ab6 <_main+0xa7e>
  800a88:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800a8e:	c1 e0 04             	shl    $0x4,%eax
  800a91:	05 4c 40 80 00       	add    $0x80404c,%eax
  800a96:	8b 00                	mov    (%eax),%eax
  800a98:	83 ec 0c             	sub    $0xc,%esp
  800a9b:	50                   	push   %eax
  800a9c:	ff b5 6c ff ff ff    	pushl  -0x94(%ebp)
  800aa2:	68 20 2c 80 00       	push   $0x802c20
  800aa7:	68 8c 00 00 00       	push   $0x8c
  800aac:	68 54 2a 80 00       	push   $0x802a54
  800ab1:	e8 93 03 00 00       	call   800e49 <_panic>
  800ab6:	ff 85 6c ff ff ff    	incl   -0x94(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800abc:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800ac2:	c1 e0 04             	shl    $0x4,%eax
  800ac5:	05 4c 40 80 00       	add    $0x80404c,%eax
  800aca:	8b 00                	mov    (%eax),%eax
  800acc:	83 f8 01             	cmp    $0x1,%eax
  800acf:	74 2e                	je     800aff <_main+0xac7>
  800ad1:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800ad7:	c1 e0 04             	shl    $0x4,%eax
  800ada:	05 4c 40 80 00       	add    $0x80404c,%eax
  800adf:	8b 00                	mov    (%eax),%eax
  800ae1:	83 ec 0c             	sub    $0xc,%esp
  800ae4:	50                   	push   %eax
  800ae5:	ff b5 6c ff ff ff    	pushl  -0x94(%ebp)
  800aeb:	68 20 2c 80 00       	push   $0x802c20
  800af0:	68 8d 00 00 00       	push   $0x8d
  800af5:	68 54 2a 80 00       	push   $0x802a54
  800afa:	e8 4a 03 00 00       	call   800e49 <_panic>
  800aff:	ff 85 6c ff ff ff    	incl   -0x94(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800b05:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800b0b:	c1 e0 04             	shl    $0x4,%eax
  800b0e:	05 4c 40 80 00       	add    $0x80404c,%eax
  800b13:	8b 00                	mov    (%eax),%eax
  800b15:	85 c0                	test   %eax,%eax
  800b17:	74 2e                	je     800b47 <_main+0xb0f>
  800b19:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800b1f:	c1 e0 04             	shl    $0x4,%eax
  800b22:	05 4c 40 80 00       	add    $0x80404c,%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	83 ec 0c             	sub    $0xc,%esp
  800b2c:	50                   	push   %eax
  800b2d:	ff b5 6c ff ff ff    	pushl  -0x94(%ebp)
  800b33:	68 20 2c 80 00       	push   $0x802c20
  800b38:	68 8e 00 00 00       	push   $0x8e
  800b3d:	68 54 2a 80 00       	push   $0x802a54
  800b42:	e8 02 03 00 00       	call   800e49 <_panic>
  800b47:	ff 85 6c ff ff ff    	incl   -0x94(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800b4d:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800b53:	c1 e0 04             	shl    $0x4,%eax
  800b56:	05 4c 40 80 00       	add    $0x80404c,%eax
  800b5b:	8b 00                	mov    (%eax),%eax
  800b5d:	83 f8 01             	cmp    $0x1,%eax
  800b60:	74 2e                	je     800b90 <_main+0xb58>
  800b62:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800b68:	c1 e0 04             	shl    $0x4,%eax
  800b6b:	05 4c 40 80 00       	add    $0x80404c,%eax
  800b70:	8b 00                	mov    (%eax),%eax
  800b72:	83 ec 0c             	sub    $0xc,%esp
  800b75:	50                   	push   %eax
  800b76:	ff b5 6c ff ff ff    	pushl  -0x94(%ebp)
  800b7c:	68 20 2c 80 00       	push   $0x802c20
  800b81:	68 8f 00 00 00       	push   $0x8f
  800b86:	68 54 2a 80 00       	push   $0x802a54
  800b8b:	e8 b9 02 00 00       	call   800e49 <_panic>
  800b90:	ff 85 6c ff ff ff    	incl   -0x94(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d.\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800b96:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800b9c:	c1 e0 04             	shl    $0x4,%eax
  800b9f:	05 4c 40 80 00       	add    $0x80404c,%eax
  800ba4:	8b 00                	mov    (%eax),%eax
  800ba6:	83 f8 01             	cmp    $0x1,%eax
  800ba9:	74 2e                	je     800bd9 <_main+0xba1>
  800bab:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800bb1:	c1 e0 04             	shl    $0x4,%eax
  800bb4:	05 4c 40 80 00       	add    $0x80404c,%eax
  800bb9:	8b 00                	mov    (%eax),%eax
  800bbb:	83 ec 0c             	sub    $0xc,%esp
  800bbe:	50                   	push   %eax
  800bbf:	ff b5 6c ff ff ff    	pushl  -0x94(%ebp)
  800bc5:	68 20 2c 80 00       	push   $0x802c20
  800bca:	68 90 00 00 00       	push   $0x90
  800bcf:	68 54 2a 80 00       	push   $0x802a54
  800bd4:	e8 70 02 00 00       	call   800e49 <_panic>
  800bd9:	ff 85 6c ff ff ff    	incl   -0x94(%ebp)
	}

	int freeFrames6 = sys_calculate_free_frames() ;
  800bdf:	e8 e4 16 00 00       	call   8022c8 <sys_calculate_free_frames>
  800be4:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
	int usedDiskPages6 = sys_pf_calculate_allocated_pages() ;
  800bea:	e8 5c 17 00 00       	call   80234b <sys_pf_calculate_allocated_pages>
  800bef:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
	expectedNumOfAllocatedFrames = ROUNDUP(expectedNumOfAllocatedFrames, PAGE_SIZE) / PAGE_SIZE;
  800bf5:	c7 85 60 ff ff ff 00 	movl   $0x1000,-0xa0(%ebp)
  800bfc:	10 00 00 
  800bff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c02:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800c08:	01 d0                	add    %edx,%eax
  800c0a:	48                   	dec    %eax
  800c0b:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  800c11:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800c17:	ba 00 00 00 00       	mov    $0x0,%edx
  800c1c:	f7 b5 60 ff ff ff    	divl   -0xa0(%ebp)
  800c22:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800c28:	29 d0                	sub    %edx,%eax
  800c2a:	85 c0                	test   %eax,%eax
  800c2c:	79 05                	jns    800c33 <_main+0xbfb>
  800c2e:	05 ff 0f 00 00       	add    $0xfff,%eax
  800c33:	c1 f8 0c             	sar    $0xc,%eax
  800c36:	89 45 f4             	mov    %eax,-0xc(%ebp)
	//Check that no extra frames are taken
	if(freeFrames5 - freeFrames6 != expectedNumOfAllocatedFrames + 1);
	if(usedDiskPages6 - usedDiskPages5 != expectedNumOfAllocatedFrames);
	//Check the array content
	for (int i = 0; i < N; ++i)
  800c39:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  800c40:	eb 62                	jmp    800ca4 <_main+0xc6c>
	{
		for (int j = 0; j < M; ++j)
  800c42:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
  800c49:	eb 4e                	jmp    800c99 <_main+0xc61>
		{
			assert(arr3[i][j] == (i + 2)%255);
  800c4b:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800c4e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800c55:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800c5b:	01 d0                	add    %edx,%eax
  800c5d:	8b 10                	mov    (%eax),%edx
  800c5f:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800c62:	01 d0                	add    %edx,%eax
  800c64:	8a 00                	mov    (%eax),%al
  800c66:	0f b6 c8             	movzbl %al,%ecx
  800c69:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800c6c:	83 c0 02             	add    $0x2,%eax
  800c6f:	bb ff 00 00 00       	mov    $0xff,%ebx
  800c74:	99                   	cltd   
  800c75:	f7 fb                	idiv   %ebx
  800c77:	89 d0                	mov    %edx,%eax
  800c79:	39 c1                	cmp    %eax,%ecx
  800c7b:	74 19                	je     800c96 <_main+0xc5e>
  800c7d:	68 86 2c 80 00       	push   $0x802c86
  800c82:	68 3f 2a 80 00       	push   $0x802a3f
  800c87:	68 9e 00 00 00       	push   $0x9e
  800c8c:	68 54 2a 80 00       	push   $0x802a54
  800c91:	e8 b3 01 00 00       	call   800e49 <_panic>
	if(freeFrames5 - freeFrames6 != expectedNumOfAllocatedFrames + 1);
	if(usedDiskPages6 - usedDiskPages5 != expectedNumOfAllocatedFrames);
	//Check the array content
	for (int i = 0; i < N; ++i)
	{
		for (int j = 0; j < M; ++j)
  800c96:	ff 45 b8             	incl   -0x48(%ebp)
  800c99:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800c9c:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  800c9f:	7c aa                	jl     800c4b <_main+0xc13>
	expectedNumOfAllocatedFrames = ROUNDUP(expectedNumOfAllocatedFrames, PAGE_SIZE) / PAGE_SIZE;
	//Check that no extra frames are taken
	if(freeFrames5 - freeFrames6 != expectedNumOfAllocatedFrames + 1);
	if(usedDiskPages6 - usedDiskPages5 != expectedNumOfAllocatedFrames);
	//Check the array content
	for (int i = 0; i < N; ++i)
  800ca1:	ff 45 bc             	incl   -0x44(%ebp)
  800ca4:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800ca7:	3b 45 ac             	cmp    -0x54(%ebp),%eax
  800caa:	7c 96                	jl     800c42 <_main+0xc0a>
		{
			assert(arr3[i][j] == (i + 2)%255);
		}
	}

	cprintf("Congratulations!! test BUDDY SYSTEM deallocation (2) completed successfully.\n");
  800cac:	83 ec 0c             	sub    $0xc,%esp
  800caf:	68 a0 2c 80 00       	push   $0x802ca0
  800cb4:	e8 32 04 00 00       	call   8010eb <cprintf>
  800cb9:	83 c4 10             	add    $0x10,%esp

	return;
  800cbc:	90                   	nop
}
  800cbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800cc0:	c9                   	leave  
  800cc1:	c3                   	ret    

00800cc2 <GetPowOf2>:

int GetPowOf2(int size)
{
  800cc2:	55                   	push   %ebp
  800cc3:	89 e5                	mov    %esp,%ebp
  800cc5:	83 ec 10             	sub    $0x10,%esp
	int i;
	for(i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; i++)
  800cc8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
  800ccf:	eb 26                	jmp    800cf7 <GetPowOf2+0x35>
	{
		if(BUDDY_NODE_SIZE(i) >= size)
  800cd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cd4:	ba 01 00 00 00       	mov    $0x1,%edx
  800cd9:	88 c1                	mov    %al,%cl
  800cdb:	d3 e2                	shl    %cl,%edx
  800cdd:	89 d0                	mov    %edx,%eax
  800cdf:	3b 45 08             	cmp    0x8(%ebp),%eax
  800ce2:	7c 10                	jl     800cf4 <GetPowOf2+0x32>
			return 1<<i;
  800ce4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ce7:	ba 01 00 00 00       	mov    $0x1,%edx
  800cec:	88 c1                	mov    %al,%cl
  800cee:	d3 e2                	shl    %cl,%edx
  800cf0:	89 d0                	mov    %edx,%eax
  800cf2:	eb 0e                	jmp    800d02 <GetPowOf2+0x40>
}

int GetPowOf2(int size)
{
	int i;
	for(i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; i++)
  800cf4:	ff 45 fc             	incl   -0x4(%ebp)
  800cf7:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  800cfb:	7e d4                	jle    800cd1 <GetPowOf2+0xf>
	{
		if(BUDDY_NODE_SIZE(i) >= size)
			return 1<<i;
	}
	return 0;
  800cfd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d02:	c9                   	leave  
  800d03:	c3                   	ret    

00800d04 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800d04:	55                   	push   %ebp
  800d05:	89 e5                	mov    %esp,%ebp
  800d07:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800d0a:	e8 ee 14 00 00       	call   8021fd <sys_getenvindex>
  800d0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800d12:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d15:	89 d0                	mov    %edx,%eax
  800d17:	c1 e0 03             	shl    $0x3,%eax
  800d1a:	01 d0                	add    %edx,%eax
  800d1c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800d23:	01 c8                	add    %ecx,%eax
  800d25:	01 c0                	add    %eax,%eax
  800d27:	01 d0                	add    %edx,%eax
  800d29:	01 c0                	add    %eax,%eax
  800d2b:	01 d0                	add    %edx,%eax
  800d2d:	89 c2                	mov    %eax,%edx
  800d2f:	c1 e2 05             	shl    $0x5,%edx
  800d32:	29 c2                	sub    %eax,%edx
  800d34:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800d3b:	89 c2                	mov    %eax,%edx
  800d3d:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800d43:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800d48:	a1 20 40 80 00       	mov    0x804020,%eax
  800d4d:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800d53:	84 c0                	test   %al,%al
  800d55:	74 0f                	je     800d66 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800d57:	a1 20 40 80 00       	mov    0x804020,%eax
  800d5c:	05 40 3c 01 00       	add    $0x13c40,%eax
  800d61:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800d66:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d6a:	7e 0a                	jle    800d76 <libmain+0x72>
		binaryname = argv[0];
  800d6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6f:	8b 00                	mov    (%eax),%eax
  800d71:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800d76:	83 ec 08             	sub    $0x8,%esp
  800d79:	ff 75 0c             	pushl  0xc(%ebp)
  800d7c:	ff 75 08             	pushl  0x8(%ebp)
  800d7f:	e8 b4 f2 ff ff       	call   800038 <_main>
  800d84:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800d87:	e8 0c 16 00 00       	call   802398 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800d8c:	83 ec 0c             	sub    $0xc,%esp
  800d8f:	68 08 2d 80 00       	push   $0x802d08
  800d94:	e8 52 03 00 00       	call   8010eb <cprintf>
  800d99:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800d9c:	a1 20 40 80 00       	mov    0x804020,%eax
  800da1:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800da7:	a1 20 40 80 00       	mov    0x804020,%eax
  800dac:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800db2:	83 ec 04             	sub    $0x4,%esp
  800db5:	52                   	push   %edx
  800db6:	50                   	push   %eax
  800db7:	68 30 2d 80 00       	push   $0x802d30
  800dbc:	e8 2a 03 00 00       	call   8010eb <cprintf>
  800dc1:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800dc4:	a1 20 40 80 00       	mov    0x804020,%eax
  800dc9:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800dcf:	a1 20 40 80 00       	mov    0x804020,%eax
  800dd4:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800dda:	83 ec 04             	sub    $0x4,%esp
  800ddd:	52                   	push   %edx
  800dde:	50                   	push   %eax
  800ddf:	68 58 2d 80 00       	push   $0x802d58
  800de4:	e8 02 03 00 00       	call   8010eb <cprintf>
  800de9:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800dec:	a1 20 40 80 00       	mov    0x804020,%eax
  800df1:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800df7:	83 ec 08             	sub    $0x8,%esp
  800dfa:	50                   	push   %eax
  800dfb:	68 99 2d 80 00       	push   $0x802d99
  800e00:	e8 e6 02 00 00       	call   8010eb <cprintf>
  800e05:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800e08:	83 ec 0c             	sub    $0xc,%esp
  800e0b:	68 08 2d 80 00       	push   $0x802d08
  800e10:	e8 d6 02 00 00       	call   8010eb <cprintf>
  800e15:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800e18:	e8 95 15 00 00       	call   8023b2 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800e1d:	e8 19 00 00 00       	call   800e3b <exit>
}
  800e22:	90                   	nop
  800e23:	c9                   	leave  
  800e24:	c3                   	ret    

00800e25 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800e25:	55                   	push   %ebp
  800e26:	89 e5                	mov    %esp,%ebp
  800e28:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800e2b:	83 ec 0c             	sub    $0xc,%esp
  800e2e:	6a 00                	push   $0x0
  800e30:	e8 94 13 00 00       	call   8021c9 <sys_env_destroy>
  800e35:	83 c4 10             	add    $0x10,%esp
}
  800e38:	90                   	nop
  800e39:	c9                   	leave  
  800e3a:	c3                   	ret    

00800e3b <exit>:

void
exit(void)
{
  800e3b:	55                   	push   %ebp
  800e3c:	89 e5                	mov    %esp,%ebp
  800e3e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800e41:	e8 e9 13 00 00       	call   80222f <sys_env_exit>
}
  800e46:	90                   	nop
  800e47:	c9                   	leave  
  800e48:	c3                   	ret    

00800e49 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800e49:	55                   	push   %ebp
  800e4a:	89 e5                	mov    %esp,%ebp
  800e4c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800e4f:	8d 45 10             	lea    0x10(%ebp),%eax
  800e52:	83 c0 04             	add    $0x4,%eax
  800e55:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800e58:	a1 18 41 80 00       	mov    0x804118,%eax
  800e5d:	85 c0                	test   %eax,%eax
  800e5f:	74 16                	je     800e77 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800e61:	a1 18 41 80 00       	mov    0x804118,%eax
  800e66:	83 ec 08             	sub    $0x8,%esp
  800e69:	50                   	push   %eax
  800e6a:	68 b0 2d 80 00       	push   $0x802db0
  800e6f:	e8 77 02 00 00       	call   8010eb <cprintf>
  800e74:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800e77:	a1 00 40 80 00       	mov    0x804000,%eax
  800e7c:	ff 75 0c             	pushl  0xc(%ebp)
  800e7f:	ff 75 08             	pushl  0x8(%ebp)
  800e82:	50                   	push   %eax
  800e83:	68 b5 2d 80 00       	push   $0x802db5
  800e88:	e8 5e 02 00 00       	call   8010eb <cprintf>
  800e8d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800e90:	8b 45 10             	mov    0x10(%ebp),%eax
  800e93:	83 ec 08             	sub    $0x8,%esp
  800e96:	ff 75 f4             	pushl  -0xc(%ebp)
  800e99:	50                   	push   %eax
  800e9a:	e8 e1 01 00 00       	call   801080 <vcprintf>
  800e9f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800ea2:	83 ec 08             	sub    $0x8,%esp
  800ea5:	6a 00                	push   $0x0
  800ea7:	68 d1 2d 80 00       	push   $0x802dd1
  800eac:	e8 cf 01 00 00       	call   801080 <vcprintf>
  800eb1:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800eb4:	e8 82 ff ff ff       	call   800e3b <exit>

	// should not return here
	while (1) ;
  800eb9:	eb fe                	jmp    800eb9 <_panic+0x70>

00800ebb <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800ebb:	55                   	push   %ebp
  800ebc:	89 e5                	mov    %esp,%ebp
  800ebe:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800ec1:	a1 20 40 80 00       	mov    0x804020,%eax
  800ec6:	8b 50 74             	mov    0x74(%eax),%edx
  800ec9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecc:	39 c2                	cmp    %eax,%edx
  800ece:	74 14                	je     800ee4 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800ed0:	83 ec 04             	sub    $0x4,%esp
  800ed3:	68 d4 2d 80 00       	push   $0x802dd4
  800ed8:	6a 26                	push   $0x26
  800eda:	68 20 2e 80 00       	push   $0x802e20
  800edf:	e8 65 ff ff ff       	call   800e49 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800ee4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800eeb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800ef2:	e9 b6 00 00 00       	jmp    800fad <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800ef7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800efa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f01:	8b 45 08             	mov    0x8(%ebp),%eax
  800f04:	01 d0                	add    %edx,%eax
  800f06:	8b 00                	mov    (%eax),%eax
  800f08:	85 c0                	test   %eax,%eax
  800f0a:	75 08                	jne    800f14 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800f0c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800f0f:	e9 96 00 00 00       	jmp    800faa <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800f14:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800f1b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800f22:	eb 5d                	jmp    800f81 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800f24:	a1 20 40 80 00       	mov    0x804020,%eax
  800f29:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800f2f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800f32:	c1 e2 04             	shl    $0x4,%edx
  800f35:	01 d0                	add    %edx,%eax
  800f37:	8a 40 04             	mov    0x4(%eax),%al
  800f3a:	84 c0                	test   %al,%al
  800f3c:	75 40                	jne    800f7e <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800f3e:	a1 20 40 80 00       	mov    0x804020,%eax
  800f43:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800f49:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800f4c:	c1 e2 04             	shl    $0x4,%edx
  800f4f:	01 d0                	add    %edx,%eax
  800f51:	8b 00                	mov    (%eax),%eax
  800f53:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800f56:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800f59:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f5e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800f60:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f63:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	01 c8                	add    %ecx,%eax
  800f6f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800f71:	39 c2                	cmp    %eax,%edx
  800f73:	75 09                	jne    800f7e <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800f75:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800f7c:	eb 12                	jmp    800f90 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800f7e:	ff 45 e8             	incl   -0x18(%ebp)
  800f81:	a1 20 40 80 00       	mov    0x804020,%eax
  800f86:	8b 50 74             	mov    0x74(%eax),%edx
  800f89:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800f8c:	39 c2                	cmp    %eax,%edx
  800f8e:	77 94                	ja     800f24 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800f90:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800f94:	75 14                	jne    800faa <CheckWSWithoutLastIndex+0xef>
			panic(
  800f96:	83 ec 04             	sub    $0x4,%esp
  800f99:	68 2c 2e 80 00       	push   $0x802e2c
  800f9e:	6a 3a                	push   $0x3a
  800fa0:	68 20 2e 80 00       	push   $0x802e20
  800fa5:	e8 9f fe ff ff       	call   800e49 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800faa:	ff 45 f0             	incl   -0x10(%ebp)
  800fad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fb0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800fb3:	0f 8c 3e ff ff ff    	jl     800ef7 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800fb9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800fc0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800fc7:	eb 20                	jmp    800fe9 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800fc9:	a1 20 40 80 00       	mov    0x804020,%eax
  800fce:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800fd4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800fd7:	c1 e2 04             	shl    $0x4,%edx
  800fda:	01 d0                	add    %edx,%eax
  800fdc:	8a 40 04             	mov    0x4(%eax),%al
  800fdf:	3c 01                	cmp    $0x1,%al
  800fe1:	75 03                	jne    800fe6 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800fe3:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800fe6:	ff 45 e0             	incl   -0x20(%ebp)
  800fe9:	a1 20 40 80 00       	mov    0x804020,%eax
  800fee:	8b 50 74             	mov    0x74(%eax),%edx
  800ff1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ff4:	39 c2                	cmp    %eax,%edx
  800ff6:	77 d1                	ja     800fc9 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800ff8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ffb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800ffe:	74 14                	je     801014 <CheckWSWithoutLastIndex+0x159>
		panic(
  801000:	83 ec 04             	sub    $0x4,%esp
  801003:	68 80 2e 80 00       	push   $0x802e80
  801008:	6a 44                	push   $0x44
  80100a:	68 20 2e 80 00       	push   $0x802e20
  80100f:	e8 35 fe ff ff       	call   800e49 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801014:	90                   	nop
  801015:	c9                   	leave  
  801016:	c3                   	ret    

00801017 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801017:	55                   	push   %ebp
  801018:	89 e5                	mov    %esp,%ebp
  80101a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80101d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801020:	8b 00                	mov    (%eax),%eax
  801022:	8d 48 01             	lea    0x1(%eax),%ecx
  801025:	8b 55 0c             	mov    0xc(%ebp),%edx
  801028:	89 0a                	mov    %ecx,(%edx)
  80102a:	8b 55 08             	mov    0x8(%ebp),%edx
  80102d:	88 d1                	mov    %dl,%cl
  80102f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801032:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801036:	8b 45 0c             	mov    0xc(%ebp),%eax
  801039:	8b 00                	mov    (%eax),%eax
  80103b:	3d ff 00 00 00       	cmp    $0xff,%eax
  801040:	75 2c                	jne    80106e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801042:	a0 24 40 80 00       	mov    0x804024,%al
  801047:	0f b6 c0             	movzbl %al,%eax
  80104a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80104d:	8b 12                	mov    (%edx),%edx
  80104f:	89 d1                	mov    %edx,%ecx
  801051:	8b 55 0c             	mov    0xc(%ebp),%edx
  801054:	83 c2 08             	add    $0x8,%edx
  801057:	83 ec 04             	sub    $0x4,%esp
  80105a:	50                   	push   %eax
  80105b:	51                   	push   %ecx
  80105c:	52                   	push   %edx
  80105d:	e8 25 11 00 00       	call   802187 <sys_cputs>
  801062:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  801065:	8b 45 0c             	mov    0xc(%ebp),%eax
  801068:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80106e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801071:	8b 40 04             	mov    0x4(%eax),%eax
  801074:	8d 50 01             	lea    0x1(%eax),%edx
  801077:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80107d:	90                   	nop
  80107e:	c9                   	leave  
  80107f:	c3                   	ret    

00801080 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801080:	55                   	push   %ebp
  801081:	89 e5                	mov    %esp,%ebp
  801083:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801089:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801090:	00 00 00 
	b.cnt = 0;
  801093:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80109a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80109d:	ff 75 0c             	pushl  0xc(%ebp)
  8010a0:	ff 75 08             	pushl  0x8(%ebp)
  8010a3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8010a9:	50                   	push   %eax
  8010aa:	68 17 10 80 00       	push   $0x801017
  8010af:	e8 11 02 00 00       	call   8012c5 <vprintfmt>
  8010b4:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8010b7:	a0 24 40 80 00       	mov    0x804024,%al
  8010bc:	0f b6 c0             	movzbl %al,%eax
  8010bf:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8010c5:	83 ec 04             	sub    $0x4,%esp
  8010c8:	50                   	push   %eax
  8010c9:	52                   	push   %edx
  8010ca:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8010d0:	83 c0 08             	add    $0x8,%eax
  8010d3:	50                   	push   %eax
  8010d4:	e8 ae 10 00 00       	call   802187 <sys_cputs>
  8010d9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8010dc:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  8010e3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8010e9:	c9                   	leave  
  8010ea:	c3                   	ret    

008010eb <cprintf>:

int cprintf(const char *fmt, ...) {
  8010eb:	55                   	push   %ebp
  8010ec:	89 e5                	mov    %esp,%ebp
  8010ee:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8010f1:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  8010f8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8010fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8010fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801101:	83 ec 08             	sub    $0x8,%esp
  801104:	ff 75 f4             	pushl  -0xc(%ebp)
  801107:	50                   	push   %eax
  801108:	e8 73 ff ff ff       	call   801080 <vcprintf>
  80110d:	83 c4 10             	add    $0x10,%esp
  801110:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801113:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801116:	c9                   	leave  
  801117:	c3                   	ret    

00801118 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801118:	55                   	push   %ebp
  801119:	89 e5                	mov    %esp,%ebp
  80111b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80111e:	e8 75 12 00 00       	call   802398 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801123:	8d 45 0c             	lea    0xc(%ebp),%eax
  801126:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	83 ec 08             	sub    $0x8,%esp
  80112f:	ff 75 f4             	pushl  -0xc(%ebp)
  801132:	50                   	push   %eax
  801133:	e8 48 ff ff ff       	call   801080 <vcprintf>
  801138:	83 c4 10             	add    $0x10,%esp
  80113b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80113e:	e8 6f 12 00 00       	call   8023b2 <sys_enable_interrupt>
	return cnt;
  801143:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801146:	c9                   	leave  
  801147:	c3                   	ret    

00801148 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801148:	55                   	push   %ebp
  801149:	89 e5                	mov    %esp,%ebp
  80114b:	53                   	push   %ebx
  80114c:	83 ec 14             	sub    $0x14,%esp
  80114f:	8b 45 10             	mov    0x10(%ebp),%eax
  801152:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801155:	8b 45 14             	mov    0x14(%ebp),%eax
  801158:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80115b:	8b 45 18             	mov    0x18(%ebp),%eax
  80115e:	ba 00 00 00 00       	mov    $0x0,%edx
  801163:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801166:	77 55                	ja     8011bd <printnum+0x75>
  801168:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80116b:	72 05                	jb     801172 <printnum+0x2a>
  80116d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801170:	77 4b                	ja     8011bd <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801172:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801175:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801178:	8b 45 18             	mov    0x18(%ebp),%eax
  80117b:	ba 00 00 00 00       	mov    $0x0,%edx
  801180:	52                   	push   %edx
  801181:	50                   	push   %eax
  801182:	ff 75 f4             	pushl  -0xc(%ebp)
  801185:	ff 75 f0             	pushl  -0x10(%ebp)
  801188:	e8 2f 16 00 00       	call   8027bc <__udivdi3>
  80118d:	83 c4 10             	add    $0x10,%esp
  801190:	83 ec 04             	sub    $0x4,%esp
  801193:	ff 75 20             	pushl  0x20(%ebp)
  801196:	53                   	push   %ebx
  801197:	ff 75 18             	pushl  0x18(%ebp)
  80119a:	52                   	push   %edx
  80119b:	50                   	push   %eax
  80119c:	ff 75 0c             	pushl  0xc(%ebp)
  80119f:	ff 75 08             	pushl  0x8(%ebp)
  8011a2:	e8 a1 ff ff ff       	call   801148 <printnum>
  8011a7:	83 c4 20             	add    $0x20,%esp
  8011aa:	eb 1a                	jmp    8011c6 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8011ac:	83 ec 08             	sub    $0x8,%esp
  8011af:	ff 75 0c             	pushl  0xc(%ebp)
  8011b2:	ff 75 20             	pushl  0x20(%ebp)
  8011b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b8:	ff d0                	call   *%eax
  8011ba:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8011bd:	ff 4d 1c             	decl   0x1c(%ebp)
  8011c0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8011c4:	7f e6                	jg     8011ac <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8011c6:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8011c9:	bb 00 00 00 00       	mov    $0x0,%ebx
  8011ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011d4:	53                   	push   %ebx
  8011d5:	51                   	push   %ecx
  8011d6:	52                   	push   %edx
  8011d7:	50                   	push   %eax
  8011d8:	e8 ef 16 00 00       	call   8028cc <__umoddi3>
  8011dd:	83 c4 10             	add    $0x10,%esp
  8011e0:	05 f4 30 80 00       	add    $0x8030f4,%eax
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	0f be c0             	movsbl %al,%eax
  8011ea:	83 ec 08             	sub    $0x8,%esp
  8011ed:	ff 75 0c             	pushl  0xc(%ebp)
  8011f0:	50                   	push   %eax
  8011f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f4:	ff d0                	call   *%eax
  8011f6:	83 c4 10             	add    $0x10,%esp
}
  8011f9:	90                   	nop
  8011fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8011fd:	c9                   	leave  
  8011fe:	c3                   	ret    

008011ff <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8011ff:	55                   	push   %ebp
  801200:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801202:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801206:	7e 1c                	jle    801224 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	8b 00                	mov    (%eax),%eax
  80120d:	8d 50 08             	lea    0x8(%eax),%edx
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	89 10                	mov    %edx,(%eax)
  801215:	8b 45 08             	mov    0x8(%ebp),%eax
  801218:	8b 00                	mov    (%eax),%eax
  80121a:	83 e8 08             	sub    $0x8,%eax
  80121d:	8b 50 04             	mov    0x4(%eax),%edx
  801220:	8b 00                	mov    (%eax),%eax
  801222:	eb 40                	jmp    801264 <getuint+0x65>
	else if (lflag)
  801224:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801228:	74 1e                	je     801248 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80122a:	8b 45 08             	mov    0x8(%ebp),%eax
  80122d:	8b 00                	mov    (%eax),%eax
  80122f:	8d 50 04             	lea    0x4(%eax),%edx
  801232:	8b 45 08             	mov    0x8(%ebp),%eax
  801235:	89 10                	mov    %edx,(%eax)
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	8b 00                	mov    (%eax),%eax
  80123c:	83 e8 04             	sub    $0x4,%eax
  80123f:	8b 00                	mov    (%eax),%eax
  801241:	ba 00 00 00 00       	mov    $0x0,%edx
  801246:	eb 1c                	jmp    801264 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801248:	8b 45 08             	mov    0x8(%ebp),%eax
  80124b:	8b 00                	mov    (%eax),%eax
  80124d:	8d 50 04             	lea    0x4(%eax),%edx
  801250:	8b 45 08             	mov    0x8(%ebp),%eax
  801253:	89 10                	mov    %edx,(%eax)
  801255:	8b 45 08             	mov    0x8(%ebp),%eax
  801258:	8b 00                	mov    (%eax),%eax
  80125a:	83 e8 04             	sub    $0x4,%eax
  80125d:	8b 00                	mov    (%eax),%eax
  80125f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801264:	5d                   	pop    %ebp
  801265:	c3                   	ret    

00801266 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801266:	55                   	push   %ebp
  801267:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801269:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80126d:	7e 1c                	jle    80128b <getint+0x25>
		return va_arg(*ap, long long);
  80126f:	8b 45 08             	mov    0x8(%ebp),%eax
  801272:	8b 00                	mov    (%eax),%eax
  801274:	8d 50 08             	lea    0x8(%eax),%edx
  801277:	8b 45 08             	mov    0x8(%ebp),%eax
  80127a:	89 10                	mov    %edx,(%eax)
  80127c:	8b 45 08             	mov    0x8(%ebp),%eax
  80127f:	8b 00                	mov    (%eax),%eax
  801281:	83 e8 08             	sub    $0x8,%eax
  801284:	8b 50 04             	mov    0x4(%eax),%edx
  801287:	8b 00                	mov    (%eax),%eax
  801289:	eb 38                	jmp    8012c3 <getint+0x5d>
	else if (lflag)
  80128b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80128f:	74 1a                	je     8012ab <getint+0x45>
		return va_arg(*ap, long);
  801291:	8b 45 08             	mov    0x8(%ebp),%eax
  801294:	8b 00                	mov    (%eax),%eax
  801296:	8d 50 04             	lea    0x4(%eax),%edx
  801299:	8b 45 08             	mov    0x8(%ebp),%eax
  80129c:	89 10                	mov    %edx,(%eax)
  80129e:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a1:	8b 00                	mov    (%eax),%eax
  8012a3:	83 e8 04             	sub    $0x4,%eax
  8012a6:	8b 00                	mov    (%eax),%eax
  8012a8:	99                   	cltd   
  8012a9:	eb 18                	jmp    8012c3 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8012ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ae:	8b 00                	mov    (%eax),%eax
  8012b0:	8d 50 04             	lea    0x4(%eax),%edx
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b6:	89 10                	mov    %edx,(%eax)
  8012b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bb:	8b 00                	mov    (%eax),%eax
  8012bd:	83 e8 04             	sub    $0x4,%eax
  8012c0:	8b 00                	mov    (%eax),%eax
  8012c2:	99                   	cltd   
}
  8012c3:	5d                   	pop    %ebp
  8012c4:	c3                   	ret    

008012c5 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8012c5:	55                   	push   %ebp
  8012c6:	89 e5                	mov    %esp,%ebp
  8012c8:	56                   	push   %esi
  8012c9:	53                   	push   %ebx
  8012ca:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8012cd:	eb 17                	jmp    8012e6 <vprintfmt+0x21>
			if (ch == '\0')
  8012cf:	85 db                	test   %ebx,%ebx
  8012d1:	0f 84 af 03 00 00    	je     801686 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8012d7:	83 ec 08             	sub    $0x8,%esp
  8012da:	ff 75 0c             	pushl  0xc(%ebp)
  8012dd:	53                   	push   %ebx
  8012de:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e1:	ff d0                	call   *%eax
  8012e3:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8012e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e9:	8d 50 01             	lea    0x1(%eax),%edx
  8012ec:	89 55 10             	mov    %edx,0x10(%ebp)
  8012ef:	8a 00                	mov    (%eax),%al
  8012f1:	0f b6 d8             	movzbl %al,%ebx
  8012f4:	83 fb 25             	cmp    $0x25,%ebx
  8012f7:	75 d6                	jne    8012cf <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8012f9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8012fd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801304:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80130b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801312:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801319:	8b 45 10             	mov    0x10(%ebp),%eax
  80131c:	8d 50 01             	lea    0x1(%eax),%edx
  80131f:	89 55 10             	mov    %edx,0x10(%ebp)
  801322:	8a 00                	mov    (%eax),%al
  801324:	0f b6 d8             	movzbl %al,%ebx
  801327:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80132a:	83 f8 55             	cmp    $0x55,%eax
  80132d:	0f 87 2b 03 00 00    	ja     80165e <vprintfmt+0x399>
  801333:	8b 04 85 18 31 80 00 	mov    0x803118(,%eax,4),%eax
  80133a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80133c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801340:	eb d7                	jmp    801319 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801342:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801346:	eb d1                	jmp    801319 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801348:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80134f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801352:	89 d0                	mov    %edx,%eax
  801354:	c1 e0 02             	shl    $0x2,%eax
  801357:	01 d0                	add    %edx,%eax
  801359:	01 c0                	add    %eax,%eax
  80135b:	01 d8                	add    %ebx,%eax
  80135d:	83 e8 30             	sub    $0x30,%eax
  801360:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801363:	8b 45 10             	mov    0x10(%ebp),%eax
  801366:	8a 00                	mov    (%eax),%al
  801368:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80136b:	83 fb 2f             	cmp    $0x2f,%ebx
  80136e:	7e 3e                	jle    8013ae <vprintfmt+0xe9>
  801370:	83 fb 39             	cmp    $0x39,%ebx
  801373:	7f 39                	jg     8013ae <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801375:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801378:	eb d5                	jmp    80134f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80137a:	8b 45 14             	mov    0x14(%ebp),%eax
  80137d:	83 c0 04             	add    $0x4,%eax
  801380:	89 45 14             	mov    %eax,0x14(%ebp)
  801383:	8b 45 14             	mov    0x14(%ebp),%eax
  801386:	83 e8 04             	sub    $0x4,%eax
  801389:	8b 00                	mov    (%eax),%eax
  80138b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80138e:	eb 1f                	jmp    8013af <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801390:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801394:	79 83                	jns    801319 <vprintfmt+0x54>
				width = 0;
  801396:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80139d:	e9 77 ff ff ff       	jmp    801319 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8013a2:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8013a9:	e9 6b ff ff ff       	jmp    801319 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8013ae:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8013af:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8013b3:	0f 89 60 ff ff ff    	jns    801319 <vprintfmt+0x54>
				width = precision, precision = -1;
  8013b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8013bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8013bf:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8013c6:	e9 4e ff ff ff       	jmp    801319 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8013cb:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8013ce:	e9 46 ff ff ff       	jmp    801319 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8013d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d6:	83 c0 04             	add    $0x4,%eax
  8013d9:	89 45 14             	mov    %eax,0x14(%ebp)
  8013dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8013df:	83 e8 04             	sub    $0x4,%eax
  8013e2:	8b 00                	mov    (%eax),%eax
  8013e4:	83 ec 08             	sub    $0x8,%esp
  8013e7:	ff 75 0c             	pushl  0xc(%ebp)
  8013ea:	50                   	push   %eax
  8013eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ee:	ff d0                	call   *%eax
  8013f0:	83 c4 10             	add    $0x10,%esp
			break;
  8013f3:	e9 89 02 00 00       	jmp    801681 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8013f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8013fb:	83 c0 04             	add    $0x4,%eax
  8013fe:	89 45 14             	mov    %eax,0x14(%ebp)
  801401:	8b 45 14             	mov    0x14(%ebp),%eax
  801404:	83 e8 04             	sub    $0x4,%eax
  801407:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801409:	85 db                	test   %ebx,%ebx
  80140b:	79 02                	jns    80140f <vprintfmt+0x14a>
				err = -err;
  80140d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80140f:	83 fb 64             	cmp    $0x64,%ebx
  801412:	7f 0b                	jg     80141f <vprintfmt+0x15a>
  801414:	8b 34 9d 60 2f 80 00 	mov    0x802f60(,%ebx,4),%esi
  80141b:	85 f6                	test   %esi,%esi
  80141d:	75 19                	jne    801438 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80141f:	53                   	push   %ebx
  801420:	68 05 31 80 00       	push   $0x803105
  801425:	ff 75 0c             	pushl  0xc(%ebp)
  801428:	ff 75 08             	pushl  0x8(%ebp)
  80142b:	e8 5e 02 00 00       	call   80168e <printfmt>
  801430:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801433:	e9 49 02 00 00       	jmp    801681 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801438:	56                   	push   %esi
  801439:	68 0e 31 80 00       	push   $0x80310e
  80143e:	ff 75 0c             	pushl  0xc(%ebp)
  801441:	ff 75 08             	pushl  0x8(%ebp)
  801444:	e8 45 02 00 00       	call   80168e <printfmt>
  801449:	83 c4 10             	add    $0x10,%esp
			break;
  80144c:	e9 30 02 00 00       	jmp    801681 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801451:	8b 45 14             	mov    0x14(%ebp),%eax
  801454:	83 c0 04             	add    $0x4,%eax
  801457:	89 45 14             	mov    %eax,0x14(%ebp)
  80145a:	8b 45 14             	mov    0x14(%ebp),%eax
  80145d:	83 e8 04             	sub    $0x4,%eax
  801460:	8b 30                	mov    (%eax),%esi
  801462:	85 f6                	test   %esi,%esi
  801464:	75 05                	jne    80146b <vprintfmt+0x1a6>
				p = "(null)";
  801466:	be 11 31 80 00       	mov    $0x803111,%esi
			if (width > 0 && padc != '-')
  80146b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80146f:	7e 6d                	jle    8014de <vprintfmt+0x219>
  801471:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801475:	74 67                	je     8014de <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801477:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80147a:	83 ec 08             	sub    $0x8,%esp
  80147d:	50                   	push   %eax
  80147e:	56                   	push   %esi
  80147f:	e8 0c 03 00 00       	call   801790 <strnlen>
  801484:	83 c4 10             	add    $0x10,%esp
  801487:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80148a:	eb 16                	jmp    8014a2 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80148c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801490:	83 ec 08             	sub    $0x8,%esp
  801493:	ff 75 0c             	pushl  0xc(%ebp)
  801496:	50                   	push   %eax
  801497:	8b 45 08             	mov    0x8(%ebp),%eax
  80149a:	ff d0                	call   *%eax
  80149c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80149f:	ff 4d e4             	decl   -0x1c(%ebp)
  8014a2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8014a6:	7f e4                	jg     80148c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8014a8:	eb 34                	jmp    8014de <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8014aa:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8014ae:	74 1c                	je     8014cc <vprintfmt+0x207>
  8014b0:	83 fb 1f             	cmp    $0x1f,%ebx
  8014b3:	7e 05                	jle    8014ba <vprintfmt+0x1f5>
  8014b5:	83 fb 7e             	cmp    $0x7e,%ebx
  8014b8:	7e 12                	jle    8014cc <vprintfmt+0x207>
					putch('?', putdat);
  8014ba:	83 ec 08             	sub    $0x8,%esp
  8014bd:	ff 75 0c             	pushl  0xc(%ebp)
  8014c0:	6a 3f                	push   $0x3f
  8014c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c5:	ff d0                	call   *%eax
  8014c7:	83 c4 10             	add    $0x10,%esp
  8014ca:	eb 0f                	jmp    8014db <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8014cc:	83 ec 08             	sub    $0x8,%esp
  8014cf:	ff 75 0c             	pushl  0xc(%ebp)
  8014d2:	53                   	push   %ebx
  8014d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d6:	ff d0                	call   *%eax
  8014d8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8014db:	ff 4d e4             	decl   -0x1c(%ebp)
  8014de:	89 f0                	mov    %esi,%eax
  8014e0:	8d 70 01             	lea    0x1(%eax),%esi
  8014e3:	8a 00                	mov    (%eax),%al
  8014e5:	0f be d8             	movsbl %al,%ebx
  8014e8:	85 db                	test   %ebx,%ebx
  8014ea:	74 24                	je     801510 <vprintfmt+0x24b>
  8014ec:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8014f0:	78 b8                	js     8014aa <vprintfmt+0x1e5>
  8014f2:	ff 4d e0             	decl   -0x20(%ebp)
  8014f5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8014f9:	79 af                	jns    8014aa <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8014fb:	eb 13                	jmp    801510 <vprintfmt+0x24b>
				putch(' ', putdat);
  8014fd:	83 ec 08             	sub    $0x8,%esp
  801500:	ff 75 0c             	pushl  0xc(%ebp)
  801503:	6a 20                	push   $0x20
  801505:	8b 45 08             	mov    0x8(%ebp),%eax
  801508:	ff d0                	call   *%eax
  80150a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80150d:	ff 4d e4             	decl   -0x1c(%ebp)
  801510:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801514:	7f e7                	jg     8014fd <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801516:	e9 66 01 00 00       	jmp    801681 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80151b:	83 ec 08             	sub    $0x8,%esp
  80151e:	ff 75 e8             	pushl  -0x18(%ebp)
  801521:	8d 45 14             	lea    0x14(%ebp),%eax
  801524:	50                   	push   %eax
  801525:	e8 3c fd ff ff       	call   801266 <getint>
  80152a:	83 c4 10             	add    $0x10,%esp
  80152d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801530:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801533:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801536:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801539:	85 d2                	test   %edx,%edx
  80153b:	79 23                	jns    801560 <vprintfmt+0x29b>
				putch('-', putdat);
  80153d:	83 ec 08             	sub    $0x8,%esp
  801540:	ff 75 0c             	pushl  0xc(%ebp)
  801543:	6a 2d                	push   $0x2d
  801545:	8b 45 08             	mov    0x8(%ebp),%eax
  801548:	ff d0                	call   *%eax
  80154a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80154d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801550:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801553:	f7 d8                	neg    %eax
  801555:	83 d2 00             	adc    $0x0,%edx
  801558:	f7 da                	neg    %edx
  80155a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80155d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801560:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801567:	e9 bc 00 00 00       	jmp    801628 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80156c:	83 ec 08             	sub    $0x8,%esp
  80156f:	ff 75 e8             	pushl  -0x18(%ebp)
  801572:	8d 45 14             	lea    0x14(%ebp),%eax
  801575:	50                   	push   %eax
  801576:	e8 84 fc ff ff       	call   8011ff <getuint>
  80157b:	83 c4 10             	add    $0x10,%esp
  80157e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801581:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801584:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80158b:	e9 98 00 00 00       	jmp    801628 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801590:	83 ec 08             	sub    $0x8,%esp
  801593:	ff 75 0c             	pushl  0xc(%ebp)
  801596:	6a 58                	push   $0x58
  801598:	8b 45 08             	mov    0x8(%ebp),%eax
  80159b:	ff d0                	call   *%eax
  80159d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8015a0:	83 ec 08             	sub    $0x8,%esp
  8015a3:	ff 75 0c             	pushl  0xc(%ebp)
  8015a6:	6a 58                	push   $0x58
  8015a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ab:	ff d0                	call   *%eax
  8015ad:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8015b0:	83 ec 08             	sub    $0x8,%esp
  8015b3:	ff 75 0c             	pushl  0xc(%ebp)
  8015b6:	6a 58                	push   $0x58
  8015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bb:	ff d0                	call   *%eax
  8015bd:	83 c4 10             	add    $0x10,%esp
			break;
  8015c0:	e9 bc 00 00 00       	jmp    801681 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8015c5:	83 ec 08             	sub    $0x8,%esp
  8015c8:	ff 75 0c             	pushl  0xc(%ebp)
  8015cb:	6a 30                	push   $0x30
  8015cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d0:	ff d0                	call   *%eax
  8015d2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8015d5:	83 ec 08             	sub    $0x8,%esp
  8015d8:	ff 75 0c             	pushl  0xc(%ebp)
  8015db:	6a 78                	push   $0x78
  8015dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e0:	ff d0                	call   *%eax
  8015e2:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8015e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8015e8:	83 c0 04             	add    $0x4,%eax
  8015eb:	89 45 14             	mov    %eax,0x14(%ebp)
  8015ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8015f1:	83 e8 04             	sub    $0x4,%eax
  8015f4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8015f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015f9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801600:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801607:	eb 1f                	jmp    801628 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801609:	83 ec 08             	sub    $0x8,%esp
  80160c:	ff 75 e8             	pushl  -0x18(%ebp)
  80160f:	8d 45 14             	lea    0x14(%ebp),%eax
  801612:	50                   	push   %eax
  801613:	e8 e7 fb ff ff       	call   8011ff <getuint>
  801618:	83 c4 10             	add    $0x10,%esp
  80161b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80161e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801621:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801628:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80162c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80162f:	83 ec 04             	sub    $0x4,%esp
  801632:	52                   	push   %edx
  801633:	ff 75 e4             	pushl  -0x1c(%ebp)
  801636:	50                   	push   %eax
  801637:	ff 75 f4             	pushl  -0xc(%ebp)
  80163a:	ff 75 f0             	pushl  -0x10(%ebp)
  80163d:	ff 75 0c             	pushl  0xc(%ebp)
  801640:	ff 75 08             	pushl  0x8(%ebp)
  801643:	e8 00 fb ff ff       	call   801148 <printnum>
  801648:	83 c4 20             	add    $0x20,%esp
			break;
  80164b:	eb 34                	jmp    801681 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80164d:	83 ec 08             	sub    $0x8,%esp
  801650:	ff 75 0c             	pushl  0xc(%ebp)
  801653:	53                   	push   %ebx
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	ff d0                	call   *%eax
  801659:	83 c4 10             	add    $0x10,%esp
			break;
  80165c:	eb 23                	jmp    801681 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80165e:	83 ec 08             	sub    $0x8,%esp
  801661:	ff 75 0c             	pushl  0xc(%ebp)
  801664:	6a 25                	push   $0x25
  801666:	8b 45 08             	mov    0x8(%ebp),%eax
  801669:	ff d0                	call   *%eax
  80166b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80166e:	ff 4d 10             	decl   0x10(%ebp)
  801671:	eb 03                	jmp    801676 <vprintfmt+0x3b1>
  801673:	ff 4d 10             	decl   0x10(%ebp)
  801676:	8b 45 10             	mov    0x10(%ebp),%eax
  801679:	48                   	dec    %eax
  80167a:	8a 00                	mov    (%eax),%al
  80167c:	3c 25                	cmp    $0x25,%al
  80167e:	75 f3                	jne    801673 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801680:	90                   	nop
		}
	}
  801681:	e9 47 fc ff ff       	jmp    8012cd <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801686:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801687:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80168a:	5b                   	pop    %ebx
  80168b:	5e                   	pop    %esi
  80168c:	5d                   	pop    %ebp
  80168d:	c3                   	ret    

0080168e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80168e:	55                   	push   %ebp
  80168f:	89 e5                	mov    %esp,%ebp
  801691:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801694:	8d 45 10             	lea    0x10(%ebp),%eax
  801697:	83 c0 04             	add    $0x4,%eax
  80169a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80169d:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a0:	ff 75 f4             	pushl  -0xc(%ebp)
  8016a3:	50                   	push   %eax
  8016a4:	ff 75 0c             	pushl  0xc(%ebp)
  8016a7:	ff 75 08             	pushl  0x8(%ebp)
  8016aa:	e8 16 fc ff ff       	call   8012c5 <vprintfmt>
  8016af:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8016b2:	90                   	nop
  8016b3:	c9                   	leave  
  8016b4:	c3                   	ret    

008016b5 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8016b5:	55                   	push   %ebp
  8016b6:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8016b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016bb:	8b 40 08             	mov    0x8(%eax),%eax
  8016be:	8d 50 01             	lea    0x1(%eax),%edx
  8016c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c4:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8016c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ca:	8b 10                	mov    (%eax),%edx
  8016cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016cf:	8b 40 04             	mov    0x4(%eax),%eax
  8016d2:	39 c2                	cmp    %eax,%edx
  8016d4:	73 12                	jae    8016e8 <sprintputch+0x33>
		*b->buf++ = ch;
  8016d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d9:	8b 00                	mov    (%eax),%eax
  8016db:	8d 48 01             	lea    0x1(%eax),%ecx
  8016de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016e1:	89 0a                	mov    %ecx,(%edx)
  8016e3:	8b 55 08             	mov    0x8(%ebp),%edx
  8016e6:	88 10                	mov    %dl,(%eax)
}
  8016e8:	90                   	nop
  8016e9:	5d                   	pop    %ebp
  8016ea:	c3                   	ret    

008016eb <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8016eb:	55                   	push   %ebp
  8016ec:	89 e5                	mov    %esp,%ebp
  8016ee:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8016f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8016f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016fa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801700:	01 d0                	add    %edx,%eax
  801702:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801705:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80170c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801710:	74 06                	je     801718 <vsnprintf+0x2d>
  801712:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801716:	7f 07                	jg     80171f <vsnprintf+0x34>
		return -E_INVAL;
  801718:	b8 03 00 00 00       	mov    $0x3,%eax
  80171d:	eb 20                	jmp    80173f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80171f:	ff 75 14             	pushl  0x14(%ebp)
  801722:	ff 75 10             	pushl  0x10(%ebp)
  801725:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801728:	50                   	push   %eax
  801729:	68 b5 16 80 00       	push   $0x8016b5
  80172e:	e8 92 fb ff ff       	call   8012c5 <vprintfmt>
  801733:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801736:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801739:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80173c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80173f:	c9                   	leave  
  801740:	c3                   	ret    

00801741 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801741:	55                   	push   %ebp
  801742:	89 e5                	mov    %esp,%ebp
  801744:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801747:	8d 45 10             	lea    0x10(%ebp),%eax
  80174a:	83 c0 04             	add    $0x4,%eax
  80174d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801750:	8b 45 10             	mov    0x10(%ebp),%eax
  801753:	ff 75 f4             	pushl  -0xc(%ebp)
  801756:	50                   	push   %eax
  801757:	ff 75 0c             	pushl  0xc(%ebp)
  80175a:	ff 75 08             	pushl  0x8(%ebp)
  80175d:	e8 89 ff ff ff       	call   8016eb <vsnprintf>
  801762:	83 c4 10             	add    $0x10,%esp
  801765:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801768:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80176b:	c9                   	leave  
  80176c:	c3                   	ret    

0080176d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80176d:	55                   	push   %ebp
  80176e:	89 e5                	mov    %esp,%ebp
  801770:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801773:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80177a:	eb 06                	jmp    801782 <strlen+0x15>
		n++;
  80177c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80177f:	ff 45 08             	incl   0x8(%ebp)
  801782:	8b 45 08             	mov    0x8(%ebp),%eax
  801785:	8a 00                	mov    (%eax),%al
  801787:	84 c0                	test   %al,%al
  801789:	75 f1                	jne    80177c <strlen+0xf>
		n++;
	return n;
  80178b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80178e:	c9                   	leave  
  80178f:	c3                   	ret    

00801790 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
  801793:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801796:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80179d:	eb 09                	jmp    8017a8 <strnlen+0x18>
		n++;
  80179f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8017a2:	ff 45 08             	incl   0x8(%ebp)
  8017a5:	ff 4d 0c             	decl   0xc(%ebp)
  8017a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017ac:	74 09                	je     8017b7 <strnlen+0x27>
  8017ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b1:	8a 00                	mov    (%eax),%al
  8017b3:	84 c0                	test   %al,%al
  8017b5:	75 e8                	jne    80179f <strnlen+0xf>
		n++;
	return n;
  8017b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
  8017bf:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8017c8:	90                   	nop
  8017c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cc:	8d 50 01             	lea    0x1(%eax),%edx
  8017cf:	89 55 08             	mov    %edx,0x8(%ebp)
  8017d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8017d8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8017db:	8a 12                	mov    (%edx),%dl
  8017dd:	88 10                	mov    %dl,(%eax)
  8017df:	8a 00                	mov    (%eax),%al
  8017e1:	84 c0                	test   %al,%al
  8017e3:	75 e4                	jne    8017c9 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8017e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8017e8:	c9                   	leave  
  8017e9:	c3                   	ret    

008017ea <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8017ea:	55                   	push   %ebp
  8017eb:	89 e5                	mov    %esp,%ebp
  8017ed:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8017f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8017f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8017fd:	eb 1f                	jmp    80181e <strncpy+0x34>
		*dst++ = *src;
  8017ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801802:	8d 50 01             	lea    0x1(%eax),%edx
  801805:	89 55 08             	mov    %edx,0x8(%ebp)
  801808:	8b 55 0c             	mov    0xc(%ebp),%edx
  80180b:	8a 12                	mov    (%edx),%dl
  80180d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80180f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801812:	8a 00                	mov    (%eax),%al
  801814:	84 c0                	test   %al,%al
  801816:	74 03                	je     80181b <strncpy+0x31>
			src++;
  801818:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80181b:	ff 45 fc             	incl   -0x4(%ebp)
  80181e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801821:	3b 45 10             	cmp    0x10(%ebp),%eax
  801824:	72 d9                	jb     8017ff <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801826:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801829:	c9                   	leave  
  80182a:	c3                   	ret    

0080182b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80182b:	55                   	push   %ebp
  80182c:	89 e5                	mov    %esp,%ebp
  80182e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801831:	8b 45 08             	mov    0x8(%ebp),%eax
  801834:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801837:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80183b:	74 30                	je     80186d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80183d:	eb 16                	jmp    801855 <strlcpy+0x2a>
			*dst++ = *src++;
  80183f:	8b 45 08             	mov    0x8(%ebp),%eax
  801842:	8d 50 01             	lea    0x1(%eax),%edx
  801845:	89 55 08             	mov    %edx,0x8(%ebp)
  801848:	8b 55 0c             	mov    0xc(%ebp),%edx
  80184b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80184e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801851:	8a 12                	mov    (%edx),%dl
  801853:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801855:	ff 4d 10             	decl   0x10(%ebp)
  801858:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80185c:	74 09                	je     801867 <strlcpy+0x3c>
  80185e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801861:	8a 00                	mov    (%eax),%al
  801863:	84 c0                	test   %al,%al
  801865:	75 d8                	jne    80183f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801867:	8b 45 08             	mov    0x8(%ebp),%eax
  80186a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80186d:	8b 55 08             	mov    0x8(%ebp),%edx
  801870:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801873:	29 c2                	sub    %eax,%edx
  801875:	89 d0                	mov    %edx,%eax
}
  801877:	c9                   	leave  
  801878:	c3                   	ret    

00801879 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801879:	55                   	push   %ebp
  80187a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80187c:	eb 06                	jmp    801884 <strcmp+0xb>
		p++, q++;
  80187e:	ff 45 08             	incl   0x8(%ebp)
  801881:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801884:	8b 45 08             	mov    0x8(%ebp),%eax
  801887:	8a 00                	mov    (%eax),%al
  801889:	84 c0                	test   %al,%al
  80188b:	74 0e                	je     80189b <strcmp+0x22>
  80188d:	8b 45 08             	mov    0x8(%ebp),%eax
  801890:	8a 10                	mov    (%eax),%dl
  801892:	8b 45 0c             	mov    0xc(%ebp),%eax
  801895:	8a 00                	mov    (%eax),%al
  801897:	38 c2                	cmp    %al,%dl
  801899:	74 e3                	je     80187e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80189b:	8b 45 08             	mov    0x8(%ebp),%eax
  80189e:	8a 00                	mov    (%eax),%al
  8018a0:	0f b6 d0             	movzbl %al,%edx
  8018a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a6:	8a 00                	mov    (%eax),%al
  8018a8:	0f b6 c0             	movzbl %al,%eax
  8018ab:	29 c2                	sub    %eax,%edx
  8018ad:	89 d0                	mov    %edx,%eax
}
  8018af:	5d                   	pop    %ebp
  8018b0:	c3                   	ret    

008018b1 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8018b1:	55                   	push   %ebp
  8018b2:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8018b4:	eb 09                	jmp    8018bf <strncmp+0xe>
		n--, p++, q++;
  8018b6:	ff 4d 10             	decl   0x10(%ebp)
  8018b9:	ff 45 08             	incl   0x8(%ebp)
  8018bc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8018bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018c3:	74 17                	je     8018dc <strncmp+0x2b>
  8018c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c8:	8a 00                	mov    (%eax),%al
  8018ca:	84 c0                	test   %al,%al
  8018cc:	74 0e                	je     8018dc <strncmp+0x2b>
  8018ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d1:	8a 10                	mov    (%eax),%dl
  8018d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d6:	8a 00                	mov    (%eax),%al
  8018d8:	38 c2                	cmp    %al,%dl
  8018da:	74 da                	je     8018b6 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8018dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018e0:	75 07                	jne    8018e9 <strncmp+0x38>
		return 0;
  8018e2:	b8 00 00 00 00       	mov    $0x0,%eax
  8018e7:	eb 14                	jmp    8018fd <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8018e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ec:	8a 00                	mov    (%eax),%al
  8018ee:	0f b6 d0             	movzbl %al,%edx
  8018f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f4:	8a 00                	mov    (%eax),%al
  8018f6:	0f b6 c0             	movzbl %al,%eax
  8018f9:	29 c2                	sub    %eax,%edx
  8018fb:	89 d0                	mov    %edx,%eax
}
  8018fd:	5d                   	pop    %ebp
  8018fe:	c3                   	ret    

008018ff <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8018ff:	55                   	push   %ebp
  801900:	89 e5                	mov    %esp,%ebp
  801902:	83 ec 04             	sub    $0x4,%esp
  801905:	8b 45 0c             	mov    0xc(%ebp),%eax
  801908:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80190b:	eb 12                	jmp    80191f <strchr+0x20>
		if (*s == c)
  80190d:	8b 45 08             	mov    0x8(%ebp),%eax
  801910:	8a 00                	mov    (%eax),%al
  801912:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801915:	75 05                	jne    80191c <strchr+0x1d>
			return (char *) s;
  801917:	8b 45 08             	mov    0x8(%ebp),%eax
  80191a:	eb 11                	jmp    80192d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80191c:	ff 45 08             	incl   0x8(%ebp)
  80191f:	8b 45 08             	mov    0x8(%ebp),%eax
  801922:	8a 00                	mov    (%eax),%al
  801924:	84 c0                	test   %al,%al
  801926:	75 e5                	jne    80190d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801928:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80192d:	c9                   	leave  
  80192e:	c3                   	ret    

0080192f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
  801932:	83 ec 04             	sub    $0x4,%esp
  801935:	8b 45 0c             	mov    0xc(%ebp),%eax
  801938:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80193b:	eb 0d                	jmp    80194a <strfind+0x1b>
		if (*s == c)
  80193d:	8b 45 08             	mov    0x8(%ebp),%eax
  801940:	8a 00                	mov    (%eax),%al
  801942:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801945:	74 0e                	je     801955 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801947:	ff 45 08             	incl   0x8(%ebp)
  80194a:	8b 45 08             	mov    0x8(%ebp),%eax
  80194d:	8a 00                	mov    (%eax),%al
  80194f:	84 c0                	test   %al,%al
  801951:	75 ea                	jne    80193d <strfind+0xe>
  801953:	eb 01                	jmp    801956 <strfind+0x27>
		if (*s == c)
			break;
  801955:	90                   	nop
	return (char *) s;
  801956:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801959:	c9                   	leave  
  80195a:	c3                   	ret    

0080195b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80195b:	55                   	push   %ebp
  80195c:	89 e5                	mov    %esp,%ebp
  80195e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801961:	8b 45 08             	mov    0x8(%ebp),%eax
  801964:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801967:	8b 45 10             	mov    0x10(%ebp),%eax
  80196a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80196d:	eb 0e                	jmp    80197d <memset+0x22>
		*p++ = c;
  80196f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801972:	8d 50 01             	lea    0x1(%eax),%edx
  801975:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801978:	8b 55 0c             	mov    0xc(%ebp),%edx
  80197b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80197d:	ff 4d f8             	decl   -0x8(%ebp)
  801980:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801984:	79 e9                	jns    80196f <memset+0x14>
		*p++ = c;

	return v;
  801986:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801989:	c9                   	leave  
  80198a:	c3                   	ret    

0080198b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80198b:	55                   	push   %ebp
  80198c:	89 e5                	mov    %esp,%ebp
  80198e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801991:	8b 45 0c             	mov    0xc(%ebp),%eax
  801994:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801997:	8b 45 08             	mov    0x8(%ebp),%eax
  80199a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80199d:	eb 16                	jmp    8019b5 <memcpy+0x2a>
		*d++ = *s++;
  80199f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019a2:	8d 50 01             	lea    0x1(%eax),%edx
  8019a5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8019a8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019ab:	8d 4a 01             	lea    0x1(%edx),%ecx
  8019ae:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8019b1:	8a 12                	mov    (%edx),%dl
  8019b3:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8019b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8019b8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8019bb:	89 55 10             	mov    %edx,0x10(%ebp)
  8019be:	85 c0                	test   %eax,%eax
  8019c0:	75 dd                	jne    80199f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8019c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8019c5:	c9                   	leave  
  8019c6:	c3                   	ret    

008019c7 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8019c7:	55                   	push   %ebp
  8019c8:	89 e5                	mov    %esp,%ebp
  8019ca:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8019cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8019d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8019d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019dc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8019df:	73 50                	jae    801a31 <memmove+0x6a>
  8019e1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8019e7:	01 d0                	add    %edx,%eax
  8019e9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8019ec:	76 43                	jbe    801a31 <memmove+0x6a>
		s += n;
  8019ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f1:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8019f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f7:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8019fa:	eb 10                	jmp    801a0c <memmove+0x45>
			*--d = *--s;
  8019fc:	ff 4d f8             	decl   -0x8(%ebp)
  8019ff:	ff 4d fc             	decl   -0x4(%ebp)
  801a02:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a05:	8a 10                	mov    (%eax),%dl
  801a07:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a0a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801a0c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a0f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801a12:	89 55 10             	mov    %edx,0x10(%ebp)
  801a15:	85 c0                	test   %eax,%eax
  801a17:	75 e3                	jne    8019fc <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801a19:	eb 23                	jmp    801a3e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801a1b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a1e:	8d 50 01             	lea    0x1(%eax),%edx
  801a21:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801a24:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a27:	8d 4a 01             	lea    0x1(%edx),%ecx
  801a2a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801a2d:	8a 12                	mov    (%edx),%dl
  801a2f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801a31:	8b 45 10             	mov    0x10(%ebp),%eax
  801a34:	8d 50 ff             	lea    -0x1(%eax),%edx
  801a37:	89 55 10             	mov    %edx,0x10(%ebp)
  801a3a:	85 c0                	test   %eax,%eax
  801a3c:	75 dd                	jne    801a1b <memmove+0x54>
			*d++ = *s++;

	return dst;
  801a3e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a41:	c9                   	leave  
  801a42:	c3                   	ret    

00801a43 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801a43:	55                   	push   %ebp
  801a44:	89 e5                	mov    %esp,%ebp
  801a46:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801a49:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801a4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a52:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801a55:	eb 2a                	jmp    801a81 <memcmp+0x3e>
		if (*s1 != *s2)
  801a57:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a5a:	8a 10                	mov    (%eax),%dl
  801a5c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a5f:	8a 00                	mov    (%eax),%al
  801a61:	38 c2                	cmp    %al,%dl
  801a63:	74 16                	je     801a7b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801a65:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a68:	8a 00                	mov    (%eax),%al
  801a6a:	0f b6 d0             	movzbl %al,%edx
  801a6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a70:	8a 00                	mov    (%eax),%al
  801a72:	0f b6 c0             	movzbl %al,%eax
  801a75:	29 c2                	sub    %eax,%edx
  801a77:	89 d0                	mov    %edx,%eax
  801a79:	eb 18                	jmp    801a93 <memcmp+0x50>
		s1++, s2++;
  801a7b:	ff 45 fc             	incl   -0x4(%ebp)
  801a7e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801a81:	8b 45 10             	mov    0x10(%ebp),%eax
  801a84:	8d 50 ff             	lea    -0x1(%eax),%edx
  801a87:	89 55 10             	mov    %edx,0x10(%ebp)
  801a8a:	85 c0                	test   %eax,%eax
  801a8c:	75 c9                	jne    801a57 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801a8e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a93:	c9                   	leave  
  801a94:	c3                   	ret    

00801a95 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801a95:	55                   	push   %ebp
  801a96:	89 e5                	mov    %esp,%ebp
  801a98:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801a9b:	8b 55 08             	mov    0x8(%ebp),%edx
  801a9e:	8b 45 10             	mov    0x10(%ebp),%eax
  801aa1:	01 d0                	add    %edx,%eax
  801aa3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801aa6:	eb 15                	jmp    801abd <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  801aab:	8a 00                	mov    (%eax),%al
  801aad:	0f b6 d0             	movzbl %al,%edx
  801ab0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ab3:	0f b6 c0             	movzbl %al,%eax
  801ab6:	39 c2                	cmp    %eax,%edx
  801ab8:	74 0d                	je     801ac7 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801aba:	ff 45 08             	incl   0x8(%ebp)
  801abd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801ac3:	72 e3                	jb     801aa8 <memfind+0x13>
  801ac5:	eb 01                	jmp    801ac8 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801ac7:	90                   	nop
	return (void *) s;
  801ac8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801acb:	c9                   	leave  
  801acc:	c3                   	ret    

00801acd <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801acd:	55                   	push   %ebp
  801ace:	89 e5                	mov    %esp,%ebp
  801ad0:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801ad3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801ada:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801ae1:	eb 03                	jmp    801ae6 <strtol+0x19>
		s++;
  801ae3:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae9:	8a 00                	mov    (%eax),%al
  801aeb:	3c 20                	cmp    $0x20,%al
  801aed:	74 f4                	je     801ae3 <strtol+0x16>
  801aef:	8b 45 08             	mov    0x8(%ebp),%eax
  801af2:	8a 00                	mov    (%eax),%al
  801af4:	3c 09                	cmp    $0x9,%al
  801af6:	74 eb                	je     801ae3 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801af8:	8b 45 08             	mov    0x8(%ebp),%eax
  801afb:	8a 00                	mov    (%eax),%al
  801afd:	3c 2b                	cmp    $0x2b,%al
  801aff:	75 05                	jne    801b06 <strtol+0x39>
		s++;
  801b01:	ff 45 08             	incl   0x8(%ebp)
  801b04:	eb 13                	jmp    801b19 <strtol+0x4c>
	else if (*s == '-')
  801b06:	8b 45 08             	mov    0x8(%ebp),%eax
  801b09:	8a 00                	mov    (%eax),%al
  801b0b:	3c 2d                	cmp    $0x2d,%al
  801b0d:	75 0a                	jne    801b19 <strtol+0x4c>
		s++, neg = 1;
  801b0f:	ff 45 08             	incl   0x8(%ebp)
  801b12:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801b19:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801b1d:	74 06                	je     801b25 <strtol+0x58>
  801b1f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801b23:	75 20                	jne    801b45 <strtol+0x78>
  801b25:	8b 45 08             	mov    0x8(%ebp),%eax
  801b28:	8a 00                	mov    (%eax),%al
  801b2a:	3c 30                	cmp    $0x30,%al
  801b2c:	75 17                	jne    801b45 <strtol+0x78>
  801b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b31:	40                   	inc    %eax
  801b32:	8a 00                	mov    (%eax),%al
  801b34:	3c 78                	cmp    $0x78,%al
  801b36:	75 0d                	jne    801b45 <strtol+0x78>
		s += 2, base = 16;
  801b38:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801b3c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801b43:	eb 28                	jmp    801b6d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801b45:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801b49:	75 15                	jne    801b60 <strtol+0x93>
  801b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4e:	8a 00                	mov    (%eax),%al
  801b50:	3c 30                	cmp    $0x30,%al
  801b52:	75 0c                	jne    801b60 <strtol+0x93>
		s++, base = 8;
  801b54:	ff 45 08             	incl   0x8(%ebp)
  801b57:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801b5e:	eb 0d                	jmp    801b6d <strtol+0xa0>
	else if (base == 0)
  801b60:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801b64:	75 07                	jne    801b6d <strtol+0xa0>
		base = 10;
  801b66:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b70:	8a 00                	mov    (%eax),%al
  801b72:	3c 2f                	cmp    $0x2f,%al
  801b74:	7e 19                	jle    801b8f <strtol+0xc2>
  801b76:	8b 45 08             	mov    0x8(%ebp),%eax
  801b79:	8a 00                	mov    (%eax),%al
  801b7b:	3c 39                	cmp    $0x39,%al
  801b7d:	7f 10                	jg     801b8f <strtol+0xc2>
			dig = *s - '0';
  801b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b82:	8a 00                	mov    (%eax),%al
  801b84:	0f be c0             	movsbl %al,%eax
  801b87:	83 e8 30             	sub    $0x30,%eax
  801b8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801b8d:	eb 42                	jmp    801bd1 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b92:	8a 00                	mov    (%eax),%al
  801b94:	3c 60                	cmp    $0x60,%al
  801b96:	7e 19                	jle    801bb1 <strtol+0xe4>
  801b98:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9b:	8a 00                	mov    (%eax),%al
  801b9d:	3c 7a                	cmp    $0x7a,%al
  801b9f:	7f 10                	jg     801bb1 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba4:	8a 00                	mov    (%eax),%al
  801ba6:	0f be c0             	movsbl %al,%eax
  801ba9:	83 e8 57             	sub    $0x57,%eax
  801bac:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801baf:	eb 20                	jmp    801bd1 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb4:	8a 00                	mov    (%eax),%al
  801bb6:	3c 40                	cmp    $0x40,%al
  801bb8:	7e 39                	jle    801bf3 <strtol+0x126>
  801bba:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbd:	8a 00                	mov    (%eax),%al
  801bbf:	3c 5a                	cmp    $0x5a,%al
  801bc1:	7f 30                	jg     801bf3 <strtol+0x126>
			dig = *s - 'A' + 10;
  801bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc6:	8a 00                	mov    (%eax),%al
  801bc8:	0f be c0             	movsbl %al,%eax
  801bcb:	83 e8 37             	sub    $0x37,%eax
  801bce:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801bd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bd4:	3b 45 10             	cmp    0x10(%ebp),%eax
  801bd7:	7d 19                	jge    801bf2 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801bd9:	ff 45 08             	incl   0x8(%ebp)
  801bdc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bdf:	0f af 45 10          	imul   0x10(%ebp),%eax
  801be3:	89 c2                	mov    %eax,%edx
  801be5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801be8:	01 d0                	add    %edx,%eax
  801bea:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801bed:	e9 7b ff ff ff       	jmp    801b6d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801bf2:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801bf3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801bf7:	74 08                	je     801c01 <strtol+0x134>
		*endptr = (char *) s;
  801bf9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bfc:	8b 55 08             	mov    0x8(%ebp),%edx
  801bff:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801c01:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801c05:	74 07                	je     801c0e <strtol+0x141>
  801c07:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c0a:	f7 d8                	neg    %eax
  801c0c:	eb 03                	jmp    801c11 <strtol+0x144>
  801c0e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801c11:	c9                   	leave  
  801c12:	c3                   	ret    

00801c13 <ltostr>:

void
ltostr(long value, char *str)
{
  801c13:	55                   	push   %ebp
  801c14:	89 e5                	mov    %esp,%ebp
  801c16:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801c19:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801c20:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801c27:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801c2b:	79 13                	jns    801c40 <ltostr+0x2d>
	{
		neg = 1;
  801c2d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801c34:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c37:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801c3a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801c3d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801c40:	8b 45 08             	mov    0x8(%ebp),%eax
  801c43:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801c48:	99                   	cltd   
  801c49:	f7 f9                	idiv   %ecx
  801c4b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801c4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c51:	8d 50 01             	lea    0x1(%eax),%edx
  801c54:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801c57:	89 c2                	mov    %eax,%edx
  801c59:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c5c:	01 d0                	add    %edx,%eax
  801c5e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801c61:	83 c2 30             	add    $0x30,%edx
  801c64:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801c66:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c69:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801c6e:	f7 e9                	imul   %ecx
  801c70:	c1 fa 02             	sar    $0x2,%edx
  801c73:	89 c8                	mov    %ecx,%eax
  801c75:	c1 f8 1f             	sar    $0x1f,%eax
  801c78:	29 c2                	sub    %eax,%edx
  801c7a:	89 d0                	mov    %edx,%eax
  801c7c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801c7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c82:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801c87:	f7 e9                	imul   %ecx
  801c89:	c1 fa 02             	sar    $0x2,%edx
  801c8c:	89 c8                	mov    %ecx,%eax
  801c8e:	c1 f8 1f             	sar    $0x1f,%eax
  801c91:	29 c2                	sub    %eax,%edx
  801c93:	89 d0                	mov    %edx,%eax
  801c95:	c1 e0 02             	shl    $0x2,%eax
  801c98:	01 d0                	add    %edx,%eax
  801c9a:	01 c0                	add    %eax,%eax
  801c9c:	29 c1                	sub    %eax,%ecx
  801c9e:	89 ca                	mov    %ecx,%edx
  801ca0:	85 d2                	test   %edx,%edx
  801ca2:	75 9c                	jne    801c40 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801ca4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801cab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cae:	48                   	dec    %eax
  801caf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801cb2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801cb6:	74 3d                	je     801cf5 <ltostr+0xe2>
		start = 1 ;
  801cb8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801cbf:	eb 34                	jmp    801cf5 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801cc1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801cc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cc7:	01 d0                	add    %edx,%eax
  801cc9:	8a 00                	mov    (%eax),%al
  801ccb:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801cce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801cd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cd4:	01 c2                	add    %eax,%edx
  801cd6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801cd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cdc:	01 c8                	add    %ecx,%eax
  801cde:	8a 00                	mov    (%eax),%al
  801ce0:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801ce2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801ce5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ce8:	01 c2                	add    %eax,%edx
  801cea:	8a 45 eb             	mov    -0x15(%ebp),%al
  801ced:	88 02                	mov    %al,(%edx)
		start++ ;
  801cef:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801cf2:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801cf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cf8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801cfb:	7c c4                	jl     801cc1 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801cfd:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801d00:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d03:	01 d0                	add    %edx,%eax
  801d05:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801d08:	90                   	nop
  801d09:	c9                   	leave  
  801d0a:	c3                   	ret    

00801d0b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801d0b:	55                   	push   %ebp
  801d0c:	89 e5                	mov    %esp,%ebp
  801d0e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801d11:	ff 75 08             	pushl  0x8(%ebp)
  801d14:	e8 54 fa ff ff       	call   80176d <strlen>
  801d19:	83 c4 04             	add    $0x4,%esp
  801d1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801d1f:	ff 75 0c             	pushl  0xc(%ebp)
  801d22:	e8 46 fa ff ff       	call   80176d <strlen>
  801d27:	83 c4 04             	add    $0x4,%esp
  801d2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801d2d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801d34:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801d3b:	eb 17                	jmp    801d54 <strcconcat+0x49>
		final[s] = str1[s] ;
  801d3d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d40:	8b 45 10             	mov    0x10(%ebp),%eax
  801d43:	01 c2                	add    %eax,%edx
  801d45:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801d48:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4b:	01 c8                	add    %ecx,%eax
  801d4d:	8a 00                	mov    (%eax),%al
  801d4f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801d51:	ff 45 fc             	incl   -0x4(%ebp)
  801d54:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d57:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801d5a:	7c e1                	jl     801d3d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801d5c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801d63:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801d6a:	eb 1f                	jmp    801d8b <strcconcat+0x80>
		final[s++] = str2[i] ;
  801d6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801d6f:	8d 50 01             	lea    0x1(%eax),%edx
  801d72:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801d75:	89 c2                	mov    %eax,%edx
  801d77:	8b 45 10             	mov    0x10(%ebp),%eax
  801d7a:	01 c2                	add    %eax,%edx
  801d7c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801d7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d82:	01 c8                	add    %ecx,%eax
  801d84:	8a 00                	mov    (%eax),%al
  801d86:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801d88:	ff 45 f8             	incl   -0x8(%ebp)
  801d8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d8e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801d91:	7c d9                	jl     801d6c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801d93:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d96:	8b 45 10             	mov    0x10(%ebp),%eax
  801d99:	01 d0                	add    %edx,%eax
  801d9b:	c6 00 00             	movb   $0x0,(%eax)
}
  801d9e:	90                   	nop
  801d9f:	c9                   	leave  
  801da0:	c3                   	ret    

00801da1 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801da1:	55                   	push   %ebp
  801da2:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801da4:	8b 45 14             	mov    0x14(%ebp),%eax
  801da7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801dad:	8b 45 14             	mov    0x14(%ebp),%eax
  801db0:	8b 00                	mov    (%eax),%eax
  801db2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801db9:	8b 45 10             	mov    0x10(%ebp),%eax
  801dbc:	01 d0                	add    %edx,%eax
  801dbe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801dc4:	eb 0c                	jmp    801dd2 <strsplit+0x31>
			*string++ = 0;
  801dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc9:	8d 50 01             	lea    0x1(%eax),%edx
  801dcc:	89 55 08             	mov    %edx,0x8(%ebp)
  801dcf:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd5:	8a 00                	mov    (%eax),%al
  801dd7:	84 c0                	test   %al,%al
  801dd9:	74 18                	je     801df3 <strsplit+0x52>
  801ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dde:	8a 00                	mov    (%eax),%al
  801de0:	0f be c0             	movsbl %al,%eax
  801de3:	50                   	push   %eax
  801de4:	ff 75 0c             	pushl  0xc(%ebp)
  801de7:	e8 13 fb ff ff       	call   8018ff <strchr>
  801dec:	83 c4 08             	add    $0x8,%esp
  801def:	85 c0                	test   %eax,%eax
  801df1:	75 d3                	jne    801dc6 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801df3:	8b 45 08             	mov    0x8(%ebp),%eax
  801df6:	8a 00                	mov    (%eax),%al
  801df8:	84 c0                	test   %al,%al
  801dfa:	74 5a                	je     801e56 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801dfc:	8b 45 14             	mov    0x14(%ebp),%eax
  801dff:	8b 00                	mov    (%eax),%eax
  801e01:	83 f8 0f             	cmp    $0xf,%eax
  801e04:	75 07                	jne    801e0d <strsplit+0x6c>
		{
			return 0;
  801e06:	b8 00 00 00 00       	mov    $0x0,%eax
  801e0b:	eb 66                	jmp    801e73 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801e0d:	8b 45 14             	mov    0x14(%ebp),%eax
  801e10:	8b 00                	mov    (%eax),%eax
  801e12:	8d 48 01             	lea    0x1(%eax),%ecx
  801e15:	8b 55 14             	mov    0x14(%ebp),%edx
  801e18:	89 0a                	mov    %ecx,(%edx)
  801e1a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e21:	8b 45 10             	mov    0x10(%ebp),%eax
  801e24:	01 c2                	add    %eax,%edx
  801e26:	8b 45 08             	mov    0x8(%ebp),%eax
  801e29:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801e2b:	eb 03                	jmp    801e30 <strsplit+0x8f>
			string++;
  801e2d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801e30:	8b 45 08             	mov    0x8(%ebp),%eax
  801e33:	8a 00                	mov    (%eax),%al
  801e35:	84 c0                	test   %al,%al
  801e37:	74 8b                	je     801dc4 <strsplit+0x23>
  801e39:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3c:	8a 00                	mov    (%eax),%al
  801e3e:	0f be c0             	movsbl %al,%eax
  801e41:	50                   	push   %eax
  801e42:	ff 75 0c             	pushl  0xc(%ebp)
  801e45:	e8 b5 fa ff ff       	call   8018ff <strchr>
  801e4a:	83 c4 08             	add    $0x8,%esp
  801e4d:	85 c0                	test   %eax,%eax
  801e4f:	74 dc                	je     801e2d <strsplit+0x8c>
			string++;
	}
  801e51:	e9 6e ff ff ff       	jmp    801dc4 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801e56:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801e57:	8b 45 14             	mov    0x14(%ebp),%eax
  801e5a:	8b 00                	mov    (%eax),%eax
  801e5c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e63:	8b 45 10             	mov    0x10(%ebp),%eax
  801e66:	01 d0                	add    %edx,%eax
  801e68:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801e6e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801e73:	c9                   	leave  
  801e74:	c3                   	ret    

00801e75 <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  801e75:	55                   	push   %ebp
  801e76:	89 e5                	mov    %esp,%ebp
  801e78:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7e:	c1 e8 0c             	shr    $0xc,%eax
  801e81:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801e84:	8b 45 08             	mov    0x8(%ebp),%eax
  801e87:	25 ff 0f 00 00       	and    $0xfff,%eax
  801e8c:	85 c0                	test   %eax,%eax
  801e8e:	74 03                	je     801e93 <malloc+0x1e>
			num++;
  801e90:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801e93:	a1 04 40 80 00       	mov    0x804004,%eax
  801e98:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801e9d:	75 73                	jne    801f12 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801e9f:	83 ec 08             	sub    $0x8,%esp
  801ea2:	ff 75 08             	pushl  0x8(%ebp)
  801ea5:	68 00 00 00 80       	push   $0x80000000
  801eaa:	e8 80 04 00 00       	call   80232f <sys_allocateMem>
  801eaf:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801eb2:	a1 04 40 80 00       	mov    0x804004,%eax
  801eb7:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801eba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ebd:	c1 e0 0c             	shl    $0xc,%eax
  801ec0:	89 c2                	mov    %eax,%edx
  801ec2:	a1 04 40 80 00       	mov    0x804004,%eax
  801ec7:	01 d0                	add    %edx,%eax
  801ec9:	a3 04 40 80 00       	mov    %eax,0x804004
			numOfPages[sizeofarray]=num;
  801ece:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801ed3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801ed6:	89 14 85 60 60 80 00 	mov    %edx,0x806060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  801edd:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801ee2:	8b 15 04 40 80 00    	mov    0x804004,%edx
  801ee8:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			changed[sizeofarray]=1;
  801eef:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801ef4:	c7 04 85 c0 50 80 00 	movl   $0x1,0x8050c0(,%eax,4)
  801efb:	01 00 00 00 
			sizeofarray++;
  801eff:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f04:	40                   	inc    %eax
  801f05:	a3 2c 40 80 00       	mov    %eax,0x80402c
			return (void*)return_addres;
  801f0a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801f0d:	e9 71 01 00 00       	jmp    802083 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801f12:	a1 28 40 80 00       	mov    0x804028,%eax
  801f17:	85 c0                	test   %eax,%eax
  801f19:	75 71                	jne    801f8c <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801f1b:	a1 04 40 80 00       	mov    0x804004,%eax
  801f20:	83 ec 08             	sub    $0x8,%esp
  801f23:	ff 75 08             	pushl  0x8(%ebp)
  801f26:	50                   	push   %eax
  801f27:	e8 03 04 00 00       	call   80232f <sys_allocateMem>
  801f2c:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801f2f:	a1 04 40 80 00       	mov    0x804004,%eax
  801f34:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801f37:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f3a:	c1 e0 0c             	shl    $0xc,%eax
  801f3d:	89 c2                	mov    %eax,%edx
  801f3f:	a1 04 40 80 00       	mov    0x804004,%eax
  801f44:	01 d0                	add    %edx,%eax
  801f46:	a3 04 40 80 00       	mov    %eax,0x804004
				numOfPages[sizeofarray]=num;
  801f4b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f50:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801f53:	89 14 85 60 60 80 00 	mov    %edx,0x806060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801f5a:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f5f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801f62:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  801f69:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f6e:	c7 04 85 c0 50 80 00 	movl   $0x1,0x8050c0(,%eax,4)
  801f75:	01 00 00 00 
				sizeofarray++;
  801f79:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f7e:	40                   	inc    %eax
  801f7f:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return (void*)return_addres;
  801f84:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801f87:	e9 f7 00 00 00       	jmp    802083 <malloc+0x20e>
			}
			else{
				int count=0;
  801f8c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801f93:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801f9a:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801fa1:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801fa8:	eb 7c                	jmp    802026 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  801faa:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801fb1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801fb8:	eb 1a                	jmp    801fd4 <malloc+0x15f>
					{
						if(addresses[j]==i)
  801fba:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801fbd:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801fc4:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801fc7:	75 08                	jne    801fd1 <malloc+0x15c>
						{
							index=j;
  801fc9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801fcc:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801fcf:	eb 0d                	jmp    801fde <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801fd1:	ff 45 dc             	incl   -0x24(%ebp)
  801fd4:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801fd9:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801fdc:	7c dc                	jl     801fba <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801fde:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801fe2:	75 05                	jne    801fe9 <malloc+0x174>
					{
						count++;
  801fe4:	ff 45 f0             	incl   -0x10(%ebp)
  801fe7:	eb 36                	jmp    80201f <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801fe9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801fec:	8b 04 85 c0 50 80 00 	mov    0x8050c0(,%eax,4),%eax
  801ff3:	85 c0                	test   %eax,%eax
  801ff5:	75 05                	jne    801ffc <malloc+0x187>
						{
							count++;
  801ff7:	ff 45 f0             	incl   -0x10(%ebp)
  801ffa:	eb 23                	jmp    80201f <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801ffc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fff:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  802002:	7d 14                	jge    802018 <malloc+0x1a3>
  802004:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802007:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80200a:	7c 0c                	jl     802018 <malloc+0x1a3>
							{
								min=count;
  80200c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80200f:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  802012:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802015:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  802018:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80201f:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  802026:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  80202d:	0f 86 77 ff ff ff    	jbe    801faa <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  802033:	83 ec 08             	sub    $0x8,%esp
  802036:	ff 75 08             	pushl  0x8(%ebp)
  802039:	ff 75 e4             	pushl  -0x1c(%ebp)
  80203c:	e8 ee 02 00 00       	call   80232f <sys_allocateMem>
  802041:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  802044:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802049:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80204c:	89 14 85 60 60 80 00 	mov    %edx,0x806060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  802053:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802058:	8b 15 04 40 80 00    	mov    0x804004,%edx
  80205e:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  802065:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80206a:	c7 04 85 c0 50 80 00 	movl   $0x1,0x8050c0(,%eax,4)
  802071:	01 00 00 00 
				sizeofarray++;
  802075:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80207a:	40                   	inc    %eax
  80207b:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return(void*) min_addresss;
  802080:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  802083:	c9                   	leave  
  802084:	c3                   	ret    

00802085 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  802085:	55                   	push   %ebp
  802086:	89 e5                	mov    %esp,%ebp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details
}
  802088:	90                   	nop
  802089:	5d                   	pop    %ebp
  80208a:	c3                   	ret    

0080208b <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80208b:	55                   	push   %ebp
  80208c:	89 e5                	mov    %esp,%ebp
  80208e:	83 ec 18             	sub    $0x18,%esp
  802091:	8b 45 10             	mov    0x10(%ebp),%eax
  802094:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802097:	83 ec 04             	sub    $0x4,%esp
  80209a:	68 70 32 80 00       	push   $0x803270
  80209f:	68 8d 00 00 00       	push   $0x8d
  8020a4:	68 93 32 80 00       	push   $0x803293
  8020a9:	e8 9b ed ff ff       	call   800e49 <_panic>

008020ae <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8020ae:	55                   	push   %ebp
  8020af:	89 e5                	mov    %esp,%ebp
  8020b1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020b4:	83 ec 04             	sub    $0x4,%esp
  8020b7:	68 70 32 80 00       	push   $0x803270
  8020bc:	68 93 00 00 00       	push   $0x93
  8020c1:	68 93 32 80 00       	push   $0x803293
  8020c6:	e8 7e ed ff ff       	call   800e49 <_panic>

008020cb <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8020cb:	55                   	push   %ebp
  8020cc:	89 e5                	mov    %esp,%ebp
  8020ce:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020d1:	83 ec 04             	sub    $0x4,%esp
  8020d4:	68 70 32 80 00       	push   $0x803270
  8020d9:	68 99 00 00 00       	push   $0x99
  8020de:	68 93 32 80 00       	push   $0x803293
  8020e3:	e8 61 ed ff ff       	call   800e49 <_panic>

008020e8 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  8020e8:	55                   	push   %ebp
  8020e9:	89 e5                	mov    %esp,%ebp
  8020eb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020ee:	83 ec 04             	sub    $0x4,%esp
  8020f1:	68 70 32 80 00       	push   $0x803270
  8020f6:	68 9e 00 00 00       	push   $0x9e
  8020fb:	68 93 32 80 00       	push   $0x803293
  802100:	e8 44 ed ff ff       	call   800e49 <_panic>

00802105 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  802105:	55                   	push   %ebp
  802106:	89 e5                	mov    %esp,%ebp
  802108:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80210b:	83 ec 04             	sub    $0x4,%esp
  80210e:	68 70 32 80 00       	push   $0x803270
  802113:	68 a4 00 00 00       	push   $0xa4
  802118:	68 93 32 80 00       	push   $0x803293
  80211d:	e8 27 ed ff ff       	call   800e49 <_panic>

00802122 <shrink>:
}
void shrink(uint32 newSize)
{
  802122:	55                   	push   %ebp
  802123:	89 e5                	mov    %esp,%ebp
  802125:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802128:	83 ec 04             	sub    $0x4,%esp
  80212b:	68 70 32 80 00       	push   $0x803270
  802130:	68 a8 00 00 00       	push   $0xa8
  802135:	68 93 32 80 00       	push   $0x803293
  80213a:	e8 0a ed ff ff       	call   800e49 <_panic>

0080213f <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  80213f:	55                   	push   %ebp
  802140:	89 e5                	mov    %esp,%ebp
  802142:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802145:	83 ec 04             	sub    $0x4,%esp
  802148:	68 70 32 80 00       	push   $0x803270
  80214d:	68 ad 00 00 00       	push   $0xad
  802152:	68 93 32 80 00       	push   $0x803293
  802157:	e8 ed ec ff ff       	call   800e49 <_panic>

0080215c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80215c:	55                   	push   %ebp
  80215d:	89 e5                	mov    %esp,%ebp
  80215f:	57                   	push   %edi
  802160:	56                   	push   %esi
  802161:	53                   	push   %ebx
  802162:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802165:	8b 45 08             	mov    0x8(%ebp),%eax
  802168:	8b 55 0c             	mov    0xc(%ebp),%edx
  80216b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80216e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802171:	8b 7d 18             	mov    0x18(%ebp),%edi
  802174:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802177:	cd 30                	int    $0x30
  802179:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80217c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80217f:	83 c4 10             	add    $0x10,%esp
  802182:	5b                   	pop    %ebx
  802183:	5e                   	pop    %esi
  802184:	5f                   	pop    %edi
  802185:	5d                   	pop    %ebp
  802186:	c3                   	ret    

00802187 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802187:	55                   	push   %ebp
  802188:	89 e5                	mov    %esp,%ebp
  80218a:	83 ec 04             	sub    $0x4,%esp
  80218d:	8b 45 10             	mov    0x10(%ebp),%eax
  802190:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802193:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802197:	8b 45 08             	mov    0x8(%ebp),%eax
  80219a:	6a 00                	push   $0x0
  80219c:	6a 00                	push   $0x0
  80219e:	52                   	push   %edx
  80219f:	ff 75 0c             	pushl  0xc(%ebp)
  8021a2:	50                   	push   %eax
  8021a3:	6a 00                	push   $0x0
  8021a5:	e8 b2 ff ff ff       	call   80215c <syscall>
  8021aa:	83 c4 18             	add    $0x18,%esp
}
  8021ad:	90                   	nop
  8021ae:	c9                   	leave  
  8021af:	c3                   	ret    

008021b0 <sys_cgetc>:

int
sys_cgetc(void)
{
  8021b0:	55                   	push   %ebp
  8021b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8021b3:	6a 00                	push   $0x0
  8021b5:	6a 00                	push   $0x0
  8021b7:	6a 00                	push   $0x0
  8021b9:	6a 00                	push   $0x0
  8021bb:	6a 00                	push   $0x0
  8021bd:	6a 01                	push   $0x1
  8021bf:	e8 98 ff ff ff       	call   80215c <syscall>
  8021c4:	83 c4 18             	add    $0x18,%esp
}
  8021c7:	c9                   	leave  
  8021c8:	c3                   	ret    

008021c9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8021c9:	55                   	push   %ebp
  8021ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8021cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 00                	push   $0x0
  8021d3:	6a 00                	push   $0x0
  8021d5:	6a 00                	push   $0x0
  8021d7:	50                   	push   %eax
  8021d8:	6a 05                	push   $0x5
  8021da:	e8 7d ff ff ff       	call   80215c <syscall>
  8021df:	83 c4 18             	add    $0x18,%esp
}
  8021e2:	c9                   	leave  
  8021e3:	c3                   	ret    

008021e4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8021e4:	55                   	push   %ebp
  8021e5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8021e7:	6a 00                	push   $0x0
  8021e9:	6a 00                	push   $0x0
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 00                	push   $0x0
  8021f1:	6a 02                	push   $0x2
  8021f3:	e8 64 ff ff ff       	call   80215c <syscall>
  8021f8:	83 c4 18             	add    $0x18,%esp
}
  8021fb:	c9                   	leave  
  8021fc:	c3                   	ret    

008021fd <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8021fd:	55                   	push   %ebp
  8021fe:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802200:	6a 00                	push   $0x0
  802202:	6a 00                	push   $0x0
  802204:	6a 00                	push   $0x0
  802206:	6a 00                	push   $0x0
  802208:	6a 00                	push   $0x0
  80220a:	6a 03                	push   $0x3
  80220c:	e8 4b ff ff ff       	call   80215c <syscall>
  802211:	83 c4 18             	add    $0x18,%esp
}
  802214:	c9                   	leave  
  802215:	c3                   	ret    

00802216 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802216:	55                   	push   %ebp
  802217:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802219:	6a 00                	push   $0x0
  80221b:	6a 00                	push   $0x0
  80221d:	6a 00                	push   $0x0
  80221f:	6a 00                	push   $0x0
  802221:	6a 00                	push   $0x0
  802223:	6a 04                	push   $0x4
  802225:	e8 32 ff ff ff       	call   80215c <syscall>
  80222a:	83 c4 18             	add    $0x18,%esp
}
  80222d:	c9                   	leave  
  80222e:	c3                   	ret    

0080222f <sys_env_exit>:


void sys_env_exit(void)
{
  80222f:	55                   	push   %ebp
  802230:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802232:	6a 00                	push   $0x0
  802234:	6a 00                	push   $0x0
  802236:	6a 00                	push   $0x0
  802238:	6a 00                	push   $0x0
  80223a:	6a 00                	push   $0x0
  80223c:	6a 06                	push   $0x6
  80223e:	e8 19 ff ff ff       	call   80215c <syscall>
  802243:	83 c4 18             	add    $0x18,%esp
}
  802246:	90                   	nop
  802247:	c9                   	leave  
  802248:	c3                   	ret    

00802249 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802249:	55                   	push   %ebp
  80224a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80224c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80224f:	8b 45 08             	mov    0x8(%ebp),%eax
  802252:	6a 00                	push   $0x0
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	52                   	push   %edx
  802259:	50                   	push   %eax
  80225a:	6a 07                	push   $0x7
  80225c:	e8 fb fe ff ff       	call   80215c <syscall>
  802261:	83 c4 18             	add    $0x18,%esp
}
  802264:	c9                   	leave  
  802265:	c3                   	ret    

00802266 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802266:	55                   	push   %ebp
  802267:	89 e5                	mov    %esp,%ebp
  802269:	56                   	push   %esi
  80226a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80226b:	8b 75 18             	mov    0x18(%ebp),%esi
  80226e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802271:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802274:	8b 55 0c             	mov    0xc(%ebp),%edx
  802277:	8b 45 08             	mov    0x8(%ebp),%eax
  80227a:	56                   	push   %esi
  80227b:	53                   	push   %ebx
  80227c:	51                   	push   %ecx
  80227d:	52                   	push   %edx
  80227e:	50                   	push   %eax
  80227f:	6a 08                	push   $0x8
  802281:	e8 d6 fe ff ff       	call   80215c <syscall>
  802286:	83 c4 18             	add    $0x18,%esp
}
  802289:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80228c:	5b                   	pop    %ebx
  80228d:	5e                   	pop    %esi
  80228e:	5d                   	pop    %ebp
  80228f:	c3                   	ret    

00802290 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802290:	55                   	push   %ebp
  802291:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802293:	8b 55 0c             	mov    0xc(%ebp),%edx
  802296:	8b 45 08             	mov    0x8(%ebp),%eax
  802299:	6a 00                	push   $0x0
  80229b:	6a 00                	push   $0x0
  80229d:	6a 00                	push   $0x0
  80229f:	52                   	push   %edx
  8022a0:	50                   	push   %eax
  8022a1:	6a 09                	push   $0x9
  8022a3:	e8 b4 fe ff ff       	call   80215c <syscall>
  8022a8:	83 c4 18             	add    $0x18,%esp
}
  8022ab:	c9                   	leave  
  8022ac:	c3                   	ret    

008022ad <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8022ad:	55                   	push   %ebp
  8022ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8022b0:	6a 00                	push   $0x0
  8022b2:	6a 00                	push   $0x0
  8022b4:	6a 00                	push   $0x0
  8022b6:	ff 75 0c             	pushl  0xc(%ebp)
  8022b9:	ff 75 08             	pushl  0x8(%ebp)
  8022bc:	6a 0a                	push   $0xa
  8022be:	e8 99 fe ff ff       	call   80215c <syscall>
  8022c3:	83 c4 18             	add    $0x18,%esp
}
  8022c6:	c9                   	leave  
  8022c7:	c3                   	ret    

008022c8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8022c8:	55                   	push   %ebp
  8022c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8022cb:	6a 00                	push   $0x0
  8022cd:	6a 00                	push   $0x0
  8022cf:	6a 00                	push   $0x0
  8022d1:	6a 00                	push   $0x0
  8022d3:	6a 00                	push   $0x0
  8022d5:	6a 0b                	push   $0xb
  8022d7:	e8 80 fe ff ff       	call   80215c <syscall>
  8022dc:	83 c4 18             	add    $0x18,%esp
}
  8022df:	c9                   	leave  
  8022e0:	c3                   	ret    

008022e1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8022e1:	55                   	push   %ebp
  8022e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8022e4:	6a 00                	push   $0x0
  8022e6:	6a 00                	push   $0x0
  8022e8:	6a 00                	push   $0x0
  8022ea:	6a 00                	push   $0x0
  8022ec:	6a 00                	push   $0x0
  8022ee:	6a 0c                	push   $0xc
  8022f0:	e8 67 fe ff ff       	call   80215c <syscall>
  8022f5:	83 c4 18             	add    $0x18,%esp
}
  8022f8:	c9                   	leave  
  8022f9:	c3                   	ret    

008022fa <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8022fa:	55                   	push   %ebp
  8022fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8022fd:	6a 00                	push   $0x0
  8022ff:	6a 00                	push   $0x0
  802301:	6a 00                	push   $0x0
  802303:	6a 00                	push   $0x0
  802305:	6a 00                	push   $0x0
  802307:	6a 0d                	push   $0xd
  802309:	e8 4e fe ff ff       	call   80215c <syscall>
  80230e:	83 c4 18             	add    $0x18,%esp
}
  802311:	c9                   	leave  
  802312:	c3                   	ret    

00802313 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802313:	55                   	push   %ebp
  802314:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802316:	6a 00                	push   $0x0
  802318:	6a 00                	push   $0x0
  80231a:	6a 00                	push   $0x0
  80231c:	ff 75 0c             	pushl  0xc(%ebp)
  80231f:	ff 75 08             	pushl  0x8(%ebp)
  802322:	6a 11                	push   $0x11
  802324:	e8 33 fe ff ff       	call   80215c <syscall>
  802329:	83 c4 18             	add    $0x18,%esp
	return;
  80232c:	90                   	nop
}
  80232d:	c9                   	leave  
  80232e:	c3                   	ret    

0080232f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80232f:	55                   	push   %ebp
  802330:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802332:	6a 00                	push   $0x0
  802334:	6a 00                	push   $0x0
  802336:	6a 00                	push   $0x0
  802338:	ff 75 0c             	pushl  0xc(%ebp)
  80233b:	ff 75 08             	pushl  0x8(%ebp)
  80233e:	6a 12                	push   $0x12
  802340:	e8 17 fe ff ff       	call   80215c <syscall>
  802345:	83 c4 18             	add    $0x18,%esp
	return ;
  802348:	90                   	nop
}
  802349:	c9                   	leave  
  80234a:	c3                   	ret    

0080234b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80234b:	55                   	push   %ebp
  80234c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80234e:	6a 00                	push   $0x0
  802350:	6a 00                	push   $0x0
  802352:	6a 00                	push   $0x0
  802354:	6a 00                	push   $0x0
  802356:	6a 00                	push   $0x0
  802358:	6a 0e                	push   $0xe
  80235a:	e8 fd fd ff ff       	call   80215c <syscall>
  80235f:	83 c4 18             	add    $0x18,%esp
}
  802362:	c9                   	leave  
  802363:	c3                   	ret    

00802364 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802364:	55                   	push   %ebp
  802365:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802367:	6a 00                	push   $0x0
  802369:	6a 00                	push   $0x0
  80236b:	6a 00                	push   $0x0
  80236d:	6a 00                	push   $0x0
  80236f:	ff 75 08             	pushl  0x8(%ebp)
  802372:	6a 0f                	push   $0xf
  802374:	e8 e3 fd ff ff       	call   80215c <syscall>
  802379:	83 c4 18             	add    $0x18,%esp
}
  80237c:	c9                   	leave  
  80237d:	c3                   	ret    

0080237e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80237e:	55                   	push   %ebp
  80237f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802381:	6a 00                	push   $0x0
  802383:	6a 00                	push   $0x0
  802385:	6a 00                	push   $0x0
  802387:	6a 00                	push   $0x0
  802389:	6a 00                	push   $0x0
  80238b:	6a 10                	push   $0x10
  80238d:	e8 ca fd ff ff       	call   80215c <syscall>
  802392:	83 c4 18             	add    $0x18,%esp
}
  802395:	90                   	nop
  802396:	c9                   	leave  
  802397:	c3                   	ret    

00802398 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802398:	55                   	push   %ebp
  802399:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80239b:	6a 00                	push   $0x0
  80239d:	6a 00                	push   $0x0
  80239f:	6a 00                	push   $0x0
  8023a1:	6a 00                	push   $0x0
  8023a3:	6a 00                	push   $0x0
  8023a5:	6a 14                	push   $0x14
  8023a7:	e8 b0 fd ff ff       	call   80215c <syscall>
  8023ac:	83 c4 18             	add    $0x18,%esp
}
  8023af:	90                   	nop
  8023b0:	c9                   	leave  
  8023b1:	c3                   	ret    

008023b2 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8023b2:	55                   	push   %ebp
  8023b3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8023b5:	6a 00                	push   $0x0
  8023b7:	6a 00                	push   $0x0
  8023b9:	6a 00                	push   $0x0
  8023bb:	6a 00                	push   $0x0
  8023bd:	6a 00                	push   $0x0
  8023bf:	6a 15                	push   $0x15
  8023c1:	e8 96 fd ff ff       	call   80215c <syscall>
  8023c6:	83 c4 18             	add    $0x18,%esp
}
  8023c9:	90                   	nop
  8023ca:	c9                   	leave  
  8023cb:	c3                   	ret    

008023cc <sys_cputc>:


void
sys_cputc(const char c)
{
  8023cc:	55                   	push   %ebp
  8023cd:	89 e5                	mov    %esp,%ebp
  8023cf:	83 ec 04             	sub    $0x4,%esp
  8023d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8023d5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8023d8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8023dc:	6a 00                	push   $0x0
  8023de:	6a 00                	push   $0x0
  8023e0:	6a 00                	push   $0x0
  8023e2:	6a 00                	push   $0x0
  8023e4:	50                   	push   %eax
  8023e5:	6a 16                	push   $0x16
  8023e7:	e8 70 fd ff ff       	call   80215c <syscall>
  8023ec:	83 c4 18             	add    $0x18,%esp
}
  8023ef:	90                   	nop
  8023f0:	c9                   	leave  
  8023f1:	c3                   	ret    

008023f2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8023f2:	55                   	push   %ebp
  8023f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8023f5:	6a 00                	push   $0x0
  8023f7:	6a 00                	push   $0x0
  8023f9:	6a 00                	push   $0x0
  8023fb:	6a 00                	push   $0x0
  8023fd:	6a 00                	push   $0x0
  8023ff:	6a 17                	push   $0x17
  802401:	e8 56 fd ff ff       	call   80215c <syscall>
  802406:	83 c4 18             	add    $0x18,%esp
}
  802409:	90                   	nop
  80240a:	c9                   	leave  
  80240b:	c3                   	ret    

0080240c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80240c:	55                   	push   %ebp
  80240d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80240f:	8b 45 08             	mov    0x8(%ebp),%eax
  802412:	6a 00                	push   $0x0
  802414:	6a 00                	push   $0x0
  802416:	6a 00                	push   $0x0
  802418:	ff 75 0c             	pushl  0xc(%ebp)
  80241b:	50                   	push   %eax
  80241c:	6a 18                	push   $0x18
  80241e:	e8 39 fd ff ff       	call   80215c <syscall>
  802423:	83 c4 18             	add    $0x18,%esp
}
  802426:	c9                   	leave  
  802427:	c3                   	ret    

00802428 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802428:	55                   	push   %ebp
  802429:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80242b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80242e:	8b 45 08             	mov    0x8(%ebp),%eax
  802431:	6a 00                	push   $0x0
  802433:	6a 00                	push   $0x0
  802435:	6a 00                	push   $0x0
  802437:	52                   	push   %edx
  802438:	50                   	push   %eax
  802439:	6a 1b                	push   $0x1b
  80243b:	e8 1c fd ff ff       	call   80215c <syscall>
  802440:	83 c4 18             	add    $0x18,%esp
}
  802443:	c9                   	leave  
  802444:	c3                   	ret    

00802445 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802445:	55                   	push   %ebp
  802446:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802448:	8b 55 0c             	mov    0xc(%ebp),%edx
  80244b:	8b 45 08             	mov    0x8(%ebp),%eax
  80244e:	6a 00                	push   $0x0
  802450:	6a 00                	push   $0x0
  802452:	6a 00                	push   $0x0
  802454:	52                   	push   %edx
  802455:	50                   	push   %eax
  802456:	6a 19                	push   $0x19
  802458:	e8 ff fc ff ff       	call   80215c <syscall>
  80245d:	83 c4 18             	add    $0x18,%esp
}
  802460:	90                   	nop
  802461:	c9                   	leave  
  802462:	c3                   	ret    

00802463 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802463:	55                   	push   %ebp
  802464:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802466:	8b 55 0c             	mov    0xc(%ebp),%edx
  802469:	8b 45 08             	mov    0x8(%ebp),%eax
  80246c:	6a 00                	push   $0x0
  80246e:	6a 00                	push   $0x0
  802470:	6a 00                	push   $0x0
  802472:	52                   	push   %edx
  802473:	50                   	push   %eax
  802474:	6a 1a                	push   $0x1a
  802476:	e8 e1 fc ff ff       	call   80215c <syscall>
  80247b:	83 c4 18             	add    $0x18,%esp
}
  80247e:	90                   	nop
  80247f:	c9                   	leave  
  802480:	c3                   	ret    

00802481 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802481:	55                   	push   %ebp
  802482:	89 e5                	mov    %esp,%ebp
  802484:	83 ec 04             	sub    $0x4,%esp
  802487:	8b 45 10             	mov    0x10(%ebp),%eax
  80248a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80248d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802490:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802494:	8b 45 08             	mov    0x8(%ebp),%eax
  802497:	6a 00                	push   $0x0
  802499:	51                   	push   %ecx
  80249a:	52                   	push   %edx
  80249b:	ff 75 0c             	pushl  0xc(%ebp)
  80249e:	50                   	push   %eax
  80249f:	6a 1c                	push   $0x1c
  8024a1:	e8 b6 fc ff ff       	call   80215c <syscall>
  8024a6:	83 c4 18             	add    $0x18,%esp
}
  8024a9:	c9                   	leave  
  8024aa:	c3                   	ret    

008024ab <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8024ab:	55                   	push   %ebp
  8024ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8024ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b4:	6a 00                	push   $0x0
  8024b6:	6a 00                	push   $0x0
  8024b8:	6a 00                	push   $0x0
  8024ba:	52                   	push   %edx
  8024bb:	50                   	push   %eax
  8024bc:	6a 1d                	push   $0x1d
  8024be:	e8 99 fc ff ff       	call   80215c <syscall>
  8024c3:	83 c4 18             	add    $0x18,%esp
}
  8024c6:	c9                   	leave  
  8024c7:	c3                   	ret    

008024c8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8024c8:	55                   	push   %ebp
  8024c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8024cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8024ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8024d4:	6a 00                	push   $0x0
  8024d6:	6a 00                	push   $0x0
  8024d8:	51                   	push   %ecx
  8024d9:	52                   	push   %edx
  8024da:	50                   	push   %eax
  8024db:	6a 1e                	push   $0x1e
  8024dd:	e8 7a fc ff ff       	call   80215c <syscall>
  8024e2:	83 c4 18             	add    $0x18,%esp
}
  8024e5:	c9                   	leave  
  8024e6:	c3                   	ret    

008024e7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8024e7:	55                   	push   %ebp
  8024e8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8024ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8024f0:	6a 00                	push   $0x0
  8024f2:	6a 00                	push   $0x0
  8024f4:	6a 00                	push   $0x0
  8024f6:	52                   	push   %edx
  8024f7:	50                   	push   %eax
  8024f8:	6a 1f                	push   $0x1f
  8024fa:	e8 5d fc ff ff       	call   80215c <syscall>
  8024ff:	83 c4 18             	add    $0x18,%esp
}
  802502:	c9                   	leave  
  802503:	c3                   	ret    

00802504 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802504:	55                   	push   %ebp
  802505:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802507:	6a 00                	push   $0x0
  802509:	6a 00                	push   $0x0
  80250b:	6a 00                	push   $0x0
  80250d:	6a 00                	push   $0x0
  80250f:	6a 00                	push   $0x0
  802511:	6a 20                	push   $0x20
  802513:	e8 44 fc ff ff       	call   80215c <syscall>
  802518:	83 c4 18             	add    $0x18,%esp
}
  80251b:	c9                   	leave  
  80251c:	c3                   	ret    

0080251d <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80251d:	55                   	push   %ebp
  80251e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802520:	8b 45 08             	mov    0x8(%ebp),%eax
  802523:	6a 00                	push   $0x0
  802525:	ff 75 14             	pushl  0x14(%ebp)
  802528:	ff 75 10             	pushl  0x10(%ebp)
  80252b:	ff 75 0c             	pushl  0xc(%ebp)
  80252e:	50                   	push   %eax
  80252f:	6a 21                	push   $0x21
  802531:	e8 26 fc ff ff       	call   80215c <syscall>
  802536:	83 c4 18             	add    $0x18,%esp
}
  802539:	c9                   	leave  
  80253a:	c3                   	ret    

0080253b <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80253b:	55                   	push   %ebp
  80253c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80253e:	8b 45 08             	mov    0x8(%ebp),%eax
  802541:	6a 00                	push   $0x0
  802543:	6a 00                	push   $0x0
  802545:	6a 00                	push   $0x0
  802547:	6a 00                	push   $0x0
  802549:	50                   	push   %eax
  80254a:	6a 22                	push   $0x22
  80254c:	e8 0b fc ff ff       	call   80215c <syscall>
  802551:	83 c4 18             	add    $0x18,%esp
}
  802554:	90                   	nop
  802555:	c9                   	leave  
  802556:	c3                   	ret    

00802557 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802557:	55                   	push   %ebp
  802558:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80255a:	8b 45 08             	mov    0x8(%ebp),%eax
  80255d:	6a 00                	push   $0x0
  80255f:	6a 00                	push   $0x0
  802561:	6a 00                	push   $0x0
  802563:	6a 00                	push   $0x0
  802565:	50                   	push   %eax
  802566:	6a 23                	push   $0x23
  802568:	e8 ef fb ff ff       	call   80215c <syscall>
  80256d:	83 c4 18             	add    $0x18,%esp
}
  802570:	90                   	nop
  802571:	c9                   	leave  
  802572:	c3                   	ret    

00802573 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802573:	55                   	push   %ebp
  802574:	89 e5                	mov    %esp,%ebp
  802576:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802579:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80257c:	8d 50 04             	lea    0x4(%eax),%edx
  80257f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802582:	6a 00                	push   $0x0
  802584:	6a 00                	push   $0x0
  802586:	6a 00                	push   $0x0
  802588:	52                   	push   %edx
  802589:	50                   	push   %eax
  80258a:	6a 24                	push   $0x24
  80258c:	e8 cb fb ff ff       	call   80215c <syscall>
  802591:	83 c4 18             	add    $0x18,%esp
	return result;
  802594:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802597:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80259a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80259d:	89 01                	mov    %eax,(%ecx)
  80259f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8025a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8025a5:	c9                   	leave  
  8025a6:	c2 04 00             	ret    $0x4

008025a9 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8025a9:	55                   	push   %ebp
  8025aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8025ac:	6a 00                	push   $0x0
  8025ae:	6a 00                	push   $0x0
  8025b0:	ff 75 10             	pushl  0x10(%ebp)
  8025b3:	ff 75 0c             	pushl  0xc(%ebp)
  8025b6:	ff 75 08             	pushl  0x8(%ebp)
  8025b9:	6a 13                	push   $0x13
  8025bb:	e8 9c fb ff ff       	call   80215c <syscall>
  8025c0:	83 c4 18             	add    $0x18,%esp
	return ;
  8025c3:	90                   	nop
}
  8025c4:	c9                   	leave  
  8025c5:	c3                   	ret    

008025c6 <sys_rcr2>:
uint32 sys_rcr2()
{
  8025c6:	55                   	push   %ebp
  8025c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8025c9:	6a 00                	push   $0x0
  8025cb:	6a 00                	push   $0x0
  8025cd:	6a 00                	push   $0x0
  8025cf:	6a 00                	push   $0x0
  8025d1:	6a 00                	push   $0x0
  8025d3:	6a 25                	push   $0x25
  8025d5:	e8 82 fb ff ff       	call   80215c <syscall>
  8025da:	83 c4 18             	add    $0x18,%esp
}
  8025dd:	c9                   	leave  
  8025de:	c3                   	ret    

008025df <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8025df:	55                   	push   %ebp
  8025e0:	89 e5                	mov    %esp,%ebp
  8025e2:	83 ec 04             	sub    $0x4,%esp
  8025e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8025e8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8025eb:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8025ef:	6a 00                	push   $0x0
  8025f1:	6a 00                	push   $0x0
  8025f3:	6a 00                	push   $0x0
  8025f5:	6a 00                	push   $0x0
  8025f7:	50                   	push   %eax
  8025f8:	6a 26                	push   $0x26
  8025fa:	e8 5d fb ff ff       	call   80215c <syscall>
  8025ff:	83 c4 18             	add    $0x18,%esp
	return ;
  802602:	90                   	nop
}
  802603:	c9                   	leave  
  802604:	c3                   	ret    

00802605 <rsttst>:
void rsttst()
{
  802605:	55                   	push   %ebp
  802606:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802608:	6a 00                	push   $0x0
  80260a:	6a 00                	push   $0x0
  80260c:	6a 00                	push   $0x0
  80260e:	6a 00                	push   $0x0
  802610:	6a 00                	push   $0x0
  802612:	6a 28                	push   $0x28
  802614:	e8 43 fb ff ff       	call   80215c <syscall>
  802619:	83 c4 18             	add    $0x18,%esp
	return ;
  80261c:	90                   	nop
}
  80261d:	c9                   	leave  
  80261e:	c3                   	ret    

0080261f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80261f:	55                   	push   %ebp
  802620:	89 e5                	mov    %esp,%ebp
  802622:	83 ec 04             	sub    $0x4,%esp
  802625:	8b 45 14             	mov    0x14(%ebp),%eax
  802628:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80262b:	8b 55 18             	mov    0x18(%ebp),%edx
  80262e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802632:	52                   	push   %edx
  802633:	50                   	push   %eax
  802634:	ff 75 10             	pushl  0x10(%ebp)
  802637:	ff 75 0c             	pushl  0xc(%ebp)
  80263a:	ff 75 08             	pushl  0x8(%ebp)
  80263d:	6a 27                	push   $0x27
  80263f:	e8 18 fb ff ff       	call   80215c <syscall>
  802644:	83 c4 18             	add    $0x18,%esp
	return ;
  802647:	90                   	nop
}
  802648:	c9                   	leave  
  802649:	c3                   	ret    

0080264a <chktst>:
void chktst(uint32 n)
{
  80264a:	55                   	push   %ebp
  80264b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80264d:	6a 00                	push   $0x0
  80264f:	6a 00                	push   $0x0
  802651:	6a 00                	push   $0x0
  802653:	6a 00                	push   $0x0
  802655:	ff 75 08             	pushl  0x8(%ebp)
  802658:	6a 29                	push   $0x29
  80265a:	e8 fd fa ff ff       	call   80215c <syscall>
  80265f:	83 c4 18             	add    $0x18,%esp
	return ;
  802662:	90                   	nop
}
  802663:	c9                   	leave  
  802664:	c3                   	ret    

00802665 <inctst>:

void inctst()
{
  802665:	55                   	push   %ebp
  802666:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802668:	6a 00                	push   $0x0
  80266a:	6a 00                	push   $0x0
  80266c:	6a 00                	push   $0x0
  80266e:	6a 00                	push   $0x0
  802670:	6a 00                	push   $0x0
  802672:	6a 2a                	push   $0x2a
  802674:	e8 e3 fa ff ff       	call   80215c <syscall>
  802679:	83 c4 18             	add    $0x18,%esp
	return ;
  80267c:	90                   	nop
}
  80267d:	c9                   	leave  
  80267e:	c3                   	ret    

0080267f <gettst>:
uint32 gettst()
{
  80267f:	55                   	push   %ebp
  802680:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802682:	6a 00                	push   $0x0
  802684:	6a 00                	push   $0x0
  802686:	6a 00                	push   $0x0
  802688:	6a 00                	push   $0x0
  80268a:	6a 00                	push   $0x0
  80268c:	6a 2b                	push   $0x2b
  80268e:	e8 c9 fa ff ff       	call   80215c <syscall>
  802693:	83 c4 18             	add    $0x18,%esp
}
  802696:	c9                   	leave  
  802697:	c3                   	ret    

00802698 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802698:	55                   	push   %ebp
  802699:	89 e5                	mov    %esp,%ebp
  80269b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80269e:	6a 00                	push   $0x0
  8026a0:	6a 00                	push   $0x0
  8026a2:	6a 00                	push   $0x0
  8026a4:	6a 00                	push   $0x0
  8026a6:	6a 00                	push   $0x0
  8026a8:	6a 2c                	push   $0x2c
  8026aa:	e8 ad fa ff ff       	call   80215c <syscall>
  8026af:	83 c4 18             	add    $0x18,%esp
  8026b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8026b5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8026b9:	75 07                	jne    8026c2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8026bb:	b8 01 00 00 00       	mov    $0x1,%eax
  8026c0:	eb 05                	jmp    8026c7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8026c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026c7:	c9                   	leave  
  8026c8:	c3                   	ret    

008026c9 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8026c9:	55                   	push   %ebp
  8026ca:	89 e5                	mov    %esp,%ebp
  8026cc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8026cf:	6a 00                	push   $0x0
  8026d1:	6a 00                	push   $0x0
  8026d3:	6a 00                	push   $0x0
  8026d5:	6a 00                	push   $0x0
  8026d7:	6a 00                	push   $0x0
  8026d9:	6a 2c                	push   $0x2c
  8026db:	e8 7c fa ff ff       	call   80215c <syscall>
  8026e0:	83 c4 18             	add    $0x18,%esp
  8026e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8026e6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8026ea:	75 07                	jne    8026f3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8026ec:	b8 01 00 00 00       	mov    $0x1,%eax
  8026f1:	eb 05                	jmp    8026f8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8026f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026f8:	c9                   	leave  
  8026f9:	c3                   	ret    

008026fa <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8026fa:	55                   	push   %ebp
  8026fb:	89 e5                	mov    %esp,%ebp
  8026fd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802700:	6a 00                	push   $0x0
  802702:	6a 00                	push   $0x0
  802704:	6a 00                	push   $0x0
  802706:	6a 00                	push   $0x0
  802708:	6a 00                	push   $0x0
  80270a:	6a 2c                	push   $0x2c
  80270c:	e8 4b fa ff ff       	call   80215c <syscall>
  802711:	83 c4 18             	add    $0x18,%esp
  802714:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802717:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80271b:	75 07                	jne    802724 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80271d:	b8 01 00 00 00       	mov    $0x1,%eax
  802722:	eb 05                	jmp    802729 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802724:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802729:	c9                   	leave  
  80272a:	c3                   	ret    

0080272b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80272b:	55                   	push   %ebp
  80272c:	89 e5                	mov    %esp,%ebp
  80272e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802731:	6a 00                	push   $0x0
  802733:	6a 00                	push   $0x0
  802735:	6a 00                	push   $0x0
  802737:	6a 00                	push   $0x0
  802739:	6a 00                	push   $0x0
  80273b:	6a 2c                	push   $0x2c
  80273d:	e8 1a fa ff ff       	call   80215c <syscall>
  802742:	83 c4 18             	add    $0x18,%esp
  802745:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802748:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80274c:	75 07                	jne    802755 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80274e:	b8 01 00 00 00       	mov    $0x1,%eax
  802753:	eb 05                	jmp    80275a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802755:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80275a:	c9                   	leave  
  80275b:	c3                   	ret    

0080275c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80275c:	55                   	push   %ebp
  80275d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80275f:	6a 00                	push   $0x0
  802761:	6a 00                	push   $0x0
  802763:	6a 00                	push   $0x0
  802765:	6a 00                	push   $0x0
  802767:	ff 75 08             	pushl  0x8(%ebp)
  80276a:	6a 2d                	push   $0x2d
  80276c:	e8 eb f9 ff ff       	call   80215c <syscall>
  802771:	83 c4 18             	add    $0x18,%esp
	return ;
  802774:	90                   	nop
}
  802775:	c9                   	leave  
  802776:	c3                   	ret    

00802777 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802777:	55                   	push   %ebp
  802778:	89 e5                	mov    %esp,%ebp
  80277a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80277b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80277e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802781:	8b 55 0c             	mov    0xc(%ebp),%edx
  802784:	8b 45 08             	mov    0x8(%ebp),%eax
  802787:	6a 00                	push   $0x0
  802789:	53                   	push   %ebx
  80278a:	51                   	push   %ecx
  80278b:	52                   	push   %edx
  80278c:	50                   	push   %eax
  80278d:	6a 2e                	push   $0x2e
  80278f:	e8 c8 f9 ff ff       	call   80215c <syscall>
  802794:	83 c4 18             	add    $0x18,%esp
}
  802797:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80279a:	c9                   	leave  
  80279b:	c3                   	ret    

0080279c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80279c:	55                   	push   %ebp
  80279d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80279f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8027a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8027a5:	6a 00                	push   $0x0
  8027a7:	6a 00                	push   $0x0
  8027a9:	6a 00                	push   $0x0
  8027ab:	52                   	push   %edx
  8027ac:	50                   	push   %eax
  8027ad:	6a 2f                	push   $0x2f
  8027af:	e8 a8 f9 ff ff       	call   80215c <syscall>
  8027b4:	83 c4 18             	add    $0x18,%esp
}
  8027b7:	c9                   	leave  
  8027b8:	c3                   	ret    
  8027b9:	66 90                	xchg   %ax,%ax
  8027bb:	90                   	nop

008027bc <__udivdi3>:
  8027bc:	55                   	push   %ebp
  8027bd:	57                   	push   %edi
  8027be:	56                   	push   %esi
  8027bf:	53                   	push   %ebx
  8027c0:	83 ec 1c             	sub    $0x1c,%esp
  8027c3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8027c7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8027cb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8027cf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8027d3:	89 ca                	mov    %ecx,%edx
  8027d5:	89 f8                	mov    %edi,%eax
  8027d7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8027db:	85 f6                	test   %esi,%esi
  8027dd:	75 2d                	jne    80280c <__udivdi3+0x50>
  8027df:	39 cf                	cmp    %ecx,%edi
  8027e1:	77 65                	ja     802848 <__udivdi3+0x8c>
  8027e3:	89 fd                	mov    %edi,%ebp
  8027e5:	85 ff                	test   %edi,%edi
  8027e7:	75 0b                	jne    8027f4 <__udivdi3+0x38>
  8027e9:	b8 01 00 00 00       	mov    $0x1,%eax
  8027ee:	31 d2                	xor    %edx,%edx
  8027f0:	f7 f7                	div    %edi
  8027f2:	89 c5                	mov    %eax,%ebp
  8027f4:	31 d2                	xor    %edx,%edx
  8027f6:	89 c8                	mov    %ecx,%eax
  8027f8:	f7 f5                	div    %ebp
  8027fa:	89 c1                	mov    %eax,%ecx
  8027fc:	89 d8                	mov    %ebx,%eax
  8027fe:	f7 f5                	div    %ebp
  802800:	89 cf                	mov    %ecx,%edi
  802802:	89 fa                	mov    %edi,%edx
  802804:	83 c4 1c             	add    $0x1c,%esp
  802807:	5b                   	pop    %ebx
  802808:	5e                   	pop    %esi
  802809:	5f                   	pop    %edi
  80280a:	5d                   	pop    %ebp
  80280b:	c3                   	ret    
  80280c:	39 ce                	cmp    %ecx,%esi
  80280e:	77 28                	ja     802838 <__udivdi3+0x7c>
  802810:	0f bd fe             	bsr    %esi,%edi
  802813:	83 f7 1f             	xor    $0x1f,%edi
  802816:	75 40                	jne    802858 <__udivdi3+0x9c>
  802818:	39 ce                	cmp    %ecx,%esi
  80281a:	72 0a                	jb     802826 <__udivdi3+0x6a>
  80281c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802820:	0f 87 9e 00 00 00    	ja     8028c4 <__udivdi3+0x108>
  802826:	b8 01 00 00 00       	mov    $0x1,%eax
  80282b:	89 fa                	mov    %edi,%edx
  80282d:	83 c4 1c             	add    $0x1c,%esp
  802830:	5b                   	pop    %ebx
  802831:	5e                   	pop    %esi
  802832:	5f                   	pop    %edi
  802833:	5d                   	pop    %ebp
  802834:	c3                   	ret    
  802835:	8d 76 00             	lea    0x0(%esi),%esi
  802838:	31 ff                	xor    %edi,%edi
  80283a:	31 c0                	xor    %eax,%eax
  80283c:	89 fa                	mov    %edi,%edx
  80283e:	83 c4 1c             	add    $0x1c,%esp
  802841:	5b                   	pop    %ebx
  802842:	5e                   	pop    %esi
  802843:	5f                   	pop    %edi
  802844:	5d                   	pop    %ebp
  802845:	c3                   	ret    
  802846:	66 90                	xchg   %ax,%ax
  802848:	89 d8                	mov    %ebx,%eax
  80284a:	f7 f7                	div    %edi
  80284c:	31 ff                	xor    %edi,%edi
  80284e:	89 fa                	mov    %edi,%edx
  802850:	83 c4 1c             	add    $0x1c,%esp
  802853:	5b                   	pop    %ebx
  802854:	5e                   	pop    %esi
  802855:	5f                   	pop    %edi
  802856:	5d                   	pop    %ebp
  802857:	c3                   	ret    
  802858:	bd 20 00 00 00       	mov    $0x20,%ebp
  80285d:	89 eb                	mov    %ebp,%ebx
  80285f:	29 fb                	sub    %edi,%ebx
  802861:	89 f9                	mov    %edi,%ecx
  802863:	d3 e6                	shl    %cl,%esi
  802865:	89 c5                	mov    %eax,%ebp
  802867:	88 d9                	mov    %bl,%cl
  802869:	d3 ed                	shr    %cl,%ebp
  80286b:	89 e9                	mov    %ebp,%ecx
  80286d:	09 f1                	or     %esi,%ecx
  80286f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802873:	89 f9                	mov    %edi,%ecx
  802875:	d3 e0                	shl    %cl,%eax
  802877:	89 c5                	mov    %eax,%ebp
  802879:	89 d6                	mov    %edx,%esi
  80287b:	88 d9                	mov    %bl,%cl
  80287d:	d3 ee                	shr    %cl,%esi
  80287f:	89 f9                	mov    %edi,%ecx
  802881:	d3 e2                	shl    %cl,%edx
  802883:	8b 44 24 08          	mov    0x8(%esp),%eax
  802887:	88 d9                	mov    %bl,%cl
  802889:	d3 e8                	shr    %cl,%eax
  80288b:	09 c2                	or     %eax,%edx
  80288d:	89 d0                	mov    %edx,%eax
  80288f:	89 f2                	mov    %esi,%edx
  802891:	f7 74 24 0c          	divl   0xc(%esp)
  802895:	89 d6                	mov    %edx,%esi
  802897:	89 c3                	mov    %eax,%ebx
  802899:	f7 e5                	mul    %ebp
  80289b:	39 d6                	cmp    %edx,%esi
  80289d:	72 19                	jb     8028b8 <__udivdi3+0xfc>
  80289f:	74 0b                	je     8028ac <__udivdi3+0xf0>
  8028a1:	89 d8                	mov    %ebx,%eax
  8028a3:	31 ff                	xor    %edi,%edi
  8028a5:	e9 58 ff ff ff       	jmp    802802 <__udivdi3+0x46>
  8028aa:	66 90                	xchg   %ax,%ax
  8028ac:	8b 54 24 08          	mov    0x8(%esp),%edx
  8028b0:	89 f9                	mov    %edi,%ecx
  8028b2:	d3 e2                	shl    %cl,%edx
  8028b4:	39 c2                	cmp    %eax,%edx
  8028b6:	73 e9                	jae    8028a1 <__udivdi3+0xe5>
  8028b8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8028bb:	31 ff                	xor    %edi,%edi
  8028bd:	e9 40 ff ff ff       	jmp    802802 <__udivdi3+0x46>
  8028c2:	66 90                	xchg   %ax,%ax
  8028c4:	31 c0                	xor    %eax,%eax
  8028c6:	e9 37 ff ff ff       	jmp    802802 <__udivdi3+0x46>
  8028cb:	90                   	nop

008028cc <__umoddi3>:
  8028cc:	55                   	push   %ebp
  8028cd:	57                   	push   %edi
  8028ce:	56                   	push   %esi
  8028cf:	53                   	push   %ebx
  8028d0:	83 ec 1c             	sub    $0x1c,%esp
  8028d3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8028d7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8028db:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8028df:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8028e3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8028e7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8028eb:	89 f3                	mov    %esi,%ebx
  8028ed:	89 fa                	mov    %edi,%edx
  8028ef:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8028f3:	89 34 24             	mov    %esi,(%esp)
  8028f6:	85 c0                	test   %eax,%eax
  8028f8:	75 1a                	jne    802914 <__umoddi3+0x48>
  8028fa:	39 f7                	cmp    %esi,%edi
  8028fc:	0f 86 a2 00 00 00    	jbe    8029a4 <__umoddi3+0xd8>
  802902:	89 c8                	mov    %ecx,%eax
  802904:	89 f2                	mov    %esi,%edx
  802906:	f7 f7                	div    %edi
  802908:	89 d0                	mov    %edx,%eax
  80290a:	31 d2                	xor    %edx,%edx
  80290c:	83 c4 1c             	add    $0x1c,%esp
  80290f:	5b                   	pop    %ebx
  802910:	5e                   	pop    %esi
  802911:	5f                   	pop    %edi
  802912:	5d                   	pop    %ebp
  802913:	c3                   	ret    
  802914:	39 f0                	cmp    %esi,%eax
  802916:	0f 87 ac 00 00 00    	ja     8029c8 <__umoddi3+0xfc>
  80291c:	0f bd e8             	bsr    %eax,%ebp
  80291f:	83 f5 1f             	xor    $0x1f,%ebp
  802922:	0f 84 ac 00 00 00    	je     8029d4 <__umoddi3+0x108>
  802928:	bf 20 00 00 00       	mov    $0x20,%edi
  80292d:	29 ef                	sub    %ebp,%edi
  80292f:	89 fe                	mov    %edi,%esi
  802931:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802935:	89 e9                	mov    %ebp,%ecx
  802937:	d3 e0                	shl    %cl,%eax
  802939:	89 d7                	mov    %edx,%edi
  80293b:	89 f1                	mov    %esi,%ecx
  80293d:	d3 ef                	shr    %cl,%edi
  80293f:	09 c7                	or     %eax,%edi
  802941:	89 e9                	mov    %ebp,%ecx
  802943:	d3 e2                	shl    %cl,%edx
  802945:	89 14 24             	mov    %edx,(%esp)
  802948:	89 d8                	mov    %ebx,%eax
  80294a:	d3 e0                	shl    %cl,%eax
  80294c:	89 c2                	mov    %eax,%edx
  80294e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802952:	d3 e0                	shl    %cl,%eax
  802954:	89 44 24 04          	mov    %eax,0x4(%esp)
  802958:	8b 44 24 08          	mov    0x8(%esp),%eax
  80295c:	89 f1                	mov    %esi,%ecx
  80295e:	d3 e8                	shr    %cl,%eax
  802960:	09 d0                	or     %edx,%eax
  802962:	d3 eb                	shr    %cl,%ebx
  802964:	89 da                	mov    %ebx,%edx
  802966:	f7 f7                	div    %edi
  802968:	89 d3                	mov    %edx,%ebx
  80296a:	f7 24 24             	mull   (%esp)
  80296d:	89 c6                	mov    %eax,%esi
  80296f:	89 d1                	mov    %edx,%ecx
  802971:	39 d3                	cmp    %edx,%ebx
  802973:	0f 82 87 00 00 00    	jb     802a00 <__umoddi3+0x134>
  802979:	0f 84 91 00 00 00    	je     802a10 <__umoddi3+0x144>
  80297f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802983:	29 f2                	sub    %esi,%edx
  802985:	19 cb                	sbb    %ecx,%ebx
  802987:	89 d8                	mov    %ebx,%eax
  802989:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80298d:	d3 e0                	shl    %cl,%eax
  80298f:	89 e9                	mov    %ebp,%ecx
  802991:	d3 ea                	shr    %cl,%edx
  802993:	09 d0                	or     %edx,%eax
  802995:	89 e9                	mov    %ebp,%ecx
  802997:	d3 eb                	shr    %cl,%ebx
  802999:	89 da                	mov    %ebx,%edx
  80299b:	83 c4 1c             	add    $0x1c,%esp
  80299e:	5b                   	pop    %ebx
  80299f:	5e                   	pop    %esi
  8029a0:	5f                   	pop    %edi
  8029a1:	5d                   	pop    %ebp
  8029a2:	c3                   	ret    
  8029a3:	90                   	nop
  8029a4:	89 fd                	mov    %edi,%ebp
  8029a6:	85 ff                	test   %edi,%edi
  8029a8:	75 0b                	jne    8029b5 <__umoddi3+0xe9>
  8029aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8029af:	31 d2                	xor    %edx,%edx
  8029b1:	f7 f7                	div    %edi
  8029b3:	89 c5                	mov    %eax,%ebp
  8029b5:	89 f0                	mov    %esi,%eax
  8029b7:	31 d2                	xor    %edx,%edx
  8029b9:	f7 f5                	div    %ebp
  8029bb:	89 c8                	mov    %ecx,%eax
  8029bd:	f7 f5                	div    %ebp
  8029bf:	89 d0                	mov    %edx,%eax
  8029c1:	e9 44 ff ff ff       	jmp    80290a <__umoddi3+0x3e>
  8029c6:	66 90                	xchg   %ax,%ax
  8029c8:	89 c8                	mov    %ecx,%eax
  8029ca:	89 f2                	mov    %esi,%edx
  8029cc:	83 c4 1c             	add    $0x1c,%esp
  8029cf:	5b                   	pop    %ebx
  8029d0:	5e                   	pop    %esi
  8029d1:	5f                   	pop    %edi
  8029d2:	5d                   	pop    %ebp
  8029d3:	c3                   	ret    
  8029d4:	3b 04 24             	cmp    (%esp),%eax
  8029d7:	72 06                	jb     8029df <__umoddi3+0x113>
  8029d9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8029dd:	77 0f                	ja     8029ee <__umoddi3+0x122>
  8029df:	89 f2                	mov    %esi,%edx
  8029e1:	29 f9                	sub    %edi,%ecx
  8029e3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8029e7:	89 14 24             	mov    %edx,(%esp)
  8029ea:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8029ee:	8b 44 24 04          	mov    0x4(%esp),%eax
  8029f2:	8b 14 24             	mov    (%esp),%edx
  8029f5:	83 c4 1c             	add    $0x1c,%esp
  8029f8:	5b                   	pop    %ebx
  8029f9:	5e                   	pop    %esi
  8029fa:	5f                   	pop    %edi
  8029fb:	5d                   	pop    %ebp
  8029fc:	c3                   	ret    
  8029fd:	8d 76 00             	lea    0x0(%esi),%esi
  802a00:	2b 04 24             	sub    (%esp),%eax
  802a03:	19 fa                	sbb    %edi,%edx
  802a05:	89 d1                	mov    %edx,%ecx
  802a07:	89 c6                	mov    %eax,%esi
  802a09:	e9 71 ff ff ff       	jmp    80297f <__umoddi3+0xb3>
  802a0e:	66 90                	xchg   %ax,%ax
  802a10:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802a14:	72 ea                	jb     802a00 <__umoddi3+0x134>
  802a16:	89 d9                	mov    %ebx,%ecx
  802a18:	e9 62 ff ff ff       	jmp    80297f <__umoddi3+0xb3>
