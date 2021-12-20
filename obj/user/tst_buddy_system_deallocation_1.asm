
obj/user/tst_buddy_system_deallocation_1:     file format elf32-i386


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
  800031:	e8 d8 06 00 00       	call   80070e <libmain>
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
  80003c:	81 ec d4 00 00 00    	sub    $0xd4,%esp
	int freeFrames1 = sys_calculate_free_frames() ;
  800042:	e8 1f 1d 00 00       	call   801d66 <sys_calculate_free_frames>
  800047:	89 45 c8             	mov    %eax,-0x38(%ebp)
	int usedDiskPages1 = sys_pf_calculate_allocated_pages() ;
  80004a:	e8 9a 1d 00 00       	call   801de9 <sys_pf_calculate_allocated_pages>
  80004f:	89 45 c4             	mov    %eax,-0x3c(%ebp)

	char line[100];
	int N = 500;
  800052:	c7 45 c0 f4 01 00 00 	movl   $0x1f4,-0x40(%ebp)
	assert(N * sizeof(int) <= BUDDY_LIMIT);
  800059:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80005c:	c1 e0 02             	shl    $0x2,%eax
  80005f:	3d 00 08 00 00       	cmp    $0x800,%eax
  800064:	76 16                	jbe    80007c <_main+0x44>
  800066:	68 c0 24 80 00       	push   $0x8024c0
  80006b:	68 df 24 80 00       	push   $0x8024df
  800070:	6a 0d                	push   $0xd
  800072:	68 f4 24 80 00       	push   $0x8024f4
  800077:	e8 d7 07 00 00       	call   800853 <_panic>
	int M = 1;
  80007c:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
	assert(M * sizeof(uint8) <= BUDDY_LIMIT);
  800083:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800086:	3d 00 08 00 00       	cmp    $0x800,%eax
  80008b:	76 16                	jbe    8000a3 <_main+0x6b>
  80008d:	68 1c 25 80 00       	push   $0x80251c
  800092:	68 df 24 80 00       	push   $0x8024df
  800097:	6a 0f                	push   $0xf
  800099:	68 f4 24 80 00       	push   $0x8024f4
  80009e:	e8 b0 07 00 00       	call   800853 <_panic>

	uint8 ** arr = malloc(N * sizeof(int)) ;
  8000a3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8000a6:	c1 e0 02             	shl    $0x2,%eax
  8000a9:	83 ec 0c             	sub    $0xc,%esp
  8000ac:	50                   	push   %eax
  8000ad:	e8 cd 17 00 00       	call   80187f <malloc>
  8000b2:	83 c4 10             	add    $0x10,%esp
  8000b5:	89 45 b8             	mov    %eax,-0x48(%ebp)
	int expectedNumOfAllocatedFrames = GetPowOf2(N * sizeof(int));
  8000b8:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8000bb:	c1 e0 02             	shl    $0x2,%eax
  8000be:	83 ec 0c             	sub    $0xc,%esp
  8000c1:	50                   	push   %eax
  8000c2:	e8 05 06 00 00       	call   8006cc <GetPowOf2>
  8000c7:	83 c4 10             	add    $0x10,%esp
  8000ca:	89 45 f4             	mov    %eax,-0xc(%ebp)

	for (int i = 0; i < N; ++i)
  8000cd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000d4:	eb 6f                	jmp    800145 <_main+0x10d>
	{
		arr[i] = malloc(M) ;
  8000d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000e0:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8000e3:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  8000e6:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8000e9:	83 ec 0c             	sub    $0xc,%esp
  8000ec:	50                   	push   %eax
  8000ed:	e8 8d 17 00 00       	call   80187f <malloc>
  8000f2:	83 c4 10             	add    $0x10,%esp
  8000f5:	89 03                	mov    %eax,(%ebx)
		expectedNumOfAllocatedFrames += GetPowOf2(M);
  8000f7:	83 ec 0c             	sub    $0xc,%esp
  8000fa:	ff 75 bc             	pushl  -0x44(%ebp)
  8000fd:	e8 ca 05 00 00       	call   8006cc <GetPowOf2>
  800102:	83 c4 10             	add    $0x10,%esp
  800105:	01 45 f4             	add    %eax,-0xc(%ebp)
		for (int j = 0; j < M; ++j)
  800108:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80010f:	eb 29                	jmp    80013a <_main+0x102>
		{
			arr[i][j] = i % 255;
  800111:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800114:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80011b:	8b 45 b8             	mov    -0x48(%ebp),%eax
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
  80013d:	3b 45 bc             	cmp    -0x44(%ebp),%eax
  800140:	7c cf                	jl     800111 <_main+0xd9>
	assert(M * sizeof(uint8) <= BUDDY_LIMIT);

	uint8 ** arr = malloc(N * sizeof(int)) ;
	int expectedNumOfAllocatedFrames = GetPowOf2(N * sizeof(int));

	for (int i = 0; i < N; ++i)
  800142:	ff 45 f0             	incl   -0x10(%ebp)
  800145:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800148:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  80014b:	7c 89                	jl     8000d6 <_main+0x9e>
		for (int j = 0; j < M; ++j)
		{
			arr[i][j] = i % 255;
		}
	}
	expectedNumOfAllocatedFrames = ROUNDUP(expectedNumOfAllocatedFrames, PAGE_SIZE) / PAGE_SIZE;
  80014d:	c7 45 b4 00 10 00 00 	movl   $0x1000,-0x4c(%ebp)
  800154:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800157:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80015a:	01 d0                	add    %edx,%eax
  80015c:	48                   	dec    %eax
  80015d:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800160:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800163:	ba 00 00 00 00       	mov    $0x0,%edx
  800168:	f7 75 b4             	divl   -0x4c(%ebp)
  80016b:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80016e:	29 d0                	sub    %edx,%eax
  800170:	85 c0                	test   %eax,%eax
  800172:	79 05                	jns    800179 <_main+0x141>
  800174:	05 ff 0f 00 00       	add    $0xfff,%eax
  800179:	c1 f8 0c             	sar    $0xc,%eax
  80017c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int freeFrames2 = sys_calculate_free_frames() ;
  80017f:	e8 e2 1b 00 00       	call   801d66 <sys_calculate_free_frames>
  800184:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int usedDiskPages2 = sys_pf_calculate_allocated_pages() ;
  800187:	e8 5d 1c 00 00       	call   801de9 <sys_pf_calculate_allocated_pages>
  80018c:	89 45 a8             	mov    %eax,-0x58(%ebp)
	if(freeFrames1 - freeFrames2 != 1 + 1 + expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in MEMORY."); //1 for page table + 1 for disk table
  80018f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800192:	2b 45 ac             	sub    -0x54(%ebp),%eax
  800195:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800198:	83 c2 02             	add    $0x2,%edx
  80019b:	39 d0                	cmp    %edx,%eax
  80019d:	74 14                	je     8001b3 <_main+0x17b>
  80019f:	83 ec 04             	sub    $0x4,%esp
  8001a2:	68 40 25 80 00       	push   $0x802540
  8001a7:	6a 20                	push   $0x20
  8001a9:	68 f4 24 80 00       	push   $0x8024f4
  8001ae:	e8 a0 06 00 00       	call   800853 <_panic>
	if(usedDiskPages2 - usedDiskPages1 != expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in PAGE FILE.");
  8001b3:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8001b6:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  8001b9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8001bc:	74 14                	je     8001d2 <_main+0x19a>
  8001be:	83 ec 04             	sub    $0x4,%esp
  8001c1:	68 70 25 80 00       	push   $0x802570
  8001c6:	6a 21                	push   $0x21
  8001c8:	68 f4 24 80 00       	push   $0x8024f4
  8001cd:	e8 81 06 00 00       	call   800853 <_panic>

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
  8001ee:	8b 45 b8             	mov    -0x48(%ebp),%eax
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
  800210:	68 a0 25 80 00       	push   $0x8025a0
  800215:	68 df 24 80 00       	push   $0x8024df
  80021a:	6a 27                	push   $0x27
  80021c:	68 f4 24 80 00       	push   $0x8024f4
  800221:	e8 2d 06 00 00       	call   800853 <_panic>
	if(freeFrames1 - freeFrames2 != 1 + 1 + expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in MEMORY."); //1 for page table + 1 for disk table
	if(usedDiskPages2 - usedDiskPages1 != expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in PAGE FILE.");

	for (int i = 0; i < N; ++i)
	{
		for (int j = 0; j < M; ++j)
  800226:	ff 45 e4             	incl   -0x1c(%ebp)
  800229:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80022c:	3b 45 bc             	cmp    -0x44(%ebp),%eax
  80022f:	7c b3                	jl     8001e4 <_main+0x1ac>
	int freeFrames2 = sys_calculate_free_frames() ;
	int usedDiskPages2 = sys_pf_calculate_allocated_pages() ;
	if(freeFrames1 - freeFrames2 != 1 + 1 + expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in MEMORY."); //1 for page table + 1 for disk table
	if(usedDiskPages2 - usedDiskPages1 != expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in PAGE FILE.");

	for (int i = 0; i < N; ++i)
  800231:	ff 45 e8             	incl   -0x18(%ebp)
  800234:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800237:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  80023a:	7c 9f                	jl     8001db <_main+0x1a3>
		for (int j = 0; j < M; ++j)
		{
			assert(arr[i][j] == i % 255);
		}
	}
	cprintf("Arrays are created successfully ... Now, they will be freed\n") ;
  80023c:	83 ec 0c             	sub    $0xc,%esp
  80023f:	68 b8 25 80 00       	push   $0x8025b8
  800244:	e8 ac 08 00 00       	call   800af5 <cprintf>
  800249:	83 c4 10             	add    $0x10,%esp

	//[1] Freeing the allocated arrays + checking the BuddyLevels content
	for (int i = 0; i < N; ++i)
  80024c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800253:	eb 20                	jmp    800275 <_main+0x23d>
	{
		free(arr[i]);
  800255:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800258:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80025f:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800262:	01 d0                	add    %edx,%eax
  800264:	8b 00                	mov    (%eax),%eax
  800266:	83 ec 0c             	sub    $0xc,%esp
  800269:	50                   	push   %eax
  80026a:	e8 20 18 00 00       	call   801a8f <free>
  80026f:	83 c4 10             	add    $0x10,%esp
		}
	}
	cprintf("Arrays are created successfully ... Now, they will be freed\n") ;

	//[1] Freeing the allocated arrays + checking the BuddyLevels content
	for (int i = 0; i < N; ++i)
  800272:	ff 45 e0             	incl   -0x20(%ebp)
  800275:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800278:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  80027b:	7c d8                	jl     800255 <_main+0x21d>
	{
		free(arr[i]);
	}
	free(arr);
  80027d:	83 ec 0c             	sub    $0xc,%esp
  800280:	ff 75 b8             	pushl  -0x48(%ebp)
  800283:	e8 07 18 00 00       	call   801a8f <free>
  800288:	83 c4 10             	add    $0x10,%esp
	int i;
	for(i = BUDDY_LOWER_LEVEL; i < BUDDY_UPPER_LEVEL; i++)
  80028b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
  800292:	eb 49                	jmp    8002dd <_main+0x2a5>
	{
		if(LIST_SIZE(&BuddyLevels[i]) != 0)
  800294:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800297:	c1 e0 04             	shl    $0x4,%eax
  80029a:	05 4c 30 80 00       	add    $0x80304c,%eax
  80029f:	8b 00                	mov    (%eax),%eax
  8002a1:	85 c0                	test   %eax,%eax
  8002a3:	74 35                	je     8002da <_main+0x2a2>
		{
			cprintf("Level # = %d - # of nodes = %d\n", i, LIST_SIZE(&BuddyLevels[i]));
  8002a5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002a8:	c1 e0 04             	shl    $0x4,%eax
  8002ab:	05 4c 30 80 00       	add    $0x80304c,%eax
  8002b0:	8b 00                	mov    (%eax),%eax
  8002b2:	83 ec 04             	sub    $0x4,%esp
  8002b5:	50                   	push   %eax
  8002b6:	ff 75 dc             	pushl  -0x24(%ebp)
  8002b9:	68 f8 25 80 00       	push   $0x8025f8
  8002be:	e8 32 08 00 00       	call   800af5 <cprintf>
  8002c3:	83 c4 10             	add    $0x10,%esp
			panic("The BuddyLevels at level <<%d>> is not freed ... !!", i);
  8002c6:	ff 75 dc             	pushl  -0x24(%ebp)
  8002c9:	68 18 26 80 00       	push   $0x802618
  8002ce:	6a 38                	push   $0x38
  8002d0:	68 f4 24 80 00       	push   $0x8024f4
  8002d5:	e8 79 05 00 00       	call   800853 <_panic>
	{
		free(arr[i]);
	}
	free(arr);
	int i;
	for(i = BUDDY_LOWER_LEVEL; i < BUDDY_UPPER_LEVEL; i++)
  8002da:	ff 45 dc             	incl   -0x24(%ebp)
  8002dd:	83 7d dc 0a          	cmpl   $0xa,-0x24(%ebp)
  8002e1:	7e b1                	jle    800294 <_main+0x25c>
		{
			cprintf("Level # = %d - # of nodes = %d\n", i, LIST_SIZE(&BuddyLevels[i]));
			panic("The BuddyLevels at level <<%d>> is not freed ... !!", i);
		}
	}
	cprintf("Arrays are freed successfully ... New arrays will be created\n") ;
  8002e3:	83 ec 0c             	sub    $0xc,%esp
  8002e6:	68 4c 26 80 00       	push   $0x80264c
  8002eb:	e8 05 08 00 00       	call   800af5 <cprintf>
  8002f0:	83 c4 10             	add    $0x10,%esp

	//[2] Creating new arrays after FREEing the created ones + checking no extra frames are taken + checking content
	uint8 ** arr2 = malloc(N * sizeof(int)) ;
  8002f3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8002f6:	c1 e0 02             	shl    $0x2,%eax
  8002f9:	83 ec 0c             	sub    $0xc,%esp
  8002fc:	50                   	push   %eax
  8002fd:	e8 7d 15 00 00       	call   80187f <malloc>
  800302:	83 c4 10             	add    $0x10,%esp
  800305:	89 45 a4             	mov    %eax,-0x5c(%ebp)
	for (int i = 0; i < N; ++i)
  800308:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  80030f:	eb 5f                	jmp    800370 <_main+0x338>
	{
		arr2[i] = malloc(M) ;
  800311:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800314:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80031b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80031e:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  800321:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800324:	83 ec 0c             	sub    $0xc,%esp
  800327:	50                   	push   %eax
  800328:	e8 52 15 00 00       	call   80187f <malloc>
  80032d:	83 c4 10             	add    $0x10,%esp
  800330:	89 03                	mov    %eax,(%ebx)
		for (int j = 0; j < M; ++j)
  800332:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  800339:	eb 2a                	jmp    800365 <_main+0x32d>
		{
			arr2[i][j] = (i + 1)%255;
  80033b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80033e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800345:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800348:	01 d0                	add    %edx,%eax
  80034a:	8b 10                	mov    (%eax),%edx
  80034c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80034f:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800352:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800355:	40                   	inc    %eax
  800356:	bb ff 00 00 00       	mov    $0xff,%ebx
  80035b:	99                   	cltd   
  80035c:	f7 fb                	idiv   %ebx
  80035e:	89 d0                	mov    %edx,%eax
  800360:	88 01                	mov    %al,(%ecx)
	//[2] Creating new arrays after FREEing the created ones + checking no extra frames are taken + checking content
	uint8 ** arr2 = malloc(N * sizeof(int)) ;
	for (int i = 0; i < N; ++i)
	{
		arr2[i] = malloc(M) ;
		for (int j = 0; j < M; ++j)
  800362:	ff 45 d4             	incl   -0x2c(%ebp)
  800365:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800368:	3b 45 bc             	cmp    -0x44(%ebp),%eax
  80036b:	7c ce                	jl     80033b <_main+0x303>
	}
	cprintf("Arrays are freed successfully ... New arrays will be created\n") ;

	//[2] Creating new arrays after FREEing the created ones + checking no extra frames are taken + checking content
	uint8 ** arr2 = malloc(N * sizeof(int)) ;
	for (int i = 0; i < N; ++i)
  80036d:	ff 45 d8             	incl   -0x28(%ebp)
  800370:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800373:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  800376:	7c 99                	jl     800311 <_main+0x2d9>
		for (int j = 0; j < M; ++j)
		{
			arr2[i][j] = (i + 1)%255;
		}
	}
	int freeFrames3 = sys_calculate_free_frames() ;
  800378:	e8 e9 19 00 00       	call   801d66 <sys_calculate_free_frames>
  80037d:	89 45 a0             	mov    %eax,-0x60(%ebp)
	int usedDiskPages3 = sys_pf_calculate_allocated_pages() ;
  800380:	e8 64 1a 00 00       	call   801de9 <sys_pf_calculate_allocated_pages>
  800385:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Check that no extra frames are taken
	if(freeFrames3 - freeFrames2 != 0) panic("Frames are not freed from MEMORY correctly. Evaluation = 60%.");
  800388:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80038b:	3b 45 ac             	cmp    -0x54(%ebp),%eax
  80038e:	74 14                	je     8003a4 <_main+0x36c>
  800390:	83 ec 04             	sub    $0x4,%esp
  800393:	68 8c 26 80 00       	push   $0x80268c
  800398:	6a 4b                	push   $0x4b
  80039a:	68 f4 24 80 00       	push   $0x8024f4
  80039f:	e8 af 04 00 00       	call   800853 <_panic>
	if(usedDiskPages3 - usedDiskPages2 != 0) panic("Frames are not freed from PAGE FILE correctly. Evaluation = 60%.");
  8003a4:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8003a7:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  8003aa:	74 14                	je     8003c0 <_main+0x388>
  8003ac:	83 ec 04             	sub    $0x4,%esp
  8003af:	68 cc 26 80 00       	push   $0x8026cc
  8003b4:	6a 4c                	push   $0x4c
  8003b6:	68 f4 24 80 00       	push   $0x8024f4
  8003bb:	e8 93 04 00 00       	call   800853 <_panic>

	//Check the array content
	for (int i = 0; i < N; ++i)
  8003c0:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  8003c7:	eb 58                	jmp    800421 <_main+0x3e9>
	{
		for (int j = 0; j < M; ++j)
  8003c9:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  8003d0:	eb 44                	jmp    800416 <_main+0x3de>
		{
			if(arr2[i][j] != (i + 1)%255) panic("Wrong content in the created arrays. Evaluation = 75%.");
  8003d2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003dc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003df:	01 d0                	add    %edx,%eax
  8003e1:	8b 10                	mov    (%eax),%edx
  8003e3:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8003e6:	01 d0                	add    %edx,%eax
  8003e8:	8a 00                	mov    (%eax),%al
  8003ea:	0f b6 c8             	movzbl %al,%ecx
  8003ed:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003f0:	40                   	inc    %eax
  8003f1:	bb ff 00 00 00       	mov    $0xff,%ebx
  8003f6:	99                   	cltd   
  8003f7:	f7 fb                	idiv   %ebx
  8003f9:	89 d0                	mov    %edx,%eax
  8003fb:	39 c1                	cmp    %eax,%ecx
  8003fd:	74 14                	je     800413 <_main+0x3db>
  8003ff:	83 ec 04             	sub    $0x4,%esp
  800402:	68 10 27 80 00       	push   $0x802710
  800407:	6a 53                	push   $0x53
  800409:	68 f4 24 80 00       	push   $0x8024f4
  80040e:	e8 40 04 00 00       	call   800853 <_panic>
	if(usedDiskPages3 - usedDiskPages2 != 0) panic("Frames are not freed from PAGE FILE correctly. Evaluation = 60%.");

	//Check the array content
	for (int i = 0; i < N; ++i)
	{
		for (int j = 0; j < M; ++j)
  800413:	ff 45 cc             	incl   -0x34(%ebp)
  800416:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800419:	3b 45 bc             	cmp    -0x44(%ebp),%eax
  80041c:	7c b4                	jl     8003d2 <_main+0x39a>
	//Check that no extra frames are taken
	if(freeFrames3 - freeFrames2 != 0) panic("Frames are not freed from MEMORY correctly. Evaluation = 60%.");
	if(usedDiskPages3 - usedDiskPages2 != 0) panic("Frames are not freed from PAGE FILE correctly. Evaluation = 60%.");

	//Check the array content
	for (int i = 0; i < N; ++i)
  80041e:	ff 45 d0             	incl   -0x30(%ebp)
  800421:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800424:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  800427:	7c a0                	jl     8003c9 <_main+0x391>
		for (int j = 0; j < M; ++j)
		{
			if(arr2[i][j] != (i + 1)%255) panic("Wrong content in the created arrays. Evaluation = 75%.");
		}
	}
	cprintf("New Arrays are created successfully after the FREE ...\n") ;
  800429:	83 ec 0c             	sub    $0xc,%esp
  80042c:	68 48 27 80 00       	push   $0x802748
  800431:	e8 bf 06 00 00       	call   800af5 <cprintf>
  800436:	83 c4 10             	add    $0x10,%esp

	//Check the lists content of the BuddyLevels array
	{
	int L = BUDDY_LOWER_LEVEL;
  800439:	c7 45 98 01 00 00 00 	movl   $0x1,-0x68(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d. Evaluation = 85%\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800440:	8b 45 98             	mov    -0x68(%ebp),%eax
  800443:	c1 e0 04             	shl    $0x4,%eax
  800446:	05 4c 30 80 00       	add    $0x80304c,%eax
  80044b:	8b 00                	mov    (%eax),%eax
  80044d:	85 c0                	test   %eax,%eax
  80044f:	74 25                	je     800476 <_main+0x43e>
  800451:	8b 45 98             	mov    -0x68(%ebp),%eax
  800454:	c1 e0 04             	shl    $0x4,%eax
  800457:	05 4c 30 80 00       	add    $0x80304c,%eax
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	83 ec 0c             	sub    $0xc,%esp
  800461:	50                   	push   %eax
  800462:	ff 75 98             	pushl  -0x68(%ebp)
  800465:	68 80 27 80 00       	push   $0x802780
  80046a:	6a 5b                	push   $0x5b
  80046c:	68 f4 24 80 00       	push   $0x8024f4
  800471:	e8 dd 03 00 00       	call   800853 <_panic>
  800476:	ff 45 98             	incl   -0x68(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d. Evaluation = 85%\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800479:	8b 45 98             	mov    -0x68(%ebp),%eax
  80047c:	c1 e0 04             	shl    $0x4,%eax
  80047f:	05 4c 30 80 00       	add    $0x80304c,%eax
  800484:	8b 00                	mov    (%eax),%eax
  800486:	85 c0                	test   %eax,%eax
  800488:	74 25                	je     8004af <_main+0x477>
  80048a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80048d:	c1 e0 04             	shl    $0x4,%eax
  800490:	05 4c 30 80 00       	add    $0x80304c,%eax
  800495:	8b 00                	mov    (%eax),%eax
  800497:	83 ec 0c             	sub    $0xc,%esp
  80049a:	50                   	push   %eax
  80049b:	ff 75 98             	pushl  -0x68(%ebp)
  80049e:	68 80 27 80 00       	push   $0x802780
  8004a3:	6a 5c                	push   $0x5c
  8004a5:	68 f4 24 80 00       	push   $0x8024f4
  8004aa:	e8 a4 03 00 00       	call   800853 <_panic>
  8004af:	ff 45 98             	incl   -0x68(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d. Evaluation = 85%\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8004b2:	8b 45 98             	mov    -0x68(%ebp),%eax
  8004b5:	c1 e0 04             	shl    $0x4,%eax
  8004b8:	05 4c 30 80 00       	add    $0x80304c,%eax
  8004bd:	8b 00                	mov    (%eax),%eax
  8004bf:	83 f8 01             	cmp    $0x1,%eax
  8004c2:	74 25                	je     8004e9 <_main+0x4b1>
  8004c4:	8b 45 98             	mov    -0x68(%ebp),%eax
  8004c7:	c1 e0 04             	shl    $0x4,%eax
  8004ca:	05 4c 30 80 00       	add    $0x80304c,%eax
  8004cf:	8b 00                	mov    (%eax),%eax
  8004d1:	83 ec 0c             	sub    $0xc,%esp
  8004d4:	50                   	push   %eax
  8004d5:	ff 75 98             	pushl  -0x68(%ebp)
  8004d8:	68 80 27 80 00       	push   $0x802780
  8004dd:	6a 5d                	push   $0x5d
  8004df:	68 f4 24 80 00       	push   $0x8024f4
  8004e4:	e8 6a 03 00 00       	call   800853 <_panic>
  8004e9:	ff 45 98             	incl   -0x68(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d. Evaluation = 85%\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8004ec:	8b 45 98             	mov    -0x68(%ebp),%eax
  8004ef:	c1 e0 04             	shl    $0x4,%eax
  8004f2:	05 4c 30 80 00       	add    $0x80304c,%eax
  8004f7:	8b 00                	mov    (%eax),%eax
  8004f9:	83 f8 01             	cmp    $0x1,%eax
  8004fc:	74 25                	je     800523 <_main+0x4eb>
  8004fe:	8b 45 98             	mov    -0x68(%ebp),%eax
  800501:	c1 e0 04             	shl    $0x4,%eax
  800504:	05 4c 30 80 00       	add    $0x80304c,%eax
  800509:	8b 00                	mov    (%eax),%eax
  80050b:	83 ec 0c             	sub    $0xc,%esp
  80050e:	50                   	push   %eax
  80050f:	ff 75 98             	pushl  -0x68(%ebp)
  800512:	68 80 27 80 00       	push   $0x802780
  800517:	6a 5e                	push   $0x5e
  800519:	68 f4 24 80 00       	push   $0x8024f4
  80051e:	e8 30 03 00 00       	call   800853 <_panic>
  800523:	ff 45 98             	incl   -0x68(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d. Evaluation = 85%\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800526:	8b 45 98             	mov    -0x68(%ebp),%eax
  800529:	c1 e0 04             	shl    $0x4,%eax
  80052c:	05 4c 30 80 00       	add    $0x80304c,%eax
  800531:	8b 00                	mov    (%eax),%eax
  800533:	85 c0                	test   %eax,%eax
  800535:	74 25                	je     80055c <_main+0x524>
  800537:	8b 45 98             	mov    -0x68(%ebp),%eax
  80053a:	c1 e0 04             	shl    $0x4,%eax
  80053d:	05 4c 30 80 00       	add    $0x80304c,%eax
  800542:	8b 00                	mov    (%eax),%eax
  800544:	83 ec 0c             	sub    $0xc,%esp
  800547:	50                   	push   %eax
  800548:	ff 75 98             	pushl  -0x68(%ebp)
  80054b:	68 80 27 80 00       	push   $0x802780
  800550:	6a 5f                	push   $0x5f
  800552:	68 f4 24 80 00       	push   $0x8024f4
  800557:	e8 f7 02 00 00       	call   800853 <_panic>
  80055c:	ff 45 98             	incl   -0x68(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d. Evaluation = 85%\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  80055f:	8b 45 98             	mov    -0x68(%ebp),%eax
  800562:	c1 e0 04             	shl    $0x4,%eax
  800565:	05 4c 30 80 00       	add    $0x80304c,%eax
  80056a:	8b 00                	mov    (%eax),%eax
  80056c:	85 c0                	test   %eax,%eax
  80056e:	74 25                	je     800595 <_main+0x55d>
  800570:	8b 45 98             	mov    -0x68(%ebp),%eax
  800573:	c1 e0 04             	shl    $0x4,%eax
  800576:	05 4c 30 80 00       	add    $0x80304c,%eax
  80057b:	8b 00                	mov    (%eax),%eax
  80057d:	83 ec 0c             	sub    $0xc,%esp
  800580:	50                   	push   %eax
  800581:	ff 75 98             	pushl  -0x68(%ebp)
  800584:	68 80 27 80 00       	push   $0x802780
  800589:	6a 60                	push   $0x60
  80058b:	68 f4 24 80 00       	push   $0x8024f4
  800590:	e8 be 02 00 00       	call   800853 <_panic>
  800595:	ff 45 98             	incl   -0x68(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d. Evaluation = 85%\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800598:	8b 45 98             	mov    -0x68(%ebp),%eax
  80059b:	c1 e0 04             	shl    $0x4,%eax
  80059e:	05 4c 30 80 00       	add    $0x80304c,%eax
  8005a3:	8b 00                	mov    (%eax),%eax
  8005a5:	85 c0                	test   %eax,%eax
  8005a7:	74 25                	je     8005ce <_main+0x596>
  8005a9:	8b 45 98             	mov    -0x68(%ebp),%eax
  8005ac:	c1 e0 04             	shl    $0x4,%eax
  8005af:	05 4c 30 80 00       	add    $0x80304c,%eax
  8005b4:	8b 00                	mov    (%eax),%eax
  8005b6:	83 ec 0c             	sub    $0xc,%esp
  8005b9:	50                   	push   %eax
  8005ba:	ff 75 98             	pushl  -0x68(%ebp)
  8005bd:	68 80 27 80 00       	push   $0x802780
  8005c2:	6a 61                	push   $0x61
  8005c4:	68 f4 24 80 00       	push   $0x8024f4
  8005c9:	e8 85 02 00 00       	call   800853 <_panic>
  8005ce:	ff 45 98             	incl   -0x68(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d. Evaluation = 85%\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8005d1:	8b 45 98             	mov    -0x68(%ebp),%eax
  8005d4:	c1 e0 04             	shl    $0x4,%eax
  8005d7:	05 4c 30 80 00       	add    $0x80304c,%eax
  8005dc:	8b 00                	mov    (%eax),%eax
  8005de:	85 c0                	test   %eax,%eax
  8005e0:	74 25                	je     800607 <_main+0x5cf>
  8005e2:	8b 45 98             	mov    -0x68(%ebp),%eax
  8005e5:	c1 e0 04             	shl    $0x4,%eax
  8005e8:	05 4c 30 80 00       	add    $0x80304c,%eax
  8005ed:	8b 00                	mov    (%eax),%eax
  8005ef:	83 ec 0c             	sub    $0xc,%esp
  8005f2:	50                   	push   %eax
  8005f3:	ff 75 98             	pushl  -0x68(%ebp)
  8005f6:	68 80 27 80 00       	push   $0x802780
  8005fb:	6a 62                	push   $0x62
  8005fd:	68 f4 24 80 00       	push   $0x8024f4
  800602:	e8 4c 02 00 00       	call   800853 <_panic>
  800607:	ff 45 98             	incl   -0x68(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d. Evaluation = 85%\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  80060a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80060d:	c1 e0 04             	shl    $0x4,%eax
  800610:	05 4c 30 80 00       	add    $0x80304c,%eax
  800615:	8b 00                	mov    (%eax),%eax
  800617:	85 c0                	test   %eax,%eax
  800619:	74 25                	je     800640 <_main+0x608>
  80061b:	8b 45 98             	mov    -0x68(%ebp),%eax
  80061e:	c1 e0 04             	shl    $0x4,%eax
  800621:	05 4c 30 80 00       	add    $0x80304c,%eax
  800626:	8b 00                	mov    (%eax),%eax
  800628:	83 ec 0c             	sub    $0xc,%esp
  80062b:	50                   	push   %eax
  80062c:	ff 75 98             	pushl  -0x68(%ebp)
  80062f:	68 80 27 80 00       	push   $0x802780
  800634:	6a 63                	push   $0x63
  800636:	68 f4 24 80 00       	push   $0x8024f4
  80063b:	e8 13 02 00 00       	call   800853 <_panic>
  800640:	ff 45 98             	incl   -0x68(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d. Evaluation = 85%\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800643:	8b 45 98             	mov    -0x68(%ebp),%eax
  800646:	c1 e0 04             	shl    $0x4,%eax
  800649:	05 4c 30 80 00       	add    $0x80304c,%eax
  80064e:	8b 00                	mov    (%eax),%eax
  800650:	83 f8 01             	cmp    $0x1,%eax
  800653:	74 25                	je     80067a <_main+0x642>
  800655:	8b 45 98             	mov    -0x68(%ebp),%eax
  800658:	c1 e0 04             	shl    $0x4,%eax
  80065b:	05 4c 30 80 00       	add    $0x80304c,%eax
  800660:	8b 00                	mov    (%eax),%eax
  800662:	83 ec 0c             	sub    $0xc,%esp
  800665:	50                   	push   %eax
  800666:	ff 75 98             	pushl  -0x68(%ebp)
  800669:	68 80 27 80 00       	push   $0x802780
  80066e:	6a 64                	push   $0x64
  800670:	68 f4 24 80 00       	push   $0x8024f4
  800675:	e8 d9 01 00 00       	call   800853 <_panic>
  80067a:	ff 45 98             	incl   -0x68(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{panic("WRONG number of nodes at Level # %d - # of nodes = %d. Evaluation = 85%\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  80067d:	8b 45 98             	mov    -0x68(%ebp),%eax
  800680:	c1 e0 04             	shl    $0x4,%eax
  800683:	05 4c 30 80 00       	add    $0x80304c,%eax
  800688:	8b 00                	mov    (%eax),%eax
  80068a:	85 c0                	test   %eax,%eax
  80068c:	74 25                	je     8006b3 <_main+0x67b>
  80068e:	8b 45 98             	mov    -0x68(%ebp),%eax
  800691:	c1 e0 04             	shl    $0x4,%eax
  800694:	05 4c 30 80 00       	add    $0x80304c,%eax
  800699:	8b 00                	mov    (%eax),%eax
  80069b:	83 ec 0c             	sub    $0xc,%esp
  80069e:	50                   	push   %eax
  80069f:	ff 75 98             	pushl  -0x68(%ebp)
  8006a2:	68 80 27 80 00       	push   $0x802780
  8006a7:	6a 65                	push   $0x65
  8006a9:	68 f4 24 80 00       	push   $0x8024f4
  8006ae:	e8 a0 01 00 00       	call   800853 <_panic>
  8006b3:	ff 45 98             	incl   -0x68(%ebp)
	}

	cprintf("Congratulations!! test BUDDY SYSTEM deallocation (1) completed successfully. Evaluation = 100%\n");
  8006b6:	83 ec 0c             	sub    $0xc,%esp
  8006b9:	68 cc 27 80 00       	push   $0x8027cc
  8006be:	e8 32 04 00 00       	call   800af5 <cprintf>
  8006c3:	83 c4 10             	add    $0x10,%esp

	return;
  8006c6:	90                   	nop
}
  8006c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006ca:	c9                   	leave  
  8006cb:	c3                   	ret    

008006cc <GetPowOf2>:

int GetPowOf2(int size)
{
  8006cc:	55                   	push   %ebp
  8006cd:	89 e5                	mov    %esp,%ebp
  8006cf:	83 ec 10             	sub    $0x10,%esp
	int i;
	for(i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; i++)
  8006d2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
  8006d9:	eb 26                	jmp    800701 <GetPowOf2+0x35>
	{
		if(BUDDY_NODE_SIZE(i) >= size)
  8006db:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006de:	ba 01 00 00 00       	mov    $0x1,%edx
  8006e3:	88 c1                	mov    %al,%cl
  8006e5:	d3 e2                	shl    %cl,%edx
  8006e7:	89 d0                	mov    %edx,%eax
  8006e9:	3b 45 08             	cmp    0x8(%ebp),%eax
  8006ec:	7c 10                	jl     8006fe <GetPowOf2+0x32>
			return 1<<i;
  8006ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006f1:	ba 01 00 00 00       	mov    $0x1,%edx
  8006f6:	88 c1                	mov    %al,%cl
  8006f8:	d3 e2                	shl    %cl,%edx
  8006fa:	89 d0                	mov    %edx,%eax
  8006fc:	eb 0e                	jmp    80070c <GetPowOf2+0x40>
}

int GetPowOf2(int size)
{
	int i;
	for(i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; i++)
  8006fe:	ff 45 fc             	incl   -0x4(%ebp)
  800701:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  800705:	7e d4                	jle    8006db <GetPowOf2+0xf>
	{
		if(BUDDY_NODE_SIZE(i) >= size)
			return 1<<i;
	}
	return 0;
  800707:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80070c:	c9                   	leave  
  80070d:	c3                   	ret    

0080070e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80070e:	55                   	push   %ebp
  80070f:	89 e5                	mov    %esp,%ebp
  800711:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800714:	e8 82 15 00 00       	call   801c9b <sys_getenvindex>
  800719:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80071c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80071f:	89 d0                	mov    %edx,%eax
  800721:	c1 e0 03             	shl    $0x3,%eax
  800724:	01 d0                	add    %edx,%eax
  800726:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80072d:	01 c8                	add    %ecx,%eax
  80072f:	01 c0                	add    %eax,%eax
  800731:	01 d0                	add    %edx,%eax
  800733:	01 c0                	add    %eax,%eax
  800735:	01 d0                	add    %edx,%eax
  800737:	89 c2                	mov    %eax,%edx
  800739:	c1 e2 05             	shl    $0x5,%edx
  80073c:	29 c2                	sub    %eax,%edx
  80073e:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800745:	89 c2                	mov    %eax,%edx
  800747:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80074d:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800752:	a1 20 30 80 00       	mov    0x803020,%eax
  800757:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80075d:	84 c0                	test   %al,%al
  80075f:	74 0f                	je     800770 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800761:	a1 20 30 80 00       	mov    0x803020,%eax
  800766:	05 40 3c 01 00       	add    $0x13c40,%eax
  80076b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800770:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800774:	7e 0a                	jle    800780 <libmain+0x72>
		binaryname = argv[0];
  800776:	8b 45 0c             	mov    0xc(%ebp),%eax
  800779:	8b 00                	mov    (%eax),%eax
  80077b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800780:	83 ec 08             	sub    $0x8,%esp
  800783:	ff 75 0c             	pushl  0xc(%ebp)
  800786:	ff 75 08             	pushl  0x8(%ebp)
  800789:	e8 aa f8 ff ff       	call   800038 <_main>
  80078e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800791:	e8 a0 16 00 00       	call   801e36 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800796:	83 ec 0c             	sub    $0xc,%esp
  800799:	68 44 28 80 00       	push   $0x802844
  80079e:	e8 52 03 00 00       	call   800af5 <cprintf>
  8007a3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8007a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8007ab:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8007b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8007b6:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8007bc:	83 ec 04             	sub    $0x4,%esp
  8007bf:	52                   	push   %edx
  8007c0:	50                   	push   %eax
  8007c1:	68 6c 28 80 00       	push   $0x80286c
  8007c6:	e8 2a 03 00 00       	call   800af5 <cprintf>
  8007cb:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8007ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8007d3:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8007d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8007de:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8007e4:	83 ec 04             	sub    $0x4,%esp
  8007e7:	52                   	push   %edx
  8007e8:	50                   	push   %eax
  8007e9:	68 94 28 80 00       	push   $0x802894
  8007ee:	e8 02 03 00 00       	call   800af5 <cprintf>
  8007f3:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8007f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8007fb:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800801:	83 ec 08             	sub    $0x8,%esp
  800804:	50                   	push   %eax
  800805:	68 d5 28 80 00       	push   $0x8028d5
  80080a:	e8 e6 02 00 00       	call   800af5 <cprintf>
  80080f:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800812:	83 ec 0c             	sub    $0xc,%esp
  800815:	68 44 28 80 00       	push   $0x802844
  80081a:	e8 d6 02 00 00       	call   800af5 <cprintf>
  80081f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800822:	e8 29 16 00 00       	call   801e50 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800827:	e8 19 00 00 00       	call   800845 <exit>
}
  80082c:	90                   	nop
  80082d:	c9                   	leave  
  80082e:	c3                   	ret    

0080082f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80082f:	55                   	push   %ebp
  800830:	89 e5                	mov    %esp,%ebp
  800832:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800835:	83 ec 0c             	sub    $0xc,%esp
  800838:	6a 00                	push   $0x0
  80083a:	e8 28 14 00 00       	call   801c67 <sys_env_destroy>
  80083f:	83 c4 10             	add    $0x10,%esp
}
  800842:	90                   	nop
  800843:	c9                   	leave  
  800844:	c3                   	ret    

00800845 <exit>:

void
exit(void)
{
  800845:	55                   	push   %ebp
  800846:	89 e5                	mov    %esp,%ebp
  800848:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80084b:	e8 7d 14 00 00       	call   801ccd <sys_env_exit>
}
  800850:	90                   	nop
  800851:	c9                   	leave  
  800852:	c3                   	ret    

00800853 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800853:	55                   	push   %ebp
  800854:	89 e5                	mov    %esp,%ebp
  800856:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800859:	8d 45 10             	lea    0x10(%ebp),%eax
  80085c:	83 c0 04             	add    $0x4,%eax
  80085f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800862:	a1 18 31 80 00       	mov    0x803118,%eax
  800867:	85 c0                	test   %eax,%eax
  800869:	74 16                	je     800881 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80086b:	a1 18 31 80 00       	mov    0x803118,%eax
  800870:	83 ec 08             	sub    $0x8,%esp
  800873:	50                   	push   %eax
  800874:	68 ec 28 80 00       	push   $0x8028ec
  800879:	e8 77 02 00 00       	call   800af5 <cprintf>
  80087e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800881:	a1 00 30 80 00       	mov    0x803000,%eax
  800886:	ff 75 0c             	pushl  0xc(%ebp)
  800889:	ff 75 08             	pushl  0x8(%ebp)
  80088c:	50                   	push   %eax
  80088d:	68 f1 28 80 00       	push   $0x8028f1
  800892:	e8 5e 02 00 00       	call   800af5 <cprintf>
  800897:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80089a:	8b 45 10             	mov    0x10(%ebp),%eax
  80089d:	83 ec 08             	sub    $0x8,%esp
  8008a0:	ff 75 f4             	pushl  -0xc(%ebp)
  8008a3:	50                   	push   %eax
  8008a4:	e8 e1 01 00 00       	call   800a8a <vcprintf>
  8008a9:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8008ac:	83 ec 08             	sub    $0x8,%esp
  8008af:	6a 00                	push   $0x0
  8008b1:	68 0d 29 80 00       	push   $0x80290d
  8008b6:	e8 cf 01 00 00       	call   800a8a <vcprintf>
  8008bb:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8008be:	e8 82 ff ff ff       	call   800845 <exit>

	// should not return here
	while (1) ;
  8008c3:	eb fe                	jmp    8008c3 <_panic+0x70>

008008c5 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8008c5:	55                   	push   %ebp
  8008c6:	89 e5                	mov    %esp,%ebp
  8008c8:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8008cb:	a1 20 30 80 00       	mov    0x803020,%eax
  8008d0:	8b 50 74             	mov    0x74(%eax),%edx
  8008d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d6:	39 c2                	cmp    %eax,%edx
  8008d8:	74 14                	je     8008ee <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8008da:	83 ec 04             	sub    $0x4,%esp
  8008dd:	68 10 29 80 00       	push   $0x802910
  8008e2:	6a 26                	push   $0x26
  8008e4:	68 5c 29 80 00       	push   $0x80295c
  8008e9:	e8 65 ff ff ff       	call   800853 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8008ee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8008f5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8008fc:	e9 b6 00 00 00       	jmp    8009b7 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800901:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800904:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80090b:	8b 45 08             	mov    0x8(%ebp),%eax
  80090e:	01 d0                	add    %edx,%eax
  800910:	8b 00                	mov    (%eax),%eax
  800912:	85 c0                	test   %eax,%eax
  800914:	75 08                	jne    80091e <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800916:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800919:	e9 96 00 00 00       	jmp    8009b4 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80091e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800925:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80092c:	eb 5d                	jmp    80098b <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80092e:	a1 20 30 80 00       	mov    0x803020,%eax
  800933:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800939:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80093c:	c1 e2 04             	shl    $0x4,%edx
  80093f:	01 d0                	add    %edx,%eax
  800941:	8a 40 04             	mov    0x4(%eax),%al
  800944:	84 c0                	test   %al,%al
  800946:	75 40                	jne    800988 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800948:	a1 20 30 80 00       	mov    0x803020,%eax
  80094d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800953:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800956:	c1 e2 04             	shl    $0x4,%edx
  800959:	01 d0                	add    %edx,%eax
  80095b:	8b 00                	mov    (%eax),%eax
  80095d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800960:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800963:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800968:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80096a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80096d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800974:	8b 45 08             	mov    0x8(%ebp),%eax
  800977:	01 c8                	add    %ecx,%eax
  800979:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80097b:	39 c2                	cmp    %eax,%edx
  80097d:	75 09                	jne    800988 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80097f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800986:	eb 12                	jmp    80099a <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800988:	ff 45 e8             	incl   -0x18(%ebp)
  80098b:	a1 20 30 80 00       	mov    0x803020,%eax
  800990:	8b 50 74             	mov    0x74(%eax),%edx
  800993:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800996:	39 c2                	cmp    %eax,%edx
  800998:	77 94                	ja     80092e <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80099a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80099e:	75 14                	jne    8009b4 <CheckWSWithoutLastIndex+0xef>
			panic(
  8009a0:	83 ec 04             	sub    $0x4,%esp
  8009a3:	68 68 29 80 00       	push   $0x802968
  8009a8:	6a 3a                	push   $0x3a
  8009aa:	68 5c 29 80 00       	push   $0x80295c
  8009af:	e8 9f fe ff ff       	call   800853 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8009b4:	ff 45 f0             	incl   -0x10(%ebp)
  8009b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ba:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009bd:	0f 8c 3e ff ff ff    	jl     800901 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8009c3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009ca:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8009d1:	eb 20                	jmp    8009f3 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8009d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8009d8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009de:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009e1:	c1 e2 04             	shl    $0x4,%edx
  8009e4:	01 d0                	add    %edx,%eax
  8009e6:	8a 40 04             	mov    0x4(%eax),%al
  8009e9:	3c 01                	cmp    $0x1,%al
  8009eb:	75 03                	jne    8009f0 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8009ed:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009f0:	ff 45 e0             	incl   -0x20(%ebp)
  8009f3:	a1 20 30 80 00       	mov    0x803020,%eax
  8009f8:	8b 50 74             	mov    0x74(%eax),%edx
  8009fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009fe:	39 c2                	cmp    %eax,%edx
  800a00:	77 d1                	ja     8009d3 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a05:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a08:	74 14                	je     800a1e <CheckWSWithoutLastIndex+0x159>
		panic(
  800a0a:	83 ec 04             	sub    $0x4,%esp
  800a0d:	68 bc 29 80 00       	push   $0x8029bc
  800a12:	6a 44                	push   $0x44
  800a14:	68 5c 29 80 00       	push   $0x80295c
  800a19:	e8 35 fe ff ff       	call   800853 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a1e:	90                   	nop
  800a1f:	c9                   	leave  
  800a20:	c3                   	ret    

00800a21 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800a21:	55                   	push   %ebp
  800a22:	89 e5                	mov    %esp,%ebp
  800a24:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800a27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2a:	8b 00                	mov    (%eax),%eax
  800a2c:	8d 48 01             	lea    0x1(%eax),%ecx
  800a2f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a32:	89 0a                	mov    %ecx,(%edx)
  800a34:	8b 55 08             	mov    0x8(%ebp),%edx
  800a37:	88 d1                	mov    %dl,%cl
  800a39:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a3c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a43:	8b 00                	mov    (%eax),%eax
  800a45:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a4a:	75 2c                	jne    800a78 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a4c:	a0 24 30 80 00       	mov    0x803024,%al
  800a51:	0f b6 c0             	movzbl %al,%eax
  800a54:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a57:	8b 12                	mov    (%edx),%edx
  800a59:	89 d1                	mov    %edx,%ecx
  800a5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a5e:	83 c2 08             	add    $0x8,%edx
  800a61:	83 ec 04             	sub    $0x4,%esp
  800a64:	50                   	push   %eax
  800a65:	51                   	push   %ecx
  800a66:	52                   	push   %edx
  800a67:	e8 b9 11 00 00       	call   801c25 <sys_cputs>
  800a6c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a72:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7b:	8b 40 04             	mov    0x4(%eax),%eax
  800a7e:	8d 50 01             	lea    0x1(%eax),%edx
  800a81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a84:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a87:	90                   	nop
  800a88:	c9                   	leave  
  800a89:	c3                   	ret    

00800a8a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a8a:	55                   	push   %ebp
  800a8b:	89 e5                	mov    %esp,%ebp
  800a8d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a93:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a9a:	00 00 00 
	b.cnt = 0;
  800a9d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800aa4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800aa7:	ff 75 0c             	pushl  0xc(%ebp)
  800aaa:	ff 75 08             	pushl  0x8(%ebp)
  800aad:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ab3:	50                   	push   %eax
  800ab4:	68 21 0a 80 00       	push   $0x800a21
  800ab9:	e8 11 02 00 00       	call   800ccf <vprintfmt>
  800abe:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800ac1:	a0 24 30 80 00       	mov    0x803024,%al
  800ac6:	0f b6 c0             	movzbl %al,%eax
  800ac9:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800acf:	83 ec 04             	sub    $0x4,%esp
  800ad2:	50                   	push   %eax
  800ad3:	52                   	push   %edx
  800ad4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ada:	83 c0 08             	add    $0x8,%eax
  800add:	50                   	push   %eax
  800ade:	e8 42 11 00 00       	call   801c25 <sys_cputs>
  800ae3:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800ae6:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800aed:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800af3:	c9                   	leave  
  800af4:	c3                   	ret    

00800af5 <cprintf>:

int cprintf(const char *fmt, ...) {
  800af5:	55                   	push   %ebp
  800af6:	89 e5                	mov    %esp,%ebp
  800af8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800afb:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800b02:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b05:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	83 ec 08             	sub    $0x8,%esp
  800b0e:	ff 75 f4             	pushl  -0xc(%ebp)
  800b11:	50                   	push   %eax
  800b12:	e8 73 ff ff ff       	call   800a8a <vcprintf>
  800b17:	83 c4 10             	add    $0x10,%esp
  800b1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b20:	c9                   	leave  
  800b21:	c3                   	ret    

00800b22 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800b22:	55                   	push   %ebp
  800b23:	89 e5                	mov    %esp,%ebp
  800b25:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800b28:	e8 09 13 00 00       	call   801e36 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800b2d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b30:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	83 ec 08             	sub    $0x8,%esp
  800b39:	ff 75 f4             	pushl  -0xc(%ebp)
  800b3c:	50                   	push   %eax
  800b3d:	e8 48 ff ff ff       	call   800a8a <vcprintf>
  800b42:	83 c4 10             	add    $0x10,%esp
  800b45:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800b48:	e8 03 13 00 00       	call   801e50 <sys_enable_interrupt>
	return cnt;
  800b4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b50:	c9                   	leave  
  800b51:	c3                   	ret    

00800b52 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b52:	55                   	push   %ebp
  800b53:	89 e5                	mov    %esp,%ebp
  800b55:	53                   	push   %ebx
  800b56:	83 ec 14             	sub    $0x14,%esp
  800b59:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b5f:	8b 45 14             	mov    0x14(%ebp),%eax
  800b62:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b65:	8b 45 18             	mov    0x18(%ebp),%eax
  800b68:	ba 00 00 00 00       	mov    $0x0,%edx
  800b6d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b70:	77 55                	ja     800bc7 <printnum+0x75>
  800b72:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b75:	72 05                	jb     800b7c <printnum+0x2a>
  800b77:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b7a:	77 4b                	ja     800bc7 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b7c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b7f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b82:	8b 45 18             	mov    0x18(%ebp),%eax
  800b85:	ba 00 00 00 00       	mov    $0x0,%edx
  800b8a:	52                   	push   %edx
  800b8b:	50                   	push   %eax
  800b8c:	ff 75 f4             	pushl  -0xc(%ebp)
  800b8f:	ff 75 f0             	pushl  -0x10(%ebp)
  800b92:	e8 c1 16 00 00       	call   802258 <__udivdi3>
  800b97:	83 c4 10             	add    $0x10,%esp
  800b9a:	83 ec 04             	sub    $0x4,%esp
  800b9d:	ff 75 20             	pushl  0x20(%ebp)
  800ba0:	53                   	push   %ebx
  800ba1:	ff 75 18             	pushl  0x18(%ebp)
  800ba4:	52                   	push   %edx
  800ba5:	50                   	push   %eax
  800ba6:	ff 75 0c             	pushl  0xc(%ebp)
  800ba9:	ff 75 08             	pushl  0x8(%ebp)
  800bac:	e8 a1 ff ff ff       	call   800b52 <printnum>
  800bb1:	83 c4 20             	add    $0x20,%esp
  800bb4:	eb 1a                	jmp    800bd0 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800bb6:	83 ec 08             	sub    $0x8,%esp
  800bb9:	ff 75 0c             	pushl  0xc(%ebp)
  800bbc:	ff 75 20             	pushl  0x20(%ebp)
  800bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc2:	ff d0                	call   *%eax
  800bc4:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800bc7:	ff 4d 1c             	decl   0x1c(%ebp)
  800bca:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800bce:	7f e6                	jg     800bb6 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800bd0:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800bd3:	bb 00 00 00 00       	mov    $0x0,%ebx
  800bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bdb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bde:	53                   	push   %ebx
  800bdf:	51                   	push   %ecx
  800be0:	52                   	push   %edx
  800be1:	50                   	push   %eax
  800be2:	e8 81 17 00 00       	call   802368 <__umoddi3>
  800be7:	83 c4 10             	add    $0x10,%esp
  800bea:	05 34 2c 80 00       	add    $0x802c34,%eax
  800bef:	8a 00                	mov    (%eax),%al
  800bf1:	0f be c0             	movsbl %al,%eax
  800bf4:	83 ec 08             	sub    $0x8,%esp
  800bf7:	ff 75 0c             	pushl  0xc(%ebp)
  800bfa:	50                   	push   %eax
  800bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfe:	ff d0                	call   *%eax
  800c00:	83 c4 10             	add    $0x10,%esp
}
  800c03:	90                   	nop
  800c04:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c07:	c9                   	leave  
  800c08:	c3                   	ret    

00800c09 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c09:	55                   	push   %ebp
  800c0a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c0c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c10:	7e 1c                	jle    800c2e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c12:	8b 45 08             	mov    0x8(%ebp),%eax
  800c15:	8b 00                	mov    (%eax),%eax
  800c17:	8d 50 08             	lea    0x8(%eax),%edx
  800c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1d:	89 10                	mov    %edx,(%eax)
  800c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c22:	8b 00                	mov    (%eax),%eax
  800c24:	83 e8 08             	sub    $0x8,%eax
  800c27:	8b 50 04             	mov    0x4(%eax),%edx
  800c2a:	8b 00                	mov    (%eax),%eax
  800c2c:	eb 40                	jmp    800c6e <getuint+0x65>
	else if (lflag)
  800c2e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c32:	74 1e                	je     800c52 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800c34:	8b 45 08             	mov    0x8(%ebp),%eax
  800c37:	8b 00                	mov    (%eax),%eax
  800c39:	8d 50 04             	lea    0x4(%eax),%edx
  800c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3f:	89 10                	mov    %edx,(%eax)
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	8b 00                	mov    (%eax),%eax
  800c46:	83 e8 04             	sub    $0x4,%eax
  800c49:	8b 00                	mov    (%eax),%eax
  800c4b:	ba 00 00 00 00       	mov    $0x0,%edx
  800c50:	eb 1c                	jmp    800c6e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	8b 00                	mov    (%eax),%eax
  800c57:	8d 50 04             	lea    0x4(%eax),%edx
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	89 10                	mov    %edx,(%eax)
  800c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c62:	8b 00                	mov    (%eax),%eax
  800c64:	83 e8 04             	sub    $0x4,%eax
  800c67:	8b 00                	mov    (%eax),%eax
  800c69:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c6e:	5d                   	pop    %ebp
  800c6f:	c3                   	ret    

00800c70 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c70:	55                   	push   %ebp
  800c71:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c73:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c77:	7e 1c                	jle    800c95 <getint+0x25>
		return va_arg(*ap, long long);
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	8b 00                	mov    (%eax),%eax
  800c7e:	8d 50 08             	lea    0x8(%eax),%edx
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	89 10                	mov    %edx,(%eax)
  800c86:	8b 45 08             	mov    0x8(%ebp),%eax
  800c89:	8b 00                	mov    (%eax),%eax
  800c8b:	83 e8 08             	sub    $0x8,%eax
  800c8e:	8b 50 04             	mov    0x4(%eax),%edx
  800c91:	8b 00                	mov    (%eax),%eax
  800c93:	eb 38                	jmp    800ccd <getint+0x5d>
	else if (lflag)
  800c95:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c99:	74 1a                	je     800cb5 <getint+0x45>
		return va_arg(*ap, long);
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	8b 00                	mov    (%eax),%eax
  800ca0:	8d 50 04             	lea    0x4(%eax),%edx
  800ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca6:	89 10                	mov    %edx,(%eax)
  800ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cab:	8b 00                	mov    (%eax),%eax
  800cad:	83 e8 04             	sub    $0x4,%eax
  800cb0:	8b 00                	mov    (%eax),%eax
  800cb2:	99                   	cltd   
  800cb3:	eb 18                	jmp    800ccd <getint+0x5d>
	else
		return va_arg(*ap, int);
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	8b 00                	mov    (%eax),%eax
  800cba:	8d 50 04             	lea    0x4(%eax),%edx
  800cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc0:	89 10                	mov    %edx,(%eax)
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	8b 00                	mov    (%eax),%eax
  800cc7:	83 e8 04             	sub    $0x4,%eax
  800cca:	8b 00                	mov    (%eax),%eax
  800ccc:	99                   	cltd   
}
  800ccd:	5d                   	pop    %ebp
  800cce:	c3                   	ret    

00800ccf <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800ccf:	55                   	push   %ebp
  800cd0:	89 e5                	mov    %esp,%ebp
  800cd2:	56                   	push   %esi
  800cd3:	53                   	push   %ebx
  800cd4:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800cd7:	eb 17                	jmp    800cf0 <vprintfmt+0x21>
			if (ch == '\0')
  800cd9:	85 db                	test   %ebx,%ebx
  800cdb:	0f 84 af 03 00 00    	je     801090 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ce1:	83 ec 08             	sub    $0x8,%esp
  800ce4:	ff 75 0c             	pushl  0xc(%ebp)
  800ce7:	53                   	push   %ebx
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ceb:	ff d0                	call   *%eax
  800ced:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800cf0:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf3:	8d 50 01             	lea    0x1(%eax),%edx
  800cf6:	89 55 10             	mov    %edx,0x10(%ebp)
  800cf9:	8a 00                	mov    (%eax),%al
  800cfb:	0f b6 d8             	movzbl %al,%ebx
  800cfe:	83 fb 25             	cmp    $0x25,%ebx
  800d01:	75 d6                	jne    800cd9 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d03:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d07:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d0e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d15:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800d1c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800d23:	8b 45 10             	mov    0x10(%ebp),%eax
  800d26:	8d 50 01             	lea    0x1(%eax),%edx
  800d29:	89 55 10             	mov    %edx,0x10(%ebp)
  800d2c:	8a 00                	mov    (%eax),%al
  800d2e:	0f b6 d8             	movzbl %al,%ebx
  800d31:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800d34:	83 f8 55             	cmp    $0x55,%eax
  800d37:	0f 87 2b 03 00 00    	ja     801068 <vprintfmt+0x399>
  800d3d:	8b 04 85 58 2c 80 00 	mov    0x802c58(,%eax,4),%eax
  800d44:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d46:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d4a:	eb d7                	jmp    800d23 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d4c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d50:	eb d1                	jmp    800d23 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d52:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d59:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d5c:	89 d0                	mov    %edx,%eax
  800d5e:	c1 e0 02             	shl    $0x2,%eax
  800d61:	01 d0                	add    %edx,%eax
  800d63:	01 c0                	add    %eax,%eax
  800d65:	01 d8                	add    %ebx,%eax
  800d67:	83 e8 30             	sub    $0x30,%eax
  800d6a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d6d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d70:	8a 00                	mov    (%eax),%al
  800d72:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d75:	83 fb 2f             	cmp    $0x2f,%ebx
  800d78:	7e 3e                	jle    800db8 <vprintfmt+0xe9>
  800d7a:	83 fb 39             	cmp    $0x39,%ebx
  800d7d:	7f 39                	jg     800db8 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d7f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d82:	eb d5                	jmp    800d59 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d84:	8b 45 14             	mov    0x14(%ebp),%eax
  800d87:	83 c0 04             	add    $0x4,%eax
  800d8a:	89 45 14             	mov    %eax,0x14(%ebp)
  800d8d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d90:	83 e8 04             	sub    $0x4,%eax
  800d93:	8b 00                	mov    (%eax),%eax
  800d95:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d98:	eb 1f                	jmp    800db9 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d9a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d9e:	79 83                	jns    800d23 <vprintfmt+0x54>
				width = 0;
  800da0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800da7:	e9 77 ff ff ff       	jmp    800d23 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800dac:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800db3:	e9 6b ff ff ff       	jmp    800d23 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800db8:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800db9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dbd:	0f 89 60 ff ff ff    	jns    800d23 <vprintfmt+0x54>
				width = precision, precision = -1;
  800dc3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800dc6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800dc9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800dd0:	e9 4e ff ff ff       	jmp    800d23 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800dd5:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800dd8:	e9 46 ff ff ff       	jmp    800d23 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ddd:	8b 45 14             	mov    0x14(%ebp),%eax
  800de0:	83 c0 04             	add    $0x4,%eax
  800de3:	89 45 14             	mov    %eax,0x14(%ebp)
  800de6:	8b 45 14             	mov    0x14(%ebp),%eax
  800de9:	83 e8 04             	sub    $0x4,%eax
  800dec:	8b 00                	mov    (%eax),%eax
  800dee:	83 ec 08             	sub    $0x8,%esp
  800df1:	ff 75 0c             	pushl  0xc(%ebp)
  800df4:	50                   	push   %eax
  800df5:	8b 45 08             	mov    0x8(%ebp),%eax
  800df8:	ff d0                	call   *%eax
  800dfa:	83 c4 10             	add    $0x10,%esp
			break;
  800dfd:	e9 89 02 00 00       	jmp    80108b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e02:	8b 45 14             	mov    0x14(%ebp),%eax
  800e05:	83 c0 04             	add    $0x4,%eax
  800e08:	89 45 14             	mov    %eax,0x14(%ebp)
  800e0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e0e:	83 e8 04             	sub    $0x4,%eax
  800e11:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e13:	85 db                	test   %ebx,%ebx
  800e15:	79 02                	jns    800e19 <vprintfmt+0x14a>
				err = -err;
  800e17:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e19:	83 fb 64             	cmp    $0x64,%ebx
  800e1c:	7f 0b                	jg     800e29 <vprintfmt+0x15a>
  800e1e:	8b 34 9d a0 2a 80 00 	mov    0x802aa0(,%ebx,4),%esi
  800e25:	85 f6                	test   %esi,%esi
  800e27:	75 19                	jne    800e42 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800e29:	53                   	push   %ebx
  800e2a:	68 45 2c 80 00       	push   $0x802c45
  800e2f:	ff 75 0c             	pushl  0xc(%ebp)
  800e32:	ff 75 08             	pushl  0x8(%ebp)
  800e35:	e8 5e 02 00 00       	call   801098 <printfmt>
  800e3a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800e3d:	e9 49 02 00 00       	jmp    80108b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e42:	56                   	push   %esi
  800e43:	68 4e 2c 80 00       	push   $0x802c4e
  800e48:	ff 75 0c             	pushl  0xc(%ebp)
  800e4b:	ff 75 08             	pushl  0x8(%ebp)
  800e4e:	e8 45 02 00 00       	call   801098 <printfmt>
  800e53:	83 c4 10             	add    $0x10,%esp
			break;
  800e56:	e9 30 02 00 00       	jmp    80108b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e5b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e5e:	83 c0 04             	add    $0x4,%eax
  800e61:	89 45 14             	mov    %eax,0x14(%ebp)
  800e64:	8b 45 14             	mov    0x14(%ebp),%eax
  800e67:	83 e8 04             	sub    $0x4,%eax
  800e6a:	8b 30                	mov    (%eax),%esi
  800e6c:	85 f6                	test   %esi,%esi
  800e6e:	75 05                	jne    800e75 <vprintfmt+0x1a6>
				p = "(null)";
  800e70:	be 51 2c 80 00       	mov    $0x802c51,%esi
			if (width > 0 && padc != '-')
  800e75:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e79:	7e 6d                	jle    800ee8 <vprintfmt+0x219>
  800e7b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e7f:	74 67                	je     800ee8 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e81:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e84:	83 ec 08             	sub    $0x8,%esp
  800e87:	50                   	push   %eax
  800e88:	56                   	push   %esi
  800e89:	e8 0c 03 00 00       	call   80119a <strnlen>
  800e8e:	83 c4 10             	add    $0x10,%esp
  800e91:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e94:	eb 16                	jmp    800eac <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e96:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e9a:	83 ec 08             	sub    $0x8,%esp
  800e9d:	ff 75 0c             	pushl  0xc(%ebp)
  800ea0:	50                   	push   %eax
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea4:	ff d0                	call   *%eax
  800ea6:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ea9:	ff 4d e4             	decl   -0x1c(%ebp)
  800eac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800eb0:	7f e4                	jg     800e96 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800eb2:	eb 34                	jmp    800ee8 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800eb4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800eb8:	74 1c                	je     800ed6 <vprintfmt+0x207>
  800eba:	83 fb 1f             	cmp    $0x1f,%ebx
  800ebd:	7e 05                	jle    800ec4 <vprintfmt+0x1f5>
  800ebf:	83 fb 7e             	cmp    $0x7e,%ebx
  800ec2:	7e 12                	jle    800ed6 <vprintfmt+0x207>
					putch('?', putdat);
  800ec4:	83 ec 08             	sub    $0x8,%esp
  800ec7:	ff 75 0c             	pushl  0xc(%ebp)
  800eca:	6a 3f                	push   $0x3f
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecf:	ff d0                	call   *%eax
  800ed1:	83 c4 10             	add    $0x10,%esp
  800ed4:	eb 0f                	jmp    800ee5 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800ed6:	83 ec 08             	sub    $0x8,%esp
  800ed9:	ff 75 0c             	pushl  0xc(%ebp)
  800edc:	53                   	push   %ebx
  800edd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee0:	ff d0                	call   *%eax
  800ee2:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ee5:	ff 4d e4             	decl   -0x1c(%ebp)
  800ee8:	89 f0                	mov    %esi,%eax
  800eea:	8d 70 01             	lea    0x1(%eax),%esi
  800eed:	8a 00                	mov    (%eax),%al
  800eef:	0f be d8             	movsbl %al,%ebx
  800ef2:	85 db                	test   %ebx,%ebx
  800ef4:	74 24                	je     800f1a <vprintfmt+0x24b>
  800ef6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800efa:	78 b8                	js     800eb4 <vprintfmt+0x1e5>
  800efc:	ff 4d e0             	decl   -0x20(%ebp)
  800eff:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f03:	79 af                	jns    800eb4 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f05:	eb 13                	jmp    800f1a <vprintfmt+0x24b>
				putch(' ', putdat);
  800f07:	83 ec 08             	sub    $0x8,%esp
  800f0a:	ff 75 0c             	pushl  0xc(%ebp)
  800f0d:	6a 20                	push   $0x20
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	ff d0                	call   *%eax
  800f14:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f17:	ff 4d e4             	decl   -0x1c(%ebp)
  800f1a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f1e:	7f e7                	jg     800f07 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800f20:	e9 66 01 00 00       	jmp    80108b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f25:	83 ec 08             	sub    $0x8,%esp
  800f28:	ff 75 e8             	pushl  -0x18(%ebp)
  800f2b:	8d 45 14             	lea    0x14(%ebp),%eax
  800f2e:	50                   	push   %eax
  800f2f:	e8 3c fd ff ff       	call   800c70 <getint>
  800f34:	83 c4 10             	add    $0x10,%esp
  800f37:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f3a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800f3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f40:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f43:	85 d2                	test   %edx,%edx
  800f45:	79 23                	jns    800f6a <vprintfmt+0x29b>
				putch('-', putdat);
  800f47:	83 ec 08             	sub    $0x8,%esp
  800f4a:	ff 75 0c             	pushl  0xc(%ebp)
  800f4d:	6a 2d                	push   $0x2d
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	ff d0                	call   *%eax
  800f54:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f57:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f5a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f5d:	f7 d8                	neg    %eax
  800f5f:	83 d2 00             	adc    $0x0,%edx
  800f62:	f7 da                	neg    %edx
  800f64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f67:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f6a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f71:	e9 bc 00 00 00       	jmp    801032 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f76:	83 ec 08             	sub    $0x8,%esp
  800f79:	ff 75 e8             	pushl  -0x18(%ebp)
  800f7c:	8d 45 14             	lea    0x14(%ebp),%eax
  800f7f:	50                   	push   %eax
  800f80:	e8 84 fc ff ff       	call   800c09 <getuint>
  800f85:	83 c4 10             	add    $0x10,%esp
  800f88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f8b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f8e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f95:	e9 98 00 00 00       	jmp    801032 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f9a:	83 ec 08             	sub    $0x8,%esp
  800f9d:	ff 75 0c             	pushl  0xc(%ebp)
  800fa0:	6a 58                	push   $0x58
  800fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa5:	ff d0                	call   *%eax
  800fa7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800faa:	83 ec 08             	sub    $0x8,%esp
  800fad:	ff 75 0c             	pushl  0xc(%ebp)
  800fb0:	6a 58                	push   $0x58
  800fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb5:	ff d0                	call   *%eax
  800fb7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800fba:	83 ec 08             	sub    $0x8,%esp
  800fbd:	ff 75 0c             	pushl  0xc(%ebp)
  800fc0:	6a 58                	push   $0x58
  800fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc5:	ff d0                	call   *%eax
  800fc7:	83 c4 10             	add    $0x10,%esp
			break;
  800fca:	e9 bc 00 00 00       	jmp    80108b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800fcf:	83 ec 08             	sub    $0x8,%esp
  800fd2:	ff 75 0c             	pushl  0xc(%ebp)
  800fd5:	6a 30                	push   $0x30
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	ff d0                	call   *%eax
  800fdc:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800fdf:	83 ec 08             	sub    $0x8,%esp
  800fe2:	ff 75 0c             	pushl  0xc(%ebp)
  800fe5:	6a 78                	push   $0x78
  800fe7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fea:	ff d0                	call   *%eax
  800fec:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800fef:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff2:	83 c0 04             	add    $0x4,%eax
  800ff5:	89 45 14             	mov    %eax,0x14(%ebp)
  800ff8:	8b 45 14             	mov    0x14(%ebp),%eax
  800ffb:	83 e8 04             	sub    $0x4,%eax
  800ffe:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801000:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801003:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80100a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801011:	eb 1f                	jmp    801032 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801013:	83 ec 08             	sub    $0x8,%esp
  801016:	ff 75 e8             	pushl  -0x18(%ebp)
  801019:	8d 45 14             	lea    0x14(%ebp),%eax
  80101c:	50                   	push   %eax
  80101d:	e8 e7 fb ff ff       	call   800c09 <getuint>
  801022:	83 c4 10             	add    $0x10,%esp
  801025:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801028:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80102b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801032:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801036:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801039:	83 ec 04             	sub    $0x4,%esp
  80103c:	52                   	push   %edx
  80103d:	ff 75 e4             	pushl  -0x1c(%ebp)
  801040:	50                   	push   %eax
  801041:	ff 75 f4             	pushl  -0xc(%ebp)
  801044:	ff 75 f0             	pushl  -0x10(%ebp)
  801047:	ff 75 0c             	pushl  0xc(%ebp)
  80104a:	ff 75 08             	pushl  0x8(%ebp)
  80104d:	e8 00 fb ff ff       	call   800b52 <printnum>
  801052:	83 c4 20             	add    $0x20,%esp
			break;
  801055:	eb 34                	jmp    80108b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801057:	83 ec 08             	sub    $0x8,%esp
  80105a:	ff 75 0c             	pushl  0xc(%ebp)
  80105d:	53                   	push   %ebx
  80105e:	8b 45 08             	mov    0x8(%ebp),%eax
  801061:	ff d0                	call   *%eax
  801063:	83 c4 10             	add    $0x10,%esp
			break;
  801066:	eb 23                	jmp    80108b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801068:	83 ec 08             	sub    $0x8,%esp
  80106b:	ff 75 0c             	pushl  0xc(%ebp)
  80106e:	6a 25                	push   $0x25
  801070:	8b 45 08             	mov    0x8(%ebp),%eax
  801073:	ff d0                	call   *%eax
  801075:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801078:	ff 4d 10             	decl   0x10(%ebp)
  80107b:	eb 03                	jmp    801080 <vprintfmt+0x3b1>
  80107d:	ff 4d 10             	decl   0x10(%ebp)
  801080:	8b 45 10             	mov    0x10(%ebp),%eax
  801083:	48                   	dec    %eax
  801084:	8a 00                	mov    (%eax),%al
  801086:	3c 25                	cmp    $0x25,%al
  801088:	75 f3                	jne    80107d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80108a:	90                   	nop
		}
	}
  80108b:	e9 47 fc ff ff       	jmp    800cd7 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801090:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801091:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801094:	5b                   	pop    %ebx
  801095:	5e                   	pop    %esi
  801096:	5d                   	pop    %ebp
  801097:	c3                   	ret    

00801098 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801098:	55                   	push   %ebp
  801099:	89 e5                	mov    %esp,%ebp
  80109b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80109e:	8d 45 10             	lea    0x10(%ebp),%eax
  8010a1:	83 c0 04             	add    $0x4,%eax
  8010a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8010a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010aa:	ff 75 f4             	pushl  -0xc(%ebp)
  8010ad:	50                   	push   %eax
  8010ae:	ff 75 0c             	pushl  0xc(%ebp)
  8010b1:	ff 75 08             	pushl  0x8(%ebp)
  8010b4:	e8 16 fc ff ff       	call   800ccf <vprintfmt>
  8010b9:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8010bc:	90                   	nop
  8010bd:	c9                   	leave  
  8010be:	c3                   	ret    

008010bf <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8010bf:	55                   	push   %ebp
  8010c0:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8010c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c5:	8b 40 08             	mov    0x8(%eax),%eax
  8010c8:	8d 50 01             	lea    0x1(%eax),%edx
  8010cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ce:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8010d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d4:	8b 10                	mov    (%eax),%edx
  8010d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d9:	8b 40 04             	mov    0x4(%eax),%eax
  8010dc:	39 c2                	cmp    %eax,%edx
  8010de:	73 12                	jae    8010f2 <sprintputch+0x33>
		*b->buf++ = ch;
  8010e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e3:	8b 00                	mov    (%eax),%eax
  8010e5:	8d 48 01             	lea    0x1(%eax),%ecx
  8010e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010eb:	89 0a                	mov    %ecx,(%edx)
  8010ed:	8b 55 08             	mov    0x8(%ebp),%edx
  8010f0:	88 10                	mov    %dl,(%eax)
}
  8010f2:	90                   	nop
  8010f3:	5d                   	pop    %ebp
  8010f4:	c3                   	ret    

008010f5 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8010f5:	55                   	push   %ebp
  8010f6:	89 e5                	mov    %esp,%ebp
  8010f8:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801101:	8b 45 0c             	mov    0xc(%ebp),%eax
  801104:	8d 50 ff             	lea    -0x1(%eax),%edx
  801107:	8b 45 08             	mov    0x8(%ebp),%eax
  80110a:	01 d0                	add    %edx,%eax
  80110c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80110f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801116:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80111a:	74 06                	je     801122 <vsnprintf+0x2d>
  80111c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801120:	7f 07                	jg     801129 <vsnprintf+0x34>
		return -E_INVAL;
  801122:	b8 03 00 00 00       	mov    $0x3,%eax
  801127:	eb 20                	jmp    801149 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801129:	ff 75 14             	pushl  0x14(%ebp)
  80112c:	ff 75 10             	pushl  0x10(%ebp)
  80112f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801132:	50                   	push   %eax
  801133:	68 bf 10 80 00       	push   $0x8010bf
  801138:	e8 92 fb ff ff       	call   800ccf <vprintfmt>
  80113d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801140:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801143:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801146:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801149:	c9                   	leave  
  80114a:	c3                   	ret    

0080114b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80114b:	55                   	push   %ebp
  80114c:	89 e5                	mov    %esp,%ebp
  80114e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801151:	8d 45 10             	lea    0x10(%ebp),%eax
  801154:	83 c0 04             	add    $0x4,%eax
  801157:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80115a:	8b 45 10             	mov    0x10(%ebp),%eax
  80115d:	ff 75 f4             	pushl  -0xc(%ebp)
  801160:	50                   	push   %eax
  801161:	ff 75 0c             	pushl  0xc(%ebp)
  801164:	ff 75 08             	pushl  0x8(%ebp)
  801167:	e8 89 ff ff ff       	call   8010f5 <vsnprintf>
  80116c:	83 c4 10             	add    $0x10,%esp
  80116f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801172:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801175:	c9                   	leave  
  801176:	c3                   	ret    

00801177 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801177:	55                   	push   %ebp
  801178:	89 e5                	mov    %esp,%ebp
  80117a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80117d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801184:	eb 06                	jmp    80118c <strlen+0x15>
		n++;
  801186:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801189:	ff 45 08             	incl   0x8(%ebp)
  80118c:	8b 45 08             	mov    0x8(%ebp),%eax
  80118f:	8a 00                	mov    (%eax),%al
  801191:	84 c0                	test   %al,%al
  801193:	75 f1                	jne    801186 <strlen+0xf>
		n++;
	return n;
  801195:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801198:	c9                   	leave  
  801199:	c3                   	ret    

0080119a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80119a:	55                   	push   %ebp
  80119b:	89 e5                	mov    %esp,%ebp
  80119d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8011a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011a7:	eb 09                	jmp    8011b2 <strnlen+0x18>
		n++;
  8011a9:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8011ac:	ff 45 08             	incl   0x8(%ebp)
  8011af:	ff 4d 0c             	decl   0xc(%ebp)
  8011b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011b6:	74 09                	je     8011c1 <strnlen+0x27>
  8011b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bb:	8a 00                	mov    (%eax),%al
  8011bd:	84 c0                	test   %al,%al
  8011bf:	75 e8                	jne    8011a9 <strnlen+0xf>
		n++;
	return n;
  8011c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011c4:	c9                   	leave  
  8011c5:	c3                   	ret    

008011c6 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8011c6:	55                   	push   %ebp
  8011c7:	89 e5                	mov    %esp,%ebp
  8011c9:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8011cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8011d2:	90                   	nop
  8011d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d6:	8d 50 01             	lea    0x1(%eax),%edx
  8011d9:	89 55 08             	mov    %edx,0x8(%ebp)
  8011dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011df:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011e2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8011e5:	8a 12                	mov    (%edx),%dl
  8011e7:	88 10                	mov    %dl,(%eax)
  8011e9:	8a 00                	mov    (%eax),%al
  8011eb:	84 c0                	test   %al,%al
  8011ed:	75 e4                	jne    8011d3 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8011ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8011f2:	c9                   	leave  
  8011f3:	c3                   	ret    

008011f4 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8011f4:	55                   	push   %ebp
  8011f5:	89 e5                	mov    %esp,%ebp
  8011f7:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801200:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801207:	eb 1f                	jmp    801228 <strncpy+0x34>
		*dst++ = *src;
  801209:	8b 45 08             	mov    0x8(%ebp),%eax
  80120c:	8d 50 01             	lea    0x1(%eax),%edx
  80120f:	89 55 08             	mov    %edx,0x8(%ebp)
  801212:	8b 55 0c             	mov    0xc(%ebp),%edx
  801215:	8a 12                	mov    (%edx),%dl
  801217:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801219:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121c:	8a 00                	mov    (%eax),%al
  80121e:	84 c0                	test   %al,%al
  801220:	74 03                	je     801225 <strncpy+0x31>
			src++;
  801222:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801225:	ff 45 fc             	incl   -0x4(%ebp)
  801228:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80122b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80122e:	72 d9                	jb     801209 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801230:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801233:	c9                   	leave  
  801234:	c3                   	ret    

00801235 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801235:	55                   	push   %ebp
  801236:	89 e5                	mov    %esp,%ebp
  801238:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80123b:	8b 45 08             	mov    0x8(%ebp),%eax
  80123e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801241:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801245:	74 30                	je     801277 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801247:	eb 16                	jmp    80125f <strlcpy+0x2a>
			*dst++ = *src++;
  801249:	8b 45 08             	mov    0x8(%ebp),%eax
  80124c:	8d 50 01             	lea    0x1(%eax),%edx
  80124f:	89 55 08             	mov    %edx,0x8(%ebp)
  801252:	8b 55 0c             	mov    0xc(%ebp),%edx
  801255:	8d 4a 01             	lea    0x1(%edx),%ecx
  801258:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80125b:	8a 12                	mov    (%edx),%dl
  80125d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80125f:	ff 4d 10             	decl   0x10(%ebp)
  801262:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801266:	74 09                	je     801271 <strlcpy+0x3c>
  801268:	8b 45 0c             	mov    0xc(%ebp),%eax
  80126b:	8a 00                	mov    (%eax),%al
  80126d:	84 c0                	test   %al,%al
  80126f:	75 d8                	jne    801249 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801271:	8b 45 08             	mov    0x8(%ebp),%eax
  801274:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801277:	8b 55 08             	mov    0x8(%ebp),%edx
  80127a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80127d:	29 c2                	sub    %eax,%edx
  80127f:	89 d0                	mov    %edx,%eax
}
  801281:	c9                   	leave  
  801282:	c3                   	ret    

00801283 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801283:	55                   	push   %ebp
  801284:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801286:	eb 06                	jmp    80128e <strcmp+0xb>
		p++, q++;
  801288:	ff 45 08             	incl   0x8(%ebp)
  80128b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80128e:	8b 45 08             	mov    0x8(%ebp),%eax
  801291:	8a 00                	mov    (%eax),%al
  801293:	84 c0                	test   %al,%al
  801295:	74 0e                	je     8012a5 <strcmp+0x22>
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	8a 10                	mov    (%eax),%dl
  80129c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129f:	8a 00                	mov    (%eax),%al
  8012a1:	38 c2                	cmp    %al,%dl
  8012a3:	74 e3                	je     801288 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8012a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a8:	8a 00                	mov    (%eax),%al
  8012aa:	0f b6 d0             	movzbl %al,%edx
  8012ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b0:	8a 00                	mov    (%eax),%al
  8012b2:	0f b6 c0             	movzbl %al,%eax
  8012b5:	29 c2                	sub    %eax,%edx
  8012b7:	89 d0                	mov    %edx,%eax
}
  8012b9:	5d                   	pop    %ebp
  8012ba:	c3                   	ret    

008012bb <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8012bb:	55                   	push   %ebp
  8012bc:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8012be:	eb 09                	jmp    8012c9 <strncmp+0xe>
		n--, p++, q++;
  8012c0:	ff 4d 10             	decl   0x10(%ebp)
  8012c3:	ff 45 08             	incl   0x8(%ebp)
  8012c6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8012c9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012cd:	74 17                	je     8012e6 <strncmp+0x2b>
  8012cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d2:	8a 00                	mov    (%eax),%al
  8012d4:	84 c0                	test   %al,%al
  8012d6:	74 0e                	je     8012e6 <strncmp+0x2b>
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012db:	8a 10                	mov    (%eax),%dl
  8012dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e0:	8a 00                	mov    (%eax),%al
  8012e2:	38 c2                	cmp    %al,%dl
  8012e4:	74 da                	je     8012c0 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8012e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012ea:	75 07                	jne    8012f3 <strncmp+0x38>
		return 0;
  8012ec:	b8 00 00 00 00       	mov    $0x0,%eax
  8012f1:	eb 14                	jmp    801307 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8012f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f6:	8a 00                	mov    (%eax),%al
  8012f8:	0f b6 d0             	movzbl %al,%edx
  8012fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fe:	8a 00                	mov    (%eax),%al
  801300:	0f b6 c0             	movzbl %al,%eax
  801303:	29 c2                	sub    %eax,%edx
  801305:	89 d0                	mov    %edx,%eax
}
  801307:	5d                   	pop    %ebp
  801308:	c3                   	ret    

00801309 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801309:	55                   	push   %ebp
  80130a:	89 e5                	mov    %esp,%ebp
  80130c:	83 ec 04             	sub    $0x4,%esp
  80130f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801312:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801315:	eb 12                	jmp    801329 <strchr+0x20>
		if (*s == c)
  801317:	8b 45 08             	mov    0x8(%ebp),%eax
  80131a:	8a 00                	mov    (%eax),%al
  80131c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80131f:	75 05                	jne    801326 <strchr+0x1d>
			return (char *) s;
  801321:	8b 45 08             	mov    0x8(%ebp),%eax
  801324:	eb 11                	jmp    801337 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801326:	ff 45 08             	incl   0x8(%ebp)
  801329:	8b 45 08             	mov    0x8(%ebp),%eax
  80132c:	8a 00                	mov    (%eax),%al
  80132e:	84 c0                	test   %al,%al
  801330:	75 e5                	jne    801317 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801332:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801337:	c9                   	leave  
  801338:	c3                   	ret    

00801339 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801339:	55                   	push   %ebp
  80133a:	89 e5                	mov    %esp,%ebp
  80133c:	83 ec 04             	sub    $0x4,%esp
  80133f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801342:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801345:	eb 0d                	jmp    801354 <strfind+0x1b>
		if (*s == c)
  801347:	8b 45 08             	mov    0x8(%ebp),%eax
  80134a:	8a 00                	mov    (%eax),%al
  80134c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80134f:	74 0e                	je     80135f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801351:	ff 45 08             	incl   0x8(%ebp)
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
  801357:	8a 00                	mov    (%eax),%al
  801359:	84 c0                	test   %al,%al
  80135b:	75 ea                	jne    801347 <strfind+0xe>
  80135d:	eb 01                	jmp    801360 <strfind+0x27>
		if (*s == c)
			break;
  80135f:	90                   	nop
	return (char *) s;
  801360:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801363:	c9                   	leave  
  801364:	c3                   	ret    

00801365 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801365:	55                   	push   %ebp
  801366:	89 e5                	mov    %esp,%ebp
  801368:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801371:	8b 45 10             	mov    0x10(%ebp),%eax
  801374:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801377:	eb 0e                	jmp    801387 <memset+0x22>
		*p++ = c;
  801379:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80137c:	8d 50 01             	lea    0x1(%eax),%edx
  80137f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801382:	8b 55 0c             	mov    0xc(%ebp),%edx
  801385:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801387:	ff 4d f8             	decl   -0x8(%ebp)
  80138a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80138e:	79 e9                	jns    801379 <memset+0x14>
		*p++ = c;

	return v;
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801393:	c9                   	leave  
  801394:	c3                   	ret    

00801395 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
  801398:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80139b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8013a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8013a7:	eb 16                	jmp    8013bf <memcpy+0x2a>
		*d++ = *s++;
  8013a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013ac:	8d 50 01             	lea    0x1(%eax),%edx
  8013af:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013b2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013b5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013b8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8013bb:	8a 12                	mov    (%edx),%dl
  8013bd:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8013bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013c5:	89 55 10             	mov    %edx,0x10(%ebp)
  8013c8:	85 c0                	test   %eax,%eax
  8013ca:	75 dd                	jne    8013a9 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8013cc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013cf:	c9                   	leave  
  8013d0:	c3                   	ret    

008013d1 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8013d1:	55                   	push   %ebp
  8013d2:	89 e5                	mov    %esp,%ebp
  8013d4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8013d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013da:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8013dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8013e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013e6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8013e9:	73 50                	jae    80143b <memmove+0x6a>
  8013eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f1:	01 d0                	add    %edx,%eax
  8013f3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8013f6:	76 43                	jbe    80143b <memmove+0x6a>
		s += n;
  8013f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013fb:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8013fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801401:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801404:	eb 10                	jmp    801416 <memmove+0x45>
			*--d = *--s;
  801406:	ff 4d f8             	decl   -0x8(%ebp)
  801409:	ff 4d fc             	decl   -0x4(%ebp)
  80140c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80140f:	8a 10                	mov    (%eax),%dl
  801411:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801414:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801416:	8b 45 10             	mov    0x10(%ebp),%eax
  801419:	8d 50 ff             	lea    -0x1(%eax),%edx
  80141c:	89 55 10             	mov    %edx,0x10(%ebp)
  80141f:	85 c0                	test   %eax,%eax
  801421:	75 e3                	jne    801406 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801423:	eb 23                	jmp    801448 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801425:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801428:	8d 50 01             	lea    0x1(%eax),%edx
  80142b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80142e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801431:	8d 4a 01             	lea    0x1(%edx),%ecx
  801434:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801437:	8a 12                	mov    (%edx),%dl
  801439:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80143b:	8b 45 10             	mov    0x10(%ebp),%eax
  80143e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801441:	89 55 10             	mov    %edx,0x10(%ebp)
  801444:	85 c0                	test   %eax,%eax
  801446:	75 dd                	jne    801425 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801448:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80144b:	c9                   	leave  
  80144c:	c3                   	ret    

0080144d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80144d:	55                   	push   %ebp
  80144e:	89 e5                	mov    %esp,%ebp
  801450:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801453:	8b 45 08             	mov    0x8(%ebp),%eax
  801456:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801459:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80145f:	eb 2a                	jmp    80148b <memcmp+0x3e>
		if (*s1 != *s2)
  801461:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801464:	8a 10                	mov    (%eax),%dl
  801466:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801469:	8a 00                	mov    (%eax),%al
  80146b:	38 c2                	cmp    %al,%dl
  80146d:	74 16                	je     801485 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80146f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801472:	8a 00                	mov    (%eax),%al
  801474:	0f b6 d0             	movzbl %al,%edx
  801477:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80147a:	8a 00                	mov    (%eax),%al
  80147c:	0f b6 c0             	movzbl %al,%eax
  80147f:	29 c2                	sub    %eax,%edx
  801481:	89 d0                	mov    %edx,%eax
  801483:	eb 18                	jmp    80149d <memcmp+0x50>
		s1++, s2++;
  801485:	ff 45 fc             	incl   -0x4(%ebp)
  801488:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80148b:	8b 45 10             	mov    0x10(%ebp),%eax
  80148e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801491:	89 55 10             	mov    %edx,0x10(%ebp)
  801494:	85 c0                	test   %eax,%eax
  801496:	75 c9                	jne    801461 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801498:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80149d:	c9                   	leave  
  80149e:	c3                   	ret    

0080149f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80149f:	55                   	push   %ebp
  8014a0:	89 e5                	mov    %esp,%ebp
  8014a2:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8014a5:	8b 55 08             	mov    0x8(%ebp),%edx
  8014a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ab:	01 d0                	add    %edx,%eax
  8014ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8014b0:	eb 15                	jmp    8014c7 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8014b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b5:	8a 00                	mov    (%eax),%al
  8014b7:	0f b6 d0             	movzbl %al,%edx
  8014ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bd:	0f b6 c0             	movzbl %al,%eax
  8014c0:	39 c2                	cmp    %eax,%edx
  8014c2:	74 0d                	je     8014d1 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8014c4:	ff 45 08             	incl   0x8(%ebp)
  8014c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ca:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8014cd:	72 e3                	jb     8014b2 <memfind+0x13>
  8014cf:	eb 01                	jmp    8014d2 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8014d1:	90                   	nop
	return (void *) s;
  8014d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014d5:	c9                   	leave  
  8014d6:	c3                   	ret    

008014d7 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8014d7:	55                   	push   %ebp
  8014d8:	89 e5                	mov    %esp,%ebp
  8014da:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8014dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8014e4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8014eb:	eb 03                	jmp    8014f0 <strtol+0x19>
		s++;
  8014ed:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8014f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f3:	8a 00                	mov    (%eax),%al
  8014f5:	3c 20                	cmp    $0x20,%al
  8014f7:	74 f4                	je     8014ed <strtol+0x16>
  8014f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fc:	8a 00                	mov    (%eax),%al
  8014fe:	3c 09                	cmp    $0x9,%al
  801500:	74 eb                	je     8014ed <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801502:	8b 45 08             	mov    0x8(%ebp),%eax
  801505:	8a 00                	mov    (%eax),%al
  801507:	3c 2b                	cmp    $0x2b,%al
  801509:	75 05                	jne    801510 <strtol+0x39>
		s++;
  80150b:	ff 45 08             	incl   0x8(%ebp)
  80150e:	eb 13                	jmp    801523 <strtol+0x4c>
	else if (*s == '-')
  801510:	8b 45 08             	mov    0x8(%ebp),%eax
  801513:	8a 00                	mov    (%eax),%al
  801515:	3c 2d                	cmp    $0x2d,%al
  801517:	75 0a                	jne    801523 <strtol+0x4c>
		s++, neg = 1;
  801519:	ff 45 08             	incl   0x8(%ebp)
  80151c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801523:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801527:	74 06                	je     80152f <strtol+0x58>
  801529:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80152d:	75 20                	jne    80154f <strtol+0x78>
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	8a 00                	mov    (%eax),%al
  801534:	3c 30                	cmp    $0x30,%al
  801536:	75 17                	jne    80154f <strtol+0x78>
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	40                   	inc    %eax
  80153c:	8a 00                	mov    (%eax),%al
  80153e:	3c 78                	cmp    $0x78,%al
  801540:	75 0d                	jne    80154f <strtol+0x78>
		s += 2, base = 16;
  801542:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801546:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80154d:	eb 28                	jmp    801577 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80154f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801553:	75 15                	jne    80156a <strtol+0x93>
  801555:	8b 45 08             	mov    0x8(%ebp),%eax
  801558:	8a 00                	mov    (%eax),%al
  80155a:	3c 30                	cmp    $0x30,%al
  80155c:	75 0c                	jne    80156a <strtol+0x93>
		s++, base = 8;
  80155e:	ff 45 08             	incl   0x8(%ebp)
  801561:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801568:	eb 0d                	jmp    801577 <strtol+0xa0>
	else if (base == 0)
  80156a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80156e:	75 07                	jne    801577 <strtol+0xa0>
		base = 10;
  801570:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801577:	8b 45 08             	mov    0x8(%ebp),%eax
  80157a:	8a 00                	mov    (%eax),%al
  80157c:	3c 2f                	cmp    $0x2f,%al
  80157e:	7e 19                	jle    801599 <strtol+0xc2>
  801580:	8b 45 08             	mov    0x8(%ebp),%eax
  801583:	8a 00                	mov    (%eax),%al
  801585:	3c 39                	cmp    $0x39,%al
  801587:	7f 10                	jg     801599 <strtol+0xc2>
			dig = *s - '0';
  801589:	8b 45 08             	mov    0x8(%ebp),%eax
  80158c:	8a 00                	mov    (%eax),%al
  80158e:	0f be c0             	movsbl %al,%eax
  801591:	83 e8 30             	sub    $0x30,%eax
  801594:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801597:	eb 42                	jmp    8015db <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801599:	8b 45 08             	mov    0x8(%ebp),%eax
  80159c:	8a 00                	mov    (%eax),%al
  80159e:	3c 60                	cmp    $0x60,%al
  8015a0:	7e 19                	jle    8015bb <strtol+0xe4>
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	8a 00                	mov    (%eax),%al
  8015a7:	3c 7a                	cmp    $0x7a,%al
  8015a9:	7f 10                	jg     8015bb <strtol+0xe4>
			dig = *s - 'a' + 10;
  8015ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ae:	8a 00                	mov    (%eax),%al
  8015b0:	0f be c0             	movsbl %al,%eax
  8015b3:	83 e8 57             	sub    $0x57,%eax
  8015b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8015b9:	eb 20                	jmp    8015db <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8015bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015be:	8a 00                	mov    (%eax),%al
  8015c0:	3c 40                	cmp    $0x40,%al
  8015c2:	7e 39                	jle    8015fd <strtol+0x126>
  8015c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c7:	8a 00                	mov    (%eax),%al
  8015c9:	3c 5a                	cmp    $0x5a,%al
  8015cb:	7f 30                	jg     8015fd <strtol+0x126>
			dig = *s - 'A' + 10;
  8015cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d0:	8a 00                	mov    (%eax),%al
  8015d2:	0f be c0             	movsbl %al,%eax
  8015d5:	83 e8 37             	sub    $0x37,%eax
  8015d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8015db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015de:	3b 45 10             	cmp    0x10(%ebp),%eax
  8015e1:	7d 19                	jge    8015fc <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8015e3:	ff 45 08             	incl   0x8(%ebp)
  8015e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e9:	0f af 45 10          	imul   0x10(%ebp),%eax
  8015ed:	89 c2                	mov    %eax,%edx
  8015ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015f2:	01 d0                	add    %edx,%eax
  8015f4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8015f7:	e9 7b ff ff ff       	jmp    801577 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8015fc:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8015fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801601:	74 08                	je     80160b <strtol+0x134>
		*endptr = (char *) s;
  801603:	8b 45 0c             	mov    0xc(%ebp),%eax
  801606:	8b 55 08             	mov    0x8(%ebp),%edx
  801609:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80160b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80160f:	74 07                	je     801618 <strtol+0x141>
  801611:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801614:	f7 d8                	neg    %eax
  801616:	eb 03                	jmp    80161b <strtol+0x144>
  801618:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80161b:	c9                   	leave  
  80161c:	c3                   	ret    

0080161d <ltostr>:

void
ltostr(long value, char *str)
{
  80161d:	55                   	push   %ebp
  80161e:	89 e5                	mov    %esp,%ebp
  801620:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801623:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80162a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801631:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801635:	79 13                	jns    80164a <ltostr+0x2d>
	{
		neg = 1;
  801637:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80163e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801641:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801644:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801647:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80164a:	8b 45 08             	mov    0x8(%ebp),%eax
  80164d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801652:	99                   	cltd   
  801653:	f7 f9                	idiv   %ecx
  801655:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801658:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80165b:	8d 50 01             	lea    0x1(%eax),%edx
  80165e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801661:	89 c2                	mov    %eax,%edx
  801663:	8b 45 0c             	mov    0xc(%ebp),%eax
  801666:	01 d0                	add    %edx,%eax
  801668:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80166b:	83 c2 30             	add    $0x30,%edx
  80166e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801670:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801673:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801678:	f7 e9                	imul   %ecx
  80167a:	c1 fa 02             	sar    $0x2,%edx
  80167d:	89 c8                	mov    %ecx,%eax
  80167f:	c1 f8 1f             	sar    $0x1f,%eax
  801682:	29 c2                	sub    %eax,%edx
  801684:	89 d0                	mov    %edx,%eax
  801686:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801689:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80168c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801691:	f7 e9                	imul   %ecx
  801693:	c1 fa 02             	sar    $0x2,%edx
  801696:	89 c8                	mov    %ecx,%eax
  801698:	c1 f8 1f             	sar    $0x1f,%eax
  80169b:	29 c2                	sub    %eax,%edx
  80169d:	89 d0                	mov    %edx,%eax
  80169f:	c1 e0 02             	shl    $0x2,%eax
  8016a2:	01 d0                	add    %edx,%eax
  8016a4:	01 c0                	add    %eax,%eax
  8016a6:	29 c1                	sub    %eax,%ecx
  8016a8:	89 ca                	mov    %ecx,%edx
  8016aa:	85 d2                	test   %edx,%edx
  8016ac:	75 9c                	jne    80164a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8016ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8016b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b8:	48                   	dec    %eax
  8016b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8016bc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016c0:	74 3d                	je     8016ff <ltostr+0xe2>
		start = 1 ;
  8016c2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8016c9:	eb 34                	jmp    8016ff <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8016cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d1:	01 d0                	add    %edx,%eax
  8016d3:	8a 00                	mov    (%eax),%al
  8016d5:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8016d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016de:	01 c2                	add    %eax,%edx
  8016e0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8016e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e6:	01 c8                	add    %ecx,%eax
  8016e8:	8a 00                	mov    (%eax),%al
  8016ea:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8016ec:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8016ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f2:	01 c2                	add    %eax,%edx
  8016f4:	8a 45 eb             	mov    -0x15(%ebp),%al
  8016f7:	88 02                	mov    %al,(%edx)
		start++ ;
  8016f9:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8016fc:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8016ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801702:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801705:	7c c4                	jl     8016cb <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801707:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80170a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80170d:	01 d0                	add    %edx,%eax
  80170f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801712:	90                   	nop
  801713:	c9                   	leave  
  801714:	c3                   	ret    

00801715 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801715:	55                   	push   %ebp
  801716:	89 e5                	mov    %esp,%ebp
  801718:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80171b:	ff 75 08             	pushl  0x8(%ebp)
  80171e:	e8 54 fa ff ff       	call   801177 <strlen>
  801723:	83 c4 04             	add    $0x4,%esp
  801726:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801729:	ff 75 0c             	pushl  0xc(%ebp)
  80172c:	e8 46 fa ff ff       	call   801177 <strlen>
  801731:	83 c4 04             	add    $0x4,%esp
  801734:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801737:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80173e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801745:	eb 17                	jmp    80175e <strcconcat+0x49>
		final[s] = str1[s] ;
  801747:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80174a:	8b 45 10             	mov    0x10(%ebp),%eax
  80174d:	01 c2                	add    %eax,%edx
  80174f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801752:	8b 45 08             	mov    0x8(%ebp),%eax
  801755:	01 c8                	add    %ecx,%eax
  801757:	8a 00                	mov    (%eax),%al
  801759:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80175b:	ff 45 fc             	incl   -0x4(%ebp)
  80175e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801761:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801764:	7c e1                	jl     801747 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801766:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80176d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801774:	eb 1f                	jmp    801795 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801776:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801779:	8d 50 01             	lea    0x1(%eax),%edx
  80177c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80177f:	89 c2                	mov    %eax,%edx
  801781:	8b 45 10             	mov    0x10(%ebp),%eax
  801784:	01 c2                	add    %eax,%edx
  801786:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801789:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178c:	01 c8                	add    %ecx,%eax
  80178e:	8a 00                	mov    (%eax),%al
  801790:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801792:	ff 45 f8             	incl   -0x8(%ebp)
  801795:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801798:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80179b:	7c d9                	jl     801776 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80179d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8017a3:	01 d0                	add    %edx,%eax
  8017a5:	c6 00 00             	movb   $0x0,(%eax)
}
  8017a8:	90                   	nop
  8017a9:	c9                   	leave  
  8017aa:	c3                   	ret    

008017ab <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8017ab:	55                   	push   %ebp
  8017ac:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8017ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8017b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8017b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8017ba:	8b 00                	mov    (%eax),%eax
  8017bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8017c6:	01 d0                	add    %edx,%eax
  8017c8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8017ce:	eb 0c                	jmp    8017dc <strsplit+0x31>
			*string++ = 0;
  8017d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d3:	8d 50 01             	lea    0x1(%eax),%edx
  8017d6:	89 55 08             	mov    %edx,0x8(%ebp)
  8017d9:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8017dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017df:	8a 00                	mov    (%eax),%al
  8017e1:	84 c0                	test   %al,%al
  8017e3:	74 18                	je     8017fd <strsplit+0x52>
  8017e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e8:	8a 00                	mov    (%eax),%al
  8017ea:	0f be c0             	movsbl %al,%eax
  8017ed:	50                   	push   %eax
  8017ee:	ff 75 0c             	pushl  0xc(%ebp)
  8017f1:	e8 13 fb ff ff       	call   801309 <strchr>
  8017f6:	83 c4 08             	add    $0x8,%esp
  8017f9:	85 c0                	test   %eax,%eax
  8017fb:	75 d3                	jne    8017d0 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8017fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801800:	8a 00                	mov    (%eax),%al
  801802:	84 c0                	test   %al,%al
  801804:	74 5a                	je     801860 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801806:	8b 45 14             	mov    0x14(%ebp),%eax
  801809:	8b 00                	mov    (%eax),%eax
  80180b:	83 f8 0f             	cmp    $0xf,%eax
  80180e:	75 07                	jne    801817 <strsplit+0x6c>
		{
			return 0;
  801810:	b8 00 00 00 00       	mov    $0x0,%eax
  801815:	eb 66                	jmp    80187d <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801817:	8b 45 14             	mov    0x14(%ebp),%eax
  80181a:	8b 00                	mov    (%eax),%eax
  80181c:	8d 48 01             	lea    0x1(%eax),%ecx
  80181f:	8b 55 14             	mov    0x14(%ebp),%edx
  801822:	89 0a                	mov    %ecx,(%edx)
  801824:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80182b:	8b 45 10             	mov    0x10(%ebp),%eax
  80182e:	01 c2                	add    %eax,%edx
  801830:	8b 45 08             	mov    0x8(%ebp),%eax
  801833:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801835:	eb 03                	jmp    80183a <strsplit+0x8f>
			string++;
  801837:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80183a:	8b 45 08             	mov    0x8(%ebp),%eax
  80183d:	8a 00                	mov    (%eax),%al
  80183f:	84 c0                	test   %al,%al
  801841:	74 8b                	je     8017ce <strsplit+0x23>
  801843:	8b 45 08             	mov    0x8(%ebp),%eax
  801846:	8a 00                	mov    (%eax),%al
  801848:	0f be c0             	movsbl %al,%eax
  80184b:	50                   	push   %eax
  80184c:	ff 75 0c             	pushl  0xc(%ebp)
  80184f:	e8 b5 fa ff ff       	call   801309 <strchr>
  801854:	83 c4 08             	add    $0x8,%esp
  801857:	85 c0                	test   %eax,%eax
  801859:	74 dc                	je     801837 <strsplit+0x8c>
			string++;
	}
  80185b:	e9 6e ff ff ff       	jmp    8017ce <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801860:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801861:	8b 45 14             	mov    0x14(%ebp),%eax
  801864:	8b 00                	mov    (%eax),%eax
  801866:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80186d:	8b 45 10             	mov    0x10(%ebp),%eax
  801870:	01 d0                	add    %edx,%eax
  801872:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801878:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80187d:	c9                   	leave  
  80187e:	c3                   	ret    

0080187f <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  80187f:	55                   	push   %ebp
  801880:	89 e5                	mov    %esp,%ebp
  801882:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801885:	8b 45 08             	mov    0x8(%ebp),%eax
  801888:	c1 e8 0c             	shr    $0xc,%eax
  80188b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  80188e:	8b 45 08             	mov    0x8(%ebp),%eax
  801891:	25 ff 0f 00 00       	and    $0xfff,%eax
  801896:	85 c0                	test   %eax,%eax
  801898:	74 03                	je     80189d <malloc+0x1e>
			num++;
  80189a:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  80189d:	a1 04 30 80 00       	mov    0x803004,%eax
  8018a2:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8018a7:	75 73                	jne    80191c <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8018a9:	83 ec 08             	sub    $0x8,%esp
  8018ac:	ff 75 08             	pushl  0x8(%ebp)
  8018af:	68 00 00 00 80       	push   $0x80000000
  8018b4:	e8 14 05 00 00       	call   801dcd <sys_allocateMem>
  8018b9:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8018bc:	a1 04 30 80 00       	mov    0x803004,%eax
  8018c1:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8018c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018c7:	c1 e0 0c             	shl    $0xc,%eax
  8018ca:	89 c2                	mov    %eax,%edx
  8018cc:	a1 04 30 80 00       	mov    0x803004,%eax
  8018d1:	01 d0                	add    %edx,%eax
  8018d3:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  8018d8:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018e0:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  8018e7:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018ec:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8018f2:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  8018f9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018fe:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801905:	01 00 00 00 
			sizeofarray++;
  801909:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80190e:	40                   	inc    %eax
  80190f:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  801914:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801917:	e9 71 01 00 00       	jmp    801a8d <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  80191c:	a1 28 30 80 00       	mov    0x803028,%eax
  801921:	85 c0                	test   %eax,%eax
  801923:	75 71                	jne    801996 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801925:	a1 04 30 80 00       	mov    0x803004,%eax
  80192a:	83 ec 08             	sub    $0x8,%esp
  80192d:	ff 75 08             	pushl  0x8(%ebp)
  801930:	50                   	push   %eax
  801931:	e8 97 04 00 00       	call   801dcd <sys_allocateMem>
  801936:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801939:	a1 04 30 80 00       	mov    0x803004,%eax
  80193e:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801941:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801944:	c1 e0 0c             	shl    $0xc,%eax
  801947:	89 c2                	mov    %eax,%edx
  801949:	a1 04 30 80 00       	mov    0x803004,%eax
  80194e:	01 d0                	add    %edx,%eax
  801950:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801955:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80195a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80195d:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801964:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801969:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80196c:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801973:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801978:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  80197f:	01 00 00 00 
				sizeofarray++;
  801983:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801988:	40                   	inc    %eax
  801989:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  80198e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801991:	e9 f7 00 00 00       	jmp    801a8d <malloc+0x20e>
			}
			else{
				int count=0;
  801996:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  80199d:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8019a4:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8019ab:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8019b2:	eb 7c                	jmp    801a30 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  8019b4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8019bb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8019c2:	eb 1a                	jmp    8019de <malloc+0x15f>
					{
						if(addresses[j]==i)
  8019c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8019c7:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8019ce:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8019d1:	75 08                	jne    8019db <malloc+0x15c>
						{
							index=j;
  8019d3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8019d6:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  8019d9:	eb 0d                	jmp    8019e8 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  8019db:	ff 45 dc             	incl   -0x24(%ebp)
  8019de:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019e3:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8019e6:	7c dc                	jl     8019c4 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  8019e8:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8019ec:	75 05                	jne    8019f3 <malloc+0x174>
					{
						count++;
  8019ee:	ff 45 f0             	incl   -0x10(%ebp)
  8019f1:	eb 36                	jmp    801a29 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  8019f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019f6:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8019fd:	85 c0                	test   %eax,%eax
  8019ff:	75 05                	jne    801a06 <malloc+0x187>
						{
							count++;
  801a01:	ff 45 f0             	incl   -0x10(%ebp)
  801a04:	eb 23                	jmp    801a29 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801a06:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a09:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801a0c:	7d 14                	jge    801a22 <malloc+0x1a3>
  801a0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a11:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a14:	7c 0c                	jl     801a22 <malloc+0x1a3>
							{
								min=count;
  801a16:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a19:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801a1c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a1f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801a22:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801a29:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801a30:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801a37:	0f 86 77 ff ff ff    	jbe    8019b4 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801a3d:	83 ec 08             	sub    $0x8,%esp
  801a40:	ff 75 08             	pushl  0x8(%ebp)
  801a43:	ff 75 e4             	pushl  -0x1c(%ebp)
  801a46:	e8 82 03 00 00       	call   801dcd <sys_allocateMem>
  801a4b:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801a4e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a53:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a56:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801a5d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a62:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801a68:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801a6f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a74:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801a7b:	01 00 00 00 
				sizeofarray++;
  801a7f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a84:	40                   	inc    %eax
  801a85:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  801a8a:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801a8d:	c9                   	leave  
  801a8e:	c3                   	ret    

00801a8f <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801a8f:	55                   	push   %ebp
  801a90:	89 e5                	mov    %esp,%ebp
  801a92:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  801a95:	8b 45 08             	mov    0x8(%ebp),%eax
  801a98:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int size;
    int is_found=0;
  801a9b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  801aa2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801aa9:	eb 30                	jmp    801adb <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  801aab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801aae:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801ab5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801ab8:	75 1e                	jne    801ad8 <free+0x49>
  801aba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801abd:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801ac4:	83 f8 01             	cmp    $0x1,%eax
  801ac7:	75 0f                	jne    801ad8 <free+0x49>
    		is_found=1;
  801ac9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  801ad0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ad3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  801ad6:	eb 0d                	jmp    801ae5 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    int size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  801ad8:	ff 45 ec             	incl   -0x14(%ebp)
  801adb:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801ae0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801ae3:	7c c6                	jl     801aab <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  801ae5:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801ae9:	75 3b                	jne    801b26 <free+0x97>
    	size=numOfPages[index]*PAGE_SIZE;
  801aeb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801aee:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801af5:	c1 e0 0c             	shl    $0xc,%eax
  801af8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  801afb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801afe:	83 ec 08             	sub    $0x8,%esp
  801b01:	50                   	push   %eax
  801b02:	ff 75 e8             	pushl  -0x18(%ebp)
  801b05:	e8 a7 02 00 00       	call   801db1 <sys_freeMem>
  801b0a:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  801b0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b10:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801b17:	00 00 00 00 
    	changes++;
  801b1b:	a1 28 30 80 00       	mov    0x803028,%eax
  801b20:	40                   	inc    %eax
  801b21:	a3 28 30 80 00       	mov    %eax,0x803028
    }


	//refer to the project presentation and documentation for details
}
  801b26:	90                   	nop
  801b27:	c9                   	leave  
  801b28:	c3                   	ret    

00801b29 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b29:	55                   	push   %ebp
  801b2a:	89 e5                	mov    %esp,%ebp
  801b2c:	83 ec 18             	sub    $0x18,%esp
  801b2f:	8b 45 10             	mov    0x10(%ebp),%eax
  801b32:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801b35:	83 ec 04             	sub    $0x4,%esp
  801b38:	68 b0 2d 80 00       	push   $0x802db0
  801b3d:	68 9f 00 00 00       	push   $0x9f
  801b42:	68 d3 2d 80 00       	push   $0x802dd3
  801b47:	e8 07 ed ff ff       	call   800853 <_panic>

00801b4c <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b4c:	55                   	push   %ebp
  801b4d:	89 e5                	mov    %esp,%ebp
  801b4f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b52:	83 ec 04             	sub    $0x4,%esp
  801b55:	68 b0 2d 80 00       	push   $0x802db0
  801b5a:	68 a5 00 00 00       	push   $0xa5
  801b5f:	68 d3 2d 80 00       	push   $0x802dd3
  801b64:	e8 ea ec ff ff       	call   800853 <_panic>

00801b69 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801b69:	55                   	push   %ebp
  801b6a:	89 e5                	mov    %esp,%ebp
  801b6c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b6f:	83 ec 04             	sub    $0x4,%esp
  801b72:	68 b0 2d 80 00       	push   $0x802db0
  801b77:	68 ab 00 00 00       	push   $0xab
  801b7c:	68 d3 2d 80 00       	push   $0x802dd3
  801b81:	e8 cd ec ff ff       	call   800853 <_panic>

00801b86 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801b86:	55                   	push   %ebp
  801b87:	89 e5                	mov    %esp,%ebp
  801b89:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b8c:	83 ec 04             	sub    $0x4,%esp
  801b8f:	68 b0 2d 80 00       	push   $0x802db0
  801b94:	68 b0 00 00 00       	push   $0xb0
  801b99:	68 d3 2d 80 00       	push   $0x802dd3
  801b9e:	e8 b0 ec ff ff       	call   800853 <_panic>

00801ba3 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801ba3:	55                   	push   %ebp
  801ba4:	89 e5                	mov    %esp,%ebp
  801ba6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ba9:	83 ec 04             	sub    $0x4,%esp
  801bac:	68 b0 2d 80 00       	push   $0x802db0
  801bb1:	68 b6 00 00 00       	push   $0xb6
  801bb6:	68 d3 2d 80 00       	push   $0x802dd3
  801bbb:	e8 93 ec ff ff       	call   800853 <_panic>

00801bc0 <shrink>:
}
void shrink(uint32 newSize)
{
  801bc0:	55                   	push   %ebp
  801bc1:	89 e5                	mov    %esp,%ebp
  801bc3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bc6:	83 ec 04             	sub    $0x4,%esp
  801bc9:	68 b0 2d 80 00       	push   $0x802db0
  801bce:	68 ba 00 00 00       	push   $0xba
  801bd3:	68 d3 2d 80 00       	push   $0x802dd3
  801bd8:	e8 76 ec ff ff       	call   800853 <_panic>

00801bdd <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801bdd:	55                   	push   %ebp
  801bde:	89 e5                	mov    %esp,%ebp
  801be0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801be3:	83 ec 04             	sub    $0x4,%esp
  801be6:	68 b0 2d 80 00       	push   $0x802db0
  801beb:	68 bf 00 00 00       	push   $0xbf
  801bf0:	68 d3 2d 80 00       	push   $0x802dd3
  801bf5:	e8 59 ec ff ff       	call   800853 <_panic>

00801bfa <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801bfa:	55                   	push   %ebp
  801bfb:	89 e5                	mov    %esp,%ebp
  801bfd:	57                   	push   %edi
  801bfe:	56                   	push   %esi
  801bff:	53                   	push   %ebx
  801c00:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c03:	8b 45 08             	mov    0x8(%ebp),%eax
  801c06:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c09:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c0c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c0f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c12:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c15:	cd 30                	int    $0x30
  801c17:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c1d:	83 c4 10             	add    $0x10,%esp
  801c20:	5b                   	pop    %ebx
  801c21:	5e                   	pop    %esi
  801c22:	5f                   	pop    %edi
  801c23:	5d                   	pop    %ebp
  801c24:	c3                   	ret    

00801c25 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c25:	55                   	push   %ebp
  801c26:	89 e5                	mov    %esp,%ebp
  801c28:	83 ec 04             	sub    $0x4,%esp
  801c2b:	8b 45 10             	mov    0x10(%ebp),%eax
  801c2e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c31:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c35:	8b 45 08             	mov    0x8(%ebp),%eax
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	52                   	push   %edx
  801c3d:	ff 75 0c             	pushl  0xc(%ebp)
  801c40:	50                   	push   %eax
  801c41:	6a 00                	push   $0x0
  801c43:	e8 b2 ff ff ff       	call   801bfa <syscall>
  801c48:	83 c4 18             	add    $0x18,%esp
}
  801c4b:	90                   	nop
  801c4c:	c9                   	leave  
  801c4d:	c3                   	ret    

00801c4e <sys_cgetc>:

int
sys_cgetc(void)
{
  801c4e:	55                   	push   %ebp
  801c4f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c51:	6a 00                	push   $0x0
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 01                	push   $0x1
  801c5d:	e8 98 ff ff ff       	call   801bfa <syscall>
  801c62:	83 c4 18             	add    $0x18,%esp
}
  801c65:	c9                   	leave  
  801c66:	c3                   	ret    

00801c67 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c67:	55                   	push   %ebp
  801c68:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	50                   	push   %eax
  801c76:	6a 05                	push   $0x5
  801c78:	e8 7d ff ff ff       	call   801bfa <syscall>
  801c7d:	83 c4 18             	add    $0x18,%esp
}
  801c80:	c9                   	leave  
  801c81:	c3                   	ret    

00801c82 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c82:	55                   	push   %ebp
  801c83:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 02                	push   $0x2
  801c91:	e8 64 ff ff ff       	call   801bfa <syscall>
  801c96:	83 c4 18             	add    $0x18,%esp
}
  801c99:	c9                   	leave  
  801c9a:	c3                   	ret    

00801c9b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c9b:	55                   	push   %ebp
  801c9c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 03                	push   $0x3
  801caa:	e8 4b ff ff ff       	call   801bfa <syscall>
  801caf:	83 c4 18             	add    $0x18,%esp
}
  801cb2:	c9                   	leave  
  801cb3:	c3                   	ret    

00801cb4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801cb4:	55                   	push   %ebp
  801cb5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801cb7:	6a 00                	push   $0x0
  801cb9:	6a 00                	push   $0x0
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 00                	push   $0x0
  801cc1:	6a 04                	push   $0x4
  801cc3:	e8 32 ff ff ff       	call   801bfa <syscall>
  801cc8:	83 c4 18             	add    $0x18,%esp
}
  801ccb:	c9                   	leave  
  801ccc:	c3                   	ret    

00801ccd <sys_env_exit>:


void sys_env_exit(void)
{
  801ccd:	55                   	push   %ebp
  801cce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801cd0:	6a 00                	push   $0x0
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 06                	push   $0x6
  801cdc:	e8 19 ff ff ff       	call   801bfa <syscall>
  801ce1:	83 c4 18             	add    $0x18,%esp
}
  801ce4:	90                   	nop
  801ce5:	c9                   	leave  
  801ce6:	c3                   	ret    

00801ce7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801ce7:	55                   	push   %ebp
  801ce8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801cea:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ced:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	52                   	push   %edx
  801cf7:	50                   	push   %eax
  801cf8:	6a 07                	push   $0x7
  801cfa:	e8 fb fe ff ff       	call   801bfa <syscall>
  801cff:	83 c4 18             	add    $0x18,%esp
}
  801d02:	c9                   	leave  
  801d03:	c3                   	ret    

00801d04 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d04:	55                   	push   %ebp
  801d05:	89 e5                	mov    %esp,%ebp
  801d07:	56                   	push   %esi
  801d08:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d09:	8b 75 18             	mov    0x18(%ebp),%esi
  801d0c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d0f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d12:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d15:	8b 45 08             	mov    0x8(%ebp),%eax
  801d18:	56                   	push   %esi
  801d19:	53                   	push   %ebx
  801d1a:	51                   	push   %ecx
  801d1b:	52                   	push   %edx
  801d1c:	50                   	push   %eax
  801d1d:	6a 08                	push   $0x8
  801d1f:	e8 d6 fe ff ff       	call   801bfa <syscall>
  801d24:	83 c4 18             	add    $0x18,%esp
}
  801d27:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d2a:	5b                   	pop    %ebx
  801d2b:	5e                   	pop    %esi
  801d2c:	5d                   	pop    %ebp
  801d2d:	c3                   	ret    

00801d2e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d2e:	55                   	push   %ebp
  801d2f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d31:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d34:	8b 45 08             	mov    0x8(%ebp),%eax
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	52                   	push   %edx
  801d3e:	50                   	push   %eax
  801d3f:	6a 09                	push   $0x9
  801d41:	e8 b4 fe ff ff       	call   801bfa <syscall>
  801d46:	83 c4 18             	add    $0x18,%esp
}
  801d49:	c9                   	leave  
  801d4a:	c3                   	ret    

00801d4b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d4b:	55                   	push   %ebp
  801d4c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	6a 00                	push   $0x0
  801d54:	ff 75 0c             	pushl  0xc(%ebp)
  801d57:	ff 75 08             	pushl  0x8(%ebp)
  801d5a:	6a 0a                	push   $0xa
  801d5c:	e8 99 fe ff ff       	call   801bfa <syscall>
  801d61:	83 c4 18             	add    $0x18,%esp
}
  801d64:	c9                   	leave  
  801d65:	c3                   	ret    

00801d66 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d66:	55                   	push   %ebp
  801d67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 00                	push   $0x0
  801d6d:	6a 00                	push   $0x0
  801d6f:	6a 00                	push   $0x0
  801d71:	6a 00                	push   $0x0
  801d73:	6a 0b                	push   $0xb
  801d75:	e8 80 fe ff ff       	call   801bfa <syscall>
  801d7a:	83 c4 18             	add    $0x18,%esp
}
  801d7d:	c9                   	leave  
  801d7e:	c3                   	ret    

00801d7f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d7f:	55                   	push   %ebp
  801d80:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d82:	6a 00                	push   $0x0
  801d84:	6a 00                	push   $0x0
  801d86:	6a 00                	push   $0x0
  801d88:	6a 00                	push   $0x0
  801d8a:	6a 00                	push   $0x0
  801d8c:	6a 0c                	push   $0xc
  801d8e:	e8 67 fe ff ff       	call   801bfa <syscall>
  801d93:	83 c4 18             	add    $0x18,%esp
}
  801d96:	c9                   	leave  
  801d97:	c3                   	ret    

00801d98 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d98:	55                   	push   %ebp
  801d99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d9b:	6a 00                	push   $0x0
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	6a 0d                	push   $0xd
  801da7:	e8 4e fe ff ff       	call   801bfa <syscall>
  801dac:	83 c4 18             	add    $0x18,%esp
}
  801daf:	c9                   	leave  
  801db0:	c3                   	ret    

00801db1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801db1:	55                   	push   %ebp
  801db2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801db4:	6a 00                	push   $0x0
  801db6:	6a 00                	push   $0x0
  801db8:	6a 00                	push   $0x0
  801dba:	ff 75 0c             	pushl  0xc(%ebp)
  801dbd:	ff 75 08             	pushl  0x8(%ebp)
  801dc0:	6a 11                	push   $0x11
  801dc2:	e8 33 fe ff ff       	call   801bfa <syscall>
  801dc7:	83 c4 18             	add    $0x18,%esp
	return;
  801dca:	90                   	nop
}
  801dcb:	c9                   	leave  
  801dcc:	c3                   	ret    

00801dcd <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801dcd:	55                   	push   %ebp
  801dce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 00                	push   $0x0
  801dd6:	ff 75 0c             	pushl  0xc(%ebp)
  801dd9:	ff 75 08             	pushl  0x8(%ebp)
  801ddc:	6a 12                	push   $0x12
  801dde:	e8 17 fe ff ff       	call   801bfa <syscall>
  801de3:	83 c4 18             	add    $0x18,%esp
	return ;
  801de6:	90                   	nop
}
  801de7:	c9                   	leave  
  801de8:	c3                   	ret    

00801de9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801de9:	55                   	push   %ebp
  801dea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801dec:	6a 00                	push   $0x0
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	6a 0e                	push   $0xe
  801df8:	e8 fd fd ff ff       	call   801bfa <syscall>
  801dfd:	83 c4 18             	add    $0x18,%esp
}
  801e00:	c9                   	leave  
  801e01:	c3                   	ret    

00801e02 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e02:	55                   	push   %ebp
  801e03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e05:	6a 00                	push   $0x0
  801e07:	6a 00                	push   $0x0
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	ff 75 08             	pushl  0x8(%ebp)
  801e10:	6a 0f                	push   $0xf
  801e12:	e8 e3 fd ff ff       	call   801bfa <syscall>
  801e17:	83 c4 18             	add    $0x18,%esp
}
  801e1a:	c9                   	leave  
  801e1b:	c3                   	ret    

00801e1c <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e1c:	55                   	push   %ebp
  801e1d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 10                	push   $0x10
  801e2b:	e8 ca fd ff ff       	call   801bfa <syscall>
  801e30:	83 c4 18             	add    $0x18,%esp
}
  801e33:	90                   	nop
  801e34:	c9                   	leave  
  801e35:	c3                   	ret    

00801e36 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e36:	55                   	push   %ebp
  801e37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 14                	push   $0x14
  801e45:	e8 b0 fd ff ff       	call   801bfa <syscall>
  801e4a:	83 c4 18             	add    $0x18,%esp
}
  801e4d:	90                   	nop
  801e4e:	c9                   	leave  
  801e4f:	c3                   	ret    

00801e50 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e50:	55                   	push   %ebp
  801e51:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 15                	push   $0x15
  801e5f:	e8 96 fd ff ff       	call   801bfa <syscall>
  801e64:	83 c4 18             	add    $0x18,%esp
}
  801e67:	90                   	nop
  801e68:	c9                   	leave  
  801e69:	c3                   	ret    

00801e6a <sys_cputc>:


void
sys_cputc(const char c)
{
  801e6a:	55                   	push   %ebp
  801e6b:	89 e5                	mov    %esp,%ebp
  801e6d:	83 ec 04             	sub    $0x4,%esp
  801e70:	8b 45 08             	mov    0x8(%ebp),%eax
  801e73:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e76:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	50                   	push   %eax
  801e83:	6a 16                	push   $0x16
  801e85:	e8 70 fd ff ff       	call   801bfa <syscall>
  801e8a:	83 c4 18             	add    $0x18,%esp
}
  801e8d:	90                   	nop
  801e8e:	c9                   	leave  
  801e8f:	c3                   	ret    

00801e90 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e90:	55                   	push   %ebp
  801e91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e93:	6a 00                	push   $0x0
  801e95:	6a 00                	push   $0x0
  801e97:	6a 00                	push   $0x0
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 17                	push   $0x17
  801e9f:	e8 56 fd ff ff       	call   801bfa <syscall>
  801ea4:	83 c4 18             	add    $0x18,%esp
}
  801ea7:	90                   	nop
  801ea8:	c9                   	leave  
  801ea9:	c3                   	ret    

00801eaa <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801eaa:	55                   	push   %ebp
  801eab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ead:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb0:	6a 00                	push   $0x0
  801eb2:	6a 00                	push   $0x0
  801eb4:	6a 00                	push   $0x0
  801eb6:	ff 75 0c             	pushl  0xc(%ebp)
  801eb9:	50                   	push   %eax
  801eba:	6a 18                	push   $0x18
  801ebc:	e8 39 fd ff ff       	call   801bfa <syscall>
  801ec1:	83 c4 18             	add    $0x18,%esp
}
  801ec4:	c9                   	leave  
  801ec5:	c3                   	ret    

00801ec6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ec6:	55                   	push   %ebp
  801ec7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ec9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	52                   	push   %edx
  801ed6:	50                   	push   %eax
  801ed7:	6a 1b                	push   $0x1b
  801ed9:	e8 1c fd ff ff       	call   801bfa <syscall>
  801ede:	83 c4 18             	add    $0x18,%esp
}
  801ee1:	c9                   	leave  
  801ee2:	c3                   	ret    

00801ee3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ee3:	55                   	push   %ebp
  801ee4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ee6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ee9:	8b 45 08             	mov    0x8(%ebp),%eax
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	52                   	push   %edx
  801ef3:	50                   	push   %eax
  801ef4:	6a 19                	push   $0x19
  801ef6:	e8 ff fc ff ff       	call   801bfa <syscall>
  801efb:	83 c4 18             	add    $0x18,%esp
}
  801efe:	90                   	nop
  801eff:	c9                   	leave  
  801f00:	c3                   	ret    

00801f01 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f01:	55                   	push   %ebp
  801f02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f04:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f07:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0a:	6a 00                	push   $0x0
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 00                	push   $0x0
  801f10:	52                   	push   %edx
  801f11:	50                   	push   %eax
  801f12:	6a 1a                	push   $0x1a
  801f14:	e8 e1 fc ff ff       	call   801bfa <syscall>
  801f19:	83 c4 18             	add    $0x18,%esp
}
  801f1c:	90                   	nop
  801f1d:	c9                   	leave  
  801f1e:	c3                   	ret    

00801f1f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f1f:	55                   	push   %ebp
  801f20:	89 e5                	mov    %esp,%ebp
  801f22:	83 ec 04             	sub    $0x4,%esp
  801f25:	8b 45 10             	mov    0x10(%ebp),%eax
  801f28:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f2b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f2e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f32:	8b 45 08             	mov    0x8(%ebp),%eax
  801f35:	6a 00                	push   $0x0
  801f37:	51                   	push   %ecx
  801f38:	52                   	push   %edx
  801f39:	ff 75 0c             	pushl  0xc(%ebp)
  801f3c:	50                   	push   %eax
  801f3d:	6a 1c                	push   $0x1c
  801f3f:	e8 b6 fc ff ff       	call   801bfa <syscall>
  801f44:	83 c4 18             	add    $0x18,%esp
}
  801f47:	c9                   	leave  
  801f48:	c3                   	ret    

00801f49 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f49:	55                   	push   %ebp
  801f4a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	6a 00                	push   $0x0
  801f58:	52                   	push   %edx
  801f59:	50                   	push   %eax
  801f5a:	6a 1d                	push   $0x1d
  801f5c:	e8 99 fc ff ff       	call   801bfa <syscall>
  801f61:	83 c4 18             	add    $0x18,%esp
}
  801f64:	c9                   	leave  
  801f65:	c3                   	ret    

00801f66 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f66:	55                   	push   %ebp
  801f67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f69:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	51                   	push   %ecx
  801f77:	52                   	push   %edx
  801f78:	50                   	push   %eax
  801f79:	6a 1e                	push   $0x1e
  801f7b:	e8 7a fc ff ff       	call   801bfa <syscall>
  801f80:	83 c4 18             	add    $0x18,%esp
}
  801f83:	c9                   	leave  
  801f84:	c3                   	ret    

00801f85 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f85:	55                   	push   %ebp
  801f86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f88:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	52                   	push   %edx
  801f95:	50                   	push   %eax
  801f96:	6a 1f                	push   $0x1f
  801f98:	e8 5d fc ff ff       	call   801bfa <syscall>
  801f9d:	83 c4 18             	add    $0x18,%esp
}
  801fa0:	c9                   	leave  
  801fa1:	c3                   	ret    

00801fa2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801fa2:	55                   	push   %ebp
  801fa3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801fa5:	6a 00                	push   $0x0
  801fa7:	6a 00                	push   $0x0
  801fa9:	6a 00                	push   $0x0
  801fab:	6a 00                	push   $0x0
  801fad:	6a 00                	push   $0x0
  801faf:	6a 20                	push   $0x20
  801fb1:	e8 44 fc ff ff       	call   801bfa <syscall>
  801fb6:	83 c4 18             	add    $0x18,%esp
}
  801fb9:	c9                   	leave  
  801fba:	c3                   	ret    

00801fbb <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801fbb:	55                   	push   %ebp
  801fbc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc1:	6a 00                	push   $0x0
  801fc3:	ff 75 14             	pushl  0x14(%ebp)
  801fc6:	ff 75 10             	pushl  0x10(%ebp)
  801fc9:	ff 75 0c             	pushl  0xc(%ebp)
  801fcc:	50                   	push   %eax
  801fcd:	6a 21                	push   $0x21
  801fcf:	e8 26 fc ff ff       	call   801bfa <syscall>
  801fd4:	83 c4 18             	add    $0x18,%esp
}
  801fd7:	c9                   	leave  
  801fd8:	c3                   	ret    

00801fd9 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801fd9:	55                   	push   %ebp
  801fda:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  801fdf:	6a 00                	push   $0x0
  801fe1:	6a 00                	push   $0x0
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 00                	push   $0x0
  801fe7:	50                   	push   %eax
  801fe8:	6a 22                	push   $0x22
  801fea:	e8 0b fc ff ff       	call   801bfa <syscall>
  801fef:	83 c4 18             	add    $0x18,%esp
}
  801ff2:	90                   	nop
  801ff3:	c9                   	leave  
  801ff4:	c3                   	ret    

00801ff5 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ff5:	55                   	push   %ebp
  801ff6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ff8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	50                   	push   %eax
  802004:	6a 23                	push   $0x23
  802006:	e8 ef fb ff ff       	call   801bfa <syscall>
  80200b:	83 c4 18             	add    $0x18,%esp
}
  80200e:	90                   	nop
  80200f:	c9                   	leave  
  802010:	c3                   	ret    

00802011 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802011:	55                   	push   %ebp
  802012:	89 e5                	mov    %esp,%ebp
  802014:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802017:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80201a:	8d 50 04             	lea    0x4(%eax),%edx
  80201d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	52                   	push   %edx
  802027:	50                   	push   %eax
  802028:	6a 24                	push   $0x24
  80202a:	e8 cb fb ff ff       	call   801bfa <syscall>
  80202f:	83 c4 18             	add    $0x18,%esp
	return result;
  802032:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802035:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802038:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80203b:	89 01                	mov    %eax,(%ecx)
  80203d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802040:	8b 45 08             	mov    0x8(%ebp),%eax
  802043:	c9                   	leave  
  802044:	c2 04 00             	ret    $0x4

00802047 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802047:	55                   	push   %ebp
  802048:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	ff 75 10             	pushl  0x10(%ebp)
  802051:	ff 75 0c             	pushl  0xc(%ebp)
  802054:	ff 75 08             	pushl  0x8(%ebp)
  802057:	6a 13                	push   $0x13
  802059:	e8 9c fb ff ff       	call   801bfa <syscall>
  80205e:	83 c4 18             	add    $0x18,%esp
	return ;
  802061:	90                   	nop
}
  802062:	c9                   	leave  
  802063:	c3                   	ret    

00802064 <sys_rcr2>:
uint32 sys_rcr2()
{
  802064:	55                   	push   %ebp
  802065:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802067:	6a 00                	push   $0x0
  802069:	6a 00                	push   $0x0
  80206b:	6a 00                	push   $0x0
  80206d:	6a 00                	push   $0x0
  80206f:	6a 00                	push   $0x0
  802071:	6a 25                	push   $0x25
  802073:	e8 82 fb ff ff       	call   801bfa <syscall>
  802078:	83 c4 18             	add    $0x18,%esp
}
  80207b:	c9                   	leave  
  80207c:	c3                   	ret    

0080207d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80207d:	55                   	push   %ebp
  80207e:	89 e5                	mov    %esp,%ebp
  802080:	83 ec 04             	sub    $0x4,%esp
  802083:	8b 45 08             	mov    0x8(%ebp),%eax
  802086:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802089:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80208d:	6a 00                	push   $0x0
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	50                   	push   %eax
  802096:	6a 26                	push   $0x26
  802098:	e8 5d fb ff ff       	call   801bfa <syscall>
  80209d:	83 c4 18             	add    $0x18,%esp
	return ;
  8020a0:	90                   	nop
}
  8020a1:	c9                   	leave  
  8020a2:	c3                   	ret    

008020a3 <rsttst>:
void rsttst()
{
  8020a3:	55                   	push   %ebp
  8020a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020a6:	6a 00                	push   $0x0
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 28                	push   $0x28
  8020b2:	e8 43 fb ff ff       	call   801bfa <syscall>
  8020b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ba:	90                   	nop
}
  8020bb:	c9                   	leave  
  8020bc:	c3                   	ret    

008020bd <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020bd:	55                   	push   %ebp
  8020be:	89 e5                	mov    %esp,%ebp
  8020c0:	83 ec 04             	sub    $0x4,%esp
  8020c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8020c6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8020c9:	8b 55 18             	mov    0x18(%ebp),%edx
  8020cc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020d0:	52                   	push   %edx
  8020d1:	50                   	push   %eax
  8020d2:	ff 75 10             	pushl  0x10(%ebp)
  8020d5:	ff 75 0c             	pushl  0xc(%ebp)
  8020d8:	ff 75 08             	pushl  0x8(%ebp)
  8020db:	6a 27                	push   $0x27
  8020dd:	e8 18 fb ff ff       	call   801bfa <syscall>
  8020e2:	83 c4 18             	add    $0x18,%esp
	return ;
  8020e5:	90                   	nop
}
  8020e6:	c9                   	leave  
  8020e7:	c3                   	ret    

008020e8 <chktst>:
void chktst(uint32 n)
{
  8020e8:	55                   	push   %ebp
  8020e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 00                	push   $0x0
  8020f1:	6a 00                	push   $0x0
  8020f3:	ff 75 08             	pushl  0x8(%ebp)
  8020f6:	6a 29                	push   $0x29
  8020f8:	e8 fd fa ff ff       	call   801bfa <syscall>
  8020fd:	83 c4 18             	add    $0x18,%esp
	return ;
  802100:	90                   	nop
}
  802101:	c9                   	leave  
  802102:	c3                   	ret    

00802103 <inctst>:

void inctst()
{
  802103:	55                   	push   %ebp
  802104:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802106:	6a 00                	push   $0x0
  802108:	6a 00                	push   $0x0
  80210a:	6a 00                	push   $0x0
  80210c:	6a 00                	push   $0x0
  80210e:	6a 00                	push   $0x0
  802110:	6a 2a                	push   $0x2a
  802112:	e8 e3 fa ff ff       	call   801bfa <syscall>
  802117:	83 c4 18             	add    $0x18,%esp
	return ;
  80211a:	90                   	nop
}
  80211b:	c9                   	leave  
  80211c:	c3                   	ret    

0080211d <gettst>:
uint32 gettst()
{
  80211d:	55                   	push   %ebp
  80211e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	6a 00                	push   $0x0
  802126:	6a 00                	push   $0x0
  802128:	6a 00                	push   $0x0
  80212a:	6a 2b                	push   $0x2b
  80212c:	e8 c9 fa ff ff       	call   801bfa <syscall>
  802131:	83 c4 18             	add    $0x18,%esp
}
  802134:	c9                   	leave  
  802135:	c3                   	ret    

00802136 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802136:	55                   	push   %ebp
  802137:	89 e5                	mov    %esp,%ebp
  802139:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80213c:	6a 00                	push   $0x0
  80213e:	6a 00                	push   $0x0
  802140:	6a 00                	push   $0x0
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 2c                	push   $0x2c
  802148:	e8 ad fa ff ff       	call   801bfa <syscall>
  80214d:	83 c4 18             	add    $0x18,%esp
  802150:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802153:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802157:	75 07                	jne    802160 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802159:	b8 01 00 00 00       	mov    $0x1,%eax
  80215e:	eb 05                	jmp    802165 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802160:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802165:	c9                   	leave  
  802166:	c3                   	ret    

00802167 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802167:	55                   	push   %ebp
  802168:	89 e5                	mov    %esp,%ebp
  80216a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80216d:	6a 00                	push   $0x0
  80216f:	6a 00                	push   $0x0
  802171:	6a 00                	push   $0x0
  802173:	6a 00                	push   $0x0
  802175:	6a 00                	push   $0x0
  802177:	6a 2c                	push   $0x2c
  802179:	e8 7c fa ff ff       	call   801bfa <syscall>
  80217e:	83 c4 18             	add    $0x18,%esp
  802181:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802184:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802188:	75 07                	jne    802191 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80218a:	b8 01 00 00 00       	mov    $0x1,%eax
  80218f:	eb 05                	jmp    802196 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802191:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802196:	c9                   	leave  
  802197:	c3                   	ret    

00802198 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802198:	55                   	push   %ebp
  802199:	89 e5                	mov    %esp,%ebp
  80219b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80219e:	6a 00                	push   $0x0
  8021a0:	6a 00                	push   $0x0
  8021a2:	6a 00                	push   $0x0
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	6a 2c                	push   $0x2c
  8021aa:	e8 4b fa ff ff       	call   801bfa <syscall>
  8021af:	83 c4 18             	add    $0x18,%esp
  8021b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8021b5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8021b9:	75 07                	jne    8021c2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8021bb:	b8 01 00 00 00       	mov    $0x1,%eax
  8021c0:	eb 05                	jmp    8021c7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8021c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021c7:	c9                   	leave  
  8021c8:	c3                   	ret    

008021c9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8021c9:	55                   	push   %ebp
  8021ca:	89 e5                	mov    %esp,%ebp
  8021cc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 00                	push   $0x0
  8021d3:	6a 00                	push   $0x0
  8021d5:	6a 00                	push   $0x0
  8021d7:	6a 00                	push   $0x0
  8021d9:	6a 2c                	push   $0x2c
  8021db:	e8 1a fa ff ff       	call   801bfa <syscall>
  8021e0:	83 c4 18             	add    $0x18,%esp
  8021e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8021e6:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8021ea:	75 07                	jne    8021f3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8021ec:	b8 01 00 00 00       	mov    $0x1,%eax
  8021f1:	eb 05                	jmp    8021f8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8021f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021f8:	c9                   	leave  
  8021f9:	c3                   	ret    

008021fa <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8021fa:	55                   	push   %ebp
  8021fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021fd:	6a 00                	push   $0x0
  8021ff:	6a 00                	push   $0x0
  802201:	6a 00                	push   $0x0
  802203:	6a 00                	push   $0x0
  802205:	ff 75 08             	pushl  0x8(%ebp)
  802208:	6a 2d                	push   $0x2d
  80220a:	e8 eb f9 ff ff       	call   801bfa <syscall>
  80220f:	83 c4 18             	add    $0x18,%esp
	return ;
  802212:	90                   	nop
}
  802213:	c9                   	leave  
  802214:	c3                   	ret    

00802215 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802215:	55                   	push   %ebp
  802216:	89 e5                	mov    %esp,%ebp
  802218:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802219:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80221c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80221f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802222:	8b 45 08             	mov    0x8(%ebp),%eax
  802225:	6a 00                	push   $0x0
  802227:	53                   	push   %ebx
  802228:	51                   	push   %ecx
  802229:	52                   	push   %edx
  80222a:	50                   	push   %eax
  80222b:	6a 2e                	push   $0x2e
  80222d:	e8 c8 f9 ff ff       	call   801bfa <syscall>
  802232:	83 c4 18             	add    $0x18,%esp
}
  802235:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802238:	c9                   	leave  
  802239:	c3                   	ret    

0080223a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80223a:	55                   	push   %ebp
  80223b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80223d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802240:	8b 45 08             	mov    0x8(%ebp),%eax
  802243:	6a 00                	push   $0x0
  802245:	6a 00                	push   $0x0
  802247:	6a 00                	push   $0x0
  802249:	52                   	push   %edx
  80224a:	50                   	push   %eax
  80224b:	6a 2f                	push   $0x2f
  80224d:	e8 a8 f9 ff ff       	call   801bfa <syscall>
  802252:	83 c4 18             	add    $0x18,%esp
}
  802255:	c9                   	leave  
  802256:	c3                   	ret    
  802257:	90                   	nop

00802258 <__udivdi3>:
  802258:	55                   	push   %ebp
  802259:	57                   	push   %edi
  80225a:	56                   	push   %esi
  80225b:	53                   	push   %ebx
  80225c:	83 ec 1c             	sub    $0x1c,%esp
  80225f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802263:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802267:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80226b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80226f:	89 ca                	mov    %ecx,%edx
  802271:	89 f8                	mov    %edi,%eax
  802273:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802277:	85 f6                	test   %esi,%esi
  802279:	75 2d                	jne    8022a8 <__udivdi3+0x50>
  80227b:	39 cf                	cmp    %ecx,%edi
  80227d:	77 65                	ja     8022e4 <__udivdi3+0x8c>
  80227f:	89 fd                	mov    %edi,%ebp
  802281:	85 ff                	test   %edi,%edi
  802283:	75 0b                	jne    802290 <__udivdi3+0x38>
  802285:	b8 01 00 00 00       	mov    $0x1,%eax
  80228a:	31 d2                	xor    %edx,%edx
  80228c:	f7 f7                	div    %edi
  80228e:	89 c5                	mov    %eax,%ebp
  802290:	31 d2                	xor    %edx,%edx
  802292:	89 c8                	mov    %ecx,%eax
  802294:	f7 f5                	div    %ebp
  802296:	89 c1                	mov    %eax,%ecx
  802298:	89 d8                	mov    %ebx,%eax
  80229a:	f7 f5                	div    %ebp
  80229c:	89 cf                	mov    %ecx,%edi
  80229e:	89 fa                	mov    %edi,%edx
  8022a0:	83 c4 1c             	add    $0x1c,%esp
  8022a3:	5b                   	pop    %ebx
  8022a4:	5e                   	pop    %esi
  8022a5:	5f                   	pop    %edi
  8022a6:	5d                   	pop    %ebp
  8022a7:	c3                   	ret    
  8022a8:	39 ce                	cmp    %ecx,%esi
  8022aa:	77 28                	ja     8022d4 <__udivdi3+0x7c>
  8022ac:	0f bd fe             	bsr    %esi,%edi
  8022af:	83 f7 1f             	xor    $0x1f,%edi
  8022b2:	75 40                	jne    8022f4 <__udivdi3+0x9c>
  8022b4:	39 ce                	cmp    %ecx,%esi
  8022b6:	72 0a                	jb     8022c2 <__udivdi3+0x6a>
  8022b8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022bc:	0f 87 9e 00 00 00    	ja     802360 <__udivdi3+0x108>
  8022c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8022c7:	89 fa                	mov    %edi,%edx
  8022c9:	83 c4 1c             	add    $0x1c,%esp
  8022cc:	5b                   	pop    %ebx
  8022cd:	5e                   	pop    %esi
  8022ce:	5f                   	pop    %edi
  8022cf:	5d                   	pop    %ebp
  8022d0:	c3                   	ret    
  8022d1:	8d 76 00             	lea    0x0(%esi),%esi
  8022d4:	31 ff                	xor    %edi,%edi
  8022d6:	31 c0                	xor    %eax,%eax
  8022d8:	89 fa                	mov    %edi,%edx
  8022da:	83 c4 1c             	add    $0x1c,%esp
  8022dd:	5b                   	pop    %ebx
  8022de:	5e                   	pop    %esi
  8022df:	5f                   	pop    %edi
  8022e0:	5d                   	pop    %ebp
  8022e1:	c3                   	ret    
  8022e2:	66 90                	xchg   %ax,%ax
  8022e4:	89 d8                	mov    %ebx,%eax
  8022e6:	f7 f7                	div    %edi
  8022e8:	31 ff                	xor    %edi,%edi
  8022ea:	89 fa                	mov    %edi,%edx
  8022ec:	83 c4 1c             	add    $0x1c,%esp
  8022ef:	5b                   	pop    %ebx
  8022f0:	5e                   	pop    %esi
  8022f1:	5f                   	pop    %edi
  8022f2:	5d                   	pop    %ebp
  8022f3:	c3                   	ret    
  8022f4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8022f9:	89 eb                	mov    %ebp,%ebx
  8022fb:	29 fb                	sub    %edi,%ebx
  8022fd:	89 f9                	mov    %edi,%ecx
  8022ff:	d3 e6                	shl    %cl,%esi
  802301:	89 c5                	mov    %eax,%ebp
  802303:	88 d9                	mov    %bl,%cl
  802305:	d3 ed                	shr    %cl,%ebp
  802307:	89 e9                	mov    %ebp,%ecx
  802309:	09 f1                	or     %esi,%ecx
  80230b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80230f:	89 f9                	mov    %edi,%ecx
  802311:	d3 e0                	shl    %cl,%eax
  802313:	89 c5                	mov    %eax,%ebp
  802315:	89 d6                	mov    %edx,%esi
  802317:	88 d9                	mov    %bl,%cl
  802319:	d3 ee                	shr    %cl,%esi
  80231b:	89 f9                	mov    %edi,%ecx
  80231d:	d3 e2                	shl    %cl,%edx
  80231f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802323:	88 d9                	mov    %bl,%cl
  802325:	d3 e8                	shr    %cl,%eax
  802327:	09 c2                	or     %eax,%edx
  802329:	89 d0                	mov    %edx,%eax
  80232b:	89 f2                	mov    %esi,%edx
  80232d:	f7 74 24 0c          	divl   0xc(%esp)
  802331:	89 d6                	mov    %edx,%esi
  802333:	89 c3                	mov    %eax,%ebx
  802335:	f7 e5                	mul    %ebp
  802337:	39 d6                	cmp    %edx,%esi
  802339:	72 19                	jb     802354 <__udivdi3+0xfc>
  80233b:	74 0b                	je     802348 <__udivdi3+0xf0>
  80233d:	89 d8                	mov    %ebx,%eax
  80233f:	31 ff                	xor    %edi,%edi
  802341:	e9 58 ff ff ff       	jmp    80229e <__udivdi3+0x46>
  802346:	66 90                	xchg   %ax,%ax
  802348:	8b 54 24 08          	mov    0x8(%esp),%edx
  80234c:	89 f9                	mov    %edi,%ecx
  80234e:	d3 e2                	shl    %cl,%edx
  802350:	39 c2                	cmp    %eax,%edx
  802352:	73 e9                	jae    80233d <__udivdi3+0xe5>
  802354:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802357:	31 ff                	xor    %edi,%edi
  802359:	e9 40 ff ff ff       	jmp    80229e <__udivdi3+0x46>
  80235e:	66 90                	xchg   %ax,%ax
  802360:	31 c0                	xor    %eax,%eax
  802362:	e9 37 ff ff ff       	jmp    80229e <__udivdi3+0x46>
  802367:	90                   	nop

00802368 <__umoddi3>:
  802368:	55                   	push   %ebp
  802369:	57                   	push   %edi
  80236a:	56                   	push   %esi
  80236b:	53                   	push   %ebx
  80236c:	83 ec 1c             	sub    $0x1c,%esp
  80236f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802373:	8b 74 24 34          	mov    0x34(%esp),%esi
  802377:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80237b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80237f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802383:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802387:	89 f3                	mov    %esi,%ebx
  802389:	89 fa                	mov    %edi,%edx
  80238b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80238f:	89 34 24             	mov    %esi,(%esp)
  802392:	85 c0                	test   %eax,%eax
  802394:	75 1a                	jne    8023b0 <__umoddi3+0x48>
  802396:	39 f7                	cmp    %esi,%edi
  802398:	0f 86 a2 00 00 00    	jbe    802440 <__umoddi3+0xd8>
  80239e:	89 c8                	mov    %ecx,%eax
  8023a0:	89 f2                	mov    %esi,%edx
  8023a2:	f7 f7                	div    %edi
  8023a4:	89 d0                	mov    %edx,%eax
  8023a6:	31 d2                	xor    %edx,%edx
  8023a8:	83 c4 1c             	add    $0x1c,%esp
  8023ab:	5b                   	pop    %ebx
  8023ac:	5e                   	pop    %esi
  8023ad:	5f                   	pop    %edi
  8023ae:	5d                   	pop    %ebp
  8023af:	c3                   	ret    
  8023b0:	39 f0                	cmp    %esi,%eax
  8023b2:	0f 87 ac 00 00 00    	ja     802464 <__umoddi3+0xfc>
  8023b8:	0f bd e8             	bsr    %eax,%ebp
  8023bb:	83 f5 1f             	xor    $0x1f,%ebp
  8023be:	0f 84 ac 00 00 00    	je     802470 <__umoddi3+0x108>
  8023c4:	bf 20 00 00 00       	mov    $0x20,%edi
  8023c9:	29 ef                	sub    %ebp,%edi
  8023cb:	89 fe                	mov    %edi,%esi
  8023cd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8023d1:	89 e9                	mov    %ebp,%ecx
  8023d3:	d3 e0                	shl    %cl,%eax
  8023d5:	89 d7                	mov    %edx,%edi
  8023d7:	89 f1                	mov    %esi,%ecx
  8023d9:	d3 ef                	shr    %cl,%edi
  8023db:	09 c7                	or     %eax,%edi
  8023dd:	89 e9                	mov    %ebp,%ecx
  8023df:	d3 e2                	shl    %cl,%edx
  8023e1:	89 14 24             	mov    %edx,(%esp)
  8023e4:	89 d8                	mov    %ebx,%eax
  8023e6:	d3 e0                	shl    %cl,%eax
  8023e8:	89 c2                	mov    %eax,%edx
  8023ea:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023ee:	d3 e0                	shl    %cl,%eax
  8023f0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8023f4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023f8:	89 f1                	mov    %esi,%ecx
  8023fa:	d3 e8                	shr    %cl,%eax
  8023fc:	09 d0                	or     %edx,%eax
  8023fe:	d3 eb                	shr    %cl,%ebx
  802400:	89 da                	mov    %ebx,%edx
  802402:	f7 f7                	div    %edi
  802404:	89 d3                	mov    %edx,%ebx
  802406:	f7 24 24             	mull   (%esp)
  802409:	89 c6                	mov    %eax,%esi
  80240b:	89 d1                	mov    %edx,%ecx
  80240d:	39 d3                	cmp    %edx,%ebx
  80240f:	0f 82 87 00 00 00    	jb     80249c <__umoddi3+0x134>
  802415:	0f 84 91 00 00 00    	je     8024ac <__umoddi3+0x144>
  80241b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80241f:	29 f2                	sub    %esi,%edx
  802421:	19 cb                	sbb    %ecx,%ebx
  802423:	89 d8                	mov    %ebx,%eax
  802425:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802429:	d3 e0                	shl    %cl,%eax
  80242b:	89 e9                	mov    %ebp,%ecx
  80242d:	d3 ea                	shr    %cl,%edx
  80242f:	09 d0                	or     %edx,%eax
  802431:	89 e9                	mov    %ebp,%ecx
  802433:	d3 eb                	shr    %cl,%ebx
  802435:	89 da                	mov    %ebx,%edx
  802437:	83 c4 1c             	add    $0x1c,%esp
  80243a:	5b                   	pop    %ebx
  80243b:	5e                   	pop    %esi
  80243c:	5f                   	pop    %edi
  80243d:	5d                   	pop    %ebp
  80243e:	c3                   	ret    
  80243f:	90                   	nop
  802440:	89 fd                	mov    %edi,%ebp
  802442:	85 ff                	test   %edi,%edi
  802444:	75 0b                	jne    802451 <__umoddi3+0xe9>
  802446:	b8 01 00 00 00       	mov    $0x1,%eax
  80244b:	31 d2                	xor    %edx,%edx
  80244d:	f7 f7                	div    %edi
  80244f:	89 c5                	mov    %eax,%ebp
  802451:	89 f0                	mov    %esi,%eax
  802453:	31 d2                	xor    %edx,%edx
  802455:	f7 f5                	div    %ebp
  802457:	89 c8                	mov    %ecx,%eax
  802459:	f7 f5                	div    %ebp
  80245b:	89 d0                	mov    %edx,%eax
  80245d:	e9 44 ff ff ff       	jmp    8023a6 <__umoddi3+0x3e>
  802462:	66 90                	xchg   %ax,%ax
  802464:	89 c8                	mov    %ecx,%eax
  802466:	89 f2                	mov    %esi,%edx
  802468:	83 c4 1c             	add    $0x1c,%esp
  80246b:	5b                   	pop    %ebx
  80246c:	5e                   	pop    %esi
  80246d:	5f                   	pop    %edi
  80246e:	5d                   	pop    %ebp
  80246f:	c3                   	ret    
  802470:	3b 04 24             	cmp    (%esp),%eax
  802473:	72 06                	jb     80247b <__umoddi3+0x113>
  802475:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802479:	77 0f                	ja     80248a <__umoddi3+0x122>
  80247b:	89 f2                	mov    %esi,%edx
  80247d:	29 f9                	sub    %edi,%ecx
  80247f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802483:	89 14 24             	mov    %edx,(%esp)
  802486:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80248a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80248e:	8b 14 24             	mov    (%esp),%edx
  802491:	83 c4 1c             	add    $0x1c,%esp
  802494:	5b                   	pop    %ebx
  802495:	5e                   	pop    %esi
  802496:	5f                   	pop    %edi
  802497:	5d                   	pop    %ebp
  802498:	c3                   	ret    
  802499:	8d 76 00             	lea    0x0(%esi),%esi
  80249c:	2b 04 24             	sub    (%esp),%eax
  80249f:	19 fa                	sbb    %edi,%edx
  8024a1:	89 d1                	mov    %edx,%ecx
  8024a3:	89 c6                	mov    %eax,%esi
  8024a5:	e9 71 ff ff ff       	jmp    80241b <__umoddi3+0xb3>
  8024aa:	66 90                	xchg   %ax,%ax
  8024ac:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024b0:	72 ea                	jb     80249c <__umoddi3+0x134>
  8024b2:	89 d9                	mov    %ebx,%ecx
  8024b4:	e9 62 ff ff ff       	jmp    80241b <__umoddi3+0xb3>
