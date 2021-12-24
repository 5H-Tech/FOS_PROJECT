
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
  800042:	e8 ed 1c 00 00       	call   801d34 <sys_calculate_free_frames>
  800047:	89 45 c8             	mov    %eax,-0x38(%ebp)
	int usedDiskPages1 = sys_pf_calculate_allocated_pages() ;
  80004a:	e8 68 1d 00 00       	call   801db7 <sys_pf_calculate_allocated_pages>
  80004f:	89 45 c4             	mov    %eax,-0x3c(%ebp)

	char line[100];
	int N = 500;
  800052:	c7 45 c0 f4 01 00 00 	movl   $0x1f4,-0x40(%ebp)
	assert(N * sizeof(int) <= BUDDY_LIMIT);
  800059:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80005c:	c1 e0 02             	shl    $0x2,%eax
  80005f:	3d 00 08 00 00       	cmp    $0x800,%eax
  800064:	76 16                	jbe    80007c <_main+0x44>
  800066:	68 a0 24 80 00       	push   $0x8024a0
  80006b:	68 bf 24 80 00       	push   $0x8024bf
  800070:	6a 0d                	push   $0xd
  800072:	68 d4 24 80 00       	push   $0x8024d4
  800077:	e8 d7 07 00 00       	call   800853 <_panic>
	int M = 1;
  80007c:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
	assert(M * sizeof(uint8) <= BUDDY_LIMIT);
  800083:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800086:	3d 00 08 00 00       	cmp    $0x800,%eax
  80008b:	76 16                	jbe    8000a3 <_main+0x6b>
  80008d:	68 fc 24 80 00       	push   $0x8024fc
  800092:	68 bf 24 80 00       	push   $0x8024bf
  800097:	6a 0f                	push   $0xf
  800099:	68 d4 24 80 00       	push   $0x8024d4
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
  80017f:	e8 b0 1b 00 00       	call   801d34 <sys_calculate_free_frames>
  800184:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int usedDiskPages2 = sys_pf_calculate_allocated_pages() ;
  800187:	e8 2b 1c 00 00       	call   801db7 <sys_pf_calculate_allocated_pages>
  80018c:	89 45 a8             	mov    %eax,-0x58(%ebp)
	if(freeFrames1 - freeFrames2 != 1 + 1 + expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in MEMORY."); //1 for page table + 1 for disk table
  80018f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800192:	2b 45 ac             	sub    -0x54(%ebp),%eax
  800195:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800198:	83 c2 02             	add    $0x2,%edx
  80019b:	39 d0                	cmp    %edx,%eax
  80019d:	74 14                	je     8001b3 <_main+0x17b>
  80019f:	83 ec 04             	sub    $0x4,%esp
  8001a2:	68 20 25 80 00       	push   $0x802520
  8001a7:	6a 20                	push   $0x20
  8001a9:	68 d4 24 80 00       	push   $0x8024d4
  8001ae:	e8 a0 06 00 00       	call   800853 <_panic>
	if(usedDiskPages2 - usedDiskPages1 != expectedNumOfAllocatedFrames) panic("Less or more frames are allocated in PAGE FILE.");
  8001b3:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8001b6:	2b 45 c4             	sub    -0x3c(%ebp),%eax
  8001b9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8001bc:	74 14                	je     8001d2 <_main+0x19a>
  8001be:	83 ec 04             	sub    $0x4,%esp
  8001c1:	68 50 25 80 00       	push   $0x802550
  8001c6:	6a 21                	push   $0x21
  8001c8:	68 d4 24 80 00       	push   $0x8024d4
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
  800210:	68 80 25 80 00       	push   $0x802580
  800215:	68 bf 24 80 00       	push   $0x8024bf
  80021a:	6a 27                	push   $0x27
  80021c:	68 d4 24 80 00       	push   $0x8024d4
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
  80023f:	68 98 25 80 00       	push   $0x802598
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
  80026a:	e8 a1 17 00 00       	call   801a10 <free>
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
  800283:	e8 88 17 00 00       	call   801a10 <free>
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
  8002b9:	68 d8 25 80 00       	push   $0x8025d8
  8002be:	e8 32 08 00 00       	call   800af5 <cprintf>
  8002c3:	83 c4 10             	add    $0x10,%esp
			panic("The BuddyLevels at level <<%d>> is not freed ... !!", i);
  8002c6:	ff 75 dc             	pushl  -0x24(%ebp)
  8002c9:	68 f8 25 80 00       	push   $0x8025f8
  8002ce:	6a 38                	push   $0x38
  8002d0:	68 d4 24 80 00       	push   $0x8024d4
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
  8002e6:	68 2c 26 80 00       	push   $0x80262c
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
  800378:	e8 b7 19 00 00       	call   801d34 <sys_calculate_free_frames>
  80037d:	89 45 a0             	mov    %eax,-0x60(%ebp)
	int usedDiskPages3 = sys_pf_calculate_allocated_pages() ;
  800380:	e8 32 1a 00 00       	call   801db7 <sys_pf_calculate_allocated_pages>
  800385:	89 45 9c             	mov    %eax,-0x64(%ebp)

	//Check that no extra frames are taken
	if(freeFrames3 - freeFrames2 != 0) panic("Frames are not freed from MEMORY correctly. Evaluation = 60%.");
  800388:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80038b:	3b 45 ac             	cmp    -0x54(%ebp),%eax
  80038e:	74 14                	je     8003a4 <_main+0x36c>
  800390:	83 ec 04             	sub    $0x4,%esp
  800393:	68 6c 26 80 00       	push   $0x80266c
  800398:	6a 4b                	push   $0x4b
  80039a:	68 d4 24 80 00       	push   $0x8024d4
  80039f:	e8 af 04 00 00       	call   800853 <_panic>
	if(usedDiskPages3 - usedDiskPages2 != 0) panic("Frames are not freed from PAGE FILE correctly. Evaluation = 60%.");
  8003a4:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8003a7:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  8003aa:	74 14                	je     8003c0 <_main+0x388>
  8003ac:	83 ec 04             	sub    $0x4,%esp
  8003af:	68 ac 26 80 00       	push   $0x8026ac
  8003b4:	6a 4c                	push   $0x4c
  8003b6:	68 d4 24 80 00       	push   $0x8024d4
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
  800402:	68 f0 26 80 00       	push   $0x8026f0
  800407:	6a 53                	push   $0x53
  800409:	68 d4 24 80 00       	push   $0x8024d4
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
  80042c:	68 28 27 80 00       	push   $0x802728
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
  800465:	68 60 27 80 00       	push   $0x802760
  80046a:	6a 5b                	push   $0x5b
  80046c:	68 d4 24 80 00       	push   $0x8024d4
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
  80049e:	68 60 27 80 00       	push   $0x802760
  8004a3:	6a 5c                	push   $0x5c
  8004a5:	68 d4 24 80 00       	push   $0x8024d4
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
  8004d8:	68 60 27 80 00       	push   $0x802760
  8004dd:	6a 5d                	push   $0x5d
  8004df:	68 d4 24 80 00       	push   $0x8024d4
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
  800512:	68 60 27 80 00       	push   $0x802760
  800517:	6a 5e                	push   $0x5e
  800519:	68 d4 24 80 00       	push   $0x8024d4
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
  80054b:	68 60 27 80 00       	push   $0x802760
  800550:	6a 5f                	push   $0x5f
  800552:	68 d4 24 80 00       	push   $0x8024d4
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
  800584:	68 60 27 80 00       	push   $0x802760
  800589:	6a 60                	push   $0x60
  80058b:	68 d4 24 80 00       	push   $0x8024d4
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
  8005bd:	68 60 27 80 00       	push   $0x802760
  8005c2:	6a 61                	push   $0x61
  8005c4:	68 d4 24 80 00       	push   $0x8024d4
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
  8005f6:	68 60 27 80 00       	push   $0x802760
  8005fb:	6a 62                	push   $0x62
  8005fd:	68 d4 24 80 00       	push   $0x8024d4
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
  80062f:	68 60 27 80 00       	push   $0x802760
  800634:	6a 63                	push   $0x63
  800636:	68 d4 24 80 00       	push   $0x8024d4
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
  800669:	68 60 27 80 00       	push   $0x802760
  80066e:	6a 64                	push   $0x64
  800670:	68 d4 24 80 00       	push   $0x8024d4
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
  8006a2:	68 60 27 80 00       	push   $0x802760
  8006a7:	6a 65                	push   $0x65
  8006a9:	68 d4 24 80 00       	push   $0x8024d4
  8006ae:	e8 a0 01 00 00       	call   800853 <_panic>
  8006b3:	ff 45 98             	incl   -0x68(%ebp)
	}

	cprintf("Congratulations!! test BUDDY SYSTEM deallocation (1) completed successfully. Evaluation = 100%\n");
  8006b6:	83 ec 0c             	sub    $0xc,%esp
  8006b9:	68 ac 27 80 00       	push   $0x8027ac
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
  800714:	e8 50 15 00 00       	call   801c69 <sys_getenvindex>
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
  800791:	e8 6e 16 00 00       	call   801e04 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800796:	83 ec 0c             	sub    $0xc,%esp
  800799:	68 24 28 80 00       	push   $0x802824
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
  8007c1:	68 4c 28 80 00       	push   $0x80284c
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
  8007e9:	68 74 28 80 00       	push   $0x802874
  8007ee:	e8 02 03 00 00       	call   800af5 <cprintf>
  8007f3:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8007f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8007fb:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800801:	83 ec 08             	sub    $0x8,%esp
  800804:	50                   	push   %eax
  800805:	68 b5 28 80 00       	push   $0x8028b5
  80080a:	e8 e6 02 00 00       	call   800af5 <cprintf>
  80080f:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800812:	83 ec 0c             	sub    $0xc,%esp
  800815:	68 24 28 80 00       	push   $0x802824
  80081a:	e8 d6 02 00 00       	call   800af5 <cprintf>
  80081f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800822:	e8 f7 15 00 00       	call   801e1e <sys_enable_interrupt>

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
  80083a:	e8 f6 13 00 00       	call   801c35 <sys_env_destroy>
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
  80084b:	e8 4b 14 00 00       	call   801c9b <sys_env_exit>
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
  800874:	68 cc 28 80 00       	push   $0x8028cc
  800879:	e8 77 02 00 00       	call   800af5 <cprintf>
  80087e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800881:	a1 00 30 80 00       	mov    0x803000,%eax
  800886:	ff 75 0c             	pushl  0xc(%ebp)
  800889:	ff 75 08             	pushl  0x8(%ebp)
  80088c:	50                   	push   %eax
  80088d:	68 d1 28 80 00       	push   $0x8028d1
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
  8008b1:	68 ed 28 80 00       	push   $0x8028ed
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
  8008dd:	68 f0 28 80 00       	push   $0x8028f0
  8008e2:	6a 26                	push   $0x26
  8008e4:	68 3c 29 80 00       	push   $0x80293c
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
  8009a3:	68 48 29 80 00       	push   $0x802948
  8009a8:	6a 3a                	push   $0x3a
  8009aa:	68 3c 29 80 00       	push   $0x80293c
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
  800a0d:	68 9c 29 80 00       	push   $0x80299c
  800a12:	6a 44                	push   $0x44
  800a14:	68 3c 29 80 00       	push   $0x80293c
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
  800a67:	e8 87 11 00 00       	call   801bf3 <sys_cputs>
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
  800ade:	e8 10 11 00 00       	call   801bf3 <sys_cputs>
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
  800b28:	e8 d7 12 00 00       	call   801e04 <sys_disable_interrupt>
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
  800b48:	e8 d1 12 00 00       	call   801e1e <sys_enable_interrupt>
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
  800b92:	e8 91 16 00 00       	call   802228 <__udivdi3>
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
  800be2:	e8 51 17 00 00       	call   802338 <__umoddi3>
  800be7:	83 c4 10             	add    $0x10,%esp
  800bea:	05 14 2c 80 00       	add    $0x802c14,%eax
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
  800d3d:	8b 04 85 38 2c 80 00 	mov    0x802c38(,%eax,4),%eax
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
  800e1e:	8b 34 9d 80 2a 80 00 	mov    0x802a80(,%ebx,4),%esi
  800e25:	85 f6                	test   %esi,%esi
  800e27:	75 19                	jne    800e42 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800e29:	53                   	push   %ebx
  800e2a:	68 25 2c 80 00       	push   $0x802c25
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
  800e43:	68 2e 2c 80 00       	push   $0x802c2e
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
  800e70:	be 31 2c 80 00       	mov    $0x802c31,%esi
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
int changes = 0;
int sizeofarray = 0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size) {
  80187f:	55                   	push   %ebp
  801880:	89 e5                	mov    %esp,%ebp
  801882:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801885:	8b 45 08             	mov    0x8(%ebp),%eax
  801888:	c1 e8 0c             	shr    $0xc,%eax
  80188b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	//sizeofarray++;
	if (size % PAGE_SIZE != 0)
  80188e:	8b 45 08             	mov    0x8(%ebp),%eax
  801891:	25 ff 0f 00 00       	and    $0xfff,%eax
  801896:	85 c0                	test   %eax,%eax
  801898:	74 03                	je     80189d <malloc+0x1e>
		num++;
  80189a:	ff 45 f4             	incl   -0xc(%ebp)
//		addresses[sizeofarray] = last_addres;
//		changed[sizeofarray] = 1;
//		sizeofarray++;
//		return (void*) return_addres;
	//} else {
	if (changes == 0) {
  80189d:	a1 28 30 80 00       	mov    0x803028,%eax
  8018a2:	85 c0                	test   %eax,%eax
  8018a4:	75 71                	jne    801917 <malloc+0x98>
		sys_allocateMem(last_addres, size);
  8018a6:	a1 04 30 80 00       	mov    0x803004,%eax
  8018ab:	83 ec 08             	sub    $0x8,%esp
  8018ae:	ff 75 08             	pushl  0x8(%ebp)
  8018b1:	50                   	push   %eax
  8018b2:	e8 e4 04 00 00       	call   801d9b <sys_allocateMem>
  8018b7:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  8018ba:	a1 04 30 80 00       	mov    0x803004,%eax
  8018bf:	89 45 d8             	mov    %eax,-0x28(%ebp)
		last_addres += num * PAGE_SIZE;
  8018c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018c5:	c1 e0 0c             	shl    $0xc,%eax
  8018c8:	89 c2                	mov    %eax,%edx
  8018ca:	a1 04 30 80 00       	mov    0x803004,%eax
  8018cf:	01 d0                	add    %edx,%eax
  8018d1:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  8018d6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018db:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018de:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = return_addres;
  8018e5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018ea:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8018ed:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  8018f4:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018f9:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801900:	01 00 00 00 
		sizeofarray++;
  801904:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801909:	40                   	inc    %eax
  80190a:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) return_addres;
  80190f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801912:	e9 f7 00 00 00       	jmp    801a0e <malloc+0x18f>
	} else {
		int count = 0;
  801917:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 1000;
  80191e:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
		int index = -1;
  801925:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  80192c:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801933:	eb 7c                	jmp    8019b1 <malloc+0x132>
		{
			uint32 *pg = NULL;
  801935:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
			for (int j = 0; j < sizeofarray; j++) {
  80193c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801943:	eb 1a                	jmp    80195f <malloc+0xe0>
				if (addresses[j] == i) {
  801945:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801948:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80194f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801952:	75 08                	jne    80195c <malloc+0xdd>
					index = j;
  801954:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801957:	89 45 e8             	mov    %eax,-0x18(%ebp)
					break;
  80195a:	eb 0d                	jmp    801969 <malloc+0xea>
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
		{
			uint32 *pg = NULL;
			for (int j = 0; j < sizeofarray; j++) {
  80195c:	ff 45 dc             	incl   -0x24(%ebp)
  80195f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801964:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801967:	7c dc                	jl     801945 <malloc+0xc6>
					index = j;
					break;
				}
			}

			if (index == -1) {
  801969:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  80196d:	75 05                	jne    801974 <malloc+0xf5>
				count++;
  80196f:	ff 45 f0             	incl   -0x10(%ebp)
  801972:	eb 36                	jmp    8019aa <malloc+0x12b>
			} else {
				if (changed[index] == 0) {
  801974:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801977:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  80197e:	85 c0                	test   %eax,%eax
  801980:	75 05                	jne    801987 <malloc+0x108>
					count++;
  801982:	ff 45 f0             	incl   -0x10(%ebp)
  801985:	eb 23                	jmp    8019aa <malloc+0x12b>
				} else {
					if (count < min && count >= num) {
  801987:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80198a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80198d:	7d 14                	jge    8019a3 <malloc+0x124>
  80198f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801992:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801995:	7c 0c                	jl     8019a3 <malloc+0x124>
						min = count;
  801997:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80199a:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss = i;
  80199d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
					}
					count = 0;
  8019a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	} else {
		int count = 0;
		int min = 1000;
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  8019aa:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8019b1:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8019b8:	0f 86 77 ff ff ff    	jbe    801935 <malloc+0xb6>

			}

		}

		sys_allocateMem(min_addresss, size);
  8019be:	83 ec 08             	sub    $0x8,%esp
  8019c1:	ff 75 08             	pushl  0x8(%ebp)
  8019c4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8019c7:	e8 cf 03 00 00       	call   801d9b <sys_allocateMem>
  8019cc:	83 c4 10             	add    $0x10,%esp
		numOfPages[sizeofarray] = num;
  8019cf:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019d7:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
		addresses[sizeofarray] = last_addres;
  8019de:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019e3:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8019e9:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		changed[sizeofarray] = 1;
  8019f0:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019f5:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8019fc:	01 00 00 00 
		sizeofarray++;
  801a00:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a05:	40                   	inc    %eax
  801a06:	a3 2c 30 80 00       	mov    %eax,0x80302c
		return (void*) min_addresss;
  801a0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801a0e:	c9                   	leave  
  801a0f:	c3                   	ret    

00801a10 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801a10:	55                   	push   %ebp
  801a11:	89 e5                	mov    %esp,%ebp
  801a13:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801a16:	8b 45 08             	mov    0x8(%ebp),%eax
  801a19:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801a1c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801a23:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801a2a:	eb 30                	jmp    801a5c <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801a2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a2f:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801a36:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801a39:	75 1e                	jne    801a59 <free+0x49>
  801a3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a3e:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801a45:	83 f8 01             	cmp    $0x1,%eax
  801a48:	75 0f                	jne    801a59 <free+0x49>
			is_found = 1;
  801a4a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801a51:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801a54:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801a57:	eb 0d                	jmp    801a66 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801a59:	ff 45 ec             	incl   -0x14(%ebp)
  801a5c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a61:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801a64:	7c c6                	jl     801a2c <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801a66:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801a6a:	75 4f                	jne    801abb <free+0xab>
		size = numOfPages[index] * PAGE_SIZE;
  801a6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a6f:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801a76:	c1 e0 0c             	shl    $0xc,%eax
  801a79:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801a7c:	83 ec 08             	sub    $0x8,%esp
  801a7f:	ff 75 e4             	pushl  -0x1c(%ebp)
  801a82:	68 90 2d 80 00       	push   $0x802d90
  801a87:	e8 69 f0 ff ff       	call   800af5 <cprintf>
  801a8c:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801a8f:	83 ec 08             	sub    $0x8,%esp
  801a92:	ff 75 e4             	pushl  -0x1c(%ebp)
  801a95:	ff 75 e8             	pushl  -0x18(%ebp)
  801a98:	e8 e2 02 00 00       	call   801d7f <sys_freeMem>
  801a9d:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801aa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801aa3:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801aaa:	00 00 00 00 
		changes++;
  801aae:	a1 28 30 80 00       	mov    0x803028,%eax
  801ab3:	40                   	inc    %eax
  801ab4:	a3 28 30 80 00       	mov    %eax,0x803028
		sys_freeMem(va, size);
		changed[index] = 0;
	}

	//refer to the project presentation and documentation for details
}
  801ab9:	eb 39                	jmp    801af4 <free+0xe4>
		cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
		changed[index] = 0;
		changes++;
	} else {
		size = 513 * PAGE_SIZE;
  801abb:	c7 45 e4 00 10 20 00 	movl   $0x201000,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801ac2:	83 ec 08             	sub    $0x8,%esp
  801ac5:	ff 75 e4             	pushl  -0x1c(%ebp)
  801ac8:	68 90 2d 80 00       	push   $0x802d90
  801acd:	e8 23 f0 ff ff       	call   800af5 <cprintf>
  801ad2:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801ad5:	83 ec 08             	sub    $0x8,%esp
  801ad8:	ff 75 e4             	pushl  -0x1c(%ebp)
  801adb:	ff 75 e8             	pushl  -0x18(%ebp)
  801ade:	e8 9c 02 00 00       	call   801d7f <sys_freeMem>
  801ae3:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801ae6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ae9:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801af0:	00 00 00 00 
	}

	//refer to the project presentation and documentation for details
}
  801af4:	90                   	nop
  801af5:	c9                   	leave  
  801af6:	c3                   	ret    

00801af7 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801af7:	55                   	push   %ebp
  801af8:	89 e5                	mov    %esp,%ebp
  801afa:	83 ec 18             	sub    $0x18,%esp
  801afd:	8b 45 10             	mov    0x10(%ebp),%eax
  801b00:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801b03:	83 ec 04             	sub    $0x4,%esp
  801b06:	68 b0 2d 80 00       	push   $0x802db0
  801b0b:	68 9d 00 00 00       	push   $0x9d
  801b10:	68 d3 2d 80 00       	push   $0x802dd3
  801b15:	e8 39 ed ff ff       	call   800853 <_panic>

00801b1a <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801b1a:	55                   	push   %ebp
  801b1b:	89 e5                	mov    %esp,%ebp
  801b1d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b20:	83 ec 04             	sub    $0x4,%esp
  801b23:	68 b0 2d 80 00       	push   $0x802db0
  801b28:	68 a2 00 00 00       	push   $0xa2
  801b2d:	68 d3 2d 80 00       	push   $0x802dd3
  801b32:	e8 1c ed ff ff       	call   800853 <_panic>

00801b37 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801b37:	55                   	push   %ebp
  801b38:	89 e5                	mov    %esp,%ebp
  801b3a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b3d:	83 ec 04             	sub    $0x4,%esp
  801b40:	68 b0 2d 80 00       	push   $0x802db0
  801b45:	68 a7 00 00 00       	push   $0xa7
  801b4a:	68 d3 2d 80 00       	push   $0x802dd3
  801b4f:	e8 ff ec ff ff       	call   800853 <_panic>

00801b54 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801b54:	55                   	push   %ebp
  801b55:	89 e5                	mov    %esp,%ebp
  801b57:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b5a:	83 ec 04             	sub    $0x4,%esp
  801b5d:	68 b0 2d 80 00       	push   $0x802db0
  801b62:	68 ab 00 00 00       	push   $0xab
  801b67:	68 d3 2d 80 00       	push   $0x802dd3
  801b6c:	e8 e2 ec ff ff       	call   800853 <_panic>

00801b71 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801b71:	55                   	push   %ebp
  801b72:	89 e5                	mov    %esp,%ebp
  801b74:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b77:	83 ec 04             	sub    $0x4,%esp
  801b7a:	68 b0 2d 80 00       	push   $0x802db0
  801b7f:	68 b0 00 00 00       	push   $0xb0
  801b84:	68 d3 2d 80 00       	push   $0x802dd3
  801b89:	e8 c5 ec ff ff       	call   800853 <_panic>

00801b8e <shrink>:
}
void shrink(uint32 newSize) {
  801b8e:	55                   	push   %ebp
  801b8f:	89 e5                	mov    %esp,%ebp
  801b91:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b94:	83 ec 04             	sub    $0x4,%esp
  801b97:	68 b0 2d 80 00       	push   $0x802db0
  801b9c:	68 b3 00 00 00       	push   $0xb3
  801ba1:	68 d3 2d 80 00       	push   $0x802dd3
  801ba6:	e8 a8 ec ff ff       	call   800853 <_panic>

00801bab <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
  801bae:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bb1:	83 ec 04             	sub    $0x4,%esp
  801bb4:	68 b0 2d 80 00       	push   $0x802db0
  801bb9:	68 b7 00 00 00       	push   $0xb7
  801bbe:	68 d3 2d 80 00       	push   $0x802dd3
  801bc3:	e8 8b ec ff ff       	call   800853 <_panic>

00801bc8 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801bc8:	55                   	push   %ebp
  801bc9:	89 e5                	mov    %esp,%ebp
  801bcb:	57                   	push   %edi
  801bcc:	56                   	push   %esi
  801bcd:	53                   	push   %ebx
  801bce:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bd7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bda:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bdd:	8b 7d 18             	mov    0x18(%ebp),%edi
  801be0:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801be3:	cd 30                	int    $0x30
  801be5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801be8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801beb:	83 c4 10             	add    $0x10,%esp
  801bee:	5b                   	pop    %ebx
  801bef:	5e                   	pop    %esi
  801bf0:	5f                   	pop    %edi
  801bf1:	5d                   	pop    %ebp
  801bf2:	c3                   	ret    

00801bf3 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801bf3:	55                   	push   %ebp
  801bf4:	89 e5                	mov    %esp,%ebp
  801bf6:	83 ec 04             	sub    $0x4,%esp
  801bf9:	8b 45 10             	mov    0x10(%ebp),%eax
  801bfc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801bff:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c03:	8b 45 08             	mov    0x8(%ebp),%eax
  801c06:	6a 00                	push   $0x0
  801c08:	6a 00                	push   $0x0
  801c0a:	52                   	push   %edx
  801c0b:	ff 75 0c             	pushl  0xc(%ebp)
  801c0e:	50                   	push   %eax
  801c0f:	6a 00                	push   $0x0
  801c11:	e8 b2 ff ff ff       	call   801bc8 <syscall>
  801c16:	83 c4 18             	add    $0x18,%esp
}
  801c19:	90                   	nop
  801c1a:	c9                   	leave  
  801c1b:	c3                   	ret    

00801c1c <sys_cgetc>:

int
sys_cgetc(void)
{
  801c1c:	55                   	push   %ebp
  801c1d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	6a 01                	push   $0x1
  801c2b:	e8 98 ff ff ff       	call   801bc8 <syscall>
  801c30:	83 c4 18             	add    $0x18,%esp
}
  801c33:	c9                   	leave  
  801c34:	c3                   	ret    

00801c35 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c35:	55                   	push   %ebp
  801c36:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c38:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 00                	push   $0x0
  801c43:	50                   	push   %eax
  801c44:	6a 05                	push   $0x5
  801c46:	e8 7d ff ff ff       	call   801bc8 <syscall>
  801c4b:	83 c4 18             	add    $0x18,%esp
}
  801c4e:	c9                   	leave  
  801c4f:	c3                   	ret    

00801c50 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c50:	55                   	push   %ebp
  801c51:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 02                	push   $0x2
  801c5f:	e8 64 ff ff ff       	call   801bc8 <syscall>
  801c64:	83 c4 18             	add    $0x18,%esp
}
  801c67:	c9                   	leave  
  801c68:	c3                   	ret    

00801c69 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c69:	55                   	push   %ebp
  801c6a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 03                	push   $0x3
  801c78:	e8 4b ff ff ff       	call   801bc8 <syscall>
  801c7d:	83 c4 18             	add    $0x18,%esp
}
  801c80:	c9                   	leave  
  801c81:	c3                   	ret    

00801c82 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c82:	55                   	push   %ebp
  801c83:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 04                	push   $0x4
  801c91:	e8 32 ff ff ff       	call   801bc8 <syscall>
  801c96:	83 c4 18             	add    $0x18,%esp
}
  801c99:	c9                   	leave  
  801c9a:	c3                   	ret    

00801c9b <sys_env_exit>:


void sys_env_exit(void)
{
  801c9b:	55                   	push   %ebp
  801c9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 06                	push   $0x6
  801caa:	e8 19 ff ff ff       	call   801bc8 <syscall>
  801caf:	83 c4 18             	add    $0x18,%esp
}
  801cb2:	90                   	nop
  801cb3:	c9                   	leave  
  801cb4:	c3                   	ret    

00801cb5 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801cb5:	55                   	push   %ebp
  801cb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801cb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	52                   	push   %edx
  801cc5:	50                   	push   %eax
  801cc6:	6a 07                	push   $0x7
  801cc8:	e8 fb fe ff ff       	call   801bc8 <syscall>
  801ccd:	83 c4 18             	add    $0x18,%esp
}
  801cd0:	c9                   	leave  
  801cd1:	c3                   	ret    

00801cd2 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801cd2:	55                   	push   %ebp
  801cd3:	89 e5                	mov    %esp,%ebp
  801cd5:	56                   	push   %esi
  801cd6:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801cd7:	8b 75 18             	mov    0x18(%ebp),%esi
  801cda:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cdd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ce0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce6:	56                   	push   %esi
  801ce7:	53                   	push   %ebx
  801ce8:	51                   	push   %ecx
  801ce9:	52                   	push   %edx
  801cea:	50                   	push   %eax
  801ceb:	6a 08                	push   $0x8
  801ced:	e8 d6 fe ff ff       	call   801bc8 <syscall>
  801cf2:	83 c4 18             	add    $0x18,%esp
}
  801cf5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801cf8:	5b                   	pop    %ebx
  801cf9:	5e                   	pop    %esi
  801cfa:	5d                   	pop    %ebp
  801cfb:	c3                   	ret    

00801cfc <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801cfc:	55                   	push   %ebp
  801cfd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801cff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d02:	8b 45 08             	mov    0x8(%ebp),%eax
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	52                   	push   %edx
  801d0c:	50                   	push   %eax
  801d0d:	6a 09                	push   $0x9
  801d0f:	e8 b4 fe ff ff       	call   801bc8 <syscall>
  801d14:	83 c4 18             	add    $0x18,%esp
}
  801d17:	c9                   	leave  
  801d18:	c3                   	ret    

00801d19 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d19:	55                   	push   %ebp
  801d1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	ff 75 0c             	pushl  0xc(%ebp)
  801d25:	ff 75 08             	pushl  0x8(%ebp)
  801d28:	6a 0a                	push   $0xa
  801d2a:	e8 99 fe ff ff       	call   801bc8 <syscall>
  801d2f:	83 c4 18             	add    $0x18,%esp
}
  801d32:	c9                   	leave  
  801d33:	c3                   	ret    

00801d34 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d34:	55                   	push   %ebp
  801d35:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 0b                	push   $0xb
  801d43:	e8 80 fe ff ff       	call   801bc8 <syscall>
  801d48:	83 c4 18             	add    $0x18,%esp
}
  801d4b:	c9                   	leave  
  801d4c:	c3                   	ret    

00801d4d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d4d:	55                   	push   %ebp
  801d4e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d50:	6a 00                	push   $0x0
  801d52:	6a 00                	push   $0x0
  801d54:	6a 00                	push   $0x0
  801d56:	6a 00                	push   $0x0
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 0c                	push   $0xc
  801d5c:	e8 67 fe ff ff       	call   801bc8 <syscall>
  801d61:	83 c4 18             	add    $0x18,%esp
}
  801d64:	c9                   	leave  
  801d65:	c3                   	ret    

00801d66 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d66:	55                   	push   %ebp
  801d67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 00                	push   $0x0
  801d6d:	6a 00                	push   $0x0
  801d6f:	6a 00                	push   $0x0
  801d71:	6a 00                	push   $0x0
  801d73:	6a 0d                	push   $0xd
  801d75:	e8 4e fe ff ff       	call   801bc8 <syscall>
  801d7a:	83 c4 18             	add    $0x18,%esp
}
  801d7d:	c9                   	leave  
  801d7e:	c3                   	ret    

00801d7f <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d7f:	55                   	push   %ebp
  801d80:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d82:	6a 00                	push   $0x0
  801d84:	6a 00                	push   $0x0
  801d86:	6a 00                	push   $0x0
  801d88:	ff 75 0c             	pushl  0xc(%ebp)
  801d8b:	ff 75 08             	pushl  0x8(%ebp)
  801d8e:	6a 11                	push   $0x11
  801d90:	e8 33 fe ff ff       	call   801bc8 <syscall>
  801d95:	83 c4 18             	add    $0x18,%esp
	return;
  801d98:	90                   	nop
}
  801d99:	c9                   	leave  
  801d9a:	c3                   	ret    

00801d9b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d9b:	55                   	push   %ebp
  801d9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	ff 75 0c             	pushl  0xc(%ebp)
  801da7:	ff 75 08             	pushl  0x8(%ebp)
  801daa:	6a 12                	push   $0x12
  801dac:	e8 17 fe ff ff       	call   801bc8 <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
	return ;
  801db4:	90                   	nop
}
  801db5:	c9                   	leave  
  801db6:	c3                   	ret    

00801db7 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801db7:	55                   	push   %ebp
  801db8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 0e                	push   $0xe
  801dc6:	e8 fd fd ff ff       	call   801bc8 <syscall>
  801dcb:	83 c4 18             	add    $0x18,%esp
}
  801dce:	c9                   	leave  
  801dcf:	c3                   	ret    

00801dd0 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801dd0:	55                   	push   %ebp
  801dd1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	ff 75 08             	pushl  0x8(%ebp)
  801dde:	6a 0f                	push   $0xf
  801de0:	e8 e3 fd ff ff       	call   801bc8 <syscall>
  801de5:	83 c4 18             	add    $0x18,%esp
}
  801de8:	c9                   	leave  
  801de9:	c3                   	ret    

00801dea <sys_scarce_memory>:

void sys_scarce_memory()
{
  801dea:	55                   	push   %ebp
  801deb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 10                	push   $0x10
  801df9:	e8 ca fd ff ff       	call   801bc8 <syscall>
  801dfe:	83 c4 18             	add    $0x18,%esp
}
  801e01:	90                   	nop
  801e02:	c9                   	leave  
  801e03:	c3                   	ret    

00801e04 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e04:	55                   	push   %ebp
  801e05:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e07:	6a 00                	push   $0x0
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 14                	push   $0x14
  801e13:	e8 b0 fd ff ff       	call   801bc8 <syscall>
  801e18:	83 c4 18             	add    $0x18,%esp
}
  801e1b:	90                   	nop
  801e1c:	c9                   	leave  
  801e1d:	c3                   	ret    

00801e1e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e1e:	55                   	push   %ebp
  801e1f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 15                	push   $0x15
  801e2d:	e8 96 fd ff ff       	call   801bc8 <syscall>
  801e32:	83 c4 18             	add    $0x18,%esp
}
  801e35:	90                   	nop
  801e36:	c9                   	leave  
  801e37:	c3                   	ret    

00801e38 <sys_cputc>:


void
sys_cputc(const char c)
{
  801e38:	55                   	push   %ebp
  801e39:	89 e5                	mov    %esp,%ebp
  801e3b:	83 ec 04             	sub    $0x4,%esp
  801e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e41:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e44:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e48:	6a 00                	push   $0x0
  801e4a:	6a 00                	push   $0x0
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	50                   	push   %eax
  801e51:	6a 16                	push   $0x16
  801e53:	e8 70 fd ff ff       	call   801bc8 <syscall>
  801e58:	83 c4 18             	add    $0x18,%esp
}
  801e5b:	90                   	nop
  801e5c:	c9                   	leave  
  801e5d:	c3                   	ret    

00801e5e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e5e:	55                   	push   %ebp
  801e5f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 17                	push   $0x17
  801e6d:	e8 56 fd ff ff       	call   801bc8 <syscall>
  801e72:	83 c4 18             	add    $0x18,%esp
}
  801e75:	90                   	nop
  801e76:	c9                   	leave  
  801e77:	c3                   	ret    

00801e78 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e78:	55                   	push   %ebp
  801e79:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	6a 00                	push   $0x0
  801e84:	ff 75 0c             	pushl  0xc(%ebp)
  801e87:	50                   	push   %eax
  801e88:	6a 18                	push   $0x18
  801e8a:	e8 39 fd ff ff       	call   801bc8 <syscall>
  801e8f:	83 c4 18             	add    $0x18,%esp
}
  801e92:	c9                   	leave  
  801e93:	c3                   	ret    

00801e94 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e94:	55                   	push   %ebp
  801e95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e97:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	52                   	push   %edx
  801ea4:	50                   	push   %eax
  801ea5:	6a 1b                	push   $0x1b
  801ea7:	e8 1c fd ff ff       	call   801bc8 <syscall>
  801eac:	83 c4 18             	add    $0x18,%esp
}
  801eaf:	c9                   	leave  
  801eb0:	c3                   	ret    

00801eb1 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801eb1:	55                   	push   %ebp
  801eb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801eb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	52                   	push   %edx
  801ec1:	50                   	push   %eax
  801ec2:	6a 19                	push   $0x19
  801ec4:	e8 ff fc ff ff       	call   801bc8 <syscall>
  801ec9:	83 c4 18             	add    $0x18,%esp
}
  801ecc:	90                   	nop
  801ecd:	c9                   	leave  
  801ece:	c3                   	ret    

00801ecf <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ecf:	55                   	push   %ebp
  801ed0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ed2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed8:	6a 00                	push   $0x0
  801eda:	6a 00                	push   $0x0
  801edc:	6a 00                	push   $0x0
  801ede:	52                   	push   %edx
  801edf:	50                   	push   %eax
  801ee0:	6a 1a                	push   $0x1a
  801ee2:	e8 e1 fc ff ff       	call   801bc8 <syscall>
  801ee7:	83 c4 18             	add    $0x18,%esp
}
  801eea:	90                   	nop
  801eeb:	c9                   	leave  
  801eec:	c3                   	ret    

00801eed <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801eed:	55                   	push   %ebp
  801eee:	89 e5                	mov    %esp,%ebp
  801ef0:	83 ec 04             	sub    $0x4,%esp
  801ef3:	8b 45 10             	mov    0x10(%ebp),%eax
  801ef6:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801ef9:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801efc:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f00:	8b 45 08             	mov    0x8(%ebp),%eax
  801f03:	6a 00                	push   $0x0
  801f05:	51                   	push   %ecx
  801f06:	52                   	push   %edx
  801f07:	ff 75 0c             	pushl  0xc(%ebp)
  801f0a:	50                   	push   %eax
  801f0b:	6a 1c                	push   $0x1c
  801f0d:	e8 b6 fc ff ff       	call   801bc8 <syscall>
  801f12:	83 c4 18             	add    $0x18,%esp
}
  801f15:	c9                   	leave  
  801f16:	c3                   	ret    

00801f17 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f17:	55                   	push   %ebp
  801f18:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f20:	6a 00                	push   $0x0
  801f22:	6a 00                	push   $0x0
  801f24:	6a 00                	push   $0x0
  801f26:	52                   	push   %edx
  801f27:	50                   	push   %eax
  801f28:	6a 1d                	push   $0x1d
  801f2a:	e8 99 fc ff ff       	call   801bc8 <syscall>
  801f2f:	83 c4 18             	add    $0x18,%esp
}
  801f32:	c9                   	leave  
  801f33:	c3                   	ret    

00801f34 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f34:	55                   	push   %ebp
  801f35:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f37:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f40:	6a 00                	push   $0x0
  801f42:	6a 00                	push   $0x0
  801f44:	51                   	push   %ecx
  801f45:	52                   	push   %edx
  801f46:	50                   	push   %eax
  801f47:	6a 1e                	push   $0x1e
  801f49:	e8 7a fc ff ff       	call   801bc8 <syscall>
  801f4e:	83 c4 18             	add    $0x18,%esp
}
  801f51:	c9                   	leave  
  801f52:	c3                   	ret    

00801f53 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f53:	55                   	push   %ebp
  801f54:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f56:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f59:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 00                	push   $0x0
  801f62:	52                   	push   %edx
  801f63:	50                   	push   %eax
  801f64:	6a 1f                	push   $0x1f
  801f66:	e8 5d fc ff ff       	call   801bc8 <syscall>
  801f6b:	83 c4 18             	add    $0x18,%esp
}
  801f6e:	c9                   	leave  
  801f6f:	c3                   	ret    

00801f70 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f70:	55                   	push   %ebp
  801f71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f73:	6a 00                	push   $0x0
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 20                	push   $0x20
  801f7f:	e8 44 fc ff ff       	call   801bc8 <syscall>
  801f84:	83 c4 18             	add    $0x18,%esp
}
  801f87:	c9                   	leave  
  801f88:	c3                   	ret    

00801f89 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801f89:	55                   	push   %ebp
  801f8a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801f8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8f:	6a 00                	push   $0x0
  801f91:	ff 75 14             	pushl  0x14(%ebp)
  801f94:	ff 75 10             	pushl  0x10(%ebp)
  801f97:	ff 75 0c             	pushl  0xc(%ebp)
  801f9a:	50                   	push   %eax
  801f9b:	6a 21                	push   $0x21
  801f9d:	e8 26 fc ff ff       	call   801bc8 <syscall>
  801fa2:	83 c4 18             	add    $0x18,%esp
}
  801fa5:	c9                   	leave  
  801fa6:	c3                   	ret    

00801fa7 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801fa7:	55                   	push   %ebp
  801fa8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801faa:	8b 45 08             	mov    0x8(%ebp),%eax
  801fad:	6a 00                	push   $0x0
  801faf:	6a 00                	push   $0x0
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	50                   	push   %eax
  801fb6:	6a 22                	push   $0x22
  801fb8:	e8 0b fc ff ff       	call   801bc8 <syscall>
  801fbd:	83 c4 18             	add    $0x18,%esp
}
  801fc0:	90                   	nop
  801fc1:	c9                   	leave  
  801fc2:	c3                   	ret    

00801fc3 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801fc3:	55                   	push   %ebp
  801fc4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	50                   	push   %eax
  801fd2:	6a 23                	push   $0x23
  801fd4:	e8 ef fb ff ff       	call   801bc8 <syscall>
  801fd9:	83 c4 18             	add    $0x18,%esp
}
  801fdc:	90                   	nop
  801fdd:	c9                   	leave  
  801fde:	c3                   	ret    

00801fdf <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801fdf:	55                   	push   %ebp
  801fe0:	89 e5                	mov    %esp,%ebp
  801fe2:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801fe5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fe8:	8d 50 04             	lea    0x4(%eax),%edx
  801feb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	52                   	push   %edx
  801ff5:	50                   	push   %eax
  801ff6:	6a 24                	push   $0x24
  801ff8:	e8 cb fb ff ff       	call   801bc8 <syscall>
  801ffd:	83 c4 18             	add    $0x18,%esp
	return result;
  802000:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802003:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802006:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802009:	89 01                	mov    %eax,(%ecx)
  80200b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80200e:	8b 45 08             	mov    0x8(%ebp),%eax
  802011:	c9                   	leave  
  802012:	c2 04 00             	ret    $0x4

00802015 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802015:	55                   	push   %ebp
  802016:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	ff 75 10             	pushl  0x10(%ebp)
  80201f:	ff 75 0c             	pushl  0xc(%ebp)
  802022:	ff 75 08             	pushl  0x8(%ebp)
  802025:	6a 13                	push   $0x13
  802027:	e8 9c fb ff ff       	call   801bc8 <syscall>
  80202c:	83 c4 18             	add    $0x18,%esp
	return ;
  80202f:	90                   	nop
}
  802030:	c9                   	leave  
  802031:	c3                   	ret    

00802032 <sys_rcr2>:
uint32 sys_rcr2()
{
  802032:	55                   	push   %ebp
  802033:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802035:	6a 00                	push   $0x0
  802037:	6a 00                	push   $0x0
  802039:	6a 00                	push   $0x0
  80203b:	6a 00                	push   $0x0
  80203d:	6a 00                	push   $0x0
  80203f:	6a 25                	push   $0x25
  802041:	e8 82 fb ff ff       	call   801bc8 <syscall>
  802046:	83 c4 18             	add    $0x18,%esp
}
  802049:	c9                   	leave  
  80204a:	c3                   	ret    

0080204b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80204b:	55                   	push   %ebp
  80204c:	89 e5                	mov    %esp,%ebp
  80204e:	83 ec 04             	sub    $0x4,%esp
  802051:	8b 45 08             	mov    0x8(%ebp),%eax
  802054:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802057:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80205b:	6a 00                	push   $0x0
  80205d:	6a 00                	push   $0x0
  80205f:	6a 00                	push   $0x0
  802061:	6a 00                	push   $0x0
  802063:	50                   	push   %eax
  802064:	6a 26                	push   $0x26
  802066:	e8 5d fb ff ff       	call   801bc8 <syscall>
  80206b:	83 c4 18             	add    $0x18,%esp
	return ;
  80206e:	90                   	nop
}
  80206f:	c9                   	leave  
  802070:	c3                   	ret    

00802071 <rsttst>:
void rsttst()
{
  802071:	55                   	push   %ebp
  802072:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802074:	6a 00                	push   $0x0
  802076:	6a 00                	push   $0x0
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	6a 00                	push   $0x0
  80207e:	6a 28                	push   $0x28
  802080:	e8 43 fb ff ff       	call   801bc8 <syscall>
  802085:	83 c4 18             	add    $0x18,%esp
	return ;
  802088:	90                   	nop
}
  802089:	c9                   	leave  
  80208a:	c3                   	ret    

0080208b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80208b:	55                   	push   %ebp
  80208c:	89 e5                	mov    %esp,%ebp
  80208e:	83 ec 04             	sub    $0x4,%esp
  802091:	8b 45 14             	mov    0x14(%ebp),%eax
  802094:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802097:	8b 55 18             	mov    0x18(%ebp),%edx
  80209a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80209e:	52                   	push   %edx
  80209f:	50                   	push   %eax
  8020a0:	ff 75 10             	pushl  0x10(%ebp)
  8020a3:	ff 75 0c             	pushl  0xc(%ebp)
  8020a6:	ff 75 08             	pushl  0x8(%ebp)
  8020a9:	6a 27                	push   $0x27
  8020ab:	e8 18 fb ff ff       	call   801bc8 <syscall>
  8020b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8020b3:	90                   	nop
}
  8020b4:	c9                   	leave  
  8020b5:	c3                   	ret    

008020b6 <chktst>:
void chktst(uint32 n)
{
  8020b6:	55                   	push   %ebp
  8020b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	ff 75 08             	pushl  0x8(%ebp)
  8020c4:	6a 29                	push   $0x29
  8020c6:	e8 fd fa ff ff       	call   801bc8 <syscall>
  8020cb:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ce:	90                   	nop
}
  8020cf:	c9                   	leave  
  8020d0:	c3                   	ret    

008020d1 <inctst>:

void inctst()
{
  8020d1:	55                   	push   %ebp
  8020d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8020d4:	6a 00                	push   $0x0
  8020d6:	6a 00                	push   $0x0
  8020d8:	6a 00                	push   $0x0
  8020da:	6a 00                	push   $0x0
  8020dc:	6a 00                	push   $0x0
  8020de:	6a 2a                	push   $0x2a
  8020e0:	e8 e3 fa ff ff       	call   801bc8 <syscall>
  8020e5:	83 c4 18             	add    $0x18,%esp
	return ;
  8020e8:	90                   	nop
}
  8020e9:	c9                   	leave  
  8020ea:	c3                   	ret    

008020eb <gettst>:
uint32 gettst()
{
  8020eb:	55                   	push   %ebp
  8020ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020ee:	6a 00                	push   $0x0
  8020f0:	6a 00                	push   $0x0
  8020f2:	6a 00                	push   $0x0
  8020f4:	6a 00                	push   $0x0
  8020f6:	6a 00                	push   $0x0
  8020f8:	6a 2b                	push   $0x2b
  8020fa:	e8 c9 fa ff ff       	call   801bc8 <syscall>
  8020ff:	83 c4 18             	add    $0x18,%esp
}
  802102:	c9                   	leave  
  802103:	c3                   	ret    

00802104 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802104:	55                   	push   %ebp
  802105:	89 e5                	mov    %esp,%ebp
  802107:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80210a:	6a 00                	push   $0x0
  80210c:	6a 00                	push   $0x0
  80210e:	6a 00                	push   $0x0
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 2c                	push   $0x2c
  802116:	e8 ad fa ff ff       	call   801bc8 <syscall>
  80211b:	83 c4 18             	add    $0x18,%esp
  80211e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802121:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802125:	75 07                	jne    80212e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802127:	b8 01 00 00 00       	mov    $0x1,%eax
  80212c:	eb 05                	jmp    802133 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80212e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802133:	c9                   	leave  
  802134:	c3                   	ret    

00802135 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802135:	55                   	push   %ebp
  802136:	89 e5                	mov    %esp,%ebp
  802138:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80213b:	6a 00                	push   $0x0
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	6a 00                	push   $0x0
  802143:	6a 00                	push   $0x0
  802145:	6a 2c                	push   $0x2c
  802147:	e8 7c fa ff ff       	call   801bc8 <syscall>
  80214c:	83 c4 18             	add    $0x18,%esp
  80214f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802152:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802156:	75 07                	jne    80215f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802158:	b8 01 00 00 00       	mov    $0x1,%eax
  80215d:	eb 05                	jmp    802164 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80215f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802164:	c9                   	leave  
  802165:	c3                   	ret    

00802166 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802166:	55                   	push   %ebp
  802167:	89 e5                	mov    %esp,%ebp
  802169:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80216c:	6a 00                	push   $0x0
  80216e:	6a 00                	push   $0x0
  802170:	6a 00                	push   $0x0
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 2c                	push   $0x2c
  802178:	e8 4b fa ff ff       	call   801bc8 <syscall>
  80217d:	83 c4 18             	add    $0x18,%esp
  802180:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802183:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802187:	75 07                	jne    802190 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802189:	b8 01 00 00 00       	mov    $0x1,%eax
  80218e:	eb 05                	jmp    802195 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802190:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802195:	c9                   	leave  
  802196:	c3                   	ret    

00802197 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802197:	55                   	push   %ebp
  802198:	89 e5                	mov    %esp,%ebp
  80219a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	6a 00                	push   $0x0
  8021a3:	6a 00                	push   $0x0
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 2c                	push   $0x2c
  8021a9:	e8 1a fa ff ff       	call   801bc8 <syscall>
  8021ae:	83 c4 18             	add    $0x18,%esp
  8021b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8021b4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8021b8:	75 07                	jne    8021c1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8021ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8021bf:	eb 05                	jmp    8021c6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8021c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021c6:	c9                   	leave  
  8021c7:	c3                   	ret    

008021c8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8021c8:	55                   	push   %ebp
  8021c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021cb:	6a 00                	push   $0x0
  8021cd:	6a 00                	push   $0x0
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 00                	push   $0x0
  8021d3:	ff 75 08             	pushl  0x8(%ebp)
  8021d6:	6a 2d                	push   $0x2d
  8021d8:	e8 eb f9 ff ff       	call   801bc8 <syscall>
  8021dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e0:	90                   	nop
}
  8021e1:	c9                   	leave  
  8021e2:	c3                   	ret    

008021e3 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8021e3:	55                   	push   %ebp
  8021e4:	89 e5                	mov    %esp,%ebp
  8021e6:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8021e7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8021ea:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8021f3:	6a 00                	push   $0x0
  8021f5:	53                   	push   %ebx
  8021f6:	51                   	push   %ecx
  8021f7:	52                   	push   %edx
  8021f8:	50                   	push   %eax
  8021f9:	6a 2e                	push   $0x2e
  8021fb:	e8 c8 f9 ff ff       	call   801bc8 <syscall>
  802200:	83 c4 18             	add    $0x18,%esp
}
  802203:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802206:	c9                   	leave  
  802207:	c3                   	ret    

00802208 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802208:	55                   	push   %ebp
  802209:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80220b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80220e:	8b 45 08             	mov    0x8(%ebp),%eax
  802211:	6a 00                	push   $0x0
  802213:	6a 00                	push   $0x0
  802215:	6a 00                	push   $0x0
  802217:	52                   	push   %edx
  802218:	50                   	push   %eax
  802219:	6a 2f                	push   $0x2f
  80221b:	e8 a8 f9 ff ff       	call   801bc8 <syscall>
  802220:	83 c4 18             	add    $0x18,%esp
}
  802223:	c9                   	leave  
  802224:	c3                   	ret    
  802225:	66 90                	xchg   %ax,%ax
  802227:	90                   	nop

00802228 <__udivdi3>:
  802228:	55                   	push   %ebp
  802229:	57                   	push   %edi
  80222a:	56                   	push   %esi
  80222b:	53                   	push   %ebx
  80222c:	83 ec 1c             	sub    $0x1c,%esp
  80222f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802233:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802237:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80223b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80223f:	89 ca                	mov    %ecx,%edx
  802241:	89 f8                	mov    %edi,%eax
  802243:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802247:	85 f6                	test   %esi,%esi
  802249:	75 2d                	jne    802278 <__udivdi3+0x50>
  80224b:	39 cf                	cmp    %ecx,%edi
  80224d:	77 65                	ja     8022b4 <__udivdi3+0x8c>
  80224f:	89 fd                	mov    %edi,%ebp
  802251:	85 ff                	test   %edi,%edi
  802253:	75 0b                	jne    802260 <__udivdi3+0x38>
  802255:	b8 01 00 00 00       	mov    $0x1,%eax
  80225a:	31 d2                	xor    %edx,%edx
  80225c:	f7 f7                	div    %edi
  80225e:	89 c5                	mov    %eax,%ebp
  802260:	31 d2                	xor    %edx,%edx
  802262:	89 c8                	mov    %ecx,%eax
  802264:	f7 f5                	div    %ebp
  802266:	89 c1                	mov    %eax,%ecx
  802268:	89 d8                	mov    %ebx,%eax
  80226a:	f7 f5                	div    %ebp
  80226c:	89 cf                	mov    %ecx,%edi
  80226e:	89 fa                	mov    %edi,%edx
  802270:	83 c4 1c             	add    $0x1c,%esp
  802273:	5b                   	pop    %ebx
  802274:	5e                   	pop    %esi
  802275:	5f                   	pop    %edi
  802276:	5d                   	pop    %ebp
  802277:	c3                   	ret    
  802278:	39 ce                	cmp    %ecx,%esi
  80227a:	77 28                	ja     8022a4 <__udivdi3+0x7c>
  80227c:	0f bd fe             	bsr    %esi,%edi
  80227f:	83 f7 1f             	xor    $0x1f,%edi
  802282:	75 40                	jne    8022c4 <__udivdi3+0x9c>
  802284:	39 ce                	cmp    %ecx,%esi
  802286:	72 0a                	jb     802292 <__udivdi3+0x6a>
  802288:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80228c:	0f 87 9e 00 00 00    	ja     802330 <__udivdi3+0x108>
  802292:	b8 01 00 00 00       	mov    $0x1,%eax
  802297:	89 fa                	mov    %edi,%edx
  802299:	83 c4 1c             	add    $0x1c,%esp
  80229c:	5b                   	pop    %ebx
  80229d:	5e                   	pop    %esi
  80229e:	5f                   	pop    %edi
  80229f:	5d                   	pop    %ebp
  8022a0:	c3                   	ret    
  8022a1:	8d 76 00             	lea    0x0(%esi),%esi
  8022a4:	31 ff                	xor    %edi,%edi
  8022a6:	31 c0                	xor    %eax,%eax
  8022a8:	89 fa                	mov    %edi,%edx
  8022aa:	83 c4 1c             	add    $0x1c,%esp
  8022ad:	5b                   	pop    %ebx
  8022ae:	5e                   	pop    %esi
  8022af:	5f                   	pop    %edi
  8022b0:	5d                   	pop    %ebp
  8022b1:	c3                   	ret    
  8022b2:	66 90                	xchg   %ax,%ax
  8022b4:	89 d8                	mov    %ebx,%eax
  8022b6:	f7 f7                	div    %edi
  8022b8:	31 ff                	xor    %edi,%edi
  8022ba:	89 fa                	mov    %edi,%edx
  8022bc:	83 c4 1c             	add    $0x1c,%esp
  8022bf:	5b                   	pop    %ebx
  8022c0:	5e                   	pop    %esi
  8022c1:	5f                   	pop    %edi
  8022c2:	5d                   	pop    %ebp
  8022c3:	c3                   	ret    
  8022c4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8022c9:	89 eb                	mov    %ebp,%ebx
  8022cb:	29 fb                	sub    %edi,%ebx
  8022cd:	89 f9                	mov    %edi,%ecx
  8022cf:	d3 e6                	shl    %cl,%esi
  8022d1:	89 c5                	mov    %eax,%ebp
  8022d3:	88 d9                	mov    %bl,%cl
  8022d5:	d3 ed                	shr    %cl,%ebp
  8022d7:	89 e9                	mov    %ebp,%ecx
  8022d9:	09 f1                	or     %esi,%ecx
  8022db:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8022df:	89 f9                	mov    %edi,%ecx
  8022e1:	d3 e0                	shl    %cl,%eax
  8022e3:	89 c5                	mov    %eax,%ebp
  8022e5:	89 d6                	mov    %edx,%esi
  8022e7:	88 d9                	mov    %bl,%cl
  8022e9:	d3 ee                	shr    %cl,%esi
  8022eb:	89 f9                	mov    %edi,%ecx
  8022ed:	d3 e2                	shl    %cl,%edx
  8022ef:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022f3:	88 d9                	mov    %bl,%cl
  8022f5:	d3 e8                	shr    %cl,%eax
  8022f7:	09 c2                	or     %eax,%edx
  8022f9:	89 d0                	mov    %edx,%eax
  8022fb:	89 f2                	mov    %esi,%edx
  8022fd:	f7 74 24 0c          	divl   0xc(%esp)
  802301:	89 d6                	mov    %edx,%esi
  802303:	89 c3                	mov    %eax,%ebx
  802305:	f7 e5                	mul    %ebp
  802307:	39 d6                	cmp    %edx,%esi
  802309:	72 19                	jb     802324 <__udivdi3+0xfc>
  80230b:	74 0b                	je     802318 <__udivdi3+0xf0>
  80230d:	89 d8                	mov    %ebx,%eax
  80230f:	31 ff                	xor    %edi,%edi
  802311:	e9 58 ff ff ff       	jmp    80226e <__udivdi3+0x46>
  802316:	66 90                	xchg   %ax,%ax
  802318:	8b 54 24 08          	mov    0x8(%esp),%edx
  80231c:	89 f9                	mov    %edi,%ecx
  80231e:	d3 e2                	shl    %cl,%edx
  802320:	39 c2                	cmp    %eax,%edx
  802322:	73 e9                	jae    80230d <__udivdi3+0xe5>
  802324:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802327:	31 ff                	xor    %edi,%edi
  802329:	e9 40 ff ff ff       	jmp    80226e <__udivdi3+0x46>
  80232e:	66 90                	xchg   %ax,%ax
  802330:	31 c0                	xor    %eax,%eax
  802332:	e9 37 ff ff ff       	jmp    80226e <__udivdi3+0x46>
  802337:	90                   	nop

00802338 <__umoddi3>:
  802338:	55                   	push   %ebp
  802339:	57                   	push   %edi
  80233a:	56                   	push   %esi
  80233b:	53                   	push   %ebx
  80233c:	83 ec 1c             	sub    $0x1c,%esp
  80233f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802343:	8b 74 24 34          	mov    0x34(%esp),%esi
  802347:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80234b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80234f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802353:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802357:	89 f3                	mov    %esi,%ebx
  802359:	89 fa                	mov    %edi,%edx
  80235b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80235f:	89 34 24             	mov    %esi,(%esp)
  802362:	85 c0                	test   %eax,%eax
  802364:	75 1a                	jne    802380 <__umoddi3+0x48>
  802366:	39 f7                	cmp    %esi,%edi
  802368:	0f 86 a2 00 00 00    	jbe    802410 <__umoddi3+0xd8>
  80236e:	89 c8                	mov    %ecx,%eax
  802370:	89 f2                	mov    %esi,%edx
  802372:	f7 f7                	div    %edi
  802374:	89 d0                	mov    %edx,%eax
  802376:	31 d2                	xor    %edx,%edx
  802378:	83 c4 1c             	add    $0x1c,%esp
  80237b:	5b                   	pop    %ebx
  80237c:	5e                   	pop    %esi
  80237d:	5f                   	pop    %edi
  80237e:	5d                   	pop    %ebp
  80237f:	c3                   	ret    
  802380:	39 f0                	cmp    %esi,%eax
  802382:	0f 87 ac 00 00 00    	ja     802434 <__umoddi3+0xfc>
  802388:	0f bd e8             	bsr    %eax,%ebp
  80238b:	83 f5 1f             	xor    $0x1f,%ebp
  80238e:	0f 84 ac 00 00 00    	je     802440 <__umoddi3+0x108>
  802394:	bf 20 00 00 00       	mov    $0x20,%edi
  802399:	29 ef                	sub    %ebp,%edi
  80239b:	89 fe                	mov    %edi,%esi
  80239d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8023a1:	89 e9                	mov    %ebp,%ecx
  8023a3:	d3 e0                	shl    %cl,%eax
  8023a5:	89 d7                	mov    %edx,%edi
  8023a7:	89 f1                	mov    %esi,%ecx
  8023a9:	d3 ef                	shr    %cl,%edi
  8023ab:	09 c7                	or     %eax,%edi
  8023ad:	89 e9                	mov    %ebp,%ecx
  8023af:	d3 e2                	shl    %cl,%edx
  8023b1:	89 14 24             	mov    %edx,(%esp)
  8023b4:	89 d8                	mov    %ebx,%eax
  8023b6:	d3 e0                	shl    %cl,%eax
  8023b8:	89 c2                	mov    %eax,%edx
  8023ba:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023be:	d3 e0                	shl    %cl,%eax
  8023c0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8023c4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023c8:	89 f1                	mov    %esi,%ecx
  8023ca:	d3 e8                	shr    %cl,%eax
  8023cc:	09 d0                	or     %edx,%eax
  8023ce:	d3 eb                	shr    %cl,%ebx
  8023d0:	89 da                	mov    %ebx,%edx
  8023d2:	f7 f7                	div    %edi
  8023d4:	89 d3                	mov    %edx,%ebx
  8023d6:	f7 24 24             	mull   (%esp)
  8023d9:	89 c6                	mov    %eax,%esi
  8023db:	89 d1                	mov    %edx,%ecx
  8023dd:	39 d3                	cmp    %edx,%ebx
  8023df:	0f 82 87 00 00 00    	jb     80246c <__umoddi3+0x134>
  8023e5:	0f 84 91 00 00 00    	je     80247c <__umoddi3+0x144>
  8023eb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8023ef:	29 f2                	sub    %esi,%edx
  8023f1:	19 cb                	sbb    %ecx,%ebx
  8023f3:	89 d8                	mov    %ebx,%eax
  8023f5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8023f9:	d3 e0                	shl    %cl,%eax
  8023fb:	89 e9                	mov    %ebp,%ecx
  8023fd:	d3 ea                	shr    %cl,%edx
  8023ff:	09 d0                	or     %edx,%eax
  802401:	89 e9                	mov    %ebp,%ecx
  802403:	d3 eb                	shr    %cl,%ebx
  802405:	89 da                	mov    %ebx,%edx
  802407:	83 c4 1c             	add    $0x1c,%esp
  80240a:	5b                   	pop    %ebx
  80240b:	5e                   	pop    %esi
  80240c:	5f                   	pop    %edi
  80240d:	5d                   	pop    %ebp
  80240e:	c3                   	ret    
  80240f:	90                   	nop
  802410:	89 fd                	mov    %edi,%ebp
  802412:	85 ff                	test   %edi,%edi
  802414:	75 0b                	jne    802421 <__umoddi3+0xe9>
  802416:	b8 01 00 00 00       	mov    $0x1,%eax
  80241b:	31 d2                	xor    %edx,%edx
  80241d:	f7 f7                	div    %edi
  80241f:	89 c5                	mov    %eax,%ebp
  802421:	89 f0                	mov    %esi,%eax
  802423:	31 d2                	xor    %edx,%edx
  802425:	f7 f5                	div    %ebp
  802427:	89 c8                	mov    %ecx,%eax
  802429:	f7 f5                	div    %ebp
  80242b:	89 d0                	mov    %edx,%eax
  80242d:	e9 44 ff ff ff       	jmp    802376 <__umoddi3+0x3e>
  802432:	66 90                	xchg   %ax,%ax
  802434:	89 c8                	mov    %ecx,%eax
  802436:	89 f2                	mov    %esi,%edx
  802438:	83 c4 1c             	add    $0x1c,%esp
  80243b:	5b                   	pop    %ebx
  80243c:	5e                   	pop    %esi
  80243d:	5f                   	pop    %edi
  80243e:	5d                   	pop    %ebp
  80243f:	c3                   	ret    
  802440:	3b 04 24             	cmp    (%esp),%eax
  802443:	72 06                	jb     80244b <__umoddi3+0x113>
  802445:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802449:	77 0f                	ja     80245a <__umoddi3+0x122>
  80244b:	89 f2                	mov    %esi,%edx
  80244d:	29 f9                	sub    %edi,%ecx
  80244f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802453:	89 14 24             	mov    %edx,(%esp)
  802456:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80245a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80245e:	8b 14 24             	mov    (%esp),%edx
  802461:	83 c4 1c             	add    $0x1c,%esp
  802464:	5b                   	pop    %ebx
  802465:	5e                   	pop    %esi
  802466:	5f                   	pop    %edi
  802467:	5d                   	pop    %ebp
  802468:	c3                   	ret    
  802469:	8d 76 00             	lea    0x0(%esi),%esi
  80246c:	2b 04 24             	sub    (%esp),%eax
  80246f:	19 fa                	sbb    %edi,%edx
  802471:	89 d1                	mov    %edx,%ecx
  802473:	89 c6                	mov    %eax,%esi
  802475:	e9 71 ff ff ff       	jmp    8023eb <__umoddi3+0xb3>
  80247a:	66 90                	xchg   %ax,%ax
  80247c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802480:	72 ea                	jb     80246c <__umoddi3+0x134>
  802482:	89 d9                	mov    %ebx,%ecx
  802484:	e9 62 ff ff ff       	jmp    8023eb <__umoddi3+0xb3>
