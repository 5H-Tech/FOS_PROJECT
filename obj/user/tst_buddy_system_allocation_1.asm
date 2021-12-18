
obj/user/tst_buddy_system_allocation_1:     file format elf32-i386


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
  800031:	e8 c4 04 00 00       	call   8004fa <libmain>
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
  80003c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
	int freeFrames1 = sys_calculate_free_frames() ;
  800042:	e8 77 1a 00 00       	call   801abe <sys_calculate_free_frames>
  800047:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int usedDiskPages1 = sys_pf_calculate_allocated_pages() ;
  80004a:	e8 f2 1a 00 00       	call   801b41 <sys_pf_calculate_allocated_pages>
  80004f:	89 45 dc             	mov    %eax,-0x24(%ebp)

	char line[100];
	int N = 500;
  800052:	c7 45 d8 f4 01 00 00 	movl   $0x1f4,-0x28(%ebp)
	assert(N * sizeof(int) <= BUDDY_LIMIT);
  800059:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80005c:	c1 e0 02             	shl    $0x2,%eax
  80005f:	3d 00 08 00 00       	cmp    $0x800,%eax
  800064:	76 16                	jbe    80007c <_main+0x44>
  800066:	68 20 22 80 00       	push   $0x802220
  80006b:	68 3f 22 80 00       	push   $0x80223f
  800070:	6a 0d                	push   $0xd
  800072:	68 54 22 80 00       	push   $0x802254
  800077:	e8 c3 05 00 00       	call   80063f <_panic>
	int M = 1;
  80007c:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
	assert(M * sizeof(uint8) <= BUDDY_LIMIT);
  800083:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800086:	3d 00 08 00 00       	cmp    $0x800,%eax
  80008b:	76 16                	jbe    8000a3 <_main+0x6b>
  80008d:	68 7c 22 80 00       	push   $0x80227c
  800092:	68 3f 22 80 00       	push   $0x80223f
  800097:	6a 0f                	push   $0xf
  800099:	68 54 22 80 00       	push   $0x802254
  80009e:	e8 9c 05 00 00       	call   80063f <_panic>

	uint8 ** arr = malloc(N * sizeof(int)) ;
  8000a3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000a6:	c1 e0 02             	shl    $0x2,%eax
  8000a9:	83 ec 0c             	sub    $0xc,%esp
  8000ac:	50                   	push   %eax
  8000ad:	e8 b9 15 00 00       	call   80166b <malloc>
  8000b2:	83 c4 10             	add    $0x10,%esp
  8000b5:	89 45 d0             	mov    %eax,-0x30(%ebp)
	int expectedNumOfAllocatedFrames = GetPowOf2(N * sizeof(int));
  8000b8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000bb:	c1 e0 02             	shl    $0x2,%eax
  8000be:	83 ec 0c             	sub    $0xc,%esp
  8000c1:	50                   	push   %eax
  8000c2:	e8 f1 03 00 00       	call   8004b8 <GetPowOf2>
  8000c7:	83 c4 10             	add    $0x10,%esp
  8000ca:	89 45 f4             	mov    %eax,-0xc(%ebp)

	for (int i = 0; i < N; ++i)
  8000cd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000d4:	eb 7a                	jmp    800150 <_main+0x118>
	{
		arr[i] = malloc(M + i) ;
  8000d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000e3:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
  8000e6:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8000e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000ec:	01 d0                	add    %edx,%eax
  8000ee:	83 ec 0c             	sub    $0xc,%esp
  8000f1:	50                   	push   %eax
  8000f2:	e8 74 15 00 00       	call   80166b <malloc>
  8000f7:	83 c4 10             	add    $0x10,%esp
  8000fa:	89 03                	mov    %eax,(%ebx)
		expectedNumOfAllocatedFrames += GetPowOf2(M + i);
  8000fc:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8000ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800102:	01 d0                	add    %edx,%eax
  800104:	83 ec 0c             	sub    $0xc,%esp
  800107:	50                   	push   %eax
  800108:	e8 ab 03 00 00       	call   8004b8 <GetPowOf2>
  80010d:	83 c4 10             	add    $0x10,%esp
  800110:	01 45 f4             	add    %eax,-0xc(%ebp)
		for (int j = 0; j < M; ++j)
  800113:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80011a:	eb 29                	jmp    800145 <_main+0x10d>
		{
			arr[i][j] = i % 255;
  80011c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80011f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800126:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800129:	01 d0                	add    %edx,%eax
  80012b:	8b 10                	mov    (%eax),%edx
  80012d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800130:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800133:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800136:	bb ff 00 00 00       	mov    $0xff,%ebx
  80013b:	99                   	cltd   
  80013c:	f7 fb                	idiv   %ebx
  80013e:	89 d0                	mov    %edx,%eax
  800140:	88 01                	mov    %al,(%ecx)

	for (int i = 0; i < N; ++i)
	{
		arr[i] = malloc(M + i) ;
		expectedNumOfAllocatedFrames += GetPowOf2(M + i);
		for (int j = 0; j < M; ++j)
  800142:	ff 45 ec             	incl   -0x14(%ebp)
  800145:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800148:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
  80014b:	7c cf                	jl     80011c <_main+0xe4>
	assert(M * sizeof(uint8) <= BUDDY_LIMIT);

	uint8 ** arr = malloc(N * sizeof(int)) ;
	int expectedNumOfAllocatedFrames = GetPowOf2(N * sizeof(int));

	for (int i = 0; i < N; ++i)
  80014d:	ff 45 f0             	incl   -0x10(%ebp)
  800150:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800153:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  800156:	0f 8c 7a ff ff ff    	jl     8000d6 <_main+0x9e>
		}
	}

	//[1] Check the lists content of the BuddyLevels array
	{
	int L = BUDDY_LOWER_LEVEL;
  80015c:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{cprintf("WRONG number of nodes at Level # %d - # of nodes = %d\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800163:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800166:	c1 e0 04             	shl    $0x4,%eax
  800169:	05 4c 30 80 00       	add    $0x80304c,%eax
  80016e:	8b 00                	mov    (%eax),%eax
  800170:	85 c0                	test   %eax,%eax
  800172:	74 21                	je     800195 <_main+0x15d>
  800174:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800177:	c1 e0 04             	shl    $0x4,%eax
  80017a:	05 4c 30 80 00       	add    $0x80304c,%eax
  80017f:	8b 00                	mov    (%eax),%eax
  800181:	83 ec 04             	sub    $0x4,%esp
  800184:	50                   	push   %eax
  800185:	ff 75 cc             	pushl  -0x34(%ebp)
  800188:	68 a0 22 80 00       	push   $0x8022a0
  80018d:	e8 4f 07 00 00       	call   8008e1 <cprintf>
  800192:	83 c4 10             	add    $0x10,%esp
  800195:	ff 45 cc             	incl   -0x34(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{cprintf("WRONG number of nodes at Level # %d - # of nodes = %d\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800198:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80019b:	c1 e0 04             	shl    $0x4,%eax
  80019e:	05 4c 30 80 00       	add    $0x80304c,%eax
  8001a3:	8b 00                	mov    (%eax),%eax
  8001a5:	83 f8 01             	cmp    $0x1,%eax
  8001a8:	74 21                	je     8001cb <_main+0x193>
  8001aa:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001ad:	c1 e0 04             	shl    $0x4,%eax
  8001b0:	05 4c 30 80 00       	add    $0x80304c,%eax
  8001b5:	8b 00                	mov    (%eax),%eax
  8001b7:	83 ec 04             	sub    $0x4,%esp
  8001ba:	50                   	push   %eax
  8001bb:	ff 75 cc             	pushl  -0x34(%ebp)
  8001be:	68 a0 22 80 00       	push   $0x8022a0
  8001c3:	e8 19 07 00 00       	call   8008e1 <cprintf>
  8001c8:	83 c4 10             	add    $0x10,%esp
  8001cb:	ff 45 cc             	incl   -0x34(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{cprintf("WRONG number of nodes at Level # %d - # of nodes = %d\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8001ce:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001d1:	c1 e0 04             	shl    $0x4,%eax
  8001d4:	05 4c 30 80 00       	add    $0x80304c,%eax
  8001d9:	8b 00                	mov    (%eax),%eax
  8001db:	85 c0                	test   %eax,%eax
  8001dd:	74 21                	je     800200 <_main+0x1c8>
  8001df:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8001e2:	c1 e0 04             	shl    $0x4,%eax
  8001e5:	05 4c 30 80 00       	add    $0x80304c,%eax
  8001ea:	8b 00                	mov    (%eax),%eax
  8001ec:	83 ec 04             	sub    $0x4,%esp
  8001ef:	50                   	push   %eax
  8001f0:	ff 75 cc             	pushl  -0x34(%ebp)
  8001f3:	68 a0 22 80 00       	push   $0x8022a0
  8001f8:	e8 e4 06 00 00       	call   8008e1 <cprintf>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	ff 45 cc             	incl   -0x34(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{cprintf("WRONG number of nodes at Level # %d - # of nodes = %d\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800203:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800206:	c1 e0 04             	shl    $0x4,%eax
  800209:	05 4c 30 80 00       	add    $0x80304c,%eax
  80020e:	8b 00                	mov    (%eax),%eax
  800210:	83 f8 01             	cmp    $0x1,%eax
  800213:	74 21                	je     800236 <_main+0x1fe>
  800215:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800218:	c1 e0 04             	shl    $0x4,%eax
  80021b:	05 4c 30 80 00       	add    $0x80304c,%eax
  800220:	8b 00                	mov    (%eax),%eax
  800222:	83 ec 04             	sub    $0x4,%esp
  800225:	50                   	push   %eax
  800226:	ff 75 cc             	pushl  -0x34(%ebp)
  800229:	68 a0 22 80 00       	push   $0x8022a0
  80022e:	e8 ae 06 00 00       	call   8008e1 <cprintf>
  800233:	83 c4 10             	add    $0x10,%esp
  800236:	ff 45 cc             	incl   -0x34(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{cprintf("WRONG number of nodes at Level # %d - # of nodes = %d\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800239:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80023c:	c1 e0 04             	shl    $0x4,%eax
  80023f:	05 4c 30 80 00       	add    $0x80304c,%eax
  800244:	8b 00                	mov    (%eax),%eax
  800246:	85 c0                	test   %eax,%eax
  800248:	74 21                	je     80026b <_main+0x233>
  80024a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80024d:	c1 e0 04             	shl    $0x4,%eax
  800250:	05 4c 30 80 00       	add    $0x80304c,%eax
  800255:	8b 00                	mov    (%eax),%eax
  800257:	83 ec 04             	sub    $0x4,%esp
  80025a:	50                   	push   %eax
  80025b:	ff 75 cc             	pushl  -0x34(%ebp)
  80025e:	68 a0 22 80 00       	push   $0x8022a0
  800263:	e8 79 06 00 00       	call   8008e1 <cprintf>
  800268:	83 c4 10             	add    $0x10,%esp
  80026b:	ff 45 cc             	incl   -0x34(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{cprintf("WRONG number of nodes at Level # %d - # of nodes = %d\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  80026e:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800271:	c1 e0 04             	shl    $0x4,%eax
  800274:	05 4c 30 80 00       	add    $0x80304c,%eax
  800279:	8b 00                	mov    (%eax),%eax
  80027b:	83 f8 01             	cmp    $0x1,%eax
  80027e:	74 21                	je     8002a1 <_main+0x269>
  800280:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800283:	c1 e0 04             	shl    $0x4,%eax
  800286:	05 4c 30 80 00       	add    $0x80304c,%eax
  80028b:	8b 00                	mov    (%eax),%eax
  80028d:	83 ec 04             	sub    $0x4,%esp
  800290:	50                   	push   %eax
  800291:	ff 75 cc             	pushl  -0x34(%ebp)
  800294:	68 a0 22 80 00       	push   $0x8022a0
  800299:	e8 43 06 00 00       	call   8008e1 <cprintf>
  80029e:	83 c4 10             	add    $0x10,%esp
  8002a1:	ff 45 cc             	incl   -0x34(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{cprintf("WRONG number of nodes at Level # %d - # of nodes = %d\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8002a4:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8002a7:	c1 e0 04             	shl    $0x4,%eax
  8002aa:	05 4c 30 80 00       	add    $0x80304c,%eax
  8002af:	8b 00                	mov    (%eax),%eax
  8002b1:	85 c0                	test   %eax,%eax
  8002b3:	74 21                	je     8002d6 <_main+0x29e>
  8002b5:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8002b8:	c1 e0 04             	shl    $0x4,%eax
  8002bb:	05 4c 30 80 00       	add    $0x80304c,%eax
  8002c0:	8b 00                	mov    (%eax),%eax
  8002c2:	83 ec 04             	sub    $0x4,%esp
  8002c5:	50                   	push   %eax
  8002c6:	ff 75 cc             	pushl  -0x34(%ebp)
  8002c9:	68 a0 22 80 00       	push   $0x8022a0
  8002ce:	e8 0e 06 00 00       	call   8008e1 <cprintf>
  8002d3:	83 c4 10             	add    $0x10,%esp
  8002d6:	ff 45 cc             	incl   -0x34(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{cprintf("WRONG number of nodes at Level # %d - # of nodes = %d\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  8002d9:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8002dc:	c1 e0 04             	shl    $0x4,%eax
  8002df:	05 4c 30 80 00       	add    $0x80304c,%eax
  8002e4:	8b 00                	mov    (%eax),%eax
  8002e6:	83 f8 01             	cmp    $0x1,%eax
  8002e9:	74 21                	je     80030c <_main+0x2d4>
  8002eb:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8002ee:	c1 e0 04             	shl    $0x4,%eax
  8002f1:	05 4c 30 80 00       	add    $0x80304c,%eax
  8002f6:	8b 00                	mov    (%eax),%eax
  8002f8:	83 ec 04             	sub    $0x4,%esp
  8002fb:	50                   	push   %eax
  8002fc:	ff 75 cc             	pushl  -0x34(%ebp)
  8002ff:	68 a0 22 80 00       	push   $0x8022a0
  800304:	e8 d8 05 00 00       	call   8008e1 <cprintf>
  800309:	83 c4 10             	add    $0x10,%esp
  80030c:	ff 45 cc             	incl   -0x34(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{cprintf("WRONG number of nodes at Level # %d - # of nodes = %d\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  80030f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800312:	c1 e0 04             	shl    $0x4,%eax
  800315:	05 4c 30 80 00       	add    $0x80304c,%eax
  80031a:	8b 00                	mov    (%eax),%eax
  80031c:	85 c0                	test   %eax,%eax
  80031e:	74 21                	je     800341 <_main+0x309>
  800320:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800323:	c1 e0 04             	shl    $0x4,%eax
  800326:	05 4c 30 80 00       	add    $0x80304c,%eax
  80032b:	8b 00                	mov    (%eax),%eax
  80032d:	83 ec 04             	sub    $0x4,%esp
  800330:	50                   	push   %eax
  800331:	ff 75 cc             	pushl  -0x34(%ebp)
  800334:	68 a0 22 80 00       	push   $0x8022a0
  800339:	e8 a3 05 00 00       	call   8008e1 <cprintf>
  80033e:	83 c4 10             	add    $0x10,%esp
  800341:	ff 45 cc             	incl   -0x34(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=1)	{cprintf("WRONG number of nodes at Level # %d - # of nodes = %d\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  800344:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800347:	c1 e0 04             	shl    $0x4,%eax
  80034a:	05 4c 30 80 00       	add    $0x80304c,%eax
  80034f:	8b 00                	mov    (%eax),%eax
  800351:	83 f8 01             	cmp    $0x1,%eax
  800354:	74 21                	je     800377 <_main+0x33f>
  800356:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800359:	c1 e0 04             	shl    $0x4,%eax
  80035c:	05 4c 30 80 00       	add    $0x80304c,%eax
  800361:	8b 00                	mov    (%eax),%eax
  800363:	83 ec 04             	sub    $0x4,%esp
  800366:	50                   	push   %eax
  800367:	ff 75 cc             	pushl  -0x34(%ebp)
  80036a:	68 a0 22 80 00       	push   $0x8022a0
  80036f:	e8 6d 05 00 00       	call   8008e1 <cprintf>
  800374:	83 c4 10             	add    $0x10,%esp
  800377:	ff 45 cc             	incl   -0x34(%ebp)
	if(LIST_SIZE(&BuddyLevels[L])!=0)	{cprintf("WRONG number of nodes at Level # %d - # of nodes = %d\n", L, LIST_SIZE(&BuddyLevels[L])); } L = L + 1;
  80037a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80037d:	c1 e0 04             	shl    $0x4,%eax
  800380:	05 4c 30 80 00       	add    $0x80304c,%eax
  800385:	8b 00                	mov    (%eax),%eax
  800387:	85 c0                	test   %eax,%eax
  800389:	74 21                	je     8003ac <_main+0x374>
  80038b:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80038e:	c1 e0 04             	shl    $0x4,%eax
  800391:	05 4c 30 80 00       	add    $0x80304c,%eax
  800396:	8b 00                	mov    (%eax),%eax
  800398:	83 ec 04             	sub    $0x4,%esp
  80039b:	50                   	push   %eax
  80039c:	ff 75 cc             	pushl  -0x34(%ebp)
  80039f:	68 a0 22 80 00       	push   $0x8022a0
  8003a4:	e8 38 05 00 00       	call   8008e1 <cprintf>
  8003a9:	83 c4 10             	add    $0x10,%esp
  8003ac:	ff 45 cc             	incl   -0x34(%ebp)
	}

	//[2] Check the frames taken after the allocation
	expectedNumOfAllocatedFrames = ROUNDUP(expectedNumOfAllocatedFrames, PAGE_SIZE) / PAGE_SIZE;
  8003af:	c7 45 c8 00 10 00 00 	movl   $0x1000,-0x38(%ebp)
  8003b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003b9:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8003bc:	01 d0                	add    %edx,%eax
  8003be:	48                   	dec    %eax
  8003bf:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  8003c2:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8003c5:	ba 00 00 00 00       	mov    $0x0,%edx
  8003ca:	f7 75 c8             	divl   -0x38(%ebp)
  8003cd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8003d0:	29 d0                	sub    %edx,%eax
  8003d2:	85 c0                	test   %eax,%eax
  8003d4:	79 05                	jns    8003db <_main+0x3a3>
  8003d6:	05 ff 0f 00 00       	add    $0xfff,%eax
  8003db:	c1 f8 0c             	sar    $0xc,%eax
  8003de:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int freeFrames2 = sys_calculate_free_frames() ;
  8003e1:	e8 d8 16 00 00       	call   801abe <sys_calculate_free_frames>
  8003e6:	89 45 c0             	mov    %eax,-0x40(%ebp)
	int usedDiskPages2 = sys_pf_calculate_allocated_pages() ;
  8003e9:	e8 53 17 00 00       	call   801b41 <sys_pf_calculate_allocated_pages>
  8003ee:	89 45 bc             	mov    %eax,-0x44(%ebp)
	assert(freeFrames1 - freeFrames2 == 1 + 1 + expectedNumOfAllocatedFrames); //2 for page table + 1 for disk table
  8003f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003f4:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8003f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003fa:	83 c2 02             	add    $0x2,%edx
  8003fd:	39 d0                	cmp    %edx,%eax
  8003ff:	74 16                	je     800417 <_main+0x3df>
  800401:	68 d8 22 80 00       	push   $0x8022d8
  800406:	68 3f 22 80 00       	push   $0x80223f
  80040b:	6a 32                	push   $0x32
  80040d:	68 54 22 80 00       	push   $0x802254
  800412:	e8 28 02 00 00       	call   80063f <_panic>
	assert(usedDiskPages2 - usedDiskPages1 == expectedNumOfAllocatedFrames);
  800417:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80041a:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80041d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800420:	74 16                	je     800438 <_main+0x400>
  800422:	68 1c 23 80 00       	push   $0x80231c
  800427:	68 3f 22 80 00       	push   $0x80223f
  80042c:	6a 33                	push   $0x33
  80042e:	68 54 22 80 00       	push   $0x802254
  800433:	e8 07 02 00 00       	call   80063f <_panic>

	//[3] Check the created arrays content
	for (int i = 0; i < N; ++i)
  800438:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80043f:	eb 59                	jmp    80049a <_main+0x462>
	{
		for (int j = 0; j < M; ++j)
  800441:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800448:	eb 45                	jmp    80048f <_main+0x457>
		{
			assert(arr[i][j] == i % 255);
  80044a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80044d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800454:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800457:	01 d0                	add    %edx,%eax
  800459:	8b 10                	mov    (%eax),%edx
  80045b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80045e:	01 d0                	add    %edx,%eax
  800460:	8a 00                	mov    (%eax),%al
  800462:	0f b6 c8             	movzbl %al,%ecx
  800465:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800468:	bb ff 00 00 00       	mov    $0xff,%ebx
  80046d:	99                   	cltd   
  80046e:	f7 fb                	idiv   %ebx
  800470:	89 d0                	mov    %edx,%eax
  800472:	39 c1                	cmp    %eax,%ecx
  800474:	74 16                	je     80048c <_main+0x454>
  800476:	68 5c 23 80 00       	push   $0x80235c
  80047b:	68 3f 22 80 00       	push   $0x80223f
  800480:	6a 3a                	push   $0x3a
  800482:	68 54 22 80 00       	push   $0x802254
  800487:	e8 b3 01 00 00       	call   80063f <_panic>
	assert(usedDiskPages2 - usedDiskPages1 == expectedNumOfAllocatedFrames);

	//[3] Check the created arrays content
	for (int i = 0; i < N; ++i)
	{
		for (int j = 0; j < M; ++j)
  80048c:	ff 45 e4             	incl   -0x1c(%ebp)
  80048f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800492:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
  800495:	7c b3                	jl     80044a <_main+0x412>
	int usedDiskPages2 = sys_pf_calculate_allocated_pages() ;
	assert(freeFrames1 - freeFrames2 == 1 + 1 + expectedNumOfAllocatedFrames); //2 for page table + 1 for disk table
	assert(usedDiskPages2 - usedDiskPages1 == expectedNumOfAllocatedFrames);

	//[3] Check the created arrays content
	for (int i = 0; i < N; ++i)
  800497:	ff 45 e8             	incl   -0x18(%ebp)
  80049a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80049d:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8004a0:	7c 9f                	jl     800441 <_main+0x409>
		{
			assert(arr[i][j] == i % 255);
		}
	}

	cprintf("Congratulations!! test BUDDY SYSTEM allocation (1) completed successfully. Evaluation = 100%\n");
  8004a2:	83 ec 0c             	sub    $0xc,%esp
  8004a5:	68 74 23 80 00       	push   $0x802374
  8004aa:	e8 32 04 00 00       	call   8008e1 <cprintf>
  8004af:	83 c4 10             	add    $0x10,%esp
}
  8004b2:	90                   	nop
  8004b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004b6:	c9                   	leave  
  8004b7:	c3                   	ret    

008004b8 <GetPowOf2>:

int GetPowOf2(int size)
{
  8004b8:	55                   	push   %ebp
  8004b9:	89 e5                	mov    %esp,%ebp
  8004bb:	83 ec 10             	sub    $0x10,%esp
	int i;
	for(i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; i++)
  8004be:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
  8004c5:	eb 26                	jmp    8004ed <GetPowOf2+0x35>
	{
		if(BUDDY_NODE_SIZE(i) >= size)
  8004c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ca:	ba 01 00 00 00       	mov    $0x1,%edx
  8004cf:	88 c1                	mov    %al,%cl
  8004d1:	d3 e2                	shl    %cl,%edx
  8004d3:	89 d0                	mov    %edx,%eax
  8004d5:	3b 45 08             	cmp    0x8(%ebp),%eax
  8004d8:	7c 10                	jl     8004ea <GetPowOf2+0x32>
			return 1<<i;
  8004da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004dd:	ba 01 00 00 00       	mov    $0x1,%edx
  8004e2:	88 c1                	mov    %al,%cl
  8004e4:	d3 e2                	shl    %cl,%edx
  8004e6:	89 d0                	mov    %edx,%eax
  8004e8:	eb 0e                	jmp    8004f8 <GetPowOf2+0x40>
}

int GetPowOf2(int size)
{
	int i;
	for(i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; i++)
  8004ea:	ff 45 fc             	incl   -0x4(%ebp)
  8004ed:	83 7d fc 0b          	cmpl   $0xb,-0x4(%ebp)
  8004f1:	7e d4                	jle    8004c7 <GetPowOf2+0xf>
	{
		if(BUDDY_NODE_SIZE(i) >= size)
			return 1<<i;
	}
	return 0;
  8004f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8004f8:	c9                   	leave  
  8004f9:	c3                   	ret    

008004fa <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8004fa:	55                   	push   %ebp
  8004fb:	89 e5                	mov    %esp,%ebp
  8004fd:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800500:	e8 ee 14 00 00       	call   8019f3 <sys_getenvindex>
  800505:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800508:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80050b:	89 d0                	mov    %edx,%eax
  80050d:	c1 e0 03             	shl    $0x3,%eax
  800510:	01 d0                	add    %edx,%eax
  800512:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800519:	01 c8                	add    %ecx,%eax
  80051b:	01 c0                	add    %eax,%eax
  80051d:	01 d0                	add    %edx,%eax
  80051f:	01 c0                	add    %eax,%eax
  800521:	01 d0                	add    %edx,%eax
  800523:	89 c2                	mov    %eax,%edx
  800525:	c1 e2 05             	shl    $0x5,%edx
  800528:	29 c2                	sub    %eax,%edx
  80052a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800531:	89 c2                	mov    %eax,%edx
  800533:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800539:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80053e:	a1 20 30 80 00       	mov    0x803020,%eax
  800543:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800549:	84 c0                	test   %al,%al
  80054b:	74 0f                	je     80055c <libmain+0x62>
		binaryname = myEnv->prog_name;
  80054d:	a1 20 30 80 00       	mov    0x803020,%eax
  800552:	05 40 3c 01 00       	add    $0x13c40,%eax
  800557:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80055c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800560:	7e 0a                	jle    80056c <libmain+0x72>
		binaryname = argv[0];
  800562:	8b 45 0c             	mov    0xc(%ebp),%eax
  800565:	8b 00                	mov    (%eax),%eax
  800567:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80056c:	83 ec 08             	sub    $0x8,%esp
  80056f:	ff 75 0c             	pushl  0xc(%ebp)
  800572:	ff 75 08             	pushl  0x8(%ebp)
  800575:	e8 be fa ff ff       	call   800038 <_main>
  80057a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80057d:	e8 0c 16 00 00       	call   801b8e <sys_disable_interrupt>
	cprintf("**************************************\n");
  800582:	83 ec 0c             	sub    $0xc,%esp
  800585:	68 ec 23 80 00       	push   $0x8023ec
  80058a:	e8 52 03 00 00       	call   8008e1 <cprintf>
  80058f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800592:	a1 20 30 80 00       	mov    0x803020,%eax
  800597:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80059d:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a2:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8005a8:	83 ec 04             	sub    $0x4,%esp
  8005ab:	52                   	push   %edx
  8005ac:	50                   	push   %eax
  8005ad:	68 14 24 80 00       	push   $0x802414
  8005b2:	e8 2a 03 00 00       	call   8008e1 <cprintf>
  8005b7:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8005ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8005bf:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8005c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ca:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8005d0:	83 ec 04             	sub    $0x4,%esp
  8005d3:	52                   	push   %edx
  8005d4:	50                   	push   %eax
  8005d5:	68 3c 24 80 00       	push   $0x80243c
  8005da:	e8 02 03 00 00       	call   8008e1 <cprintf>
  8005df:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8005e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e7:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8005ed:	83 ec 08             	sub    $0x8,%esp
  8005f0:	50                   	push   %eax
  8005f1:	68 7d 24 80 00       	push   $0x80247d
  8005f6:	e8 e6 02 00 00       	call   8008e1 <cprintf>
  8005fb:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8005fe:	83 ec 0c             	sub    $0xc,%esp
  800601:	68 ec 23 80 00       	push   $0x8023ec
  800606:	e8 d6 02 00 00       	call   8008e1 <cprintf>
  80060b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80060e:	e8 95 15 00 00       	call   801ba8 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800613:	e8 19 00 00 00       	call   800631 <exit>
}
  800618:	90                   	nop
  800619:	c9                   	leave  
  80061a:	c3                   	ret    

0080061b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80061b:	55                   	push   %ebp
  80061c:	89 e5                	mov    %esp,%ebp
  80061e:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800621:	83 ec 0c             	sub    $0xc,%esp
  800624:	6a 00                	push   $0x0
  800626:	e8 94 13 00 00       	call   8019bf <sys_env_destroy>
  80062b:	83 c4 10             	add    $0x10,%esp
}
  80062e:	90                   	nop
  80062f:	c9                   	leave  
  800630:	c3                   	ret    

00800631 <exit>:

void
exit(void)
{
  800631:	55                   	push   %ebp
  800632:	89 e5                	mov    %esp,%ebp
  800634:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800637:	e8 e9 13 00 00       	call   801a25 <sys_env_exit>
}
  80063c:	90                   	nop
  80063d:	c9                   	leave  
  80063e:	c3                   	ret    

0080063f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80063f:	55                   	push   %ebp
  800640:	89 e5                	mov    %esp,%ebp
  800642:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800645:	8d 45 10             	lea    0x10(%ebp),%eax
  800648:	83 c0 04             	add    $0x4,%eax
  80064b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80064e:	a1 18 31 80 00       	mov    0x803118,%eax
  800653:	85 c0                	test   %eax,%eax
  800655:	74 16                	je     80066d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800657:	a1 18 31 80 00       	mov    0x803118,%eax
  80065c:	83 ec 08             	sub    $0x8,%esp
  80065f:	50                   	push   %eax
  800660:	68 94 24 80 00       	push   $0x802494
  800665:	e8 77 02 00 00       	call   8008e1 <cprintf>
  80066a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80066d:	a1 00 30 80 00       	mov    0x803000,%eax
  800672:	ff 75 0c             	pushl  0xc(%ebp)
  800675:	ff 75 08             	pushl  0x8(%ebp)
  800678:	50                   	push   %eax
  800679:	68 99 24 80 00       	push   $0x802499
  80067e:	e8 5e 02 00 00       	call   8008e1 <cprintf>
  800683:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800686:	8b 45 10             	mov    0x10(%ebp),%eax
  800689:	83 ec 08             	sub    $0x8,%esp
  80068c:	ff 75 f4             	pushl  -0xc(%ebp)
  80068f:	50                   	push   %eax
  800690:	e8 e1 01 00 00       	call   800876 <vcprintf>
  800695:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800698:	83 ec 08             	sub    $0x8,%esp
  80069b:	6a 00                	push   $0x0
  80069d:	68 b5 24 80 00       	push   $0x8024b5
  8006a2:	e8 cf 01 00 00       	call   800876 <vcprintf>
  8006a7:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8006aa:	e8 82 ff ff ff       	call   800631 <exit>

	// should not return here
	while (1) ;
  8006af:	eb fe                	jmp    8006af <_panic+0x70>

008006b1 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8006b1:	55                   	push   %ebp
  8006b2:	89 e5                	mov    %esp,%ebp
  8006b4:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8006b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8006bc:	8b 50 74             	mov    0x74(%eax),%edx
  8006bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006c2:	39 c2                	cmp    %eax,%edx
  8006c4:	74 14                	je     8006da <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8006c6:	83 ec 04             	sub    $0x4,%esp
  8006c9:	68 b8 24 80 00       	push   $0x8024b8
  8006ce:	6a 26                	push   $0x26
  8006d0:	68 04 25 80 00       	push   $0x802504
  8006d5:	e8 65 ff ff ff       	call   80063f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8006da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8006e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8006e8:	e9 b6 00 00 00       	jmp    8007a3 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8006ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fa:	01 d0                	add    %edx,%eax
  8006fc:	8b 00                	mov    (%eax),%eax
  8006fe:	85 c0                	test   %eax,%eax
  800700:	75 08                	jne    80070a <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800702:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800705:	e9 96 00 00 00       	jmp    8007a0 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80070a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800711:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800718:	eb 5d                	jmp    800777 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80071a:	a1 20 30 80 00       	mov    0x803020,%eax
  80071f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800725:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800728:	c1 e2 04             	shl    $0x4,%edx
  80072b:	01 d0                	add    %edx,%eax
  80072d:	8a 40 04             	mov    0x4(%eax),%al
  800730:	84 c0                	test   %al,%al
  800732:	75 40                	jne    800774 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800734:	a1 20 30 80 00       	mov    0x803020,%eax
  800739:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80073f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800742:	c1 e2 04             	shl    $0x4,%edx
  800745:	01 d0                	add    %edx,%eax
  800747:	8b 00                	mov    (%eax),%eax
  800749:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80074c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80074f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800754:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800756:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800759:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800760:	8b 45 08             	mov    0x8(%ebp),%eax
  800763:	01 c8                	add    %ecx,%eax
  800765:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800767:	39 c2                	cmp    %eax,%edx
  800769:	75 09                	jne    800774 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80076b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800772:	eb 12                	jmp    800786 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800774:	ff 45 e8             	incl   -0x18(%ebp)
  800777:	a1 20 30 80 00       	mov    0x803020,%eax
  80077c:	8b 50 74             	mov    0x74(%eax),%edx
  80077f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800782:	39 c2                	cmp    %eax,%edx
  800784:	77 94                	ja     80071a <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800786:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80078a:	75 14                	jne    8007a0 <CheckWSWithoutLastIndex+0xef>
			panic(
  80078c:	83 ec 04             	sub    $0x4,%esp
  80078f:	68 10 25 80 00       	push   $0x802510
  800794:	6a 3a                	push   $0x3a
  800796:	68 04 25 80 00       	push   $0x802504
  80079b:	e8 9f fe ff ff       	call   80063f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8007a0:	ff 45 f0             	incl   -0x10(%ebp)
  8007a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8007a9:	0f 8c 3e ff ff ff    	jl     8006ed <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8007af:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007b6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8007bd:	eb 20                	jmp    8007df <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8007bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8007c4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007ca:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007cd:	c1 e2 04             	shl    $0x4,%edx
  8007d0:	01 d0                	add    %edx,%eax
  8007d2:	8a 40 04             	mov    0x4(%eax),%al
  8007d5:	3c 01                	cmp    $0x1,%al
  8007d7:	75 03                	jne    8007dc <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8007d9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007dc:	ff 45 e0             	incl   -0x20(%ebp)
  8007df:	a1 20 30 80 00       	mov    0x803020,%eax
  8007e4:	8b 50 74             	mov    0x74(%eax),%edx
  8007e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007ea:	39 c2                	cmp    %eax,%edx
  8007ec:	77 d1                	ja     8007bf <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8007ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8007f1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8007f4:	74 14                	je     80080a <CheckWSWithoutLastIndex+0x159>
		panic(
  8007f6:	83 ec 04             	sub    $0x4,%esp
  8007f9:	68 64 25 80 00       	push   $0x802564
  8007fe:	6a 44                	push   $0x44
  800800:	68 04 25 80 00       	push   $0x802504
  800805:	e8 35 fe ff ff       	call   80063f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80080a:	90                   	nop
  80080b:	c9                   	leave  
  80080c:	c3                   	ret    

0080080d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80080d:	55                   	push   %ebp
  80080e:	89 e5                	mov    %esp,%ebp
  800810:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800813:	8b 45 0c             	mov    0xc(%ebp),%eax
  800816:	8b 00                	mov    (%eax),%eax
  800818:	8d 48 01             	lea    0x1(%eax),%ecx
  80081b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80081e:	89 0a                	mov    %ecx,(%edx)
  800820:	8b 55 08             	mov    0x8(%ebp),%edx
  800823:	88 d1                	mov    %dl,%cl
  800825:	8b 55 0c             	mov    0xc(%ebp),%edx
  800828:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80082c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082f:	8b 00                	mov    (%eax),%eax
  800831:	3d ff 00 00 00       	cmp    $0xff,%eax
  800836:	75 2c                	jne    800864 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800838:	a0 24 30 80 00       	mov    0x803024,%al
  80083d:	0f b6 c0             	movzbl %al,%eax
  800840:	8b 55 0c             	mov    0xc(%ebp),%edx
  800843:	8b 12                	mov    (%edx),%edx
  800845:	89 d1                	mov    %edx,%ecx
  800847:	8b 55 0c             	mov    0xc(%ebp),%edx
  80084a:	83 c2 08             	add    $0x8,%edx
  80084d:	83 ec 04             	sub    $0x4,%esp
  800850:	50                   	push   %eax
  800851:	51                   	push   %ecx
  800852:	52                   	push   %edx
  800853:	e8 25 11 00 00       	call   80197d <sys_cputs>
  800858:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80085b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800864:	8b 45 0c             	mov    0xc(%ebp),%eax
  800867:	8b 40 04             	mov    0x4(%eax),%eax
  80086a:	8d 50 01             	lea    0x1(%eax),%edx
  80086d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800870:	89 50 04             	mov    %edx,0x4(%eax)
}
  800873:	90                   	nop
  800874:	c9                   	leave  
  800875:	c3                   	ret    

00800876 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800876:	55                   	push   %ebp
  800877:	89 e5                	mov    %esp,%ebp
  800879:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80087f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800886:	00 00 00 
	b.cnt = 0;
  800889:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800890:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800893:	ff 75 0c             	pushl  0xc(%ebp)
  800896:	ff 75 08             	pushl  0x8(%ebp)
  800899:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80089f:	50                   	push   %eax
  8008a0:	68 0d 08 80 00       	push   $0x80080d
  8008a5:	e8 11 02 00 00       	call   800abb <vprintfmt>
  8008aa:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8008ad:	a0 24 30 80 00       	mov    0x803024,%al
  8008b2:	0f b6 c0             	movzbl %al,%eax
  8008b5:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8008bb:	83 ec 04             	sub    $0x4,%esp
  8008be:	50                   	push   %eax
  8008bf:	52                   	push   %edx
  8008c0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8008c6:	83 c0 08             	add    $0x8,%eax
  8008c9:	50                   	push   %eax
  8008ca:	e8 ae 10 00 00       	call   80197d <sys_cputs>
  8008cf:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8008d2:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8008d9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8008df:	c9                   	leave  
  8008e0:	c3                   	ret    

008008e1 <cprintf>:

int cprintf(const char *fmt, ...) {
  8008e1:	55                   	push   %ebp
  8008e2:	89 e5                	mov    %esp,%ebp
  8008e4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8008e7:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8008ee:	8d 45 0c             	lea    0xc(%ebp),%eax
  8008f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8008f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f7:	83 ec 08             	sub    $0x8,%esp
  8008fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8008fd:	50                   	push   %eax
  8008fe:	e8 73 ff ff ff       	call   800876 <vcprintf>
  800903:	83 c4 10             	add    $0x10,%esp
  800906:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800909:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80090c:	c9                   	leave  
  80090d:	c3                   	ret    

0080090e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80090e:	55                   	push   %ebp
  80090f:	89 e5                	mov    %esp,%ebp
  800911:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800914:	e8 75 12 00 00       	call   801b8e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800919:	8d 45 0c             	lea    0xc(%ebp),%eax
  80091c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80091f:	8b 45 08             	mov    0x8(%ebp),%eax
  800922:	83 ec 08             	sub    $0x8,%esp
  800925:	ff 75 f4             	pushl  -0xc(%ebp)
  800928:	50                   	push   %eax
  800929:	e8 48 ff ff ff       	call   800876 <vcprintf>
  80092e:	83 c4 10             	add    $0x10,%esp
  800931:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800934:	e8 6f 12 00 00       	call   801ba8 <sys_enable_interrupt>
	return cnt;
  800939:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80093c:	c9                   	leave  
  80093d:	c3                   	ret    

0080093e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80093e:	55                   	push   %ebp
  80093f:	89 e5                	mov    %esp,%ebp
  800941:	53                   	push   %ebx
  800942:	83 ec 14             	sub    $0x14,%esp
  800945:	8b 45 10             	mov    0x10(%ebp),%eax
  800948:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80094b:	8b 45 14             	mov    0x14(%ebp),%eax
  80094e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800951:	8b 45 18             	mov    0x18(%ebp),%eax
  800954:	ba 00 00 00 00       	mov    $0x0,%edx
  800959:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80095c:	77 55                	ja     8009b3 <printnum+0x75>
  80095e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800961:	72 05                	jb     800968 <printnum+0x2a>
  800963:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800966:	77 4b                	ja     8009b3 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800968:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80096b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80096e:	8b 45 18             	mov    0x18(%ebp),%eax
  800971:	ba 00 00 00 00       	mov    $0x0,%edx
  800976:	52                   	push   %edx
  800977:	50                   	push   %eax
  800978:	ff 75 f4             	pushl  -0xc(%ebp)
  80097b:	ff 75 f0             	pushl  -0x10(%ebp)
  80097e:	e8 2d 16 00 00       	call   801fb0 <__udivdi3>
  800983:	83 c4 10             	add    $0x10,%esp
  800986:	83 ec 04             	sub    $0x4,%esp
  800989:	ff 75 20             	pushl  0x20(%ebp)
  80098c:	53                   	push   %ebx
  80098d:	ff 75 18             	pushl  0x18(%ebp)
  800990:	52                   	push   %edx
  800991:	50                   	push   %eax
  800992:	ff 75 0c             	pushl  0xc(%ebp)
  800995:	ff 75 08             	pushl  0x8(%ebp)
  800998:	e8 a1 ff ff ff       	call   80093e <printnum>
  80099d:	83 c4 20             	add    $0x20,%esp
  8009a0:	eb 1a                	jmp    8009bc <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8009a2:	83 ec 08             	sub    $0x8,%esp
  8009a5:	ff 75 0c             	pushl  0xc(%ebp)
  8009a8:	ff 75 20             	pushl  0x20(%ebp)
  8009ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ae:	ff d0                	call   *%eax
  8009b0:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8009b3:	ff 4d 1c             	decl   0x1c(%ebp)
  8009b6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8009ba:	7f e6                	jg     8009a2 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8009bc:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8009bf:	bb 00 00 00 00       	mov    $0x0,%ebx
  8009c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009ca:	53                   	push   %ebx
  8009cb:	51                   	push   %ecx
  8009cc:	52                   	push   %edx
  8009cd:	50                   	push   %eax
  8009ce:	e8 ed 16 00 00       	call   8020c0 <__umoddi3>
  8009d3:	83 c4 10             	add    $0x10,%esp
  8009d6:	05 d4 27 80 00       	add    $0x8027d4,%eax
  8009db:	8a 00                	mov    (%eax),%al
  8009dd:	0f be c0             	movsbl %al,%eax
  8009e0:	83 ec 08             	sub    $0x8,%esp
  8009e3:	ff 75 0c             	pushl  0xc(%ebp)
  8009e6:	50                   	push   %eax
  8009e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ea:	ff d0                	call   *%eax
  8009ec:	83 c4 10             	add    $0x10,%esp
}
  8009ef:	90                   	nop
  8009f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8009f3:	c9                   	leave  
  8009f4:	c3                   	ret    

008009f5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8009f5:	55                   	push   %ebp
  8009f6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8009f8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8009fc:	7e 1c                	jle    800a1a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8009fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800a01:	8b 00                	mov    (%eax),%eax
  800a03:	8d 50 08             	lea    0x8(%eax),%edx
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	89 10                	mov    %edx,(%eax)
  800a0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0e:	8b 00                	mov    (%eax),%eax
  800a10:	83 e8 08             	sub    $0x8,%eax
  800a13:	8b 50 04             	mov    0x4(%eax),%edx
  800a16:	8b 00                	mov    (%eax),%eax
  800a18:	eb 40                	jmp    800a5a <getuint+0x65>
	else if (lflag)
  800a1a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a1e:	74 1e                	je     800a3e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800a20:	8b 45 08             	mov    0x8(%ebp),%eax
  800a23:	8b 00                	mov    (%eax),%eax
  800a25:	8d 50 04             	lea    0x4(%eax),%edx
  800a28:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2b:	89 10                	mov    %edx,(%eax)
  800a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a30:	8b 00                	mov    (%eax),%eax
  800a32:	83 e8 04             	sub    $0x4,%eax
  800a35:	8b 00                	mov    (%eax),%eax
  800a37:	ba 00 00 00 00       	mov    $0x0,%edx
  800a3c:	eb 1c                	jmp    800a5a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a41:	8b 00                	mov    (%eax),%eax
  800a43:	8d 50 04             	lea    0x4(%eax),%edx
  800a46:	8b 45 08             	mov    0x8(%ebp),%eax
  800a49:	89 10                	mov    %edx,(%eax)
  800a4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4e:	8b 00                	mov    (%eax),%eax
  800a50:	83 e8 04             	sub    $0x4,%eax
  800a53:	8b 00                	mov    (%eax),%eax
  800a55:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800a5a:	5d                   	pop    %ebp
  800a5b:	c3                   	ret    

00800a5c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800a5c:	55                   	push   %ebp
  800a5d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a5f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a63:	7e 1c                	jle    800a81 <getint+0x25>
		return va_arg(*ap, long long);
  800a65:	8b 45 08             	mov    0x8(%ebp),%eax
  800a68:	8b 00                	mov    (%eax),%eax
  800a6a:	8d 50 08             	lea    0x8(%eax),%edx
  800a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a70:	89 10                	mov    %edx,(%eax)
  800a72:	8b 45 08             	mov    0x8(%ebp),%eax
  800a75:	8b 00                	mov    (%eax),%eax
  800a77:	83 e8 08             	sub    $0x8,%eax
  800a7a:	8b 50 04             	mov    0x4(%eax),%edx
  800a7d:	8b 00                	mov    (%eax),%eax
  800a7f:	eb 38                	jmp    800ab9 <getint+0x5d>
	else if (lflag)
  800a81:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a85:	74 1a                	je     800aa1 <getint+0x45>
		return va_arg(*ap, long);
  800a87:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8a:	8b 00                	mov    (%eax),%eax
  800a8c:	8d 50 04             	lea    0x4(%eax),%edx
  800a8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a92:	89 10                	mov    %edx,(%eax)
  800a94:	8b 45 08             	mov    0x8(%ebp),%eax
  800a97:	8b 00                	mov    (%eax),%eax
  800a99:	83 e8 04             	sub    $0x4,%eax
  800a9c:	8b 00                	mov    (%eax),%eax
  800a9e:	99                   	cltd   
  800a9f:	eb 18                	jmp    800ab9 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa4:	8b 00                	mov    (%eax),%eax
  800aa6:	8d 50 04             	lea    0x4(%eax),%edx
  800aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aac:	89 10                	mov    %edx,(%eax)
  800aae:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab1:	8b 00                	mov    (%eax),%eax
  800ab3:	83 e8 04             	sub    $0x4,%eax
  800ab6:	8b 00                	mov    (%eax),%eax
  800ab8:	99                   	cltd   
}
  800ab9:	5d                   	pop    %ebp
  800aba:	c3                   	ret    

00800abb <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800abb:	55                   	push   %ebp
  800abc:	89 e5                	mov    %esp,%ebp
  800abe:	56                   	push   %esi
  800abf:	53                   	push   %ebx
  800ac0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ac3:	eb 17                	jmp    800adc <vprintfmt+0x21>
			if (ch == '\0')
  800ac5:	85 db                	test   %ebx,%ebx
  800ac7:	0f 84 af 03 00 00    	je     800e7c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800acd:	83 ec 08             	sub    $0x8,%esp
  800ad0:	ff 75 0c             	pushl  0xc(%ebp)
  800ad3:	53                   	push   %ebx
  800ad4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad7:	ff d0                	call   *%eax
  800ad9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800adc:	8b 45 10             	mov    0x10(%ebp),%eax
  800adf:	8d 50 01             	lea    0x1(%eax),%edx
  800ae2:	89 55 10             	mov    %edx,0x10(%ebp)
  800ae5:	8a 00                	mov    (%eax),%al
  800ae7:	0f b6 d8             	movzbl %al,%ebx
  800aea:	83 fb 25             	cmp    $0x25,%ebx
  800aed:	75 d6                	jne    800ac5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800aef:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800af3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800afa:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b01:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b08:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800b0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b12:	8d 50 01             	lea    0x1(%eax),%edx
  800b15:	89 55 10             	mov    %edx,0x10(%ebp)
  800b18:	8a 00                	mov    (%eax),%al
  800b1a:	0f b6 d8             	movzbl %al,%ebx
  800b1d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800b20:	83 f8 55             	cmp    $0x55,%eax
  800b23:	0f 87 2b 03 00 00    	ja     800e54 <vprintfmt+0x399>
  800b29:	8b 04 85 f8 27 80 00 	mov    0x8027f8(,%eax,4),%eax
  800b30:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800b32:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800b36:	eb d7                	jmp    800b0f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800b38:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800b3c:	eb d1                	jmp    800b0f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800b3e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800b45:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b48:	89 d0                	mov    %edx,%eax
  800b4a:	c1 e0 02             	shl    $0x2,%eax
  800b4d:	01 d0                	add    %edx,%eax
  800b4f:	01 c0                	add    %eax,%eax
  800b51:	01 d8                	add    %ebx,%eax
  800b53:	83 e8 30             	sub    $0x30,%eax
  800b56:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800b59:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5c:	8a 00                	mov    (%eax),%al
  800b5e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800b61:	83 fb 2f             	cmp    $0x2f,%ebx
  800b64:	7e 3e                	jle    800ba4 <vprintfmt+0xe9>
  800b66:	83 fb 39             	cmp    $0x39,%ebx
  800b69:	7f 39                	jg     800ba4 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800b6b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800b6e:	eb d5                	jmp    800b45 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800b70:	8b 45 14             	mov    0x14(%ebp),%eax
  800b73:	83 c0 04             	add    $0x4,%eax
  800b76:	89 45 14             	mov    %eax,0x14(%ebp)
  800b79:	8b 45 14             	mov    0x14(%ebp),%eax
  800b7c:	83 e8 04             	sub    $0x4,%eax
  800b7f:	8b 00                	mov    (%eax),%eax
  800b81:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800b84:	eb 1f                	jmp    800ba5 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800b86:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b8a:	79 83                	jns    800b0f <vprintfmt+0x54>
				width = 0;
  800b8c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800b93:	e9 77 ff ff ff       	jmp    800b0f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800b98:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800b9f:	e9 6b ff ff ff       	jmp    800b0f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ba4:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ba5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ba9:	0f 89 60 ff ff ff    	jns    800b0f <vprintfmt+0x54>
				width = precision, precision = -1;
  800baf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bb2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800bb5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800bbc:	e9 4e ff ff ff       	jmp    800b0f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800bc1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800bc4:	e9 46 ff ff ff       	jmp    800b0f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800bc9:	8b 45 14             	mov    0x14(%ebp),%eax
  800bcc:	83 c0 04             	add    $0x4,%eax
  800bcf:	89 45 14             	mov    %eax,0x14(%ebp)
  800bd2:	8b 45 14             	mov    0x14(%ebp),%eax
  800bd5:	83 e8 04             	sub    $0x4,%eax
  800bd8:	8b 00                	mov    (%eax),%eax
  800bda:	83 ec 08             	sub    $0x8,%esp
  800bdd:	ff 75 0c             	pushl  0xc(%ebp)
  800be0:	50                   	push   %eax
  800be1:	8b 45 08             	mov    0x8(%ebp),%eax
  800be4:	ff d0                	call   *%eax
  800be6:	83 c4 10             	add    $0x10,%esp
			break;
  800be9:	e9 89 02 00 00       	jmp    800e77 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800bee:	8b 45 14             	mov    0x14(%ebp),%eax
  800bf1:	83 c0 04             	add    $0x4,%eax
  800bf4:	89 45 14             	mov    %eax,0x14(%ebp)
  800bf7:	8b 45 14             	mov    0x14(%ebp),%eax
  800bfa:	83 e8 04             	sub    $0x4,%eax
  800bfd:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800bff:	85 db                	test   %ebx,%ebx
  800c01:	79 02                	jns    800c05 <vprintfmt+0x14a>
				err = -err;
  800c03:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c05:	83 fb 64             	cmp    $0x64,%ebx
  800c08:	7f 0b                	jg     800c15 <vprintfmt+0x15a>
  800c0a:	8b 34 9d 40 26 80 00 	mov    0x802640(,%ebx,4),%esi
  800c11:	85 f6                	test   %esi,%esi
  800c13:	75 19                	jne    800c2e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800c15:	53                   	push   %ebx
  800c16:	68 e5 27 80 00       	push   $0x8027e5
  800c1b:	ff 75 0c             	pushl  0xc(%ebp)
  800c1e:	ff 75 08             	pushl  0x8(%ebp)
  800c21:	e8 5e 02 00 00       	call   800e84 <printfmt>
  800c26:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800c29:	e9 49 02 00 00       	jmp    800e77 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800c2e:	56                   	push   %esi
  800c2f:	68 ee 27 80 00       	push   $0x8027ee
  800c34:	ff 75 0c             	pushl  0xc(%ebp)
  800c37:	ff 75 08             	pushl  0x8(%ebp)
  800c3a:	e8 45 02 00 00       	call   800e84 <printfmt>
  800c3f:	83 c4 10             	add    $0x10,%esp
			break;
  800c42:	e9 30 02 00 00       	jmp    800e77 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800c47:	8b 45 14             	mov    0x14(%ebp),%eax
  800c4a:	83 c0 04             	add    $0x4,%eax
  800c4d:	89 45 14             	mov    %eax,0x14(%ebp)
  800c50:	8b 45 14             	mov    0x14(%ebp),%eax
  800c53:	83 e8 04             	sub    $0x4,%eax
  800c56:	8b 30                	mov    (%eax),%esi
  800c58:	85 f6                	test   %esi,%esi
  800c5a:	75 05                	jne    800c61 <vprintfmt+0x1a6>
				p = "(null)";
  800c5c:	be f1 27 80 00       	mov    $0x8027f1,%esi
			if (width > 0 && padc != '-')
  800c61:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c65:	7e 6d                	jle    800cd4 <vprintfmt+0x219>
  800c67:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800c6b:	74 67                	je     800cd4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800c6d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c70:	83 ec 08             	sub    $0x8,%esp
  800c73:	50                   	push   %eax
  800c74:	56                   	push   %esi
  800c75:	e8 0c 03 00 00       	call   800f86 <strnlen>
  800c7a:	83 c4 10             	add    $0x10,%esp
  800c7d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800c80:	eb 16                	jmp    800c98 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800c82:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800c86:	83 ec 08             	sub    $0x8,%esp
  800c89:	ff 75 0c             	pushl  0xc(%ebp)
  800c8c:	50                   	push   %eax
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	ff d0                	call   *%eax
  800c92:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800c95:	ff 4d e4             	decl   -0x1c(%ebp)
  800c98:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c9c:	7f e4                	jg     800c82 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c9e:	eb 34                	jmp    800cd4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ca0:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ca4:	74 1c                	je     800cc2 <vprintfmt+0x207>
  800ca6:	83 fb 1f             	cmp    $0x1f,%ebx
  800ca9:	7e 05                	jle    800cb0 <vprintfmt+0x1f5>
  800cab:	83 fb 7e             	cmp    $0x7e,%ebx
  800cae:	7e 12                	jle    800cc2 <vprintfmt+0x207>
					putch('?', putdat);
  800cb0:	83 ec 08             	sub    $0x8,%esp
  800cb3:	ff 75 0c             	pushl  0xc(%ebp)
  800cb6:	6a 3f                	push   $0x3f
  800cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbb:	ff d0                	call   *%eax
  800cbd:	83 c4 10             	add    $0x10,%esp
  800cc0:	eb 0f                	jmp    800cd1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800cc2:	83 ec 08             	sub    $0x8,%esp
  800cc5:	ff 75 0c             	pushl  0xc(%ebp)
  800cc8:	53                   	push   %ebx
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	ff d0                	call   *%eax
  800cce:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800cd1:	ff 4d e4             	decl   -0x1c(%ebp)
  800cd4:	89 f0                	mov    %esi,%eax
  800cd6:	8d 70 01             	lea    0x1(%eax),%esi
  800cd9:	8a 00                	mov    (%eax),%al
  800cdb:	0f be d8             	movsbl %al,%ebx
  800cde:	85 db                	test   %ebx,%ebx
  800ce0:	74 24                	je     800d06 <vprintfmt+0x24b>
  800ce2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ce6:	78 b8                	js     800ca0 <vprintfmt+0x1e5>
  800ce8:	ff 4d e0             	decl   -0x20(%ebp)
  800ceb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800cef:	79 af                	jns    800ca0 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800cf1:	eb 13                	jmp    800d06 <vprintfmt+0x24b>
				putch(' ', putdat);
  800cf3:	83 ec 08             	sub    $0x8,%esp
  800cf6:	ff 75 0c             	pushl  0xc(%ebp)
  800cf9:	6a 20                	push   $0x20
  800cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfe:	ff d0                	call   *%eax
  800d00:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d03:	ff 4d e4             	decl   -0x1c(%ebp)
  800d06:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d0a:	7f e7                	jg     800cf3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d0c:	e9 66 01 00 00       	jmp    800e77 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800d11:	83 ec 08             	sub    $0x8,%esp
  800d14:	ff 75 e8             	pushl  -0x18(%ebp)
  800d17:	8d 45 14             	lea    0x14(%ebp),%eax
  800d1a:	50                   	push   %eax
  800d1b:	e8 3c fd ff ff       	call   800a5c <getint>
  800d20:	83 c4 10             	add    $0x10,%esp
  800d23:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d26:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800d29:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d2c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d2f:	85 d2                	test   %edx,%edx
  800d31:	79 23                	jns    800d56 <vprintfmt+0x29b>
				putch('-', putdat);
  800d33:	83 ec 08             	sub    $0x8,%esp
  800d36:	ff 75 0c             	pushl  0xc(%ebp)
  800d39:	6a 2d                	push   $0x2d
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	ff d0                	call   *%eax
  800d40:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800d43:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d46:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d49:	f7 d8                	neg    %eax
  800d4b:	83 d2 00             	adc    $0x0,%edx
  800d4e:	f7 da                	neg    %edx
  800d50:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d53:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800d56:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800d5d:	e9 bc 00 00 00       	jmp    800e1e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800d62:	83 ec 08             	sub    $0x8,%esp
  800d65:	ff 75 e8             	pushl  -0x18(%ebp)
  800d68:	8d 45 14             	lea    0x14(%ebp),%eax
  800d6b:	50                   	push   %eax
  800d6c:	e8 84 fc ff ff       	call   8009f5 <getuint>
  800d71:	83 c4 10             	add    $0x10,%esp
  800d74:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d77:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800d7a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800d81:	e9 98 00 00 00       	jmp    800e1e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800d86:	83 ec 08             	sub    $0x8,%esp
  800d89:	ff 75 0c             	pushl  0xc(%ebp)
  800d8c:	6a 58                	push   $0x58
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d91:	ff d0                	call   *%eax
  800d93:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d96:	83 ec 08             	sub    $0x8,%esp
  800d99:	ff 75 0c             	pushl  0xc(%ebp)
  800d9c:	6a 58                	push   $0x58
  800d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800da1:	ff d0                	call   *%eax
  800da3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800da6:	83 ec 08             	sub    $0x8,%esp
  800da9:	ff 75 0c             	pushl  0xc(%ebp)
  800dac:	6a 58                	push   $0x58
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
  800db1:	ff d0                	call   *%eax
  800db3:	83 c4 10             	add    $0x10,%esp
			break;
  800db6:	e9 bc 00 00 00       	jmp    800e77 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800dbb:	83 ec 08             	sub    $0x8,%esp
  800dbe:	ff 75 0c             	pushl  0xc(%ebp)
  800dc1:	6a 30                	push   $0x30
  800dc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc6:	ff d0                	call   *%eax
  800dc8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800dcb:	83 ec 08             	sub    $0x8,%esp
  800dce:	ff 75 0c             	pushl  0xc(%ebp)
  800dd1:	6a 78                	push   $0x78
  800dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd6:	ff d0                	call   *%eax
  800dd8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ddb:	8b 45 14             	mov    0x14(%ebp),%eax
  800dde:	83 c0 04             	add    $0x4,%eax
  800de1:	89 45 14             	mov    %eax,0x14(%ebp)
  800de4:	8b 45 14             	mov    0x14(%ebp),%eax
  800de7:	83 e8 04             	sub    $0x4,%eax
  800dea:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800dec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800def:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800df6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800dfd:	eb 1f                	jmp    800e1e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800dff:	83 ec 08             	sub    $0x8,%esp
  800e02:	ff 75 e8             	pushl  -0x18(%ebp)
  800e05:	8d 45 14             	lea    0x14(%ebp),%eax
  800e08:	50                   	push   %eax
  800e09:	e8 e7 fb ff ff       	call   8009f5 <getuint>
  800e0e:	83 c4 10             	add    $0x10,%esp
  800e11:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e14:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800e17:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800e1e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800e22:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e25:	83 ec 04             	sub    $0x4,%esp
  800e28:	52                   	push   %edx
  800e29:	ff 75 e4             	pushl  -0x1c(%ebp)
  800e2c:	50                   	push   %eax
  800e2d:	ff 75 f4             	pushl  -0xc(%ebp)
  800e30:	ff 75 f0             	pushl  -0x10(%ebp)
  800e33:	ff 75 0c             	pushl  0xc(%ebp)
  800e36:	ff 75 08             	pushl  0x8(%ebp)
  800e39:	e8 00 fb ff ff       	call   80093e <printnum>
  800e3e:	83 c4 20             	add    $0x20,%esp
			break;
  800e41:	eb 34                	jmp    800e77 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800e43:	83 ec 08             	sub    $0x8,%esp
  800e46:	ff 75 0c             	pushl  0xc(%ebp)
  800e49:	53                   	push   %ebx
  800e4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4d:	ff d0                	call   *%eax
  800e4f:	83 c4 10             	add    $0x10,%esp
			break;
  800e52:	eb 23                	jmp    800e77 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800e54:	83 ec 08             	sub    $0x8,%esp
  800e57:	ff 75 0c             	pushl  0xc(%ebp)
  800e5a:	6a 25                	push   $0x25
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	ff d0                	call   *%eax
  800e61:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800e64:	ff 4d 10             	decl   0x10(%ebp)
  800e67:	eb 03                	jmp    800e6c <vprintfmt+0x3b1>
  800e69:	ff 4d 10             	decl   0x10(%ebp)
  800e6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6f:	48                   	dec    %eax
  800e70:	8a 00                	mov    (%eax),%al
  800e72:	3c 25                	cmp    $0x25,%al
  800e74:	75 f3                	jne    800e69 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800e76:	90                   	nop
		}
	}
  800e77:	e9 47 fc ff ff       	jmp    800ac3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800e7c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800e7d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800e80:	5b                   	pop    %ebx
  800e81:	5e                   	pop    %esi
  800e82:	5d                   	pop    %ebp
  800e83:	c3                   	ret    

00800e84 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800e84:	55                   	push   %ebp
  800e85:	89 e5                	mov    %esp,%ebp
  800e87:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800e8a:	8d 45 10             	lea    0x10(%ebp),%eax
  800e8d:	83 c0 04             	add    $0x4,%eax
  800e90:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800e93:	8b 45 10             	mov    0x10(%ebp),%eax
  800e96:	ff 75 f4             	pushl  -0xc(%ebp)
  800e99:	50                   	push   %eax
  800e9a:	ff 75 0c             	pushl  0xc(%ebp)
  800e9d:	ff 75 08             	pushl  0x8(%ebp)
  800ea0:	e8 16 fc ff ff       	call   800abb <vprintfmt>
  800ea5:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ea8:	90                   	nop
  800ea9:	c9                   	leave  
  800eaa:	c3                   	ret    

00800eab <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800eab:	55                   	push   %ebp
  800eac:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800eae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb1:	8b 40 08             	mov    0x8(%eax),%eax
  800eb4:	8d 50 01             	lea    0x1(%eax),%edx
  800eb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eba:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec0:	8b 10                	mov    (%eax),%edx
  800ec2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec5:	8b 40 04             	mov    0x4(%eax),%eax
  800ec8:	39 c2                	cmp    %eax,%edx
  800eca:	73 12                	jae    800ede <sprintputch+0x33>
		*b->buf++ = ch;
  800ecc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecf:	8b 00                	mov    (%eax),%eax
  800ed1:	8d 48 01             	lea    0x1(%eax),%ecx
  800ed4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ed7:	89 0a                	mov    %ecx,(%edx)
  800ed9:	8b 55 08             	mov    0x8(%ebp),%edx
  800edc:	88 10                	mov    %dl,(%eax)
}
  800ede:	90                   	nop
  800edf:	5d                   	pop    %ebp
  800ee0:	c3                   	ret    

00800ee1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ee1:	55                   	push   %ebp
  800ee2:	89 e5                	mov    %esp,%ebp
  800ee4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eea:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800eed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef6:	01 d0                	add    %edx,%eax
  800ef8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800efb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f02:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f06:	74 06                	je     800f0e <vsnprintf+0x2d>
  800f08:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f0c:	7f 07                	jg     800f15 <vsnprintf+0x34>
		return -E_INVAL;
  800f0e:	b8 03 00 00 00       	mov    $0x3,%eax
  800f13:	eb 20                	jmp    800f35 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800f15:	ff 75 14             	pushl  0x14(%ebp)
  800f18:	ff 75 10             	pushl  0x10(%ebp)
  800f1b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800f1e:	50                   	push   %eax
  800f1f:	68 ab 0e 80 00       	push   $0x800eab
  800f24:	e8 92 fb ff ff       	call   800abb <vprintfmt>
  800f29:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800f2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f2f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800f32:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800f35:	c9                   	leave  
  800f36:	c3                   	ret    

00800f37 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800f37:	55                   	push   %ebp
  800f38:	89 e5                	mov    %esp,%ebp
  800f3a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800f3d:	8d 45 10             	lea    0x10(%ebp),%eax
  800f40:	83 c0 04             	add    $0x4,%eax
  800f43:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800f46:	8b 45 10             	mov    0x10(%ebp),%eax
  800f49:	ff 75 f4             	pushl  -0xc(%ebp)
  800f4c:	50                   	push   %eax
  800f4d:	ff 75 0c             	pushl  0xc(%ebp)
  800f50:	ff 75 08             	pushl  0x8(%ebp)
  800f53:	e8 89 ff ff ff       	call   800ee1 <vsnprintf>
  800f58:	83 c4 10             	add    $0x10,%esp
  800f5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800f5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f61:	c9                   	leave  
  800f62:	c3                   	ret    

00800f63 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800f63:	55                   	push   %ebp
  800f64:	89 e5                	mov    %esp,%ebp
  800f66:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800f69:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f70:	eb 06                	jmp    800f78 <strlen+0x15>
		n++;
  800f72:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800f75:	ff 45 08             	incl   0x8(%ebp)
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	8a 00                	mov    (%eax),%al
  800f7d:	84 c0                	test   %al,%al
  800f7f:	75 f1                	jne    800f72 <strlen+0xf>
		n++;
	return n;
  800f81:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f84:	c9                   	leave  
  800f85:	c3                   	ret    

00800f86 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800f86:	55                   	push   %ebp
  800f87:	89 e5                	mov    %esp,%ebp
  800f89:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f8c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f93:	eb 09                	jmp    800f9e <strnlen+0x18>
		n++;
  800f95:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f98:	ff 45 08             	incl   0x8(%ebp)
  800f9b:	ff 4d 0c             	decl   0xc(%ebp)
  800f9e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fa2:	74 09                	je     800fad <strnlen+0x27>
  800fa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa7:	8a 00                	mov    (%eax),%al
  800fa9:	84 c0                	test   %al,%al
  800fab:	75 e8                	jne    800f95 <strnlen+0xf>
		n++;
	return n;
  800fad:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800fb0:	c9                   	leave  
  800fb1:	c3                   	ret    

00800fb2 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800fb2:	55                   	push   %ebp
  800fb3:	89 e5                	mov    %esp,%ebp
  800fb5:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800fbe:	90                   	nop
  800fbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc2:	8d 50 01             	lea    0x1(%eax),%edx
  800fc5:	89 55 08             	mov    %edx,0x8(%ebp)
  800fc8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fcb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fce:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800fd1:	8a 12                	mov    (%edx),%dl
  800fd3:	88 10                	mov    %dl,(%eax)
  800fd5:	8a 00                	mov    (%eax),%al
  800fd7:	84 c0                	test   %al,%al
  800fd9:	75 e4                	jne    800fbf <strcpy+0xd>
		/* do nothing */;
	return ret;
  800fdb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800fde:	c9                   	leave  
  800fdf:	c3                   	ret    

00800fe0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800fe0:	55                   	push   %ebp
  800fe1:	89 e5                	mov    %esp,%ebp
  800fe3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800fe6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800fec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ff3:	eb 1f                	jmp    801014 <strncpy+0x34>
		*dst++ = *src;
  800ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff8:	8d 50 01             	lea    0x1(%eax),%edx
  800ffb:	89 55 08             	mov    %edx,0x8(%ebp)
  800ffe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801001:	8a 12                	mov    (%edx),%dl
  801003:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801005:	8b 45 0c             	mov    0xc(%ebp),%eax
  801008:	8a 00                	mov    (%eax),%al
  80100a:	84 c0                	test   %al,%al
  80100c:	74 03                	je     801011 <strncpy+0x31>
			src++;
  80100e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801011:	ff 45 fc             	incl   -0x4(%ebp)
  801014:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801017:	3b 45 10             	cmp    0x10(%ebp),%eax
  80101a:	72 d9                	jb     800ff5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80101c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80101f:	c9                   	leave  
  801020:	c3                   	ret    

00801021 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801021:	55                   	push   %ebp
  801022:	89 e5                	mov    %esp,%ebp
  801024:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80102d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801031:	74 30                	je     801063 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801033:	eb 16                	jmp    80104b <strlcpy+0x2a>
			*dst++ = *src++;
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	8d 50 01             	lea    0x1(%eax),%edx
  80103b:	89 55 08             	mov    %edx,0x8(%ebp)
  80103e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801041:	8d 4a 01             	lea    0x1(%edx),%ecx
  801044:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801047:	8a 12                	mov    (%edx),%dl
  801049:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80104b:	ff 4d 10             	decl   0x10(%ebp)
  80104e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801052:	74 09                	je     80105d <strlcpy+0x3c>
  801054:	8b 45 0c             	mov    0xc(%ebp),%eax
  801057:	8a 00                	mov    (%eax),%al
  801059:	84 c0                	test   %al,%al
  80105b:	75 d8                	jne    801035 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801063:	8b 55 08             	mov    0x8(%ebp),%edx
  801066:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801069:	29 c2                	sub    %eax,%edx
  80106b:	89 d0                	mov    %edx,%eax
}
  80106d:	c9                   	leave  
  80106e:	c3                   	ret    

0080106f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80106f:	55                   	push   %ebp
  801070:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801072:	eb 06                	jmp    80107a <strcmp+0xb>
		p++, q++;
  801074:	ff 45 08             	incl   0x8(%ebp)
  801077:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80107a:	8b 45 08             	mov    0x8(%ebp),%eax
  80107d:	8a 00                	mov    (%eax),%al
  80107f:	84 c0                	test   %al,%al
  801081:	74 0e                	je     801091 <strcmp+0x22>
  801083:	8b 45 08             	mov    0x8(%ebp),%eax
  801086:	8a 10                	mov    (%eax),%dl
  801088:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108b:	8a 00                	mov    (%eax),%al
  80108d:	38 c2                	cmp    %al,%dl
  80108f:	74 e3                	je     801074 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801091:	8b 45 08             	mov    0x8(%ebp),%eax
  801094:	8a 00                	mov    (%eax),%al
  801096:	0f b6 d0             	movzbl %al,%edx
  801099:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109c:	8a 00                	mov    (%eax),%al
  80109e:	0f b6 c0             	movzbl %al,%eax
  8010a1:	29 c2                	sub    %eax,%edx
  8010a3:	89 d0                	mov    %edx,%eax
}
  8010a5:	5d                   	pop    %ebp
  8010a6:	c3                   	ret    

008010a7 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8010a7:	55                   	push   %ebp
  8010a8:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8010aa:	eb 09                	jmp    8010b5 <strncmp+0xe>
		n--, p++, q++;
  8010ac:	ff 4d 10             	decl   0x10(%ebp)
  8010af:	ff 45 08             	incl   0x8(%ebp)
  8010b2:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8010b5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010b9:	74 17                	je     8010d2 <strncmp+0x2b>
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	8a 00                	mov    (%eax),%al
  8010c0:	84 c0                	test   %al,%al
  8010c2:	74 0e                	je     8010d2 <strncmp+0x2b>
  8010c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c7:	8a 10                	mov    (%eax),%dl
  8010c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cc:	8a 00                	mov    (%eax),%al
  8010ce:	38 c2                	cmp    %al,%dl
  8010d0:	74 da                	je     8010ac <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8010d2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010d6:	75 07                	jne    8010df <strncmp+0x38>
		return 0;
  8010d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8010dd:	eb 14                	jmp    8010f3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8010df:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e2:	8a 00                	mov    (%eax),%al
  8010e4:	0f b6 d0             	movzbl %al,%edx
  8010e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ea:	8a 00                	mov    (%eax),%al
  8010ec:	0f b6 c0             	movzbl %al,%eax
  8010ef:	29 c2                	sub    %eax,%edx
  8010f1:	89 d0                	mov    %edx,%eax
}
  8010f3:	5d                   	pop    %ebp
  8010f4:	c3                   	ret    

008010f5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8010f5:	55                   	push   %ebp
  8010f6:	89 e5                	mov    %esp,%ebp
  8010f8:	83 ec 04             	sub    $0x4,%esp
  8010fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fe:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801101:	eb 12                	jmp    801115 <strchr+0x20>
		if (*s == c)
  801103:	8b 45 08             	mov    0x8(%ebp),%eax
  801106:	8a 00                	mov    (%eax),%al
  801108:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80110b:	75 05                	jne    801112 <strchr+0x1d>
			return (char *) s;
  80110d:	8b 45 08             	mov    0x8(%ebp),%eax
  801110:	eb 11                	jmp    801123 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801112:	ff 45 08             	incl   0x8(%ebp)
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	8a 00                	mov    (%eax),%al
  80111a:	84 c0                	test   %al,%al
  80111c:	75 e5                	jne    801103 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80111e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801123:	c9                   	leave  
  801124:	c3                   	ret    

00801125 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801125:	55                   	push   %ebp
  801126:	89 e5                	mov    %esp,%ebp
  801128:	83 ec 04             	sub    $0x4,%esp
  80112b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801131:	eb 0d                	jmp    801140 <strfind+0x1b>
		if (*s == c)
  801133:	8b 45 08             	mov    0x8(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80113b:	74 0e                	je     80114b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80113d:	ff 45 08             	incl   0x8(%ebp)
  801140:	8b 45 08             	mov    0x8(%ebp),%eax
  801143:	8a 00                	mov    (%eax),%al
  801145:	84 c0                	test   %al,%al
  801147:	75 ea                	jne    801133 <strfind+0xe>
  801149:	eb 01                	jmp    80114c <strfind+0x27>
		if (*s == c)
			break;
  80114b:	90                   	nop
	return (char *) s;
  80114c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80114f:	c9                   	leave  
  801150:	c3                   	ret    

00801151 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801151:	55                   	push   %ebp
  801152:	89 e5                	mov    %esp,%ebp
  801154:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801157:	8b 45 08             	mov    0x8(%ebp),%eax
  80115a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80115d:	8b 45 10             	mov    0x10(%ebp),%eax
  801160:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801163:	eb 0e                	jmp    801173 <memset+0x22>
		*p++ = c;
  801165:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801168:	8d 50 01             	lea    0x1(%eax),%edx
  80116b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80116e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801171:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801173:	ff 4d f8             	decl   -0x8(%ebp)
  801176:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80117a:	79 e9                	jns    801165 <memset+0x14>
		*p++ = c;

	return v;
  80117c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80117f:	c9                   	leave  
  801180:	c3                   	ret    

00801181 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801181:	55                   	push   %ebp
  801182:	89 e5                	mov    %esp,%ebp
  801184:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801187:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80118d:	8b 45 08             	mov    0x8(%ebp),%eax
  801190:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801193:	eb 16                	jmp    8011ab <memcpy+0x2a>
		*d++ = *s++;
  801195:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801198:	8d 50 01             	lea    0x1(%eax),%edx
  80119b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80119e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011a1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011a4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8011a7:	8a 12                	mov    (%edx),%dl
  8011a9:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8011ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ae:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011b1:	89 55 10             	mov    %edx,0x10(%ebp)
  8011b4:	85 c0                	test   %eax,%eax
  8011b6:	75 dd                	jne    801195 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8011b8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011bb:	c9                   	leave  
  8011bc:	c3                   	ret    

008011bd <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8011bd:	55                   	push   %ebp
  8011be:	89 e5                	mov    %esp,%ebp
  8011c0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8011cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011d2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011d5:	73 50                	jae    801227 <memmove+0x6a>
  8011d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011da:	8b 45 10             	mov    0x10(%ebp),%eax
  8011dd:	01 d0                	add    %edx,%eax
  8011df:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011e2:	76 43                	jbe    801227 <memmove+0x6a>
		s += n;
  8011e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8011ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ed:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8011f0:	eb 10                	jmp    801202 <memmove+0x45>
			*--d = *--s;
  8011f2:	ff 4d f8             	decl   -0x8(%ebp)
  8011f5:	ff 4d fc             	decl   -0x4(%ebp)
  8011f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011fb:	8a 10                	mov    (%eax),%dl
  8011fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801200:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801202:	8b 45 10             	mov    0x10(%ebp),%eax
  801205:	8d 50 ff             	lea    -0x1(%eax),%edx
  801208:	89 55 10             	mov    %edx,0x10(%ebp)
  80120b:	85 c0                	test   %eax,%eax
  80120d:	75 e3                	jne    8011f2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80120f:	eb 23                	jmp    801234 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801211:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801214:	8d 50 01             	lea    0x1(%eax),%edx
  801217:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80121a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80121d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801220:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801223:	8a 12                	mov    (%edx),%dl
  801225:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801227:	8b 45 10             	mov    0x10(%ebp),%eax
  80122a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80122d:	89 55 10             	mov    %edx,0x10(%ebp)
  801230:	85 c0                	test   %eax,%eax
  801232:	75 dd                	jne    801211 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801234:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801237:	c9                   	leave  
  801238:	c3                   	ret    

00801239 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801239:	55                   	push   %ebp
  80123a:	89 e5                	mov    %esp,%ebp
  80123c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80123f:	8b 45 08             	mov    0x8(%ebp),%eax
  801242:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801245:	8b 45 0c             	mov    0xc(%ebp),%eax
  801248:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80124b:	eb 2a                	jmp    801277 <memcmp+0x3e>
		if (*s1 != *s2)
  80124d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801250:	8a 10                	mov    (%eax),%dl
  801252:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801255:	8a 00                	mov    (%eax),%al
  801257:	38 c2                	cmp    %al,%dl
  801259:	74 16                	je     801271 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80125b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80125e:	8a 00                	mov    (%eax),%al
  801260:	0f b6 d0             	movzbl %al,%edx
  801263:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801266:	8a 00                	mov    (%eax),%al
  801268:	0f b6 c0             	movzbl %al,%eax
  80126b:	29 c2                	sub    %eax,%edx
  80126d:	89 d0                	mov    %edx,%eax
  80126f:	eb 18                	jmp    801289 <memcmp+0x50>
		s1++, s2++;
  801271:	ff 45 fc             	incl   -0x4(%ebp)
  801274:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801277:	8b 45 10             	mov    0x10(%ebp),%eax
  80127a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80127d:	89 55 10             	mov    %edx,0x10(%ebp)
  801280:	85 c0                	test   %eax,%eax
  801282:	75 c9                	jne    80124d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801284:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801289:	c9                   	leave  
  80128a:	c3                   	ret    

0080128b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80128b:	55                   	push   %ebp
  80128c:	89 e5                	mov    %esp,%ebp
  80128e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801291:	8b 55 08             	mov    0x8(%ebp),%edx
  801294:	8b 45 10             	mov    0x10(%ebp),%eax
  801297:	01 d0                	add    %edx,%eax
  801299:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80129c:	eb 15                	jmp    8012b3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80129e:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a1:	8a 00                	mov    (%eax),%al
  8012a3:	0f b6 d0             	movzbl %al,%edx
  8012a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a9:	0f b6 c0             	movzbl %al,%eax
  8012ac:	39 c2                	cmp    %eax,%edx
  8012ae:	74 0d                	je     8012bd <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8012b0:	ff 45 08             	incl   0x8(%ebp)
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8012b9:	72 e3                	jb     80129e <memfind+0x13>
  8012bb:	eb 01                	jmp    8012be <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8012bd:	90                   	nop
	return (void *) s;
  8012be:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012c1:	c9                   	leave  
  8012c2:	c3                   	ret    

008012c3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8012c3:	55                   	push   %ebp
  8012c4:	89 e5                	mov    %esp,%ebp
  8012c6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8012c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8012d0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012d7:	eb 03                	jmp    8012dc <strtol+0x19>
		s++;
  8012d9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	8a 00                	mov    (%eax),%al
  8012e1:	3c 20                	cmp    $0x20,%al
  8012e3:	74 f4                	je     8012d9 <strtol+0x16>
  8012e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e8:	8a 00                	mov    (%eax),%al
  8012ea:	3c 09                	cmp    $0x9,%al
  8012ec:	74 eb                	je     8012d9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	8a 00                	mov    (%eax),%al
  8012f3:	3c 2b                	cmp    $0x2b,%al
  8012f5:	75 05                	jne    8012fc <strtol+0x39>
		s++;
  8012f7:	ff 45 08             	incl   0x8(%ebp)
  8012fa:	eb 13                	jmp    80130f <strtol+0x4c>
	else if (*s == '-')
  8012fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ff:	8a 00                	mov    (%eax),%al
  801301:	3c 2d                	cmp    $0x2d,%al
  801303:	75 0a                	jne    80130f <strtol+0x4c>
		s++, neg = 1;
  801305:	ff 45 08             	incl   0x8(%ebp)
  801308:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80130f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801313:	74 06                	je     80131b <strtol+0x58>
  801315:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801319:	75 20                	jne    80133b <strtol+0x78>
  80131b:	8b 45 08             	mov    0x8(%ebp),%eax
  80131e:	8a 00                	mov    (%eax),%al
  801320:	3c 30                	cmp    $0x30,%al
  801322:	75 17                	jne    80133b <strtol+0x78>
  801324:	8b 45 08             	mov    0x8(%ebp),%eax
  801327:	40                   	inc    %eax
  801328:	8a 00                	mov    (%eax),%al
  80132a:	3c 78                	cmp    $0x78,%al
  80132c:	75 0d                	jne    80133b <strtol+0x78>
		s += 2, base = 16;
  80132e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801332:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801339:	eb 28                	jmp    801363 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80133b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80133f:	75 15                	jne    801356 <strtol+0x93>
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	8a 00                	mov    (%eax),%al
  801346:	3c 30                	cmp    $0x30,%al
  801348:	75 0c                	jne    801356 <strtol+0x93>
		s++, base = 8;
  80134a:	ff 45 08             	incl   0x8(%ebp)
  80134d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801354:	eb 0d                	jmp    801363 <strtol+0xa0>
	else if (base == 0)
  801356:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80135a:	75 07                	jne    801363 <strtol+0xa0>
		base = 10;
  80135c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801363:	8b 45 08             	mov    0x8(%ebp),%eax
  801366:	8a 00                	mov    (%eax),%al
  801368:	3c 2f                	cmp    $0x2f,%al
  80136a:	7e 19                	jle    801385 <strtol+0xc2>
  80136c:	8b 45 08             	mov    0x8(%ebp),%eax
  80136f:	8a 00                	mov    (%eax),%al
  801371:	3c 39                	cmp    $0x39,%al
  801373:	7f 10                	jg     801385 <strtol+0xc2>
			dig = *s - '0';
  801375:	8b 45 08             	mov    0x8(%ebp),%eax
  801378:	8a 00                	mov    (%eax),%al
  80137a:	0f be c0             	movsbl %al,%eax
  80137d:	83 e8 30             	sub    $0x30,%eax
  801380:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801383:	eb 42                	jmp    8013c7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	8a 00                	mov    (%eax),%al
  80138a:	3c 60                	cmp    $0x60,%al
  80138c:	7e 19                	jle    8013a7 <strtol+0xe4>
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	8a 00                	mov    (%eax),%al
  801393:	3c 7a                	cmp    $0x7a,%al
  801395:	7f 10                	jg     8013a7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	8a 00                	mov    (%eax),%al
  80139c:	0f be c0             	movsbl %al,%eax
  80139f:	83 e8 57             	sub    $0x57,%eax
  8013a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013a5:	eb 20                	jmp    8013c7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	8a 00                	mov    (%eax),%al
  8013ac:	3c 40                	cmp    $0x40,%al
  8013ae:	7e 39                	jle    8013e9 <strtol+0x126>
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	8a 00                	mov    (%eax),%al
  8013b5:	3c 5a                	cmp    $0x5a,%al
  8013b7:	7f 30                	jg     8013e9 <strtol+0x126>
			dig = *s - 'A' + 10;
  8013b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bc:	8a 00                	mov    (%eax),%al
  8013be:	0f be c0             	movsbl %al,%eax
  8013c1:	83 e8 37             	sub    $0x37,%eax
  8013c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8013c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013ca:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013cd:	7d 19                	jge    8013e8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8013cf:	ff 45 08             	incl   0x8(%ebp)
  8013d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013d5:	0f af 45 10          	imul   0x10(%ebp),%eax
  8013d9:	89 c2                	mov    %eax,%edx
  8013db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013de:	01 d0                	add    %edx,%eax
  8013e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8013e3:	e9 7b ff ff ff       	jmp    801363 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8013e8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8013e9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013ed:	74 08                	je     8013f7 <strtol+0x134>
		*endptr = (char *) s;
  8013ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f2:	8b 55 08             	mov    0x8(%ebp),%edx
  8013f5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8013f7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013fb:	74 07                	je     801404 <strtol+0x141>
  8013fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801400:	f7 d8                	neg    %eax
  801402:	eb 03                	jmp    801407 <strtol+0x144>
  801404:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801407:	c9                   	leave  
  801408:	c3                   	ret    

00801409 <ltostr>:

void
ltostr(long value, char *str)
{
  801409:	55                   	push   %ebp
  80140a:	89 e5                	mov    %esp,%ebp
  80140c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80140f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801416:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80141d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801421:	79 13                	jns    801436 <ltostr+0x2d>
	{
		neg = 1;
  801423:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80142a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801430:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801433:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801436:	8b 45 08             	mov    0x8(%ebp),%eax
  801439:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80143e:	99                   	cltd   
  80143f:	f7 f9                	idiv   %ecx
  801441:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801444:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801447:	8d 50 01             	lea    0x1(%eax),%edx
  80144a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80144d:	89 c2                	mov    %eax,%edx
  80144f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801452:	01 d0                	add    %edx,%eax
  801454:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801457:	83 c2 30             	add    $0x30,%edx
  80145a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80145c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80145f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801464:	f7 e9                	imul   %ecx
  801466:	c1 fa 02             	sar    $0x2,%edx
  801469:	89 c8                	mov    %ecx,%eax
  80146b:	c1 f8 1f             	sar    $0x1f,%eax
  80146e:	29 c2                	sub    %eax,%edx
  801470:	89 d0                	mov    %edx,%eax
  801472:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801475:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801478:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80147d:	f7 e9                	imul   %ecx
  80147f:	c1 fa 02             	sar    $0x2,%edx
  801482:	89 c8                	mov    %ecx,%eax
  801484:	c1 f8 1f             	sar    $0x1f,%eax
  801487:	29 c2                	sub    %eax,%edx
  801489:	89 d0                	mov    %edx,%eax
  80148b:	c1 e0 02             	shl    $0x2,%eax
  80148e:	01 d0                	add    %edx,%eax
  801490:	01 c0                	add    %eax,%eax
  801492:	29 c1                	sub    %eax,%ecx
  801494:	89 ca                	mov    %ecx,%edx
  801496:	85 d2                	test   %edx,%edx
  801498:	75 9c                	jne    801436 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80149a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8014a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a4:	48                   	dec    %eax
  8014a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8014a8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014ac:	74 3d                	je     8014eb <ltostr+0xe2>
		start = 1 ;
  8014ae:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8014b5:	eb 34                	jmp    8014eb <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8014b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bd:	01 d0                	add    %edx,%eax
  8014bf:	8a 00                	mov    (%eax),%al
  8014c1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8014c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ca:	01 c2                	add    %eax,%edx
  8014cc:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8014cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d2:	01 c8                	add    %ecx,%eax
  8014d4:	8a 00                	mov    (%eax),%al
  8014d6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8014d8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8014db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014de:	01 c2                	add    %eax,%edx
  8014e0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8014e3:	88 02                	mov    %al,(%edx)
		start++ ;
  8014e5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8014e8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8014eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014ee:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014f1:	7c c4                	jl     8014b7 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8014f3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8014f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f9:	01 d0                	add    %edx,%eax
  8014fb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8014fe:	90                   	nop
  8014ff:	c9                   	leave  
  801500:	c3                   	ret    

00801501 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801501:	55                   	push   %ebp
  801502:	89 e5                	mov    %esp,%ebp
  801504:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801507:	ff 75 08             	pushl  0x8(%ebp)
  80150a:	e8 54 fa ff ff       	call   800f63 <strlen>
  80150f:	83 c4 04             	add    $0x4,%esp
  801512:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801515:	ff 75 0c             	pushl  0xc(%ebp)
  801518:	e8 46 fa ff ff       	call   800f63 <strlen>
  80151d:	83 c4 04             	add    $0x4,%esp
  801520:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801523:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80152a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801531:	eb 17                	jmp    80154a <strcconcat+0x49>
		final[s] = str1[s] ;
  801533:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801536:	8b 45 10             	mov    0x10(%ebp),%eax
  801539:	01 c2                	add    %eax,%edx
  80153b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80153e:	8b 45 08             	mov    0x8(%ebp),%eax
  801541:	01 c8                	add    %ecx,%eax
  801543:	8a 00                	mov    (%eax),%al
  801545:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801547:	ff 45 fc             	incl   -0x4(%ebp)
  80154a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80154d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801550:	7c e1                	jl     801533 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801552:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801559:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801560:	eb 1f                	jmp    801581 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801562:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801565:	8d 50 01             	lea    0x1(%eax),%edx
  801568:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80156b:	89 c2                	mov    %eax,%edx
  80156d:	8b 45 10             	mov    0x10(%ebp),%eax
  801570:	01 c2                	add    %eax,%edx
  801572:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801575:	8b 45 0c             	mov    0xc(%ebp),%eax
  801578:	01 c8                	add    %ecx,%eax
  80157a:	8a 00                	mov    (%eax),%al
  80157c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80157e:	ff 45 f8             	incl   -0x8(%ebp)
  801581:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801584:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801587:	7c d9                	jl     801562 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801589:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80158c:	8b 45 10             	mov    0x10(%ebp),%eax
  80158f:	01 d0                	add    %edx,%eax
  801591:	c6 00 00             	movb   $0x0,(%eax)
}
  801594:	90                   	nop
  801595:	c9                   	leave  
  801596:	c3                   	ret    

00801597 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801597:	55                   	push   %ebp
  801598:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80159a:	8b 45 14             	mov    0x14(%ebp),%eax
  80159d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8015a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8015a6:	8b 00                	mov    (%eax),%eax
  8015a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015af:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b2:	01 d0                	add    %edx,%eax
  8015b4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8015ba:	eb 0c                	jmp    8015c8 <strsplit+0x31>
			*string++ = 0;
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	8d 50 01             	lea    0x1(%eax),%edx
  8015c2:	89 55 08             	mov    %edx,0x8(%ebp)
  8015c5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8015c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cb:	8a 00                	mov    (%eax),%al
  8015cd:	84 c0                	test   %al,%al
  8015cf:	74 18                	je     8015e9 <strsplit+0x52>
  8015d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d4:	8a 00                	mov    (%eax),%al
  8015d6:	0f be c0             	movsbl %al,%eax
  8015d9:	50                   	push   %eax
  8015da:	ff 75 0c             	pushl  0xc(%ebp)
  8015dd:	e8 13 fb ff ff       	call   8010f5 <strchr>
  8015e2:	83 c4 08             	add    $0x8,%esp
  8015e5:	85 c0                	test   %eax,%eax
  8015e7:	75 d3                	jne    8015bc <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8015e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ec:	8a 00                	mov    (%eax),%al
  8015ee:	84 c0                	test   %al,%al
  8015f0:	74 5a                	je     80164c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8015f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8015f5:	8b 00                	mov    (%eax),%eax
  8015f7:	83 f8 0f             	cmp    $0xf,%eax
  8015fa:	75 07                	jne    801603 <strsplit+0x6c>
		{
			return 0;
  8015fc:	b8 00 00 00 00       	mov    $0x0,%eax
  801601:	eb 66                	jmp    801669 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801603:	8b 45 14             	mov    0x14(%ebp),%eax
  801606:	8b 00                	mov    (%eax),%eax
  801608:	8d 48 01             	lea    0x1(%eax),%ecx
  80160b:	8b 55 14             	mov    0x14(%ebp),%edx
  80160e:	89 0a                	mov    %ecx,(%edx)
  801610:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801617:	8b 45 10             	mov    0x10(%ebp),%eax
  80161a:	01 c2                	add    %eax,%edx
  80161c:	8b 45 08             	mov    0x8(%ebp),%eax
  80161f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801621:	eb 03                	jmp    801626 <strsplit+0x8f>
			string++;
  801623:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	8a 00                	mov    (%eax),%al
  80162b:	84 c0                	test   %al,%al
  80162d:	74 8b                	je     8015ba <strsplit+0x23>
  80162f:	8b 45 08             	mov    0x8(%ebp),%eax
  801632:	8a 00                	mov    (%eax),%al
  801634:	0f be c0             	movsbl %al,%eax
  801637:	50                   	push   %eax
  801638:	ff 75 0c             	pushl  0xc(%ebp)
  80163b:	e8 b5 fa ff ff       	call   8010f5 <strchr>
  801640:	83 c4 08             	add    $0x8,%esp
  801643:	85 c0                	test   %eax,%eax
  801645:	74 dc                	je     801623 <strsplit+0x8c>
			string++;
	}
  801647:	e9 6e ff ff ff       	jmp    8015ba <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80164c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80164d:	8b 45 14             	mov    0x14(%ebp),%eax
  801650:	8b 00                	mov    (%eax),%eax
  801652:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801659:	8b 45 10             	mov    0x10(%ebp),%eax
  80165c:	01 d0                	add    %edx,%eax
  80165e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801664:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801669:	c9                   	leave  
  80166a:	c3                   	ret    

0080166b <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  80166b:	55                   	push   %ebp
  80166c:	89 e5                	mov    %esp,%ebp
  80166e:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	c1 e8 0c             	shr    $0xc,%eax
  801677:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  80167a:	8b 45 08             	mov    0x8(%ebp),%eax
  80167d:	25 ff 0f 00 00       	and    $0xfff,%eax
  801682:	85 c0                	test   %eax,%eax
  801684:	74 03                	je     801689 <malloc+0x1e>
			num++;
  801686:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801689:	a1 04 30 80 00       	mov    0x803004,%eax
  80168e:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801693:	75 73                	jne    801708 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801695:	83 ec 08             	sub    $0x8,%esp
  801698:	ff 75 08             	pushl  0x8(%ebp)
  80169b:	68 00 00 00 80       	push   $0x80000000
  8016a0:	e8 80 04 00 00       	call   801b25 <sys_allocateMem>
  8016a5:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8016a8:	a1 04 30 80 00       	mov    0x803004,%eax
  8016ad:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8016b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b3:	c1 e0 0c             	shl    $0xc,%eax
  8016b6:	89 c2                	mov    %eax,%edx
  8016b8:	a1 04 30 80 00       	mov    0x803004,%eax
  8016bd:	01 d0                	add    %edx,%eax
  8016bf:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  8016c4:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016cc:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  8016d3:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016d8:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8016de:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  8016e5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016ea:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  8016f1:	01 00 00 00 
			sizeofarray++;
  8016f5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016fa:	40                   	inc    %eax
  8016fb:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  801700:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801703:	e9 71 01 00 00       	jmp    801879 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801708:	a1 28 30 80 00       	mov    0x803028,%eax
  80170d:	85 c0                	test   %eax,%eax
  80170f:	75 71                	jne    801782 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801711:	a1 04 30 80 00       	mov    0x803004,%eax
  801716:	83 ec 08             	sub    $0x8,%esp
  801719:	ff 75 08             	pushl  0x8(%ebp)
  80171c:	50                   	push   %eax
  80171d:	e8 03 04 00 00       	call   801b25 <sys_allocateMem>
  801722:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801725:	a1 04 30 80 00       	mov    0x803004,%eax
  80172a:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  80172d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801730:	c1 e0 0c             	shl    $0xc,%eax
  801733:	89 c2                	mov    %eax,%edx
  801735:	a1 04 30 80 00       	mov    0x803004,%eax
  80173a:	01 d0                	add    %edx,%eax
  80173c:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801741:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801746:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801749:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801750:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801755:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801758:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  80175f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801764:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  80176b:	01 00 00 00 
				sizeofarray++;
  80176f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801774:	40                   	inc    %eax
  801775:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  80177a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80177d:	e9 f7 00 00 00       	jmp    801879 <malloc+0x20e>
			}
			else{
				int count=0;
  801782:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801789:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801790:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801797:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  80179e:	eb 7c                	jmp    80181c <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  8017a0:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8017a7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8017ae:	eb 1a                	jmp    8017ca <malloc+0x15f>
					{
						if(addresses[j]==i)
  8017b0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8017b3:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8017ba:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8017bd:	75 08                	jne    8017c7 <malloc+0x15c>
						{
							index=j;
  8017bf:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8017c2:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  8017c5:	eb 0d                	jmp    8017d4 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  8017c7:	ff 45 dc             	incl   -0x24(%ebp)
  8017ca:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017cf:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8017d2:	7c dc                	jl     8017b0 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  8017d4:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8017d8:	75 05                	jne    8017df <malloc+0x174>
					{
						count++;
  8017da:	ff 45 f0             	incl   -0x10(%ebp)
  8017dd:	eb 36                	jmp    801815 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  8017df:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8017e2:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  8017e9:	85 c0                	test   %eax,%eax
  8017eb:	75 05                	jne    8017f2 <malloc+0x187>
						{
							count++;
  8017ed:	ff 45 f0             	incl   -0x10(%ebp)
  8017f0:	eb 23                	jmp    801815 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  8017f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017f5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8017f8:	7d 14                	jge    80180e <malloc+0x1a3>
  8017fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017fd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801800:	7c 0c                	jl     80180e <malloc+0x1a3>
							{
								min=count;
  801802:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801805:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801808:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80180b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  80180e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801815:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  80181c:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801823:	0f 86 77 ff ff ff    	jbe    8017a0 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801829:	83 ec 08             	sub    $0x8,%esp
  80182c:	ff 75 08             	pushl  0x8(%ebp)
  80182f:	ff 75 e4             	pushl  -0x1c(%ebp)
  801832:	e8 ee 02 00 00       	call   801b25 <sys_allocateMem>
  801837:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  80183a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80183f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801842:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801849:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80184e:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801854:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  80185b:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801860:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801867:	01 00 00 00 
				sizeofarray++;
  80186b:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801870:	40                   	inc    %eax
  801871:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  801876:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801879:	c9                   	leave  
  80187a:	c3                   	ret    

0080187b <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80187b:	55                   	push   %ebp
  80187c:	89 e5                	mov    %esp,%ebp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details
}
  80187e:	90                   	nop
  80187f:	5d                   	pop    %ebp
  801880:	c3                   	ret    

00801881 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801881:	55                   	push   %ebp
  801882:	89 e5                	mov    %esp,%ebp
  801884:	83 ec 18             	sub    $0x18,%esp
  801887:	8b 45 10             	mov    0x10(%ebp),%eax
  80188a:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80188d:	83 ec 04             	sub    $0x4,%esp
  801890:	68 50 29 80 00       	push   $0x802950
  801895:	68 8d 00 00 00       	push   $0x8d
  80189a:	68 73 29 80 00       	push   $0x802973
  80189f:	e8 9b ed ff ff       	call   80063f <_panic>

008018a4 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8018a4:	55                   	push   %ebp
  8018a5:	89 e5                	mov    %esp,%ebp
  8018a7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018aa:	83 ec 04             	sub    $0x4,%esp
  8018ad:	68 50 29 80 00       	push   $0x802950
  8018b2:	68 93 00 00 00       	push   $0x93
  8018b7:	68 73 29 80 00       	push   $0x802973
  8018bc:	e8 7e ed ff ff       	call   80063f <_panic>

008018c1 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8018c1:	55                   	push   %ebp
  8018c2:	89 e5                	mov    %esp,%ebp
  8018c4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018c7:	83 ec 04             	sub    $0x4,%esp
  8018ca:	68 50 29 80 00       	push   $0x802950
  8018cf:	68 99 00 00 00       	push   $0x99
  8018d4:	68 73 29 80 00       	push   $0x802973
  8018d9:	e8 61 ed ff ff       	call   80063f <_panic>

008018de <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  8018de:	55                   	push   %ebp
  8018df:	89 e5                	mov    %esp,%ebp
  8018e1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018e4:	83 ec 04             	sub    $0x4,%esp
  8018e7:	68 50 29 80 00       	push   $0x802950
  8018ec:	68 9e 00 00 00       	push   $0x9e
  8018f1:	68 73 29 80 00       	push   $0x802973
  8018f6:	e8 44 ed ff ff       	call   80063f <_panic>

008018fb <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8018fb:	55                   	push   %ebp
  8018fc:	89 e5                	mov    %esp,%ebp
  8018fe:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801901:	83 ec 04             	sub    $0x4,%esp
  801904:	68 50 29 80 00       	push   $0x802950
  801909:	68 a4 00 00 00       	push   $0xa4
  80190e:	68 73 29 80 00       	push   $0x802973
  801913:	e8 27 ed ff ff       	call   80063f <_panic>

00801918 <shrink>:
}
void shrink(uint32 newSize)
{
  801918:	55                   	push   %ebp
  801919:	89 e5                	mov    %esp,%ebp
  80191b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80191e:	83 ec 04             	sub    $0x4,%esp
  801921:	68 50 29 80 00       	push   $0x802950
  801926:	68 a8 00 00 00       	push   $0xa8
  80192b:	68 73 29 80 00       	push   $0x802973
  801930:	e8 0a ed ff ff       	call   80063f <_panic>

00801935 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
  801938:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80193b:	83 ec 04             	sub    $0x4,%esp
  80193e:	68 50 29 80 00       	push   $0x802950
  801943:	68 ad 00 00 00       	push   $0xad
  801948:	68 73 29 80 00       	push   $0x802973
  80194d:	e8 ed ec ff ff       	call   80063f <_panic>

00801952 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801952:	55                   	push   %ebp
  801953:	89 e5                	mov    %esp,%ebp
  801955:	57                   	push   %edi
  801956:	56                   	push   %esi
  801957:	53                   	push   %ebx
  801958:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80195b:	8b 45 08             	mov    0x8(%ebp),%eax
  80195e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801961:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801964:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801967:	8b 7d 18             	mov    0x18(%ebp),%edi
  80196a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80196d:	cd 30                	int    $0x30
  80196f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801972:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801975:	83 c4 10             	add    $0x10,%esp
  801978:	5b                   	pop    %ebx
  801979:	5e                   	pop    %esi
  80197a:	5f                   	pop    %edi
  80197b:	5d                   	pop    %ebp
  80197c:	c3                   	ret    

0080197d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80197d:	55                   	push   %ebp
  80197e:	89 e5                	mov    %esp,%ebp
  801980:	83 ec 04             	sub    $0x4,%esp
  801983:	8b 45 10             	mov    0x10(%ebp),%eax
  801986:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801989:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80198d:	8b 45 08             	mov    0x8(%ebp),%eax
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	52                   	push   %edx
  801995:	ff 75 0c             	pushl  0xc(%ebp)
  801998:	50                   	push   %eax
  801999:	6a 00                	push   $0x0
  80199b:	e8 b2 ff ff ff       	call   801952 <syscall>
  8019a0:	83 c4 18             	add    $0x18,%esp
}
  8019a3:	90                   	nop
  8019a4:	c9                   	leave  
  8019a5:	c3                   	ret    

008019a6 <sys_cgetc>:

int
sys_cgetc(void)
{
  8019a6:	55                   	push   %ebp
  8019a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 01                	push   $0x1
  8019b5:	e8 98 ff ff ff       	call   801952 <syscall>
  8019ba:	83 c4 18             	add    $0x18,%esp
}
  8019bd:	c9                   	leave  
  8019be:	c3                   	ret    

008019bf <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8019bf:	55                   	push   %ebp
  8019c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8019c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	50                   	push   %eax
  8019ce:	6a 05                	push   $0x5
  8019d0:	e8 7d ff ff ff       	call   801952 <syscall>
  8019d5:	83 c4 18             	add    $0x18,%esp
}
  8019d8:	c9                   	leave  
  8019d9:	c3                   	ret    

008019da <sys_getenvid>:

int32 sys_getenvid(void)
{
  8019da:	55                   	push   %ebp
  8019db:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 02                	push   $0x2
  8019e9:	e8 64 ff ff ff       	call   801952 <syscall>
  8019ee:	83 c4 18             	add    $0x18,%esp
}
  8019f1:	c9                   	leave  
  8019f2:	c3                   	ret    

008019f3 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8019f3:	55                   	push   %ebp
  8019f4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 03                	push   $0x3
  801a02:	e8 4b ff ff ff       	call   801952 <syscall>
  801a07:	83 c4 18             	add    $0x18,%esp
}
  801a0a:	c9                   	leave  
  801a0b:	c3                   	ret    

00801a0c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801a0c:	55                   	push   %ebp
  801a0d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	6a 04                	push   $0x4
  801a1b:	e8 32 ff ff ff       	call   801952 <syscall>
  801a20:	83 c4 18             	add    $0x18,%esp
}
  801a23:	c9                   	leave  
  801a24:	c3                   	ret    

00801a25 <sys_env_exit>:


void sys_env_exit(void)
{
  801a25:	55                   	push   %ebp
  801a26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801a28:	6a 00                	push   $0x0
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 06                	push   $0x6
  801a34:	e8 19 ff ff ff       	call   801952 <syscall>
  801a39:	83 c4 18             	add    $0x18,%esp
}
  801a3c:	90                   	nop
  801a3d:	c9                   	leave  
  801a3e:	c3                   	ret    

00801a3f <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801a3f:	55                   	push   %ebp
  801a40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801a42:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a45:	8b 45 08             	mov    0x8(%ebp),%eax
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	52                   	push   %edx
  801a4f:	50                   	push   %eax
  801a50:	6a 07                	push   $0x7
  801a52:	e8 fb fe ff ff       	call   801952 <syscall>
  801a57:	83 c4 18             	add    $0x18,%esp
}
  801a5a:	c9                   	leave  
  801a5b:	c3                   	ret    

00801a5c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801a5c:	55                   	push   %ebp
  801a5d:	89 e5                	mov    %esp,%ebp
  801a5f:	56                   	push   %esi
  801a60:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801a61:	8b 75 18             	mov    0x18(%ebp),%esi
  801a64:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a67:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a70:	56                   	push   %esi
  801a71:	53                   	push   %ebx
  801a72:	51                   	push   %ecx
  801a73:	52                   	push   %edx
  801a74:	50                   	push   %eax
  801a75:	6a 08                	push   $0x8
  801a77:	e8 d6 fe ff ff       	call   801952 <syscall>
  801a7c:	83 c4 18             	add    $0x18,%esp
}
  801a7f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801a82:	5b                   	pop    %ebx
  801a83:	5e                   	pop    %esi
  801a84:	5d                   	pop    %ebp
  801a85:	c3                   	ret    

00801a86 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801a86:	55                   	push   %ebp
  801a87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801a89:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	52                   	push   %edx
  801a96:	50                   	push   %eax
  801a97:	6a 09                	push   $0x9
  801a99:	e8 b4 fe ff ff       	call   801952 <syscall>
  801a9e:	83 c4 18             	add    $0x18,%esp
}
  801aa1:	c9                   	leave  
  801aa2:	c3                   	ret    

00801aa3 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801aa3:	55                   	push   %ebp
  801aa4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801aa6:	6a 00                	push   $0x0
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	ff 75 0c             	pushl  0xc(%ebp)
  801aaf:	ff 75 08             	pushl  0x8(%ebp)
  801ab2:	6a 0a                	push   $0xa
  801ab4:	e8 99 fe ff ff       	call   801952 <syscall>
  801ab9:	83 c4 18             	add    $0x18,%esp
}
  801abc:	c9                   	leave  
  801abd:	c3                   	ret    

00801abe <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801abe:	55                   	push   %ebp
  801abf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 0b                	push   $0xb
  801acd:	e8 80 fe ff ff       	call   801952 <syscall>
  801ad2:	83 c4 18             	add    $0x18,%esp
}
  801ad5:	c9                   	leave  
  801ad6:	c3                   	ret    

00801ad7 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ad7:	55                   	push   %ebp
  801ad8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ada:	6a 00                	push   $0x0
  801adc:	6a 00                	push   $0x0
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 0c                	push   $0xc
  801ae6:	e8 67 fe ff ff       	call   801952 <syscall>
  801aeb:	83 c4 18             	add    $0x18,%esp
}
  801aee:	c9                   	leave  
  801aef:	c3                   	ret    

00801af0 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801af0:	55                   	push   %ebp
  801af1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801af3:	6a 00                	push   $0x0
  801af5:	6a 00                	push   $0x0
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	6a 0d                	push   $0xd
  801aff:	e8 4e fe ff ff       	call   801952 <syscall>
  801b04:	83 c4 18             	add    $0x18,%esp
}
  801b07:	c9                   	leave  
  801b08:	c3                   	ret    

00801b09 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801b09:	55                   	push   %ebp
  801b0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 00                	push   $0x0
  801b12:	ff 75 0c             	pushl  0xc(%ebp)
  801b15:	ff 75 08             	pushl  0x8(%ebp)
  801b18:	6a 11                	push   $0x11
  801b1a:	e8 33 fe ff ff       	call   801952 <syscall>
  801b1f:	83 c4 18             	add    $0x18,%esp
	return;
  801b22:	90                   	nop
}
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	ff 75 0c             	pushl  0xc(%ebp)
  801b31:	ff 75 08             	pushl  0x8(%ebp)
  801b34:	6a 12                	push   $0x12
  801b36:	e8 17 fe ff ff       	call   801952 <syscall>
  801b3b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b3e:	90                   	nop
}
  801b3f:	c9                   	leave  
  801b40:	c3                   	ret    

00801b41 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 0e                	push   $0xe
  801b50:	e8 fd fd ff ff       	call   801952 <syscall>
  801b55:	83 c4 18             	add    $0x18,%esp
}
  801b58:	c9                   	leave  
  801b59:	c3                   	ret    

00801b5a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801b5a:	55                   	push   %ebp
  801b5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	ff 75 08             	pushl  0x8(%ebp)
  801b68:	6a 0f                	push   $0xf
  801b6a:	e8 e3 fd ff ff       	call   801952 <syscall>
  801b6f:	83 c4 18             	add    $0x18,%esp
}
  801b72:	c9                   	leave  
  801b73:	c3                   	ret    

00801b74 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801b74:	55                   	push   %ebp
  801b75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 10                	push   $0x10
  801b83:	e8 ca fd ff ff       	call   801952 <syscall>
  801b88:	83 c4 18             	add    $0x18,%esp
}
  801b8b:	90                   	nop
  801b8c:	c9                   	leave  
  801b8d:	c3                   	ret    

00801b8e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801b8e:	55                   	push   %ebp
  801b8f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 14                	push   $0x14
  801b9d:	e8 b0 fd ff ff       	call   801952 <syscall>
  801ba2:	83 c4 18             	add    $0x18,%esp
}
  801ba5:	90                   	nop
  801ba6:	c9                   	leave  
  801ba7:	c3                   	ret    

00801ba8 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ba8:	55                   	push   %ebp
  801ba9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 15                	push   $0x15
  801bb7:	e8 96 fd ff ff       	call   801952 <syscall>
  801bbc:	83 c4 18             	add    $0x18,%esp
}
  801bbf:	90                   	nop
  801bc0:	c9                   	leave  
  801bc1:	c3                   	ret    

00801bc2 <sys_cputc>:


void
sys_cputc(const char c)
{
  801bc2:	55                   	push   %ebp
  801bc3:	89 e5                	mov    %esp,%ebp
  801bc5:	83 ec 04             	sub    $0x4,%esp
  801bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801bce:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	50                   	push   %eax
  801bdb:	6a 16                	push   $0x16
  801bdd:	e8 70 fd ff ff       	call   801952 <syscall>
  801be2:	83 c4 18             	add    $0x18,%esp
}
  801be5:	90                   	nop
  801be6:	c9                   	leave  
  801be7:	c3                   	ret    

00801be8 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801be8:	55                   	push   %ebp
  801be9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 17                	push   $0x17
  801bf7:	e8 56 fd ff ff       	call   801952 <syscall>
  801bfc:	83 c4 18             	add    $0x18,%esp
}
  801bff:	90                   	nop
  801c00:	c9                   	leave  
  801c01:	c3                   	ret    

00801c02 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801c02:	55                   	push   %ebp
  801c03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801c05:	8b 45 08             	mov    0x8(%ebp),%eax
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	ff 75 0c             	pushl  0xc(%ebp)
  801c11:	50                   	push   %eax
  801c12:	6a 18                	push   $0x18
  801c14:	e8 39 fd ff ff       	call   801952 <syscall>
  801c19:	83 c4 18             	add    $0x18,%esp
}
  801c1c:	c9                   	leave  
  801c1d:	c3                   	ret    

00801c1e <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801c1e:	55                   	push   %ebp
  801c1f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c21:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c24:	8b 45 08             	mov    0x8(%ebp),%eax
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	52                   	push   %edx
  801c2e:	50                   	push   %eax
  801c2f:	6a 1b                	push   $0x1b
  801c31:	e8 1c fd ff ff       	call   801952 <syscall>
  801c36:	83 c4 18             	add    $0x18,%esp
}
  801c39:	c9                   	leave  
  801c3a:	c3                   	ret    

00801c3b <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c3b:	55                   	push   %ebp
  801c3c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c41:	8b 45 08             	mov    0x8(%ebp),%eax
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	52                   	push   %edx
  801c4b:	50                   	push   %eax
  801c4c:	6a 19                	push   $0x19
  801c4e:	e8 ff fc ff ff       	call   801952 <syscall>
  801c53:	83 c4 18             	add    $0x18,%esp
}
  801c56:	90                   	nop
  801c57:	c9                   	leave  
  801c58:	c3                   	ret    

00801c59 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c59:	55                   	push   %ebp
  801c5a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 00                	push   $0x0
  801c68:	52                   	push   %edx
  801c69:	50                   	push   %eax
  801c6a:	6a 1a                	push   $0x1a
  801c6c:	e8 e1 fc ff ff       	call   801952 <syscall>
  801c71:	83 c4 18             	add    $0x18,%esp
}
  801c74:	90                   	nop
  801c75:	c9                   	leave  
  801c76:	c3                   	ret    

00801c77 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801c77:	55                   	push   %ebp
  801c78:	89 e5                	mov    %esp,%ebp
  801c7a:	83 ec 04             	sub    $0x4,%esp
  801c7d:	8b 45 10             	mov    0x10(%ebp),%eax
  801c80:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801c83:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801c86:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8d:	6a 00                	push   $0x0
  801c8f:	51                   	push   %ecx
  801c90:	52                   	push   %edx
  801c91:	ff 75 0c             	pushl  0xc(%ebp)
  801c94:	50                   	push   %eax
  801c95:	6a 1c                	push   $0x1c
  801c97:	e8 b6 fc ff ff       	call   801952 <syscall>
  801c9c:	83 c4 18             	add    $0x18,%esp
}
  801c9f:	c9                   	leave  
  801ca0:	c3                   	ret    

00801ca1 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801ca1:	55                   	push   %ebp
  801ca2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ca4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  801caa:	6a 00                	push   $0x0
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	52                   	push   %edx
  801cb1:	50                   	push   %eax
  801cb2:	6a 1d                	push   $0x1d
  801cb4:	e8 99 fc ff ff       	call   801952 <syscall>
  801cb9:	83 c4 18             	add    $0x18,%esp
}
  801cbc:	c9                   	leave  
  801cbd:	c3                   	ret    

00801cbe <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801cbe:	55                   	push   %ebp
  801cbf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801cc1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cc4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	51                   	push   %ecx
  801ccf:	52                   	push   %edx
  801cd0:	50                   	push   %eax
  801cd1:	6a 1e                	push   $0x1e
  801cd3:	e8 7a fc ff ff       	call   801952 <syscall>
  801cd8:	83 c4 18             	add    $0x18,%esp
}
  801cdb:	c9                   	leave  
  801cdc:	c3                   	ret    

00801cdd <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801cdd:	55                   	push   %ebp
  801cde:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ce0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	52                   	push   %edx
  801ced:	50                   	push   %eax
  801cee:	6a 1f                	push   $0x1f
  801cf0:	e8 5d fc ff ff       	call   801952 <syscall>
  801cf5:	83 c4 18             	add    $0x18,%esp
}
  801cf8:	c9                   	leave  
  801cf9:	c3                   	ret    

00801cfa <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801cfa:	55                   	push   %ebp
  801cfb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 20                	push   $0x20
  801d09:	e8 44 fc ff ff       	call   801952 <syscall>
  801d0e:	83 c4 18             	add    $0x18,%esp
}
  801d11:	c9                   	leave  
  801d12:	c3                   	ret    

00801d13 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801d13:	55                   	push   %ebp
  801d14:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801d16:	8b 45 08             	mov    0x8(%ebp),%eax
  801d19:	6a 00                	push   $0x0
  801d1b:	ff 75 14             	pushl  0x14(%ebp)
  801d1e:	ff 75 10             	pushl  0x10(%ebp)
  801d21:	ff 75 0c             	pushl  0xc(%ebp)
  801d24:	50                   	push   %eax
  801d25:	6a 21                	push   $0x21
  801d27:	e8 26 fc ff ff       	call   801952 <syscall>
  801d2c:	83 c4 18             	add    $0x18,%esp
}
  801d2f:	c9                   	leave  
  801d30:	c3                   	ret    

00801d31 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801d31:	55                   	push   %ebp
  801d32:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801d34:	8b 45 08             	mov    0x8(%ebp),%eax
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	50                   	push   %eax
  801d40:	6a 22                	push   $0x22
  801d42:	e8 0b fc ff ff       	call   801952 <syscall>
  801d47:	83 c4 18             	add    $0x18,%esp
}
  801d4a:	90                   	nop
  801d4b:	c9                   	leave  
  801d4c:	c3                   	ret    

00801d4d <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801d4d:	55                   	push   %ebp
  801d4e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801d50:	8b 45 08             	mov    0x8(%ebp),%eax
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	6a 00                	push   $0x0
  801d59:	6a 00                	push   $0x0
  801d5b:	50                   	push   %eax
  801d5c:	6a 23                	push   $0x23
  801d5e:	e8 ef fb ff ff       	call   801952 <syscall>
  801d63:	83 c4 18             	add    $0x18,%esp
}
  801d66:	90                   	nop
  801d67:	c9                   	leave  
  801d68:	c3                   	ret    

00801d69 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801d69:	55                   	push   %ebp
  801d6a:	89 e5                	mov    %esp,%ebp
  801d6c:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801d6f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d72:	8d 50 04             	lea    0x4(%eax),%edx
  801d75:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 00                	push   $0x0
  801d7c:	6a 00                	push   $0x0
  801d7e:	52                   	push   %edx
  801d7f:	50                   	push   %eax
  801d80:	6a 24                	push   $0x24
  801d82:	e8 cb fb ff ff       	call   801952 <syscall>
  801d87:	83 c4 18             	add    $0x18,%esp
	return result;
  801d8a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d90:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d93:	89 01                	mov    %eax,(%ecx)
  801d95:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801d98:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9b:	c9                   	leave  
  801d9c:	c2 04 00             	ret    $0x4

00801d9f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801d9f:	55                   	push   %ebp
  801da0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	ff 75 10             	pushl  0x10(%ebp)
  801da9:	ff 75 0c             	pushl  0xc(%ebp)
  801dac:	ff 75 08             	pushl  0x8(%ebp)
  801daf:	6a 13                	push   $0x13
  801db1:	e8 9c fb ff ff       	call   801952 <syscall>
  801db6:	83 c4 18             	add    $0x18,%esp
	return ;
  801db9:	90                   	nop
}
  801dba:	c9                   	leave  
  801dbb:	c3                   	ret    

00801dbc <sys_rcr2>:
uint32 sys_rcr2()
{
  801dbc:	55                   	push   %ebp
  801dbd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 25                	push   $0x25
  801dcb:	e8 82 fb ff ff       	call   801952 <syscall>
  801dd0:	83 c4 18             	add    $0x18,%esp
}
  801dd3:	c9                   	leave  
  801dd4:	c3                   	ret    

00801dd5 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801dd5:	55                   	push   %ebp
  801dd6:	89 e5                	mov    %esp,%ebp
  801dd8:	83 ec 04             	sub    $0x4,%esp
  801ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dde:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801de1:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 00                	push   $0x0
  801ded:	50                   	push   %eax
  801dee:	6a 26                	push   $0x26
  801df0:	e8 5d fb ff ff       	call   801952 <syscall>
  801df5:	83 c4 18             	add    $0x18,%esp
	return ;
  801df8:	90                   	nop
}
  801df9:	c9                   	leave  
  801dfa:	c3                   	ret    

00801dfb <rsttst>:
void rsttst()
{
  801dfb:	55                   	push   %ebp
  801dfc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 00                	push   $0x0
  801e06:	6a 00                	push   $0x0
  801e08:	6a 28                	push   $0x28
  801e0a:	e8 43 fb ff ff       	call   801952 <syscall>
  801e0f:	83 c4 18             	add    $0x18,%esp
	return ;
  801e12:	90                   	nop
}
  801e13:	c9                   	leave  
  801e14:	c3                   	ret    

00801e15 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801e15:	55                   	push   %ebp
  801e16:	89 e5                	mov    %esp,%ebp
  801e18:	83 ec 04             	sub    $0x4,%esp
  801e1b:	8b 45 14             	mov    0x14(%ebp),%eax
  801e1e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801e21:	8b 55 18             	mov    0x18(%ebp),%edx
  801e24:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e28:	52                   	push   %edx
  801e29:	50                   	push   %eax
  801e2a:	ff 75 10             	pushl  0x10(%ebp)
  801e2d:	ff 75 0c             	pushl  0xc(%ebp)
  801e30:	ff 75 08             	pushl  0x8(%ebp)
  801e33:	6a 27                	push   $0x27
  801e35:	e8 18 fb ff ff       	call   801952 <syscall>
  801e3a:	83 c4 18             	add    $0x18,%esp
	return ;
  801e3d:	90                   	nop
}
  801e3e:	c9                   	leave  
  801e3f:	c3                   	ret    

00801e40 <chktst>:
void chktst(uint32 n)
{
  801e40:	55                   	push   %ebp
  801e41:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801e43:	6a 00                	push   $0x0
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	ff 75 08             	pushl  0x8(%ebp)
  801e4e:	6a 29                	push   $0x29
  801e50:	e8 fd fa ff ff       	call   801952 <syscall>
  801e55:	83 c4 18             	add    $0x18,%esp
	return ;
  801e58:	90                   	nop
}
  801e59:	c9                   	leave  
  801e5a:	c3                   	ret    

00801e5b <inctst>:

void inctst()
{
  801e5b:	55                   	push   %ebp
  801e5c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 2a                	push   $0x2a
  801e6a:	e8 e3 fa ff ff       	call   801952 <syscall>
  801e6f:	83 c4 18             	add    $0x18,%esp
	return ;
  801e72:	90                   	nop
}
  801e73:	c9                   	leave  
  801e74:	c3                   	ret    

00801e75 <gettst>:
uint32 gettst()
{
  801e75:	55                   	push   %ebp
  801e76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	6a 2b                	push   $0x2b
  801e84:	e8 c9 fa ff ff       	call   801952 <syscall>
  801e89:	83 c4 18             	add    $0x18,%esp
}
  801e8c:	c9                   	leave  
  801e8d:	c3                   	ret    

00801e8e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801e8e:	55                   	push   %ebp
  801e8f:	89 e5                	mov    %esp,%ebp
  801e91:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e94:	6a 00                	push   $0x0
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 2c                	push   $0x2c
  801ea0:	e8 ad fa ff ff       	call   801952 <syscall>
  801ea5:	83 c4 18             	add    $0x18,%esp
  801ea8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801eab:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801eaf:	75 07                	jne    801eb8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801eb1:	b8 01 00 00 00       	mov    $0x1,%eax
  801eb6:	eb 05                	jmp    801ebd <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801eb8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ebd:	c9                   	leave  
  801ebe:	c3                   	ret    

00801ebf <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801ebf:	55                   	push   %ebp
  801ec0:	89 e5                	mov    %esp,%ebp
  801ec2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ec5:	6a 00                	push   $0x0
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 00                	push   $0x0
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 2c                	push   $0x2c
  801ed1:	e8 7c fa ff ff       	call   801952 <syscall>
  801ed6:	83 c4 18             	add    $0x18,%esp
  801ed9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801edc:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ee0:	75 07                	jne    801ee9 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ee2:	b8 01 00 00 00       	mov    $0x1,%eax
  801ee7:	eb 05                	jmp    801eee <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ee9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801eee:	c9                   	leave  
  801eef:	c3                   	ret    

00801ef0 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ef0:	55                   	push   %ebp
  801ef1:	89 e5                	mov    %esp,%ebp
  801ef3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	6a 2c                	push   $0x2c
  801f02:	e8 4b fa ff ff       	call   801952 <syscall>
  801f07:	83 c4 18             	add    $0x18,%esp
  801f0a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801f0d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801f11:	75 07                	jne    801f1a <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801f13:	b8 01 00 00 00       	mov    $0x1,%eax
  801f18:	eb 05                	jmp    801f1f <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801f1a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f1f:	c9                   	leave  
  801f20:	c3                   	ret    

00801f21 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801f21:	55                   	push   %ebp
  801f22:	89 e5                	mov    %esp,%ebp
  801f24:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f27:	6a 00                	push   $0x0
  801f29:	6a 00                	push   $0x0
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 2c                	push   $0x2c
  801f33:	e8 1a fa ff ff       	call   801952 <syscall>
  801f38:	83 c4 18             	add    $0x18,%esp
  801f3b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801f3e:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801f42:	75 07                	jne    801f4b <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801f44:	b8 01 00 00 00       	mov    $0x1,%eax
  801f49:	eb 05                	jmp    801f50 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801f4b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f50:	c9                   	leave  
  801f51:	c3                   	ret    

00801f52 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801f52:	55                   	push   %ebp
  801f53:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 00                	push   $0x0
  801f5d:	ff 75 08             	pushl  0x8(%ebp)
  801f60:	6a 2d                	push   $0x2d
  801f62:	e8 eb f9 ff ff       	call   801952 <syscall>
  801f67:	83 c4 18             	add    $0x18,%esp
	return ;
  801f6a:	90                   	nop
}
  801f6b:	c9                   	leave  
  801f6c:	c3                   	ret    

00801f6d <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801f6d:	55                   	push   %ebp
  801f6e:	89 e5                	mov    %esp,%ebp
  801f70:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801f71:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f74:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f77:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7d:	6a 00                	push   $0x0
  801f7f:	53                   	push   %ebx
  801f80:	51                   	push   %ecx
  801f81:	52                   	push   %edx
  801f82:	50                   	push   %eax
  801f83:	6a 2e                	push   $0x2e
  801f85:	e8 c8 f9 ff ff       	call   801952 <syscall>
  801f8a:	83 c4 18             	add    $0x18,%esp
}
  801f8d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801f90:	c9                   	leave  
  801f91:	c3                   	ret    

00801f92 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801f92:	55                   	push   %ebp
  801f93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801f95:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f98:	8b 45 08             	mov    0x8(%ebp),%eax
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 00                	push   $0x0
  801fa1:	52                   	push   %edx
  801fa2:	50                   	push   %eax
  801fa3:	6a 2f                	push   $0x2f
  801fa5:	e8 a8 f9 ff ff       	call   801952 <syscall>
  801faa:	83 c4 18             	add    $0x18,%esp
}
  801fad:	c9                   	leave  
  801fae:	c3                   	ret    
  801faf:	90                   	nop

00801fb0 <__udivdi3>:
  801fb0:	55                   	push   %ebp
  801fb1:	57                   	push   %edi
  801fb2:	56                   	push   %esi
  801fb3:	53                   	push   %ebx
  801fb4:	83 ec 1c             	sub    $0x1c,%esp
  801fb7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801fbb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801fbf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801fc3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801fc7:	89 ca                	mov    %ecx,%edx
  801fc9:	89 f8                	mov    %edi,%eax
  801fcb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801fcf:	85 f6                	test   %esi,%esi
  801fd1:	75 2d                	jne    802000 <__udivdi3+0x50>
  801fd3:	39 cf                	cmp    %ecx,%edi
  801fd5:	77 65                	ja     80203c <__udivdi3+0x8c>
  801fd7:	89 fd                	mov    %edi,%ebp
  801fd9:	85 ff                	test   %edi,%edi
  801fdb:	75 0b                	jne    801fe8 <__udivdi3+0x38>
  801fdd:	b8 01 00 00 00       	mov    $0x1,%eax
  801fe2:	31 d2                	xor    %edx,%edx
  801fe4:	f7 f7                	div    %edi
  801fe6:	89 c5                	mov    %eax,%ebp
  801fe8:	31 d2                	xor    %edx,%edx
  801fea:	89 c8                	mov    %ecx,%eax
  801fec:	f7 f5                	div    %ebp
  801fee:	89 c1                	mov    %eax,%ecx
  801ff0:	89 d8                	mov    %ebx,%eax
  801ff2:	f7 f5                	div    %ebp
  801ff4:	89 cf                	mov    %ecx,%edi
  801ff6:	89 fa                	mov    %edi,%edx
  801ff8:	83 c4 1c             	add    $0x1c,%esp
  801ffb:	5b                   	pop    %ebx
  801ffc:	5e                   	pop    %esi
  801ffd:	5f                   	pop    %edi
  801ffe:	5d                   	pop    %ebp
  801fff:	c3                   	ret    
  802000:	39 ce                	cmp    %ecx,%esi
  802002:	77 28                	ja     80202c <__udivdi3+0x7c>
  802004:	0f bd fe             	bsr    %esi,%edi
  802007:	83 f7 1f             	xor    $0x1f,%edi
  80200a:	75 40                	jne    80204c <__udivdi3+0x9c>
  80200c:	39 ce                	cmp    %ecx,%esi
  80200e:	72 0a                	jb     80201a <__udivdi3+0x6a>
  802010:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802014:	0f 87 9e 00 00 00    	ja     8020b8 <__udivdi3+0x108>
  80201a:	b8 01 00 00 00       	mov    $0x1,%eax
  80201f:	89 fa                	mov    %edi,%edx
  802021:	83 c4 1c             	add    $0x1c,%esp
  802024:	5b                   	pop    %ebx
  802025:	5e                   	pop    %esi
  802026:	5f                   	pop    %edi
  802027:	5d                   	pop    %ebp
  802028:	c3                   	ret    
  802029:	8d 76 00             	lea    0x0(%esi),%esi
  80202c:	31 ff                	xor    %edi,%edi
  80202e:	31 c0                	xor    %eax,%eax
  802030:	89 fa                	mov    %edi,%edx
  802032:	83 c4 1c             	add    $0x1c,%esp
  802035:	5b                   	pop    %ebx
  802036:	5e                   	pop    %esi
  802037:	5f                   	pop    %edi
  802038:	5d                   	pop    %ebp
  802039:	c3                   	ret    
  80203a:	66 90                	xchg   %ax,%ax
  80203c:	89 d8                	mov    %ebx,%eax
  80203e:	f7 f7                	div    %edi
  802040:	31 ff                	xor    %edi,%edi
  802042:	89 fa                	mov    %edi,%edx
  802044:	83 c4 1c             	add    $0x1c,%esp
  802047:	5b                   	pop    %ebx
  802048:	5e                   	pop    %esi
  802049:	5f                   	pop    %edi
  80204a:	5d                   	pop    %ebp
  80204b:	c3                   	ret    
  80204c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802051:	89 eb                	mov    %ebp,%ebx
  802053:	29 fb                	sub    %edi,%ebx
  802055:	89 f9                	mov    %edi,%ecx
  802057:	d3 e6                	shl    %cl,%esi
  802059:	89 c5                	mov    %eax,%ebp
  80205b:	88 d9                	mov    %bl,%cl
  80205d:	d3 ed                	shr    %cl,%ebp
  80205f:	89 e9                	mov    %ebp,%ecx
  802061:	09 f1                	or     %esi,%ecx
  802063:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802067:	89 f9                	mov    %edi,%ecx
  802069:	d3 e0                	shl    %cl,%eax
  80206b:	89 c5                	mov    %eax,%ebp
  80206d:	89 d6                	mov    %edx,%esi
  80206f:	88 d9                	mov    %bl,%cl
  802071:	d3 ee                	shr    %cl,%esi
  802073:	89 f9                	mov    %edi,%ecx
  802075:	d3 e2                	shl    %cl,%edx
  802077:	8b 44 24 08          	mov    0x8(%esp),%eax
  80207b:	88 d9                	mov    %bl,%cl
  80207d:	d3 e8                	shr    %cl,%eax
  80207f:	09 c2                	or     %eax,%edx
  802081:	89 d0                	mov    %edx,%eax
  802083:	89 f2                	mov    %esi,%edx
  802085:	f7 74 24 0c          	divl   0xc(%esp)
  802089:	89 d6                	mov    %edx,%esi
  80208b:	89 c3                	mov    %eax,%ebx
  80208d:	f7 e5                	mul    %ebp
  80208f:	39 d6                	cmp    %edx,%esi
  802091:	72 19                	jb     8020ac <__udivdi3+0xfc>
  802093:	74 0b                	je     8020a0 <__udivdi3+0xf0>
  802095:	89 d8                	mov    %ebx,%eax
  802097:	31 ff                	xor    %edi,%edi
  802099:	e9 58 ff ff ff       	jmp    801ff6 <__udivdi3+0x46>
  80209e:	66 90                	xchg   %ax,%ax
  8020a0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8020a4:	89 f9                	mov    %edi,%ecx
  8020a6:	d3 e2                	shl    %cl,%edx
  8020a8:	39 c2                	cmp    %eax,%edx
  8020aa:	73 e9                	jae    802095 <__udivdi3+0xe5>
  8020ac:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8020af:	31 ff                	xor    %edi,%edi
  8020b1:	e9 40 ff ff ff       	jmp    801ff6 <__udivdi3+0x46>
  8020b6:	66 90                	xchg   %ax,%ax
  8020b8:	31 c0                	xor    %eax,%eax
  8020ba:	e9 37 ff ff ff       	jmp    801ff6 <__udivdi3+0x46>
  8020bf:	90                   	nop

008020c0 <__umoddi3>:
  8020c0:	55                   	push   %ebp
  8020c1:	57                   	push   %edi
  8020c2:	56                   	push   %esi
  8020c3:	53                   	push   %ebx
  8020c4:	83 ec 1c             	sub    $0x1c,%esp
  8020c7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8020cb:	8b 74 24 34          	mov    0x34(%esp),%esi
  8020cf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020d3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8020d7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8020db:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8020df:	89 f3                	mov    %esi,%ebx
  8020e1:	89 fa                	mov    %edi,%edx
  8020e3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020e7:	89 34 24             	mov    %esi,(%esp)
  8020ea:	85 c0                	test   %eax,%eax
  8020ec:	75 1a                	jne    802108 <__umoddi3+0x48>
  8020ee:	39 f7                	cmp    %esi,%edi
  8020f0:	0f 86 a2 00 00 00    	jbe    802198 <__umoddi3+0xd8>
  8020f6:	89 c8                	mov    %ecx,%eax
  8020f8:	89 f2                	mov    %esi,%edx
  8020fa:	f7 f7                	div    %edi
  8020fc:	89 d0                	mov    %edx,%eax
  8020fe:	31 d2                	xor    %edx,%edx
  802100:	83 c4 1c             	add    $0x1c,%esp
  802103:	5b                   	pop    %ebx
  802104:	5e                   	pop    %esi
  802105:	5f                   	pop    %edi
  802106:	5d                   	pop    %ebp
  802107:	c3                   	ret    
  802108:	39 f0                	cmp    %esi,%eax
  80210a:	0f 87 ac 00 00 00    	ja     8021bc <__umoddi3+0xfc>
  802110:	0f bd e8             	bsr    %eax,%ebp
  802113:	83 f5 1f             	xor    $0x1f,%ebp
  802116:	0f 84 ac 00 00 00    	je     8021c8 <__umoddi3+0x108>
  80211c:	bf 20 00 00 00       	mov    $0x20,%edi
  802121:	29 ef                	sub    %ebp,%edi
  802123:	89 fe                	mov    %edi,%esi
  802125:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802129:	89 e9                	mov    %ebp,%ecx
  80212b:	d3 e0                	shl    %cl,%eax
  80212d:	89 d7                	mov    %edx,%edi
  80212f:	89 f1                	mov    %esi,%ecx
  802131:	d3 ef                	shr    %cl,%edi
  802133:	09 c7                	or     %eax,%edi
  802135:	89 e9                	mov    %ebp,%ecx
  802137:	d3 e2                	shl    %cl,%edx
  802139:	89 14 24             	mov    %edx,(%esp)
  80213c:	89 d8                	mov    %ebx,%eax
  80213e:	d3 e0                	shl    %cl,%eax
  802140:	89 c2                	mov    %eax,%edx
  802142:	8b 44 24 08          	mov    0x8(%esp),%eax
  802146:	d3 e0                	shl    %cl,%eax
  802148:	89 44 24 04          	mov    %eax,0x4(%esp)
  80214c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802150:	89 f1                	mov    %esi,%ecx
  802152:	d3 e8                	shr    %cl,%eax
  802154:	09 d0                	or     %edx,%eax
  802156:	d3 eb                	shr    %cl,%ebx
  802158:	89 da                	mov    %ebx,%edx
  80215a:	f7 f7                	div    %edi
  80215c:	89 d3                	mov    %edx,%ebx
  80215e:	f7 24 24             	mull   (%esp)
  802161:	89 c6                	mov    %eax,%esi
  802163:	89 d1                	mov    %edx,%ecx
  802165:	39 d3                	cmp    %edx,%ebx
  802167:	0f 82 87 00 00 00    	jb     8021f4 <__umoddi3+0x134>
  80216d:	0f 84 91 00 00 00    	je     802204 <__umoddi3+0x144>
  802173:	8b 54 24 04          	mov    0x4(%esp),%edx
  802177:	29 f2                	sub    %esi,%edx
  802179:	19 cb                	sbb    %ecx,%ebx
  80217b:	89 d8                	mov    %ebx,%eax
  80217d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802181:	d3 e0                	shl    %cl,%eax
  802183:	89 e9                	mov    %ebp,%ecx
  802185:	d3 ea                	shr    %cl,%edx
  802187:	09 d0                	or     %edx,%eax
  802189:	89 e9                	mov    %ebp,%ecx
  80218b:	d3 eb                	shr    %cl,%ebx
  80218d:	89 da                	mov    %ebx,%edx
  80218f:	83 c4 1c             	add    $0x1c,%esp
  802192:	5b                   	pop    %ebx
  802193:	5e                   	pop    %esi
  802194:	5f                   	pop    %edi
  802195:	5d                   	pop    %ebp
  802196:	c3                   	ret    
  802197:	90                   	nop
  802198:	89 fd                	mov    %edi,%ebp
  80219a:	85 ff                	test   %edi,%edi
  80219c:	75 0b                	jne    8021a9 <__umoddi3+0xe9>
  80219e:	b8 01 00 00 00       	mov    $0x1,%eax
  8021a3:	31 d2                	xor    %edx,%edx
  8021a5:	f7 f7                	div    %edi
  8021a7:	89 c5                	mov    %eax,%ebp
  8021a9:	89 f0                	mov    %esi,%eax
  8021ab:	31 d2                	xor    %edx,%edx
  8021ad:	f7 f5                	div    %ebp
  8021af:	89 c8                	mov    %ecx,%eax
  8021b1:	f7 f5                	div    %ebp
  8021b3:	89 d0                	mov    %edx,%eax
  8021b5:	e9 44 ff ff ff       	jmp    8020fe <__umoddi3+0x3e>
  8021ba:	66 90                	xchg   %ax,%ax
  8021bc:	89 c8                	mov    %ecx,%eax
  8021be:	89 f2                	mov    %esi,%edx
  8021c0:	83 c4 1c             	add    $0x1c,%esp
  8021c3:	5b                   	pop    %ebx
  8021c4:	5e                   	pop    %esi
  8021c5:	5f                   	pop    %edi
  8021c6:	5d                   	pop    %ebp
  8021c7:	c3                   	ret    
  8021c8:	3b 04 24             	cmp    (%esp),%eax
  8021cb:	72 06                	jb     8021d3 <__umoddi3+0x113>
  8021cd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8021d1:	77 0f                	ja     8021e2 <__umoddi3+0x122>
  8021d3:	89 f2                	mov    %esi,%edx
  8021d5:	29 f9                	sub    %edi,%ecx
  8021d7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8021db:	89 14 24             	mov    %edx,(%esp)
  8021de:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021e2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8021e6:	8b 14 24             	mov    (%esp),%edx
  8021e9:	83 c4 1c             	add    $0x1c,%esp
  8021ec:	5b                   	pop    %ebx
  8021ed:	5e                   	pop    %esi
  8021ee:	5f                   	pop    %edi
  8021ef:	5d                   	pop    %ebp
  8021f0:	c3                   	ret    
  8021f1:	8d 76 00             	lea    0x0(%esi),%esi
  8021f4:	2b 04 24             	sub    (%esp),%eax
  8021f7:	19 fa                	sbb    %edi,%edx
  8021f9:	89 d1                	mov    %edx,%ecx
  8021fb:	89 c6                	mov    %eax,%esi
  8021fd:	e9 71 ff ff ff       	jmp    802173 <__umoddi3+0xb3>
  802202:	66 90                	xchg   %ax,%ax
  802204:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802208:	72 ea                	jb     8021f4 <__umoddi3+0x134>
  80220a:	89 d9                	mov    %ebx,%ecx
  80220c:	e9 62 ff ff ff       	jmp    802173 <__umoddi3+0xb3>
