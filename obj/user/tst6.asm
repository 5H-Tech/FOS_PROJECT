
obj/user/tst6:     file format elf32-i386


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
  800031:	e8 4d 06 00 00       	call   800683 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	char a;
	short b;
	int c;
};
void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 6c             	sub    $0x6c,%esp
	

	rsttst();
  800041:	e8 70 1d 00 00       	call   801db6 <rsttst>
	
	

	int Mega = 1024*1024;
  800046:	c7 45 e4 00 00 10 00 	movl   $0x100000,-0x1c(%ebp)
	int kilo = 1024;
  80004d:	c7 45 e0 00 04 00 00 	movl   $0x400,-0x20(%ebp)
	void* ptr_allocations[20] = {0};
  800054:	8d 55 88             	lea    -0x78(%ebp),%edx
  800057:	b9 14 00 00 00       	mov    $0x14,%ecx
  80005c:	b8 00 00 00 00       	mov    $0x0,%eax
  800061:	89 d7                	mov    %edx,%edi
  800063:	f3 ab                	rep stos %eax,%es:(%edi)

	//[1] Attempt to allocate more than heap size
	{
		ptr_allocations[0] = malloc(USER_HEAP_MAX - USER_HEAP_START + 1);
  800065:	83 ec 0c             	sub    $0xc,%esp
  800068:	68 01 00 00 20       	push   $0x20000001
  80006d:	e8 b4 15 00 00       	call   801626 <malloc>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 88             	mov    %eax,-0x78(%ebp)
		tst((uint32) ptr_allocations[0], 0,0, 'b', 0);
  800078:	8b 45 88             	mov    -0x78(%ebp),%eax
  80007b:	83 ec 0c             	sub    $0xc,%esp
  80007e:	6a 00                	push   $0x0
  800080:	6a 62                	push   $0x62
  800082:	6a 00                	push   $0x0
  800084:	6a 00                	push   $0x0
  800086:	50                   	push   %eax
  800087:	e8 44 1d 00 00       	call   801dd0 <tst>
  80008c:	83 c4 20             	add    $0x20,%esp

	//[2] Attempt to allocate space more than any available fragment
	//	a) Create Fragments
	{
		//2 MB
		int freeFrames = sys_calculate_free_frames() ;
  80008f:	e8 e5 19 00 00       	call   801a79 <sys_calculate_free_frames>
  800094:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  800097:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80009a:	01 c0                	add    %eax,%eax
  80009c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80009f:	83 ec 0c             	sub    $0xc,%esp
  8000a2:	50                   	push   %eax
  8000a3:	e8 7e 15 00 00       	call   801626 <malloc>
  8000a8:	83 c4 10             	add    $0x10,%esp
  8000ab:	89 45 88             	mov    %eax,-0x78(%ebp)
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
  8000ae:	8b 45 88             	mov    -0x78(%ebp),%eax
  8000b1:	83 ec 0c             	sub    $0xc,%esp
  8000b4:	6a 00                	push   $0x0
  8000b6:	6a 62                	push   $0x62
  8000b8:	68 00 10 00 80       	push   $0x80001000
  8000bd:	68 00 00 00 80       	push   $0x80000000
  8000c2:	50                   	push   %eax
  8000c3:	e8 08 1d 00 00       	call   801dd0 <tst>
  8000c8:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  8000cb:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  8000ce:	e8 a6 19 00 00       	call   801a79 <sys_calculate_free_frames>
  8000d3:	29 c3                	sub    %eax,%ebx
  8000d5:	89 d8                	mov    %ebx,%eax
  8000d7:	83 ec 0c             	sub    $0xc,%esp
  8000da:	6a 00                	push   $0x0
  8000dc:	6a 65                	push   $0x65
  8000de:	6a 00                	push   $0x0
  8000e0:	68 01 02 00 00       	push   $0x201
  8000e5:	50                   	push   %eax
  8000e6:	e8 e5 1c 00 00       	call   801dd0 <tst>
  8000eb:	83 c4 20             	add    $0x20,%esp

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  8000ee:	e8 86 19 00 00       	call   801a79 <sys_calculate_free_frames>
  8000f3:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  8000f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f9:	01 c0                	add    %eax,%eax
  8000fb:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 1f 15 00 00       	call   801626 <malloc>
  800107:	83 c4 10             	add    $0x10,%esp
  80010a:	89 45 8c             	mov    %eax,-0x74(%ebp)
		tst((uint32) ptr_allocations[1], USER_HEAP_START+ 2*Mega,USER_HEAP_START + 2*Mega+ PAGE_SIZE, 'b', 0);
  80010d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800110:	01 c0                	add    %eax,%eax
  800112:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800118:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80011b:	01 c0                	add    %eax,%eax
  80011d:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800123:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800126:	83 ec 0c             	sub    $0xc,%esp
  800129:	6a 00                	push   $0x0
  80012b:	6a 62                	push   $0x62
  80012d:	51                   	push   %ecx
  80012e:	52                   	push   %edx
  80012f:	50                   	push   %eax
  800130:	e8 9b 1c 00 00       	call   801dd0 <tst>
  800135:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);
  800138:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  80013b:	e8 39 19 00 00       	call   801a79 <sys_calculate_free_frames>
  800140:	29 c3                	sub    %eax,%ebx
  800142:	89 d8                	mov    %ebx,%eax
  800144:	83 ec 0c             	sub    $0xc,%esp
  800147:	6a 00                	push   $0x0
  800149:	6a 65                	push   $0x65
  80014b:	6a 00                	push   $0x0
  80014d:	68 00 02 00 00       	push   $0x200
  800152:	50                   	push   %eax
  800153:	e8 78 1c 00 00       	call   801dd0 <tst>
  800158:	83 c4 20             	add    $0x20,%esp

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  80015b:	e8 19 19 00 00       	call   801a79 <sys_calculate_free_frames>
  800160:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800163:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800166:	01 c0                	add    %eax,%eax
  800168:	83 ec 0c             	sub    $0xc,%esp
  80016b:	50                   	push   %eax
  80016c:	e8 b5 14 00 00       	call   801626 <malloc>
  800171:	83 c4 10             	add    $0x10,%esp
  800174:	89 45 90             	mov    %eax,-0x70(%ebp)
		tst((uint32) ptr_allocations[2], USER_HEAP_START+ 4*Mega,USER_HEAP_START + 4*Mega+ PAGE_SIZE, 'b', 0);
  800177:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80017a:	c1 e0 02             	shl    $0x2,%eax
  80017d:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800183:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800186:	c1 e0 02             	shl    $0x2,%eax
  800189:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80018f:	8b 45 90             	mov    -0x70(%ebp),%eax
  800192:	83 ec 0c             	sub    $0xc,%esp
  800195:	6a 00                	push   $0x0
  800197:	6a 62                	push   $0x62
  800199:	51                   	push   %ecx
  80019a:	52                   	push   %edx
  80019b:	50                   	push   %eax
  80019c:	e8 2f 1c 00 00       	call   801dd0 <tst>
  8001a1:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1+1 ,0, 'e', 0);
  8001a4:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  8001a7:	e8 cd 18 00 00       	call   801a79 <sys_calculate_free_frames>
  8001ac:	29 c3                	sub    %eax,%ebx
  8001ae:	89 d8                	mov    %ebx,%eax
  8001b0:	83 ec 0c             	sub    $0xc,%esp
  8001b3:	6a 00                	push   $0x0
  8001b5:	6a 65                	push   $0x65
  8001b7:	6a 00                	push   $0x0
  8001b9:	6a 02                	push   $0x2
  8001bb:	50                   	push   %eax
  8001bc:	e8 0f 1c 00 00       	call   801dd0 <tst>
  8001c1:	83 c4 20             	add    $0x20,%esp

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8001c4:	e8 b0 18 00 00       	call   801a79 <sys_calculate_free_frames>
  8001c9:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8001cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001cf:	01 c0                	add    %eax,%eax
  8001d1:	83 ec 0c             	sub    $0xc,%esp
  8001d4:	50                   	push   %eax
  8001d5:	e8 4c 14 00 00       	call   801626 <malloc>
  8001da:	83 c4 10             	add    $0x10,%esp
  8001dd:	89 45 94             	mov    %eax,-0x6c(%ebp)
		tst((uint32) ptr_allocations[3], USER_HEAP_START+ 4*Mega+ 4*kilo,USER_HEAP_START + 4*Mega+ 4*kilo+ PAGE_SIZE, 'b', 0);
  8001e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001e3:	c1 e0 02             	shl    $0x2,%eax
  8001e6:	89 c2                	mov    %eax,%edx
  8001e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001eb:	c1 e0 02             	shl    $0x2,%eax
  8001ee:	01 d0                	add    %edx,%eax
  8001f0:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8001f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001f9:	c1 e0 02             	shl    $0x2,%eax
  8001fc:	89 c2                	mov    %eax,%edx
  8001fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800201:	c1 e0 02             	shl    $0x2,%eax
  800204:	01 d0                	add    %edx,%eax
  800206:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80020c:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80020f:	83 ec 0c             	sub    $0xc,%esp
  800212:	6a 00                	push   $0x0
  800214:	6a 62                	push   $0x62
  800216:	51                   	push   %ecx
  800217:	52                   	push   %edx
  800218:	50                   	push   %eax
  800219:	e8 b2 1b 00 00       	call   801dd0 <tst>
  80021e:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1 ,0, 'e', 0);
  800221:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  800224:	e8 50 18 00 00       	call   801a79 <sys_calculate_free_frames>
  800229:	29 c3                	sub    %eax,%ebx
  80022b:	89 d8                	mov    %ebx,%eax
  80022d:	83 ec 0c             	sub    $0xc,%esp
  800230:	6a 00                	push   $0x0
  800232:	6a 65                	push   $0x65
  800234:	6a 00                	push   $0x0
  800236:	6a 01                	push   $0x1
  800238:	50                   	push   %eax
  800239:	e8 92 1b 00 00       	call   801dd0 <tst>
  80023e:	83 c4 20             	add    $0x20,%esp

		//4 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  800241:	e8 33 18 00 00       	call   801a79 <sys_calculate_free_frames>
  800246:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[2]);
  800249:	8b 45 90             	mov    -0x70(%ebp),%eax
  80024c:	83 ec 0c             	sub    $0xc,%esp
  80024f:	50                   	push   %eax
  800250:	e8 e1 15 00 00       	call   801836 <free>
  800255:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 1,0, 'e', 0);
  800258:	e8 1c 18 00 00       	call   801a79 <sys_calculate_free_frames>
  80025d:	89 c2                	mov    %eax,%edx
  80025f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800262:	29 c2                	sub    %eax,%edx
  800264:	89 d0                	mov    %edx,%eax
  800266:	83 ec 0c             	sub    $0xc,%esp
  800269:	6a 00                	push   $0x0
  80026b:	6a 65                	push   $0x65
  80026d:	6a 00                	push   $0x0
  80026f:	6a 01                	push   $0x1
  800271:	50                   	push   %eax
  800272:	e8 59 1b 00 00       	call   801dd0 <tst>
  800277:	83 c4 20             	add    $0x20,%esp

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
  80027a:	e8 fa 17 00 00       	call   801a79 <sys_calculate_free_frames>
  80027f:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800282:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800285:	89 d0                	mov    %edx,%eax
  800287:	01 c0                	add    %eax,%eax
  800289:	01 d0                	add    %edx,%eax
  80028b:	01 c0                	add    %eax,%eax
  80028d:	01 d0                	add    %edx,%eax
  80028f:	83 ec 0c             	sub    $0xc,%esp
  800292:	50                   	push   %eax
  800293:	e8 8e 13 00 00       	call   801626 <malloc>
  800298:	83 c4 10             	add    $0x10,%esp
  80029b:	89 45 98             	mov    %eax,-0x68(%ebp)
		tst((uint32) ptr_allocations[4], USER_HEAP_START+ 4*Mega+ 8*kilo,USER_HEAP_START + 4*Mega+ 8*kilo+ PAGE_SIZE, 'b', 0);
  80029e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002a1:	c1 e0 02             	shl    $0x2,%eax
  8002a4:	89 c2                	mov    %eax,%edx
  8002a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002a9:	c1 e0 03             	shl    $0x3,%eax
  8002ac:	01 d0                	add    %edx,%eax
  8002ae:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8002b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002b7:	c1 e0 02             	shl    $0x2,%eax
  8002ba:	89 c2                	mov    %eax,%edx
  8002bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002bf:	c1 e0 03             	shl    $0x3,%eax
  8002c2:	01 d0                	add    %edx,%eax
  8002c4:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8002ca:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002cd:	83 ec 0c             	sub    $0xc,%esp
  8002d0:	6a 00                	push   $0x0
  8002d2:	6a 62                	push   $0x62
  8002d4:	51                   	push   %ecx
  8002d5:	52                   	push   %edx
  8002d6:	50                   	push   %eax
  8002d7:	e8 f4 1a 00 00       	call   801dd0 <tst>
  8002dc:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 2,0, 'e', 0);
  8002df:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  8002e2:	e8 92 17 00 00       	call   801a79 <sys_calculate_free_frames>
  8002e7:	29 c3                	sub    %eax,%ebx
  8002e9:	89 d8                	mov    %ebx,%eax
  8002eb:	83 ec 0c             	sub    $0xc,%esp
  8002ee:	6a 00                	push   $0x0
  8002f0:	6a 65                	push   $0x65
  8002f2:	6a 00                	push   $0x0
  8002f4:	6a 02                	push   $0x2
  8002f6:	50                   	push   %eax
  8002f7:	e8 d4 1a 00 00       	call   801dd0 <tst>
  8002fc:	83 c4 20             	add    $0x20,%esp

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8002ff:	e8 75 17 00 00       	call   801a79 <sys_calculate_free_frames>
  800304:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[0]);
  800307:	8b 45 88             	mov    -0x78(%ebp),%eax
  80030a:	83 ec 0c             	sub    $0xc,%esp
  80030d:	50                   	push   %eax
  80030e:	e8 23 15 00 00       	call   801836 <free>
  800313:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 512,0, 'e', 0);
  800316:	e8 5e 17 00 00       	call   801a79 <sys_calculate_free_frames>
  80031b:	89 c2                	mov    %eax,%edx
  80031d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800320:	29 c2                	sub    %eax,%edx
  800322:	89 d0                	mov    %edx,%eax
  800324:	83 ec 0c             	sub    $0xc,%esp
  800327:	6a 00                	push   $0x0
  800329:	6a 65                	push   $0x65
  80032b:	6a 00                	push   $0x0
  80032d:	68 00 02 00 00       	push   $0x200
  800332:	50                   	push   %eax
  800333:	e8 98 1a 00 00       	call   801dd0 <tst>
  800338:	83 c4 20             	add    $0x20,%esp

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  80033b:	e8 39 17 00 00       	call   801a79 <sys_calculate_free_frames>
  800340:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  800343:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800346:	89 c2                	mov    %eax,%edx
  800348:	01 d2                	add    %edx,%edx
  80034a:	01 d0                	add    %edx,%eax
  80034c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80034f:	83 ec 0c             	sub    $0xc,%esp
  800352:	50                   	push   %eax
  800353:	e8 ce 12 00 00       	call   801626 <malloc>
  800358:	83 c4 10             	add    $0x10,%esp
  80035b:	89 45 9c             	mov    %eax,-0x64(%ebp)
		tst((uint32) ptr_allocations[5], USER_HEAP_START+ 4*Mega+ 16*kilo,USER_HEAP_START + 4*Mega+ 16*kilo+ PAGE_SIZE, 'b', 0);
  80035e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800361:	c1 e0 02             	shl    $0x2,%eax
  800364:	89 c2                	mov    %eax,%edx
  800366:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800369:	c1 e0 04             	shl    $0x4,%eax
  80036c:	01 d0                	add    %edx,%eax
  80036e:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800374:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800377:	c1 e0 02             	shl    $0x2,%eax
  80037a:	89 c2                	mov    %eax,%edx
  80037c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80037f:	c1 e0 04             	shl    $0x4,%eax
  800382:	01 d0                	add    %edx,%eax
  800384:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80038a:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80038d:	83 ec 0c             	sub    $0xc,%esp
  800390:	6a 00                	push   $0x0
  800392:	6a 62                	push   $0x62
  800394:	51                   	push   %ecx
  800395:	52                   	push   %edx
  800396:	50                   	push   %eax
  800397:	e8 34 1a 00 00       	call   801dd0 <tst>
  80039c:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 3*Mega/4096 ,0, 'e', 0);
  80039f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003a2:	89 c2                	mov    %eax,%edx
  8003a4:	01 d2                	add    %edx,%edx
  8003a6:	01 d0                	add    %edx,%eax
  8003a8:	85 c0                	test   %eax,%eax
  8003aa:	79 05                	jns    8003b1 <_main+0x379>
  8003ac:	05 ff 0f 00 00       	add    $0xfff,%eax
  8003b1:	c1 f8 0c             	sar    $0xc,%eax
  8003b4:	89 c3                	mov    %eax,%ebx
  8003b6:	8b 75 dc             	mov    -0x24(%ebp),%esi
  8003b9:	e8 bb 16 00 00       	call   801a79 <sys_calculate_free_frames>
  8003be:	29 c6                	sub    %eax,%esi
  8003c0:	89 f0                	mov    %esi,%eax
  8003c2:	83 ec 0c             	sub    $0xc,%esp
  8003c5:	6a 00                	push   $0x0
  8003c7:	6a 65                	push   $0x65
  8003c9:	6a 00                	push   $0x0
  8003cb:	53                   	push   %ebx
  8003cc:	50                   	push   %eax
  8003cd:	e8 fe 19 00 00       	call   801dd0 <tst>
  8003d2:	83 c4 20             	add    $0x20,%esp

		//2 MB + 6 KB
		freeFrames = sys_calculate_free_frames() ;
  8003d5:	e8 9f 16 00 00       	call   801a79 <sys_calculate_free_frames>
  8003da:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[6] = malloc(2*Mega + 6*kilo);
  8003dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003e0:	89 c2                	mov    %eax,%edx
  8003e2:	01 d2                	add    %edx,%edx
  8003e4:	01 c2                	add    %eax,%edx
  8003e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003e9:	01 d0                	add    %edx,%eax
  8003eb:	01 c0                	add    %eax,%eax
  8003ed:	83 ec 0c             	sub    $0xc,%esp
  8003f0:	50                   	push   %eax
  8003f1:	e8 30 12 00 00       	call   801626 <malloc>
  8003f6:	83 c4 10             	add    $0x10,%esp
  8003f9:	89 45 a0             	mov    %eax,-0x60(%ebp)
		tst((uint32) ptr_allocations[6], USER_HEAP_START+ 7*Mega+ 16*kilo,USER_HEAP_START + 7*Mega+ 16*kilo+ PAGE_SIZE, 'b', 0);
  8003fc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8003ff:	89 d0                	mov    %edx,%eax
  800401:	01 c0                	add    %eax,%eax
  800403:	01 d0                	add    %edx,%eax
  800405:	01 c0                	add    %eax,%eax
  800407:	01 d0                	add    %edx,%eax
  800409:	89 c2                	mov    %eax,%edx
  80040b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80040e:	c1 e0 04             	shl    $0x4,%eax
  800411:	01 d0                	add    %edx,%eax
  800413:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800419:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80041c:	89 d0                	mov    %edx,%eax
  80041e:	01 c0                	add    %eax,%eax
  800420:	01 d0                	add    %edx,%eax
  800422:	01 c0                	add    %eax,%eax
  800424:	01 d0                	add    %edx,%eax
  800426:	89 c2                	mov    %eax,%edx
  800428:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80042b:	c1 e0 04             	shl    $0x4,%eax
  80042e:	01 d0                	add    %edx,%eax
  800430:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800436:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800439:	83 ec 0c             	sub    $0xc,%esp
  80043c:	6a 00                	push   $0x0
  80043e:	6a 62                	push   $0x62
  800440:	51                   	push   %ecx
  800441:	52                   	push   %edx
  800442:	50                   	push   %eax
  800443:	e8 88 19 00 00       	call   801dd0 <tst>
  800448:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 514+1 ,0, 'e', 0);
  80044b:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  80044e:	e8 26 16 00 00       	call   801a79 <sys_calculate_free_frames>
  800453:	29 c3                	sub    %eax,%ebx
  800455:	89 d8                	mov    %ebx,%eax
  800457:	83 ec 0c             	sub    $0xc,%esp
  80045a:	6a 00                	push   $0x0
  80045c:	6a 65                	push   $0x65
  80045e:	6a 00                	push   $0x0
  800460:	68 03 02 00 00       	push   $0x203
  800465:	50                   	push   %eax
  800466:	e8 65 19 00 00       	call   801dd0 <tst>
  80046b:	83 c4 20             	add    $0x20,%esp

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80046e:	e8 06 16 00 00       	call   801a79 <sys_calculate_free_frames>
  800473:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[5]);
  800476:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800479:	83 ec 0c             	sub    $0xc,%esp
  80047c:	50                   	push   %eax
  80047d:	e8 b4 13 00 00       	call   801836 <free>
  800482:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 768,0, 'e', 0);
  800485:	e8 ef 15 00 00       	call   801a79 <sys_calculate_free_frames>
  80048a:	89 c2                	mov    %eax,%edx
  80048c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80048f:	29 c2                	sub    %eax,%edx
  800491:	89 d0                	mov    %edx,%eax
  800493:	83 ec 0c             	sub    $0xc,%esp
  800496:	6a 00                	push   $0x0
  800498:	6a 65                	push   $0x65
  80049a:	6a 00                	push   $0x0
  80049c:	68 00 03 00 00       	push   $0x300
  8004a1:	50                   	push   %eax
  8004a2:	e8 29 19 00 00       	call   801dd0 <tst>
  8004a7:	83 c4 20             	add    $0x20,%esp

		//5 MB
		freeFrames = sys_calculate_free_frames() ;
  8004aa:	e8 ca 15 00 00       	call   801a79 <sys_calculate_free_frames>
  8004af:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[7] = malloc(5*Mega-kilo);
  8004b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8004b5:	89 d0                	mov    %edx,%eax
  8004b7:	c1 e0 02             	shl    $0x2,%eax
  8004ba:	01 d0                	add    %edx,%eax
  8004bc:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004bf:	83 ec 0c             	sub    $0xc,%esp
  8004c2:	50                   	push   %eax
  8004c3:	e8 5e 11 00 00       	call   801626 <malloc>
  8004c8:	83 c4 10             	add    $0x10,%esp
  8004cb:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		tst((uint32) ptr_allocations[7], USER_HEAP_START+ 9*Mega+ 24*kilo,USER_HEAP_START + 9*Mega+ 24*kilo+ PAGE_SIZE, 'b', 0);
  8004ce:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8004d1:	89 d0                	mov    %edx,%eax
  8004d3:	c1 e0 03             	shl    $0x3,%eax
  8004d6:	01 d0                	add    %edx,%eax
  8004d8:	89 c1                	mov    %eax,%ecx
  8004da:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004dd:	89 d0                	mov    %edx,%eax
  8004df:	01 c0                	add    %eax,%eax
  8004e1:	01 d0                	add    %edx,%eax
  8004e3:	c1 e0 03             	shl    $0x3,%eax
  8004e6:	01 c8                	add    %ecx,%eax
  8004e8:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8004ee:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8004f1:	89 d0                	mov    %edx,%eax
  8004f3:	c1 e0 03             	shl    $0x3,%eax
  8004f6:	01 d0                	add    %edx,%eax
  8004f8:	89 c3                	mov    %eax,%ebx
  8004fa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004fd:	89 d0                	mov    %edx,%eax
  8004ff:	01 c0                	add    %eax,%eax
  800501:	01 d0                	add    %edx,%eax
  800503:	c1 e0 03             	shl    $0x3,%eax
  800506:	01 d8                	add    %ebx,%eax
  800508:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80050e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800511:	83 ec 0c             	sub    $0xc,%esp
  800514:	6a 00                	push   $0x0
  800516:	6a 62                	push   $0x62
  800518:	51                   	push   %ecx
  800519:	52                   	push   %edx
  80051a:	50                   	push   %eax
  80051b:	e8 b0 18 00 00       	call   801dd0 <tst>
  800520:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 5*Mega/4096 + 1,0, 'e', 0);
  800523:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800526:	89 d0                	mov    %edx,%eax
  800528:	c1 e0 02             	shl    $0x2,%eax
  80052b:	01 d0                	add    %edx,%eax
  80052d:	85 c0                	test   %eax,%eax
  80052f:	79 05                	jns    800536 <_main+0x4fe>
  800531:	05 ff 0f 00 00       	add    $0xfff,%eax
  800536:	c1 f8 0c             	sar    $0xc,%eax
  800539:	40                   	inc    %eax
  80053a:	89 c3                	mov    %eax,%ebx
  80053c:	8b 75 dc             	mov    -0x24(%ebp),%esi
  80053f:	e8 35 15 00 00       	call   801a79 <sys_calculate_free_frames>
  800544:	29 c6                	sub    %eax,%esi
  800546:	89 f0                	mov    %esi,%eax
  800548:	83 ec 0c             	sub    $0xc,%esp
  80054b:	6a 00                	push   $0x0
  80054d:	6a 65                	push   $0x65
  80054f:	6a 00                	push   $0x0
  800551:	53                   	push   %ebx
  800552:	50                   	push   %eax
  800553:	e8 78 18 00 00       	call   801dd0 <tst>
  800558:	83 c4 20             	add    $0x20,%esp

		//2 MB + 8 KB Hole
		freeFrames = sys_calculate_free_frames() ;
  80055b:	e8 19 15 00 00       	call   801a79 <sys_calculate_free_frames>
  800560:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[6]);
  800563:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800566:	83 ec 0c             	sub    $0xc,%esp
  800569:	50                   	push   %eax
  80056a:	e8 c7 12 00 00       	call   801836 <free>
  80056f:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 514,0, 'e', 0);
  800572:	e8 02 15 00 00       	call   801a79 <sys_calculate_free_frames>
  800577:	89 c2                	mov    %eax,%edx
  800579:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80057c:	29 c2                	sub    %eax,%edx
  80057e:	89 d0                	mov    %edx,%eax
  800580:	83 ec 0c             	sub    $0xc,%esp
  800583:	6a 00                	push   $0x0
  800585:	6a 65                	push   $0x65
  800587:	6a 00                	push   $0x0
  800589:	68 02 02 00 00       	push   $0x202
  80058e:	50                   	push   %eax
  80058f:	e8 3c 18 00 00       	call   801dd0 <tst>
  800594:	83 c4 20             	add    $0x20,%esp

		//4 MB
		freeFrames = sys_calculate_free_frames() ;
  800597:	e8 dd 14 00 00       	call   801a79 <sys_calculate_free_frames>
  80059c:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[8] = malloc(4*Mega-kilo);
  80059f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005a2:	c1 e0 02             	shl    $0x2,%eax
  8005a5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8005a8:	83 ec 0c             	sub    $0xc,%esp
  8005ab:	50                   	push   %eax
  8005ac:	e8 75 10 00 00       	call   801626 <malloc>
  8005b1:	83 c4 10             	add    $0x10,%esp
  8005b4:	89 45 a8             	mov    %eax,-0x58(%ebp)
		tst((uint32) ptr_allocations[8], USER_HEAP_START+ 4*Mega+ 16*kilo,USER_HEAP_START + 4*Mega+ 16*kilo+ PAGE_SIZE, 'b', 0);
  8005b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005ba:	c1 e0 02             	shl    $0x2,%eax
  8005bd:	89 c2                	mov    %eax,%edx
  8005bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005c2:	c1 e0 04             	shl    $0x4,%eax
  8005c5:	01 d0                	add    %edx,%eax
  8005c7:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8005cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005d0:	c1 e0 02             	shl    $0x2,%eax
  8005d3:	89 c2                	mov    %eax,%edx
  8005d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005d8:	c1 e0 04             	shl    $0x4,%eax
  8005db:	01 d0                	add    %edx,%eax
  8005dd:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8005e3:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8005e6:	83 ec 0c             	sub    $0xc,%esp
  8005e9:	6a 00                	push   $0x0
  8005eb:	6a 62                	push   $0x62
  8005ed:	51                   	push   %ecx
  8005ee:	52                   	push   %edx
  8005ef:	50                   	push   %eax
  8005f0:	e8 db 17 00 00       	call   801dd0 <tst>
  8005f5:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 4*Mega/4096,0, 'e', 0);
  8005f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005fb:	c1 e0 02             	shl    $0x2,%eax
  8005fe:	85 c0                	test   %eax,%eax
  800600:	79 05                	jns    800607 <_main+0x5cf>
  800602:	05 ff 0f 00 00       	add    $0xfff,%eax
  800607:	c1 f8 0c             	sar    $0xc,%eax
  80060a:	89 c3                	mov    %eax,%ebx
  80060c:	8b 75 dc             	mov    -0x24(%ebp),%esi
  80060f:	e8 65 14 00 00       	call   801a79 <sys_calculate_free_frames>
  800614:	29 c6                	sub    %eax,%esi
  800616:	89 f0                	mov    %esi,%eax
  800618:	83 ec 0c             	sub    $0xc,%esp
  80061b:	6a 00                	push   $0x0
  80061d:	6a 65                	push   $0x65
  80061f:	6a 00                	push   $0x0
  800621:	53                   	push   %ebx
  800622:	50                   	push   %eax
  800623:	e8 a8 17 00 00       	call   801dd0 <tst>
  800628:	83 c4 20             	add    $0x20,%esp
	}

	//	b) Attempt to allocate large segment with no suitable fragment to fit on
	{
		//Large Allocation
		int freeFrames = sys_calculate_free_frames() ;
  80062b:	e8 49 14 00 00       	call   801a79 <sys_calculate_free_frames>
  800630:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[9] = malloc((USER_HEAP_MAX - USER_HEAP_START + 14*Mega));
  800633:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800636:	89 d0                	mov    %edx,%eax
  800638:	01 c0                	add    %eax,%eax
  80063a:	01 d0                	add    %edx,%eax
  80063c:	01 c0                	add    %eax,%eax
  80063e:	01 d0                	add    %edx,%eax
  800640:	01 c0                	add    %eax,%eax
  800642:	05 00 00 00 20       	add    $0x20000000,%eax
  800647:	83 ec 0c             	sub    $0xc,%esp
  80064a:	50                   	push   %eax
  80064b:	e8 d6 0f 00 00       	call   801626 <malloc>
  800650:	83 c4 10             	add    $0x10,%esp
  800653:	89 45 ac             	mov    %eax,-0x54(%ebp)
		tst((uint32) ptr_allocations[9], 0,0, 'b', 0);
  800656:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800659:	83 ec 0c             	sub    $0xc,%esp
  80065c:	6a 00                	push   $0x0
  80065e:	6a 62                	push   $0x62
  800660:	6a 00                	push   $0x0
  800662:	6a 00                	push   $0x0
  800664:	50                   	push   %eax
  800665:	e8 66 17 00 00       	call   801dd0 <tst>
  80066a:	83 c4 20             	add    $0x20,%esp

		chktst(24);
  80066d:	83 ec 0c             	sub    $0xc,%esp
  800670:	6a 18                	push   $0x18
  800672:	e8 84 17 00 00       	call   801dfb <chktst>
  800677:	83 c4 10             	add    $0x10,%esp

		return;
  80067a:	90                   	nop
	}
}
  80067b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80067e:	5b                   	pop    %ebx
  80067f:	5e                   	pop    %esi
  800680:	5f                   	pop    %edi
  800681:	5d                   	pop    %ebp
  800682:	c3                   	ret    

00800683 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800683:	55                   	push   %ebp
  800684:	89 e5                	mov    %esp,%ebp
  800686:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800689:	e8 20 13 00 00       	call   8019ae <sys_getenvindex>
  80068e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800691:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800694:	89 d0                	mov    %edx,%eax
  800696:	c1 e0 03             	shl    $0x3,%eax
  800699:	01 d0                	add    %edx,%eax
  80069b:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8006a2:	01 c8                	add    %ecx,%eax
  8006a4:	01 c0                	add    %eax,%eax
  8006a6:	01 d0                	add    %edx,%eax
  8006a8:	01 c0                	add    %eax,%eax
  8006aa:	01 d0                	add    %edx,%eax
  8006ac:	89 c2                	mov    %eax,%edx
  8006ae:	c1 e2 05             	shl    $0x5,%edx
  8006b1:	29 c2                	sub    %eax,%edx
  8006b3:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8006ba:	89 c2                	mov    %eax,%edx
  8006bc:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8006c2:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8006cc:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8006d2:	84 c0                	test   %al,%al
  8006d4:	74 0f                	je     8006e5 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8006d6:	a1 20 30 80 00       	mov    0x803020,%eax
  8006db:	05 40 3c 01 00       	add    $0x13c40,%eax
  8006e0:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006e5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006e9:	7e 0a                	jle    8006f5 <libmain+0x72>
		binaryname = argv[0];
  8006eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ee:	8b 00                	mov    (%eax),%eax
  8006f0:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006f5:	83 ec 08             	sub    $0x8,%esp
  8006f8:	ff 75 0c             	pushl  0xc(%ebp)
  8006fb:	ff 75 08             	pushl  0x8(%ebp)
  8006fe:	e8 35 f9 ff ff       	call   800038 <_main>
  800703:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800706:	e8 3e 14 00 00       	call   801b49 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80070b:	83 ec 0c             	sub    $0xc,%esp
  80070e:	68 b8 23 80 00       	push   $0x8023b8
  800713:	e8 84 01 00 00       	call   80089c <cprintf>
  800718:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80071b:	a1 20 30 80 00       	mov    0x803020,%eax
  800720:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800726:	a1 20 30 80 00       	mov    0x803020,%eax
  80072b:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800731:	83 ec 04             	sub    $0x4,%esp
  800734:	52                   	push   %edx
  800735:	50                   	push   %eax
  800736:	68 e0 23 80 00       	push   $0x8023e0
  80073b:	e8 5c 01 00 00       	call   80089c <cprintf>
  800740:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800743:	a1 20 30 80 00       	mov    0x803020,%eax
  800748:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80074e:	a1 20 30 80 00       	mov    0x803020,%eax
  800753:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800759:	83 ec 04             	sub    $0x4,%esp
  80075c:	52                   	push   %edx
  80075d:	50                   	push   %eax
  80075e:	68 08 24 80 00       	push   $0x802408
  800763:	e8 34 01 00 00       	call   80089c <cprintf>
  800768:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80076b:	a1 20 30 80 00       	mov    0x803020,%eax
  800770:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800776:	83 ec 08             	sub    $0x8,%esp
  800779:	50                   	push   %eax
  80077a:	68 49 24 80 00       	push   $0x802449
  80077f:	e8 18 01 00 00       	call   80089c <cprintf>
  800784:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800787:	83 ec 0c             	sub    $0xc,%esp
  80078a:	68 b8 23 80 00       	push   $0x8023b8
  80078f:	e8 08 01 00 00       	call   80089c <cprintf>
  800794:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800797:	e8 c7 13 00 00       	call   801b63 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80079c:	e8 19 00 00 00       	call   8007ba <exit>
}
  8007a1:	90                   	nop
  8007a2:	c9                   	leave  
  8007a3:	c3                   	ret    

008007a4 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007a4:	55                   	push   %ebp
  8007a5:	89 e5                	mov    %esp,%ebp
  8007a7:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007aa:	83 ec 0c             	sub    $0xc,%esp
  8007ad:	6a 00                	push   $0x0
  8007af:	e8 c6 11 00 00       	call   80197a <sys_env_destroy>
  8007b4:	83 c4 10             	add    $0x10,%esp
}
  8007b7:	90                   	nop
  8007b8:	c9                   	leave  
  8007b9:	c3                   	ret    

008007ba <exit>:

void
exit(void)
{
  8007ba:	55                   	push   %ebp
  8007bb:	89 e5                	mov    %esp,%ebp
  8007bd:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007c0:	e8 1b 12 00 00       	call   8019e0 <sys_env_exit>
}
  8007c5:	90                   	nop
  8007c6:	c9                   	leave  
  8007c7:	c3                   	ret    

008007c8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8007c8:	55                   	push   %ebp
  8007c9:	89 e5                	mov    %esp,%ebp
  8007cb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8007ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007d1:	8b 00                	mov    (%eax),%eax
  8007d3:	8d 48 01             	lea    0x1(%eax),%ecx
  8007d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007d9:	89 0a                	mov    %ecx,(%edx)
  8007db:	8b 55 08             	mov    0x8(%ebp),%edx
  8007de:	88 d1                	mov    %dl,%cl
  8007e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007e3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8007e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007ea:	8b 00                	mov    (%eax),%eax
  8007ec:	3d ff 00 00 00       	cmp    $0xff,%eax
  8007f1:	75 2c                	jne    80081f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8007f3:	a0 24 30 80 00       	mov    0x803024,%al
  8007f8:	0f b6 c0             	movzbl %al,%eax
  8007fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007fe:	8b 12                	mov    (%edx),%edx
  800800:	89 d1                	mov    %edx,%ecx
  800802:	8b 55 0c             	mov    0xc(%ebp),%edx
  800805:	83 c2 08             	add    $0x8,%edx
  800808:	83 ec 04             	sub    $0x4,%esp
  80080b:	50                   	push   %eax
  80080c:	51                   	push   %ecx
  80080d:	52                   	push   %edx
  80080e:	e8 25 11 00 00       	call   801938 <sys_cputs>
  800813:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800816:	8b 45 0c             	mov    0xc(%ebp),%eax
  800819:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80081f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800822:	8b 40 04             	mov    0x4(%eax),%eax
  800825:	8d 50 01             	lea    0x1(%eax),%edx
  800828:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80082e:	90                   	nop
  80082f:	c9                   	leave  
  800830:	c3                   	ret    

00800831 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800831:	55                   	push   %ebp
  800832:	89 e5                	mov    %esp,%ebp
  800834:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80083a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800841:	00 00 00 
	b.cnt = 0;
  800844:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80084b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80084e:	ff 75 0c             	pushl  0xc(%ebp)
  800851:	ff 75 08             	pushl  0x8(%ebp)
  800854:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80085a:	50                   	push   %eax
  80085b:	68 c8 07 80 00       	push   $0x8007c8
  800860:	e8 11 02 00 00       	call   800a76 <vprintfmt>
  800865:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800868:	a0 24 30 80 00       	mov    0x803024,%al
  80086d:	0f b6 c0             	movzbl %al,%eax
  800870:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800876:	83 ec 04             	sub    $0x4,%esp
  800879:	50                   	push   %eax
  80087a:	52                   	push   %edx
  80087b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800881:	83 c0 08             	add    $0x8,%eax
  800884:	50                   	push   %eax
  800885:	e8 ae 10 00 00       	call   801938 <sys_cputs>
  80088a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80088d:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800894:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80089a:	c9                   	leave  
  80089b:	c3                   	ret    

0080089c <cprintf>:

int cprintf(const char *fmt, ...) {
  80089c:	55                   	push   %ebp
  80089d:	89 e5                	mov    %esp,%ebp
  80089f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8008a2:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8008a9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8008ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8008af:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b2:	83 ec 08             	sub    $0x8,%esp
  8008b5:	ff 75 f4             	pushl  -0xc(%ebp)
  8008b8:	50                   	push   %eax
  8008b9:	e8 73 ff ff ff       	call   800831 <vcprintf>
  8008be:	83 c4 10             	add    $0x10,%esp
  8008c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8008c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008c7:	c9                   	leave  
  8008c8:	c3                   	ret    

008008c9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8008c9:	55                   	push   %ebp
  8008ca:	89 e5                	mov    %esp,%ebp
  8008cc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8008cf:	e8 75 12 00 00       	call   801b49 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8008d4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8008d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8008da:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dd:	83 ec 08             	sub    $0x8,%esp
  8008e0:	ff 75 f4             	pushl  -0xc(%ebp)
  8008e3:	50                   	push   %eax
  8008e4:	e8 48 ff ff ff       	call   800831 <vcprintf>
  8008e9:	83 c4 10             	add    $0x10,%esp
  8008ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8008ef:	e8 6f 12 00 00       	call   801b63 <sys_enable_interrupt>
	return cnt;
  8008f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008f7:	c9                   	leave  
  8008f8:	c3                   	ret    

008008f9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8008f9:	55                   	push   %ebp
  8008fa:	89 e5                	mov    %esp,%ebp
  8008fc:	53                   	push   %ebx
  8008fd:	83 ec 14             	sub    $0x14,%esp
  800900:	8b 45 10             	mov    0x10(%ebp),%eax
  800903:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800906:	8b 45 14             	mov    0x14(%ebp),%eax
  800909:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80090c:	8b 45 18             	mov    0x18(%ebp),%eax
  80090f:	ba 00 00 00 00       	mov    $0x0,%edx
  800914:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800917:	77 55                	ja     80096e <printnum+0x75>
  800919:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80091c:	72 05                	jb     800923 <printnum+0x2a>
  80091e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800921:	77 4b                	ja     80096e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800923:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800926:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800929:	8b 45 18             	mov    0x18(%ebp),%eax
  80092c:	ba 00 00 00 00       	mov    $0x0,%edx
  800931:	52                   	push   %edx
  800932:	50                   	push   %eax
  800933:	ff 75 f4             	pushl  -0xc(%ebp)
  800936:	ff 75 f0             	pushl  -0x10(%ebp)
  800939:	e8 fa 17 00 00       	call   802138 <__udivdi3>
  80093e:	83 c4 10             	add    $0x10,%esp
  800941:	83 ec 04             	sub    $0x4,%esp
  800944:	ff 75 20             	pushl  0x20(%ebp)
  800947:	53                   	push   %ebx
  800948:	ff 75 18             	pushl  0x18(%ebp)
  80094b:	52                   	push   %edx
  80094c:	50                   	push   %eax
  80094d:	ff 75 0c             	pushl  0xc(%ebp)
  800950:	ff 75 08             	pushl  0x8(%ebp)
  800953:	e8 a1 ff ff ff       	call   8008f9 <printnum>
  800958:	83 c4 20             	add    $0x20,%esp
  80095b:	eb 1a                	jmp    800977 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80095d:	83 ec 08             	sub    $0x8,%esp
  800960:	ff 75 0c             	pushl  0xc(%ebp)
  800963:	ff 75 20             	pushl  0x20(%ebp)
  800966:	8b 45 08             	mov    0x8(%ebp),%eax
  800969:	ff d0                	call   *%eax
  80096b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80096e:	ff 4d 1c             	decl   0x1c(%ebp)
  800971:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800975:	7f e6                	jg     80095d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800977:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80097a:	bb 00 00 00 00       	mov    $0x0,%ebx
  80097f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800982:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800985:	53                   	push   %ebx
  800986:	51                   	push   %ecx
  800987:	52                   	push   %edx
  800988:	50                   	push   %eax
  800989:	e8 ba 18 00 00       	call   802248 <__umoddi3>
  80098e:	83 c4 10             	add    $0x10,%esp
  800991:	05 74 26 80 00       	add    $0x802674,%eax
  800996:	8a 00                	mov    (%eax),%al
  800998:	0f be c0             	movsbl %al,%eax
  80099b:	83 ec 08             	sub    $0x8,%esp
  80099e:	ff 75 0c             	pushl  0xc(%ebp)
  8009a1:	50                   	push   %eax
  8009a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a5:	ff d0                	call   *%eax
  8009a7:	83 c4 10             	add    $0x10,%esp
}
  8009aa:	90                   	nop
  8009ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8009ae:	c9                   	leave  
  8009af:	c3                   	ret    

008009b0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8009b0:	55                   	push   %ebp
  8009b1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8009b3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8009b7:	7e 1c                	jle    8009d5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8009b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bc:	8b 00                	mov    (%eax),%eax
  8009be:	8d 50 08             	lea    0x8(%eax),%edx
  8009c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c4:	89 10                	mov    %edx,(%eax)
  8009c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c9:	8b 00                	mov    (%eax),%eax
  8009cb:	83 e8 08             	sub    $0x8,%eax
  8009ce:	8b 50 04             	mov    0x4(%eax),%edx
  8009d1:	8b 00                	mov    (%eax),%eax
  8009d3:	eb 40                	jmp    800a15 <getuint+0x65>
	else if (lflag)
  8009d5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009d9:	74 1e                	je     8009f9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8009db:	8b 45 08             	mov    0x8(%ebp),%eax
  8009de:	8b 00                	mov    (%eax),%eax
  8009e0:	8d 50 04             	lea    0x4(%eax),%edx
  8009e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e6:	89 10                	mov    %edx,(%eax)
  8009e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009eb:	8b 00                	mov    (%eax),%eax
  8009ed:	83 e8 04             	sub    $0x4,%eax
  8009f0:	8b 00                	mov    (%eax),%eax
  8009f2:	ba 00 00 00 00       	mov    $0x0,%edx
  8009f7:	eb 1c                	jmp    800a15 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8009f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fc:	8b 00                	mov    (%eax),%eax
  8009fe:	8d 50 04             	lea    0x4(%eax),%edx
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	89 10                	mov    %edx,(%eax)
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	8b 00                	mov    (%eax),%eax
  800a0b:	83 e8 04             	sub    $0x4,%eax
  800a0e:	8b 00                	mov    (%eax),%eax
  800a10:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800a15:	5d                   	pop    %ebp
  800a16:	c3                   	ret    

00800a17 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800a17:	55                   	push   %ebp
  800a18:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a1a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a1e:	7e 1c                	jle    800a3c <getint+0x25>
		return va_arg(*ap, long long);
  800a20:	8b 45 08             	mov    0x8(%ebp),%eax
  800a23:	8b 00                	mov    (%eax),%eax
  800a25:	8d 50 08             	lea    0x8(%eax),%edx
  800a28:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2b:	89 10                	mov    %edx,(%eax)
  800a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a30:	8b 00                	mov    (%eax),%eax
  800a32:	83 e8 08             	sub    $0x8,%eax
  800a35:	8b 50 04             	mov    0x4(%eax),%edx
  800a38:	8b 00                	mov    (%eax),%eax
  800a3a:	eb 38                	jmp    800a74 <getint+0x5d>
	else if (lflag)
  800a3c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a40:	74 1a                	je     800a5c <getint+0x45>
		return va_arg(*ap, long);
  800a42:	8b 45 08             	mov    0x8(%ebp),%eax
  800a45:	8b 00                	mov    (%eax),%eax
  800a47:	8d 50 04             	lea    0x4(%eax),%edx
  800a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4d:	89 10                	mov    %edx,(%eax)
  800a4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a52:	8b 00                	mov    (%eax),%eax
  800a54:	83 e8 04             	sub    $0x4,%eax
  800a57:	8b 00                	mov    (%eax),%eax
  800a59:	99                   	cltd   
  800a5a:	eb 18                	jmp    800a74 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5f:	8b 00                	mov    (%eax),%eax
  800a61:	8d 50 04             	lea    0x4(%eax),%edx
  800a64:	8b 45 08             	mov    0x8(%ebp),%eax
  800a67:	89 10                	mov    %edx,(%eax)
  800a69:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6c:	8b 00                	mov    (%eax),%eax
  800a6e:	83 e8 04             	sub    $0x4,%eax
  800a71:	8b 00                	mov    (%eax),%eax
  800a73:	99                   	cltd   
}
  800a74:	5d                   	pop    %ebp
  800a75:	c3                   	ret    

00800a76 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800a76:	55                   	push   %ebp
  800a77:	89 e5                	mov    %esp,%ebp
  800a79:	56                   	push   %esi
  800a7a:	53                   	push   %ebx
  800a7b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a7e:	eb 17                	jmp    800a97 <vprintfmt+0x21>
			if (ch == '\0')
  800a80:	85 db                	test   %ebx,%ebx
  800a82:	0f 84 af 03 00 00    	je     800e37 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800a88:	83 ec 08             	sub    $0x8,%esp
  800a8b:	ff 75 0c             	pushl  0xc(%ebp)
  800a8e:	53                   	push   %ebx
  800a8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a92:	ff d0                	call   *%eax
  800a94:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a97:	8b 45 10             	mov    0x10(%ebp),%eax
  800a9a:	8d 50 01             	lea    0x1(%eax),%edx
  800a9d:	89 55 10             	mov    %edx,0x10(%ebp)
  800aa0:	8a 00                	mov    (%eax),%al
  800aa2:	0f b6 d8             	movzbl %al,%ebx
  800aa5:	83 fb 25             	cmp    $0x25,%ebx
  800aa8:	75 d6                	jne    800a80 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800aaa:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800aae:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ab5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800abc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ac3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800aca:	8b 45 10             	mov    0x10(%ebp),%eax
  800acd:	8d 50 01             	lea    0x1(%eax),%edx
  800ad0:	89 55 10             	mov    %edx,0x10(%ebp)
  800ad3:	8a 00                	mov    (%eax),%al
  800ad5:	0f b6 d8             	movzbl %al,%ebx
  800ad8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800adb:	83 f8 55             	cmp    $0x55,%eax
  800ade:	0f 87 2b 03 00 00    	ja     800e0f <vprintfmt+0x399>
  800ae4:	8b 04 85 98 26 80 00 	mov    0x802698(,%eax,4),%eax
  800aeb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800aed:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800af1:	eb d7                	jmp    800aca <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800af3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800af7:	eb d1                	jmp    800aca <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800af9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800b00:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b03:	89 d0                	mov    %edx,%eax
  800b05:	c1 e0 02             	shl    $0x2,%eax
  800b08:	01 d0                	add    %edx,%eax
  800b0a:	01 c0                	add    %eax,%eax
  800b0c:	01 d8                	add    %ebx,%eax
  800b0e:	83 e8 30             	sub    $0x30,%eax
  800b11:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800b14:	8b 45 10             	mov    0x10(%ebp),%eax
  800b17:	8a 00                	mov    (%eax),%al
  800b19:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800b1c:	83 fb 2f             	cmp    $0x2f,%ebx
  800b1f:	7e 3e                	jle    800b5f <vprintfmt+0xe9>
  800b21:	83 fb 39             	cmp    $0x39,%ebx
  800b24:	7f 39                	jg     800b5f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800b26:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800b29:	eb d5                	jmp    800b00 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800b2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800b2e:	83 c0 04             	add    $0x4,%eax
  800b31:	89 45 14             	mov    %eax,0x14(%ebp)
  800b34:	8b 45 14             	mov    0x14(%ebp),%eax
  800b37:	83 e8 04             	sub    $0x4,%eax
  800b3a:	8b 00                	mov    (%eax),%eax
  800b3c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800b3f:	eb 1f                	jmp    800b60 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800b41:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b45:	79 83                	jns    800aca <vprintfmt+0x54>
				width = 0;
  800b47:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800b4e:	e9 77 ff ff ff       	jmp    800aca <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800b53:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800b5a:	e9 6b ff ff ff       	jmp    800aca <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800b5f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800b60:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b64:	0f 89 60 ff ff ff    	jns    800aca <vprintfmt+0x54>
				width = precision, precision = -1;
  800b6a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800b70:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800b77:	e9 4e ff ff ff       	jmp    800aca <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800b7c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800b7f:	e9 46 ff ff ff       	jmp    800aca <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800b84:	8b 45 14             	mov    0x14(%ebp),%eax
  800b87:	83 c0 04             	add    $0x4,%eax
  800b8a:	89 45 14             	mov    %eax,0x14(%ebp)
  800b8d:	8b 45 14             	mov    0x14(%ebp),%eax
  800b90:	83 e8 04             	sub    $0x4,%eax
  800b93:	8b 00                	mov    (%eax),%eax
  800b95:	83 ec 08             	sub    $0x8,%esp
  800b98:	ff 75 0c             	pushl  0xc(%ebp)
  800b9b:	50                   	push   %eax
  800b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9f:	ff d0                	call   *%eax
  800ba1:	83 c4 10             	add    $0x10,%esp
			break;
  800ba4:	e9 89 02 00 00       	jmp    800e32 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ba9:	8b 45 14             	mov    0x14(%ebp),%eax
  800bac:	83 c0 04             	add    $0x4,%eax
  800baf:	89 45 14             	mov    %eax,0x14(%ebp)
  800bb2:	8b 45 14             	mov    0x14(%ebp),%eax
  800bb5:	83 e8 04             	sub    $0x4,%eax
  800bb8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800bba:	85 db                	test   %ebx,%ebx
  800bbc:	79 02                	jns    800bc0 <vprintfmt+0x14a>
				err = -err;
  800bbe:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800bc0:	83 fb 64             	cmp    $0x64,%ebx
  800bc3:	7f 0b                	jg     800bd0 <vprintfmt+0x15a>
  800bc5:	8b 34 9d e0 24 80 00 	mov    0x8024e0(,%ebx,4),%esi
  800bcc:	85 f6                	test   %esi,%esi
  800bce:	75 19                	jne    800be9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800bd0:	53                   	push   %ebx
  800bd1:	68 85 26 80 00       	push   $0x802685
  800bd6:	ff 75 0c             	pushl  0xc(%ebp)
  800bd9:	ff 75 08             	pushl  0x8(%ebp)
  800bdc:	e8 5e 02 00 00       	call   800e3f <printfmt>
  800be1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800be4:	e9 49 02 00 00       	jmp    800e32 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800be9:	56                   	push   %esi
  800bea:	68 8e 26 80 00       	push   $0x80268e
  800bef:	ff 75 0c             	pushl  0xc(%ebp)
  800bf2:	ff 75 08             	pushl  0x8(%ebp)
  800bf5:	e8 45 02 00 00       	call   800e3f <printfmt>
  800bfa:	83 c4 10             	add    $0x10,%esp
			break;
  800bfd:	e9 30 02 00 00       	jmp    800e32 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800c02:	8b 45 14             	mov    0x14(%ebp),%eax
  800c05:	83 c0 04             	add    $0x4,%eax
  800c08:	89 45 14             	mov    %eax,0x14(%ebp)
  800c0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c0e:	83 e8 04             	sub    $0x4,%eax
  800c11:	8b 30                	mov    (%eax),%esi
  800c13:	85 f6                	test   %esi,%esi
  800c15:	75 05                	jne    800c1c <vprintfmt+0x1a6>
				p = "(null)";
  800c17:	be 91 26 80 00       	mov    $0x802691,%esi
			if (width > 0 && padc != '-')
  800c1c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c20:	7e 6d                	jle    800c8f <vprintfmt+0x219>
  800c22:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800c26:	74 67                	je     800c8f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800c28:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c2b:	83 ec 08             	sub    $0x8,%esp
  800c2e:	50                   	push   %eax
  800c2f:	56                   	push   %esi
  800c30:	e8 0c 03 00 00       	call   800f41 <strnlen>
  800c35:	83 c4 10             	add    $0x10,%esp
  800c38:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800c3b:	eb 16                	jmp    800c53 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800c3d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800c41:	83 ec 08             	sub    $0x8,%esp
  800c44:	ff 75 0c             	pushl  0xc(%ebp)
  800c47:	50                   	push   %eax
  800c48:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4b:	ff d0                	call   *%eax
  800c4d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800c50:	ff 4d e4             	decl   -0x1c(%ebp)
  800c53:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c57:	7f e4                	jg     800c3d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c59:	eb 34                	jmp    800c8f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800c5b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800c5f:	74 1c                	je     800c7d <vprintfmt+0x207>
  800c61:	83 fb 1f             	cmp    $0x1f,%ebx
  800c64:	7e 05                	jle    800c6b <vprintfmt+0x1f5>
  800c66:	83 fb 7e             	cmp    $0x7e,%ebx
  800c69:	7e 12                	jle    800c7d <vprintfmt+0x207>
					putch('?', putdat);
  800c6b:	83 ec 08             	sub    $0x8,%esp
  800c6e:	ff 75 0c             	pushl  0xc(%ebp)
  800c71:	6a 3f                	push   $0x3f
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	ff d0                	call   *%eax
  800c78:	83 c4 10             	add    $0x10,%esp
  800c7b:	eb 0f                	jmp    800c8c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800c7d:	83 ec 08             	sub    $0x8,%esp
  800c80:	ff 75 0c             	pushl  0xc(%ebp)
  800c83:	53                   	push   %ebx
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	ff d0                	call   *%eax
  800c89:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c8c:	ff 4d e4             	decl   -0x1c(%ebp)
  800c8f:	89 f0                	mov    %esi,%eax
  800c91:	8d 70 01             	lea    0x1(%eax),%esi
  800c94:	8a 00                	mov    (%eax),%al
  800c96:	0f be d8             	movsbl %al,%ebx
  800c99:	85 db                	test   %ebx,%ebx
  800c9b:	74 24                	je     800cc1 <vprintfmt+0x24b>
  800c9d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ca1:	78 b8                	js     800c5b <vprintfmt+0x1e5>
  800ca3:	ff 4d e0             	decl   -0x20(%ebp)
  800ca6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800caa:	79 af                	jns    800c5b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800cac:	eb 13                	jmp    800cc1 <vprintfmt+0x24b>
				putch(' ', putdat);
  800cae:	83 ec 08             	sub    $0x8,%esp
  800cb1:	ff 75 0c             	pushl  0xc(%ebp)
  800cb4:	6a 20                	push   $0x20
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	ff d0                	call   *%eax
  800cbb:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800cbe:	ff 4d e4             	decl   -0x1c(%ebp)
  800cc1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cc5:	7f e7                	jg     800cae <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800cc7:	e9 66 01 00 00       	jmp    800e32 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ccc:	83 ec 08             	sub    $0x8,%esp
  800ccf:	ff 75 e8             	pushl  -0x18(%ebp)
  800cd2:	8d 45 14             	lea    0x14(%ebp),%eax
  800cd5:	50                   	push   %eax
  800cd6:	e8 3c fd ff ff       	call   800a17 <getint>
  800cdb:	83 c4 10             	add    $0x10,%esp
  800cde:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ce1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ce4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ce7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cea:	85 d2                	test   %edx,%edx
  800cec:	79 23                	jns    800d11 <vprintfmt+0x29b>
				putch('-', putdat);
  800cee:	83 ec 08             	sub    $0x8,%esp
  800cf1:	ff 75 0c             	pushl  0xc(%ebp)
  800cf4:	6a 2d                	push   $0x2d
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf9:	ff d0                	call   *%eax
  800cfb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800cfe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d01:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d04:	f7 d8                	neg    %eax
  800d06:	83 d2 00             	adc    $0x0,%edx
  800d09:	f7 da                	neg    %edx
  800d0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d0e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800d11:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800d18:	e9 bc 00 00 00       	jmp    800dd9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800d1d:	83 ec 08             	sub    $0x8,%esp
  800d20:	ff 75 e8             	pushl  -0x18(%ebp)
  800d23:	8d 45 14             	lea    0x14(%ebp),%eax
  800d26:	50                   	push   %eax
  800d27:	e8 84 fc ff ff       	call   8009b0 <getuint>
  800d2c:	83 c4 10             	add    $0x10,%esp
  800d2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d32:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800d35:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800d3c:	e9 98 00 00 00       	jmp    800dd9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800d41:	83 ec 08             	sub    $0x8,%esp
  800d44:	ff 75 0c             	pushl  0xc(%ebp)
  800d47:	6a 58                	push   $0x58
  800d49:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4c:	ff d0                	call   *%eax
  800d4e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d51:	83 ec 08             	sub    $0x8,%esp
  800d54:	ff 75 0c             	pushl  0xc(%ebp)
  800d57:	6a 58                	push   $0x58
  800d59:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5c:	ff d0                	call   *%eax
  800d5e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d61:	83 ec 08             	sub    $0x8,%esp
  800d64:	ff 75 0c             	pushl  0xc(%ebp)
  800d67:	6a 58                	push   $0x58
  800d69:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6c:	ff d0                	call   *%eax
  800d6e:	83 c4 10             	add    $0x10,%esp
			break;
  800d71:	e9 bc 00 00 00       	jmp    800e32 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800d76:	83 ec 08             	sub    $0x8,%esp
  800d79:	ff 75 0c             	pushl  0xc(%ebp)
  800d7c:	6a 30                	push   $0x30
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	ff d0                	call   *%eax
  800d83:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800d86:	83 ec 08             	sub    $0x8,%esp
  800d89:	ff 75 0c             	pushl  0xc(%ebp)
  800d8c:	6a 78                	push   $0x78
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d91:	ff d0                	call   *%eax
  800d93:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d96:	8b 45 14             	mov    0x14(%ebp),%eax
  800d99:	83 c0 04             	add    $0x4,%eax
  800d9c:	89 45 14             	mov    %eax,0x14(%ebp)
  800d9f:	8b 45 14             	mov    0x14(%ebp),%eax
  800da2:	83 e8 04             	sub    $0x4,%eax
  800da5:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800da7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800daa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800db1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800db8:	eb 1f                	jmp    800dd9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800dba:	83 ec 08             	sub    $0x8,%esp
  800dbd:	ff 75 e8             	pushl  -0x18(%ebp)
  800dc0:	8d 45 14             	lea    0x14(%ebp),%eax
  800dc3:	50                   	push   %eax
  800dc4:	e8 e7 fb ff ff       	call   8009b0 <getuint>
  800dc9:	83 c4 10             	add    $0x10,%esp
  800dcc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dcf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800dd2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800dd9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ddd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800de0:	83 ec 04             	sub    $0x4,%esp
  800de3:	52                   	push   %edx
  800de4:	ff 75 e4             	pushl  -0x1c(%ebp)
  800de7:	50                   	push   %eax
  800de8:	ff 75 f4             	pushl  -0xc(%ebp)
  800deb:	ff 75 f0             	pushl  -0x10(%ebp)
  800dee:	ff 75 0c             	pushl  0xc(%ebp)
  800df1:	ff 75 08             	pushl  0x8(%ebp)
  800df4:	e8 00 fb ff ff       	call   8008f9 <printnum>
  800df9:	83 c4 20             	add    $0x20,%esp
			break;
  800dfc:	eb 34                	jmp    800e32 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800dfe:	83 ec 08             	sub    $0x8,%esp
  800e01:	ff 75 0c             	pushl  0xc(%ebp)
  800e04:	53                   	push   %ebx
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
  800e08:	ff d0                	call   *%eax
  800e0a:	83 c4 10             	add    $0x10,%esp
			break;
  800e0d:	eb 23                	jmp    800e32 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800e0f:	83 ec 08             	sub    $0x8,%esp
  800e12:	ff 75 0c             	pushl  0xc(%ebp)
  800e15:	6a 25                	push   $0x25
  800e17:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1a:	ff d0                	call   *%eax
  800e1c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800e1f:	ff 4d 10             	decl   0x10(%ebp)
  800e22:	eb 03                	jmp    800e27 <vprintfmt+0x3b1>
  800e24:	ff 4d 10             	decl   0x10(%ebp)
  800e27:	8b 45 10             	mov    0x10(%ebp),%eax
  800e2a:	48                   	dec    %eax
  800e2b:	8a 00                	mov    (%eax),%al
  800e2d:	3c 25                	cmp    $0x25,%al
  800e2f:	75 f3                	jne    800e24 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800e31:	90                   	nop
		}
	}
  800e32:	e9 47 fc ff ff       	jmp    800a7e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800e37:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800e38:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800e3b:	5b                   	pop    %ebx
  800e3c:	5e                   	pop    %esi
  800e3d:	5d                   	pop    %ebp
  800e3e:	c3                   	ret    

00800e3f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800e3f:	55                   	push   %ebp
  800e40:	89 e5                	mov    %esp,%ebp
  800e42:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800e45:	8d 45 10             	lea    0x10(%ebp),%eax
  800e48:	83 c0 04             	add    $0x4,%eax
  800e4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800e4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e51:	ff 75 f4             	pushl  -0xc(%ebp)
  800e54:	50                   	push   %eax
  800e55:	ff 75 0c             	pushl  0xc(%ebp)
  800e58:	ff 75 08             	pushl  0x8(%ebp)
  800e5b:	e8 16 fc ff ff       	call   800a76 <vprintfmt>
  800e60:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800e63:	90                   	nop
  800e64:	c9                   	leave  
  800e65:	c3                   	ret    

00800e66 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800e66:	55                   	push   %ebp
  800e67:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800e69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6c:	8b 40 08             	mov    0x8(%eax),%eax
  800e6f:	8d 50 01             	lea    0x1(%eax),%edx
  800e72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e75:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800e78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7b:	8b 10                	mov    (%eax),%edx
  800e7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e80:	8b 40 04             	mov    0x4(%eax),%eax
  800e83:	39 c2                	cmp    %eax,%edx
  800e85:	73 12                	jae    800e99 <sprintputch+0x33>
		*b->buf++ = ch;
  800e87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8a:	8b 00                	mov    (%eax),%eax
  800e8c:	8d 48 01             	lea    0x1(%eax),%ecx
  800e8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e92:	89 0a                	mov    %ecx,(%edx)
  800e94:	8b 55 08             	mov    0x8(%ebp),%edx
  800e97:	88 10                	mov    %dl,(%eax)
}
  800e99:	90                   	nop
  800e9a:	5d                   	pop    %ebp
  800e9b:	c3                   	ret    

00800e9c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e9c:	55                   	push   %ebp
  800e9d:	89 e5                	mov    %esp,%ebp
  800e9f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800ea8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eab:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	01 d0                	add    %edx,%eax
  800eb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eb6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ebd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ec1:	74 06                	je     800ec9 <vsnprintf+0x2d>
  800ec3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ec7:	7f 07                	jg     800ed0 <vsnprintf+0x34>
		return -E_INVAL;
  800ec9:	b8 03 00 00 00       	mov    $0x3,%eax
  800ece:	eb 20                	jmp    800ef0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ed0:	ff 75 14             	pushl  0x14(%ebp)
  800ed3:	ff 75 10             	pushl  0x10(%ebp)
  800ed6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ed9:	50                   	push   %eax
  800eda:	68 66 0e 80 00       	push   $0x800e66
  800edf:	e8 92 fb ff ff       	call   800a76 <vprintfmt>
  800ee4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ee7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800eea:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800eed:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ef0:	c9                   	leave  
  800ef1:	c3                   	ret    

00800ef2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ef2:	55                   	push   %ebp
  800ef3:	89 e5                	mov    %esp,%ebp
  800ef5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ef8:	8d 45 10             	lea    0x10(%ebp),%eax
  800efb:	83 c0 04             	add    $0x4,%eax
  800efe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800f01:	8b 45 10             	mov    0x10(%ebp),%eax
  800f04:	ff 75 f4             	pushl  -0xc(%ebp)
  800f07:	50                   	push   %eax
  800f08:	ff 75 0c             	pushl  0xc(%ebp)
  800f0b:	ff 75 08             	pushl  0x8(%ebp)
  800f0e:	e8 89 ff ff ff       	call   800e9c <vsnprintf>
  800f13:	83 c4 10             	add    $0x10,%esp
  800f16:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800f19:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f1c:	c9                   	leave  
  800f1d:	c3                   	ret    

00800f1e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800f1e:	55                   	push   %ebp
  800f1f:	89 e5                	mov    %esp,%ebp
  800f21:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800f24:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f2b:	eb 06                	jmp    800f33 <strlen+0x15>
		n++;
  800f2d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800f30:	ff 45 08             	incl   0x8(%ebp)
  800f33:	8b 45 08             	mov    0x8(%ebp),%eax
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	84 c0                	test   %al,%al
  800f3a:	75 f1                	jne    800f2d <strlen+0xf>
		n++;
	return n;
  800f3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f3f:	c9                   	leave  
  800f40:	c3                   	ret    

00800f41 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800f41:	55                   	push   %ebp
  800f42:	89 e5                	mov    %esp,%ebp
  800f44:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f47:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f4e:	eb 09                	jmp    800f59 <strnlen+0x18>
		n++;
  800f50:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f53:	ff 45 08             	incl   0x8(%ebp)
  800f56:	ff 4d 0c             	decl   0xc(%ebp)
  800f59:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f5d:	74 09                	je     800f68 <strnlen+0x27>
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	8a 00                	mov    (%eax),%al
  800f64:	84 c0                	test   %al,%al
  800f66:	75 e8                	jne    800f50 <strnlen+0xf>
		n++;
	return n;
  800f68:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f6b:	c9                   	leave  
  800f6c:	c3                   	ret    

00800f6d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800f6d:	55                   	push   %ebp
  800f6e:	89 e5                	mov    %esp,%ebp
  800f70:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800f73:	8b 45 08             	mov    0x8(%ebp),%eax
  800f76:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800f79:	90                   	nop
  800f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7d:	8d 50 01             	lea    0x1(%eax),%edx
  800f80:	89 55 08             	mov    %edx,0x8(%ebp)
  800f83:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f86:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f89:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f8c:	8a 12                	mov    (%edx),%dl
  800f8e:	88 10                	mov    %dl,(%eax)
  800f90:	8a 00                	mov    (%eax),%al
  800f92:	84 c0                	test   %al,%al
  800f94:	75 e4                	jne    800f7a <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f96:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f99:	c9                   	leave  
  800f9a:	c3                   	ret    

00800f9b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f9b:	55                   	push   %ebp
  800f9c:	89 e5                	mov    %esp,%ebp
  800f9e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800fa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800fa7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fae:	eb 1f                	jmp    800fcf <strncpy+0x34>
		*dst++ = *src;
  800fb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb3:	8d 50 01             	lea    0x1(%eax),%edx
  800fb6:	89 55 08             	mov    %edx,0x8(%ebp)
  800fb9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fbc:	8a 12                	mov    (%edx),%dl
  800fbe:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc3:	8a 00                	mov    (%eax),%al
  800fc5:	84 c0                	test   %al,%al
  800fc7:	74 03                	je     800fcc <strncpy+0x31>
			src++;
  800fc9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800fcc:	ff 45 fc             	incl   -0x4(%ebp)
  800fcf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fd2:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fd5:	72 d9                	jb     800fb0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800fd7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fda:	c9                   	leave  
  800fdb:	c3                   	ret    

00800fdc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800fdc:	55                   	push   %ebp
  800fdd:	89 e5                	mov    %esp,%ebp
  800fdf:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800fe8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fec:	74 30                	je     80101e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800fee:	eb 16                	jmp    801006 <strlcpy+0x2a>
			*dst++ = *src++;
  800ff0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff3:	8d 50 01             	lea    0x1(%eax),%edx
  800ff6:	89 55 08             	mov    %edx,0x8(%ebp)
  800ff9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ffc:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fff:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801002:	8a 12                	mov    (%edx),%dl
  801004:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801006:	ff 4d 10             	decl   0x10(%ebp)
  801009:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80100d:	74 09                	je     801018 <strlcpy+0x3c>
  80100f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801012:	8a 00                	mov    (%eax),%al
  801014:	84 c0                	test   %al,%al
  801016:	75 d8                	jne    800ff0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801018:	8b 45 08             	mov    0x8(%ebp),%eax
  80101b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80101e:	8b 55 08             	mov    0x8(%ebp),%edx
  801021:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801024:	29 c2                	sub    %eax,%edx
  801026:	89 d0                	mov    %edx,%eax
}
  801028:	c9                   	leave  
  801029:	c3                   	ret    

0080102a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80102a:	55                   	push   %ebp
  80102b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80102d:	eb 06                	jmp    801035 <strcmp+0xb>
		p++, q++;
  80102f:	ff 45 08             	incl   0x8(%ebp)
  801032:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	8a 00                	mov    (%eax),%al
  80103a:	84 c0                	test   %al,%al
  80103c:	74 0e                	je     80104c <strcmp+0x22>
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	8a 10                	mov    (%eax),%dl
  801043:	8b 45 0c             	mov    0xc(%ebp),%eax
  801046:	8a 00                	mov    (%eax),%al
  801048:	38 c2                	cmp    %al,%dl
  80104a:	74 e3                	je     80102f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80104c:	8b 45 08             	mov    0x8(%ebp),%eax
  80104f:	8a 00                	mov    (%eax),%al
  801051:	0f b6 d0             	movzbl %al,%edx
  801054:	8b 45 0c             	mov    0xc(%ebp),%eax
  801057:	8a 00                	mov    (%eax),%al
  801059:	0f b6 c0             	movzbl %al,%eax
  80105c:	29 c2                	sub    %eax,%edx
  80105e:	89 d0                	mov    %edx,%eax
}
  801060:	5d                   	pop    %ebp
  801061:	c3                   	ret    

00801062 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801062:	55                   	push   %ebp
  801063:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801065:	eb 09                	jmp    801070 <strncmp+0xe>
		n--, p++, q++;
  801067:	ff 4d 10             	decl   0x10(%ebp)
  80106a:	ff 45 08             	incl   0x8(%ebp)
  80106d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801070:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801074:	74 17                	je     80108d <strncmp+0x2b>
  801076:	8b 45 08             	mov    0x8(%ebp),%eax
  801079:	8a 00                	mov    (%eax),%al
  80107b:	84 c0                	test   %al,%al
  80107d:	74 0e                	je     80108d <strncmp+0x2b>
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	8a 10                	mov    (%eax),%dl
  801084:	8b 45 0c             	mov    0xc(%ebp),%eax
  801087:	8a 00                	mov    (%eax),%al
  801089:	38 c2                	cmp    %al,%dl
  80108b:	74 da                	je     801067 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80108d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801091:	75 07                	jne    80109a <strncmp+0x38>
		return 0;
  801093:	b8 00 00 00 00       	mov    $0x0,%eax
  801098:	eb 14                	jmp    8010ae <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80109a:	8b 45 08             	mov    0x8(%ebp),%eax
  80109d:	8a 00                	mov    (%eax),%al
  80109f:	0f b6 d0             	movzbl %al,%edx
  8010a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a5:	8a 00                	mov    (%eax),%al
  8010a7:	0f b6 c0             	movzbl %al,%eax
  8010aa:	29 c2                	sub    %eax,%edx
  8010ac:	89 d0                	mov    %edx,%eax
}
  8010ae:	5d                   	pop    %ebp
  8010af:	c3                   	ret    

008010b0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8010b0:	55                   	push   %ebp
  8010b1:	89 e5                	mov    %esp,%ebp
  8010b3:	83 ec 04             	sub    $0x4,%esp
  8010b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8010bc:	eb 12                	jmp    8010d0 <strchr+0x20>
		if (*s == c)
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c1:	8a 00                	mov    (%eax),%al
  8010c3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8010c6:	75 05                	jne    8010cd <strchr+0x1d>
			return (char *) s;
  8010c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cb:	eb 11                	jmp    8010de <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8010cd:	ff 45 08             	incl   0x8(%ebp)
  8010d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d3:	8a 00                	mov    (%eax),%al
  8010d5:	84 c0                	test   %al,%al
  8010d7:	75 e5                	jne    8010be <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8010d9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010de:	c9                   	leave  
  8010df:	c3                   	ret    

008010e0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8010e0:	55                   	push   %ebp
  8010e1:	89 e5                	mov    %esp,%ebp
  8010e3:	83 ec 04             	sub    $0x4,%esp
  8010e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8010ec:	eb 0d                	jmp    8010fb <strfind+0x1b>
		if (*s == c)
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f1:	8a 00                	mov    (%eax),%al
  8010f3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8010f6:	74 0e                	je     801106 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8010f8:	ff 45 08             	incl   0x8(%ebp)
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	8a 00                	mov    (%eax),%al
  801100:	84 c0                	test   %al,%al
  801102:	75 ea                	jne    8010ee <strfind+0xe>
  801104:	eb 01                	jmp    801107 <strfind+0x27>
		if (*s == c)
			break;
  801106:	90                   	nop
	return (char *) s;
  801107:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80110a:	c9                   	leave  
  80110b:	c3                   	ret    

0080110c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80110c:	55                   	push   %ebp
  80110d:	89 e5                	mov    %esp,%ebp
  80110f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801112:	8b 45 08             	mov    0x8(%ebp),%eax
  801115:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801118:	8b 45 10             	mov    0x10(%ebp),%eax
  80111b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80111e:	eb 0e                	jmp    80112e <memset+0x22>
		*p++ = c;
  801120:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801123:	8d 50 01             	lea    0x1(%eax),%edx
  801126:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801129:	8b 55 0c             	mov    0xc(%ebp),%edx
  80112c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80112e:	ff 4d f8             	decl   -0x8(%ebp)
  801131:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801135:	79 e9                	jns    801120 <memset+0x14>
		*p++ = c;

	return v;
  801137:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80113a:	c9                   	leave  
  80113b:	c3                   	ret    

0080113c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80113c:	55                   	push   %ebp
  80113d:	89 e5                	mov    %esp,%ebp
  80113f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801142:	8b 45 0c             	mov    0xc(%ebp),%eax
  801145:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801148:	8b 45 08             	mov    0x8(%ebp),%eax
  80114b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80114e:	eb 16                	jmp    801166 <memcpy+0x2a>
		*d++ = *s++;
  801150:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801153:	8d 50 01             	lea    0x1(%eax),%edx
  801156:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801159:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80115c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80115f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801162:	8a 12                	mov    (%edx),%dl
  801164:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801166:	8b 45 10             	mov    0x10(%ebp),%eax
  801169:	8d 50 ff             	lea    -0x1(%eax),%edx
  80116c:	89 55 10             	mov    %edx,0x10(%ebp)
  80116f:	85 c0                	test   %eax,%eax
  801171:	75 dd                	jne    801150 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801176:	c9                   	leave  
  801177:	c3                   	ret    

00801178 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801178:	55                   	push   %ebp
  801179:	89 e5                	mov    %esp,%ebp
  80117b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80117e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801181:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801184:	8b 45 08             	mov    0x8(%ebp),%eax
  801187:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80118a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80118d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801190:	73 50                	jae    8011e2 <memmove+0x6a>
  801192:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801195:	8b 45 10             	mov    0x10(%ebp),%eax
  801198:	01 d0                	add    %edx,%eax
  80119a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80119d:	76 43                	jbe    8011e2 <memmove+0x6a>
		s += n;
  80119f:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8011a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8011ab:	eb 10                	jmp    8011bd <memmove+0x45>
			*--d = *--s;
  8011ad:	ff 4d f8             	decl   -0x8(%ebp)
  8011b0:	ff 4d fc             	decl   -0x4(%ebp)
  8011b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011b6:	8a 10                	mov    (%eax),%dl
  8011b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011bb:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8011bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011c3:	89 55 10             	mov    %edx,0x10(%ebp)
  8011c6:	85 c0                	test   %eax,%eax
  8011c8:	75 e3                	jne    8011ad <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8011ca:	eb 23                	jmp    8011ef <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8011cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011cf:	8d 50 01             	lea    0x1(%eax),%edx
  8011d2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011d8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011db:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8011de:	8a 12                	mov    (%edx),%dl
  8011e0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8011e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011e8:	89 55 10             	mov    %edx,0x10(%ebp)
  8011eb:	85 c0                	test   %eax,%eax
  8011ed:	75 dd                	jne    8011cc <memmove+0x54>
			*d++ = *s++;

	return dst;
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011f2:	c9                   	leave  
  8011f3:	c3                   	ret    

008011f4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8011f4:	55                   	push   %ebp
  8011f5:	89 e5                	mov    %esp,%ebp
  8011f7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801200:	8b 45 0c             	mov    0xc(%ebp),%eax
  801203:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801206:	eb 2a                	jmp    801232 <memcmp+0x3e>
		if (*s1 != *s2)
  801208:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80120b:	8a 10                	mov    (%eax),%dl
  80120d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801210:	8a 00                	mov    (%eax),%al
  801212:	38 c2                	cmp    %al,%dl
  801214:	74 16                	je     80122c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801216:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801219:	8a 00                	mov    (%eax),%al
  80121b:	0f b6 d0             	movzbl %al,%edx
  80121e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801221:	8a 00                	mov    (%eax),%al
  801223:	0f b6 c0             	movzbl %al,%eax
  801226:	29 c2                	sub    %eax,%edx
  801228:	89 d0                	mov    %edx,%eax
  80122a:	eb 18                	jmp    801244 <memcmp+0x50>
		s1++, s2++;
  80122c:	ff 45 fc             	incl   -0x4(%ebp)
  80122f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801232:	8b 45 10             	mov    0x10(%ebp),%eax
  801235:	8d 50 ff             	lea    -0x1(%eax),%edx
  801238:	89 55 10             	mov    %edx,0x10(%ebp)
  80123b:	85 c0                	test   %eax,%eax
  80123d:	75 c9                	jne    801208 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80123f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801244:	c9                   	leave  
  801245:	c3                   	ret    

00801246 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801246:	55                   	push   %ebp
  801247:	89 e5                	mov    %esp,%ebp
  801249:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80124c:	8b 55 08             	mov    0x8(%ebp),%edx
  80124f:	8b 45 10             	mov    0x10(%ebp),%eax
  801252:	01 d0                	add    %edx,%eax
  801254:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801257:	eb 15                	jmp    80126e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801259:	8b 45 08             	mov    0x8(%ebp),%eax
  80125c:	8a 00                	mov    (%eax),%al
  80125e:	0f b6 d0             	movzbl %al,%edx
  801261:	8b 45 0c             	mov    0xc(%ebp),%eax
  801264:	0f b6 c0             	movzbl %al,%eax
  801267:	39 c2                	cmp    %eax,%edx
  801269:	74 0d                	je     801278 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80126b:	ff 45 08             	incl   0x8(%ebp)
  80126e:	8b 45 08             	mov    0x8(%ebp),%eax
  801271:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801274:	72 e3                	jb     801259 <memfind+0x13>
  801276:	eb 01                	jmp    801279 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801278:	90                   	nop
	return (void *) s;
  801279:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80127c:	c9                   	leave  
  80127d:	c3                   	ret    

0080127e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80127e:	55                   	push   %ebp
  80127f:	89 e5                	mov    %esp,%ebp
  801281:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801284:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80128b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801292:	eb 03                	jmp    801297 <strtol+0x19>
		s++;
  801294:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	8a 00                	mov    (%eax),%al
  80129c:	3c 20                	cmp    $0x20,%al
  80129e:	74 f4                	je     801294 <strtol+0x16>
  8012a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a3:	8a 00                	mov    (%eax),%al
  8012a5:	3c 09                	cmp    $0x9,%al
  8012a7:	74 eb                	je     801294 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8012a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ac:	8a 00                	mov    (%eax),%al
  8012ae:	3c 2b                	cmp    $0x2b,%al
  8012b0:	75 05                	jne    8012b7 <strtol+0x39>
		s++;
  8012b2:	ff 45 08             	incl   0x8(%ebp)
  8012b5:	eb 13                	jmp    8012ca <strtol+0x4c>
	else if (*s == '-')
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ba:	8a 00                	mov    (%eax),%al
  8012bc:	3c 2d                	cmp    $0x2d,%al
  8012be:	75 0a                	jne    8012ca <strtol+0x4c>
		s++, neg = 1;
  8012c0:	ff 45 08             	incl   0x8(%ebp)
  8012c3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8012ca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012ce:	74 06                	je     8012d6 <strtol+0x58>
  8012d0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8012d4:	75 20                	jne    8012f6 <strtol+0x78>
  8012d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d9:	8a 00                	mov    (%eax),%al
  8012db:	3c 30                	cmp    $0x30,%al
  8012dd:	75 17                	jne    8012f6 <strtol+0x78>
  8012df:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e2:	40                   	inc    %eax
  8012e3:	8a 00                	mov    (%eax),%al
  8012e5:	3c 78                	cmp    $0x78,%al
  8012e7:	75 0d                	jne    8012f6 <strtol+0x78>
		s += 2, base = 16;
  8012e9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8012ed:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8012f4:	eb 28                	jmp    80131e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8012f6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012fa:	75 15                	jne    801311 <strtol+0x93>
  8012fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ff:	8a 00                	mov    (%eax),%al
  801301:	3c 30                	cmp    $0x30,%al
  801303:	75 0c                	jne    801311 <strtol+0x93>
		s++, base = 8;
  801305:	ff 45 08             	incl   0x8(%ebp)
  801308:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80130f:	eb 0d                	jmp    80131e <strtol+0xa0>
	else if (base == 0)
  801311:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801315:	75 07                	jne    80131e <strtol+0xa0>
		base = 10;
  801317:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80131e:	8b 45 08             	mov    0x8(%ebp),%eax
  801321:	8a 00                	mov    (%eax),%al
  801323:	3c 2f                	cmp    $0x2f,%al
  801325:	7e 19                	jle    801340 <strtol+0xc2>
  801327:	8b 45 08             	mov    0x8(%ebp),%eax
  80132a:	8a 00                	mov    (%eax),%al
  80132c:	3c 39                	cmp    $0x39,%al
  80132e:	7f 10                	jg     801340 <strtol+0xc2>
			dig = *s - '0';
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	8a 00                	mov    (%eax),%al
  801335:	0f be c0             	movsbl %al,%eax
  801338:	83 e8 30             	sub    $0x30,%eax
  80133b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80133e:	eb 42                	jmp    801382 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801340:	8b 45 08             	mov    0x8(%ebp),%eax
  801343:	8a 00                	mov    (%eax),%al
  801345:	3c 60                	cmp    $0x60,%al
  801347:	7e 19                	jle    801362 <strtol+0xe4>
  801349:	8b 45 08             	mov    0x8(%ebp),%eax
  80134c:	8a 00                	mov    (%eax),%al
  80134e:	3c 7a                	cmp    $0x7a,%al
  801350:	7f 10                	jg     801362 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801352:	8b 45 08             	mov    0x8(%ebp),%eax
  801355:	8a 00                	mov    (%eax),%al
  801357:	0f be c0             	movsbl %al,%eax
  80135a:	83 e8 57             	sub    $0x57,%eax
  80135d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801360:	eb 20                	jmp    801382 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	8a 00                	mov    (%eax),%al
  801367:	3c 40                	cmp    $0x40,%al
  801369:	7e 39                	jle    8013a4 <strtol+0x126>
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	8a 00                	mov    (%eax),%al
  801370:	3c 5a                	cmp    $0x5a,%al
  801372:	7f 30                	jg     8013a4 <strtol+0x126>
			dig = *s - 'A' + 10;
  801374:	8b 45 08             	mov    0x8(%ebp),%eax
  801377:	8a 00                	mov    (%eax),%al
  801379:	0f be c0             	movsbl %al,%eax
  80137c:	83 e8 37             	sub    $0x37,%eax
  80137f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801382:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801385:	3b 45 10             	cmp    0x10(%ebp),%eax
  801388:	7d 19                	jge    8013a3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80138a:	ff 45 08             	incl   0x8(%ebp)
  80138d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801390:	0f af 45 10          	imul   0x10(%ebp),%eax
  801394:	89 c2                	mov    %eax,%edx
  801396:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801399:	01 d0                	add    %edx,%eax
  80139b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80139e:	e9 7b ff ff ff       	jmp    80131e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8013a3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8013a4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013a8:	74 08                	je     8013b2 <strtol+0x134>
		*endptr = (char *) s;
  8013aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ad:	8b 55 08             	mov    0x8(%ebp),%edx
  8013b0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8013b2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013b6:	74 07                	je     8013bf <strtol+0x141>
  8013b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013bb:	f7 d8                	neg    %eax
  8013bd:	eb 03                	jmp    8013c2 <strtol+0x144>
  8013bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013c2:	c9                   	leave  
  8013c3:	c3                   	ret    

008013c4 <ltostr>:

void
ltostr(long value, char *str)
{
  8013c4:	55                   	push   %ebp
  8013c5:	89 e5                	mov    %esp,%ebp
  8013c7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8013ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8013d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8013d8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013dc:	79 13                	jns    8013f1 <ltostr+0x2d>
	{
		neg = 1;
  8013de:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8013e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8013eb:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8013ee:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8013f9:	99                   	cltd   
  8013fa:	f7 f9                	idiv   %ecx
  8013fc:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8013ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801402:	8d 50 01             	lea    0x1(%eax),%edx
  801405:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801408:	89 c2                	mov    %eax,%edx
  80140a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140d:	01 d0                	add    %edx,%eax
  80140f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801412:	83 c2 30             	add    $0x30,%edx
  801415:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801417:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80141a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80141f:	f7 e9                	imul   %ecx
  801421:	c1 fa 02             	sar    $0x2,%edx
  801424:	89 c8                	mov    %ecx,%eax
  801426:	c1 f8 1f             	sar    $0x1f,%eax
  801429:	29 c2                	sub    %eax,%edx
  80142b:	89 d0                	mov    %edx,%eax
  80142d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801430:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801433:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801438:	f7 e9                	imul   %ecx
  80143a:	c1 fa 02             	sar    $0x2,%edx
  80143d:	89 c8                	mov    %ecx,%eax
  80143f:	c1 f8 1f             	sar    $0x1f,%eax
  801442:	29 c2                	sub    %eax,%edx
  801444:	89 d0                	mov    %edx,%eax
  801446:	c1 e0 02             	shl    $0x2,%eax
  801449:	01 d0                	add    %edx,%eax
  80144b:	01 c0                	add    %eax,%eax
  80144d:	29 c1                	sub    %eax,%ecx
  80144f:	89 ca                	mov    %ecx,%edx
  801451:	85 d2                	test   %edx,%edx
  801453:	75 9c                	jne    8013f1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801455:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80145c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80145f:	48                   	dec    %eax
  801460:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801463:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801467:	74 3d                	je     8014a6 <ltostr+0xe2>
		start = 1 ;
  801469:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801470:	eb 34                	jmp    8014a6 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801472:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801475:	8b 45 0c             	mov    0xc(%ebp),%eax
  801478:	01 d0                	add    %edx,%eax
  80147a:	8a 00                	mov    (%eax),%al
  80147c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80147f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801482:	8b 45 0c             	mov    0xc(%ebp),%eax
  801485:	01 c2                	add    %eax,%edx
  801487:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80148a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148d:	01 c8                	add    %ecx,%eax
  80148f:	8a 00                	mov    (%eax),%al
  801491:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801493:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801496:	8b 45 0c             	mov    0xc(%ebp),%eax
  801499:	01 c2                	add    %eax,%edx
  80149b:	8a 45 eb             	mov    -0x15(%ebp),%al
  80149e:	88 02                	mov    %al,(%edx)
		start++ ;
  8014a0:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8014a3:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8014a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014a9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014ac:	7c c4                	jl     801472 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8014ae:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8014b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b4:	01 d0                	add    %edx,%eax
  8014b6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8014b9:	90                   	nop
  8014ba:	c9                   	leave  
  8014bb:	c3                   	ret    

008014bc <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8014bc:	55                   	push   %ebp
  8014bd:	89 e5                	mov    %esp,%ebp
  8014bf:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8014c2:	ff 75 08             	pushl  0x8(%ebp)
  8014c5:	e8 54 fa ff ff       	call   800f1e <strlen>
  8014ca:	83 c4 04             	add    $0x4,%esp
  8014cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8014d0:	ff 75 0c             	pushl  0xc(%ebp)
  8014d3:	e8 46 fa ff ff       	call   800f1e <strlen>
  8014d8:	83 c4 04             	add    $0x4,%esp
  8014db:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8014de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8014e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014ec:	eb 17                	jmp    801505 <strcconcat+0x49>
		final[s] = str1[s] ;
  8014ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f4:	01 c2                	add    %eax,%edx
  8014f6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fc:	01 c8                	add    %ecx,%eax
  8014fe:	8a 00                	mov    (%eax),%al
  801500:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801502:	ff 45 fc             	incl   -0x4(%ebp)
  801505:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801508:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80150b:	7c e1                	jl     8014ee <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80150d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801514:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80151b:	eb 1f                	jmp    80153c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80151d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801520:	8d 50 01             	lea    0x1(%eax),%edx
  801523:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801526:	89 c2                	mov    %eax,%edx
  801528:	8b 45 10             	mov    0x10(%ebp),%eax
  80152b:	01 c2                	add    %eax,%edx
  80152d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801530:	8b 45 0c             	mov    0xc(%ebp),%eax
  801533:	01 c8                	add    %ecx,%eax
  801535:	8a 00                	mov    (%eax),%al
  801537:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801539:	ff 45 f8             	incl   -0x8(%ebp)
  80153c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801542:	7c d9                	jl     80151d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801544:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801547:	8b 45 10             	mov    0x10(%ebp),%eax
  80154a:	01 d0                	add    %edx,%eax
  80154c:	c6 00 00             	movb   $0x0,(%eax)
}
  80154f:	90                   	nop
  801550:	c9                   	leave  
  801551:	c3                   	ret    

00801552 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801552:	55                   	push   %ebp
  801553:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801555:	8b 45 14             	mov    0x14(%ebp),%eax
  801558:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80155e:	8b 45 14             	mov    0x14(%ebp),%eax
  801561:	8b 00                	mov    (%eax),%eax
  801563:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80156a:	8b 45 10             	mov    0x10(%ebp),%eax
  80156d:	01 d0                	add    %edx,%eax
  80156f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801575:	eb 0c                	jmp    801583 <strsplit+0x31>
			*string++ = 0;
  801577:	8b 45 08             	mov    0x8(%ebp),%eax
  80157a:	8d 50 01             	lea    0x1(%eax),%edx
  80157d:	89 55 08             	mov    %edx,0x8(%ebp)
  801580:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801583:	8b 45 08             	mov    0x8(%ebp),%eax
  801586:	8a 00                	mov    (%eax),%al
  801588:	84 c0                	test   %al,%al
  80158a:	74 18                	je     8015a4 <strsplit+0x52>
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	8a 00                	mov    (%eax),%al
  801591:	0f be c0             	movsbl %al,%eax
  801594:	50                   	push   %eax
  801595:	ff 75 0c             	pushl  0xc(%ebp)
  801598:	e8 13 fb ff ff       	call   8010b0 <strchr>
  80159d:	83 c4 08             	add    $0x8,%esp
  8015a0:	85 c0                	test   %eax,%eax
  8015a2:	75 d3                	jne    801577 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8015a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a7:	8a 00                	mov    (%eax),%al
  8015a9:	84 c0                	test   %al,%al
  8015ab:	74 5a                	je     801607 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8015ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8015b0:	8b 00                	mov    (%eax),%eax
  8015b2:	83 f8 0f             	cmp    $0xf,%eax
  8015b5:	75 07                	jne    8015be <strsplit+0x6c>
		{
			return 0;
  8015b7:	b8 00 00 00 00       	mov    $0x0,%eax
  8015bc:	eb 66                	jmp    801624 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8015be:	8b 45 14             	mov    0x14(%ebp),%eax
  8015c1:	8b 00                	mov    (%eax),%eax
  8015c3:	8d 48 01             	lea    0x1(%eax),%ecx
  8015c6:	8b 55 14             	mov    0x14(%ebp),%edx
  8015c9:	89 0a                	mov    %ecx,(%edx)
  8015cb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d5:	01 c2                	add    %eax,%edx
  8015d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015da:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015dc:	eb 03                	jmp    8015e1 <strsplit+0x8f>
			string++;
  8015de:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e4:	8a 00                	mov    (%eax),%al
  8015e6:	84 c0                	test   %al,%al
  8015e8:	74 8b                	je     801575 <strsplit+0x23>
  8015ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ed:	8a 00                	mov    (%eax),%al
  8015ef:	0f be c0             	movsbl %al,%eax
  8015f2:	50                   	push   %eax
  8015f3:	ff 75 0c             	pushl  0xc(%ebp)
  8015f6:	e8 b5 fa ff ff       	call   8010b0 <strchr>
  8015fb:	83 c4 08             	add    $0x8,%esp
  8015fe:	85 c0                	test   %eax,%eax
  801600:	74 dc                	je     8015de <strsplit+0x8c>
			string++;
	}
  801602:	e9 6e ff ff ff       	jmp    801575 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801607:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801608:	8b 45 14             	mov    0x14(%ebp),%eax
  80160b:	8b 00                	mov    (%eax),%eax
  80160d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801614:	8b 45 10             	mov    0x10(%ebp),%eax
  801617:	01 d0                	add    %edx,%eax
  801619:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80161f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801624:	c9                   	leave  
  801625:	c3                   	ret    

00801626 <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  801626:	55                   	push   %ebp
  801627:	89 e5                	mov    %esp,%ebp
  801629:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  80162c:	8b 45 08             	mov    0x8(%ebp),%eax
  80162f:	c1 e8 0c             	shr    $0xc,%eax
  801632:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801635:	8b 45 08             	mov    0x8(%ebp),%eax
  801638:	25 ff 0f 00 00       	and    $0xfff,%eax
  80163d:	85 c0                	test   %eax,%eax
  80163f:	74 03                	je     801644 <malloc+0x1e>
			num++;
  801641:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801644:	a1 04 30 80 00       	mov    0x803004,%eax
  801649:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  80164e:	75 73                	jne    8016c3 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801650:	83 ec 08             	sub    $0x8,%esp
  801653:	ff 75 08             	pushl  0x8(%ebp)
  801656:	68 00 00 00 80       	push   $0x80000000
  80165b:	e8 80 04 00 00       	call   801ae0 <sys_allocateMem>
  801660:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801663:	a1 04 30 80 00       	mov    0x803004,%eax
  801668:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  80166b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80166e:	c1 e0 0c             	shl    $0xc,%eax
  801671:	89 c2                	mov    %eax,%edx
  801673:	a1 04 30 80 00       	mov    0x803004,%eax
  801678:	01 d0                	add    %edx,%eax
  80167a:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  80167f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801684:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801687:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  80168e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801693:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801699:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  8016a0:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016a5:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  8016ac:	01 00 00 00 
			sizeofarray++;
  8016b0:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8016b5:	40                   	inc    %eax
  8016b6:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  8016bb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8016be:	e9 71 01 00 00       	jmp    801834 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  8016c3:	a1 28 30 80 00       	mov    0x803028,%eax
  8016c8:	85 c0                	test   %eax,%eax
  8016ca:	75 71                	jne    80173d <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  8016cc:	a1 04 30 80 00       	mov    0x803004,%eax
  8016d1:	83 ec 08             	sub    $0x8,%esp
  8016d4:	ff 75 08             	pushl  0x8(%ebp)
  8016d7:	50                   	push   %eax
  8016d8:	e8 03 04 00 00       	call   801ae0 <sys_allocateMem>
  8016dd:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8016e0:	a1 04 30 80 00       	mov    0x803004,%eax
  8016e5:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  8016e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016eb:	c1 e0 0c             	shl    $0xc,%eax
  8016ee:	89 c2                	mov    %eax,%edx
  8016f0:	a1 04 30 80 00       	mov    0x803004,%eax
  8016f5:	01 d0                	add    %edx,%eax
  8016f7:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  8016fc:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801701:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801704:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  80170b:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801710:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801713:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  80171a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80171f:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801726:	01 00 00 00 
				sizeofarray++;
  80172a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80172f:	40                   	inc    %eax
  801730:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  801735:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801738:	e9 f7 00 00 00       	jmp    801834 <malloc+0x20e>
			}
			else{
				int count=0;
  80173d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801744:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  80174b:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801752:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801759:	eb 7c                	jmp    8017d7 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  80175b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801762:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801769:	eb 1a                	jmp    801785 <malloc+0x15f>
					{
						if(addresses[j]==i)
  80176b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80176e:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801775:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801778:	75 08                	jne    801782 <malloc+0x15c>
						{
							index=j;
  80177a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80177d:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801780:	eb 0d                	jmp    80178f <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801782:	ff 45 dc             	incl   -0x24(%ebp)
  801785:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80178a:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  80178d:	7c dc                	jl     80176b <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  80178f:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801793:	75 05                	jne    80179a <malloc+0x174>
					{
						count++;
  801795:	ff 45 f0             	incl   -0x10(%ebp)
  801798:	eb 36                	jmp    8017d0 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  80179a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80179d:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  8017a4:	85 c0                	test   %eax,%eax
  8017a6:	75 05                	jne    8017ad <malloc+0x187>
						{
							count++;
  8017a8:	ff 45 f0             	incl   -0x10(%ebp)
  8017ab:	eb 23                	jmp    8017d0 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  8017ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017b0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8017b3:	7d 14                	jge    8017c9 <malloc+0x1a3>
  8017b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017b8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8017bb:	7c 0c                	jl     8017c9 <malloc+0x1a3>
							{
								min=count;
  8017bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8017c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8017c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8017c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8017c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8017d0:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8017d7:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8017de:	0f 86 77 ff ff ff    	jbe    80175b <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  8017e4:	83 ec 08             	sub    $0x8,%esp
  8017e7:	ff 75 08             	pushl  0x8(%ebp)
  8017ea:	ff 75 e4             	pushl  -0x1c(%ebp)
  8017ed:	e8 ee 02 00 00       	call   801ae0 <sys_allocateMem>
  8017f2:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  8017f5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017fd:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801804:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801809:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80180f:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801816:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80181b:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801822:	01 00 00 00 
				sizeofarray++;
  801826:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80182b:	40                   	inc    %eax
  80182c:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  801831:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801834:	c9                   	leave  
  801835:	c3                   	ret    

00801836 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details
}
  801839:	90                   	nop
  80183a:	5d                   	pop    %ebp
  80183b:	c3                   	ret    

0080183c <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80183c:	55                   	push   %ebp
  80183d:	89 e5                	mov    %esp,%ebp
  80183f:	83 ec 18             	sub    $0x18,%esp
  801842:	8b 45 10             	mov    0x10(%ebp),%eax
  801845:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801848:	83 ec 04             	sub    $0x4,%esp
  80184b:	68 f0 27 80 00       	push   $0x8027f0
  801850:	68 8d 00 00 00       	push   $0x8d
  801855:	68 13 28 80 00       	push   $0x802813
  80185a:	e8 0b 07 00 00       	call   801f6a <_panic>

0080185f <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80185f:	55                   	push   %ebp
  801860:	89 e5                	mov    %esp,%ebp
  801862:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801865:	83 ec 04             	sub    $0x4,%esp
  801868:	68 f0 27 80 00       	push   $0x8027f0
  80186d:	68 93 00 00 00       	push   $0x93
  801872:	68 13 28 80 00       	push   $0x802813
  801877:	e8 ee 06 00 00       	call   801f6a <_panic>

0080187c <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80187c:	55                   	push   %ebp
  80187d:	89 e5                	mov    %esp,%ebp
  80187f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801882:	83 ec 04             	sub    $0x4,%esp
  801885:	68 f0 27 80 00       	push   $0x8027f0
  80188a:	68 99 00 00 00       	push   $0x99
  80188f:	68 13 28 80 00       	push   $0x802813
  801894:	e8 d1 06 00 00       	call   801f6a <_panic>

00801899 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801899:	55                   	push   %ebp
  80189a:	89 e5                	mov    %esp,%ebp
  80189c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80189f:	83 ec 04             	sub    $0x4,%esp
  8018a2:	68 f0 27 80 00       	push   $0x8027f0
  8018a7:	68 9e 00 00 00       	push   $0x9e
  8018ac:	68 13 28 80 00       	push   $0x802813
  8018b1:	e8 b4 06 00 00       	call   801f6a <_panic>

008018b6 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8018b6:	55                   	push   %ebp
  8018b7:	89 e5                	mov    %esp,%ebp
  8018b9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018bc:	83 ec 04             	sub    $0x4,%esp
  8018bf:	68 f0 27 80 00       	push   $0x8027f0
  8018c4:	68 a4 00 00 00       	push   $0xa4
  8018c9:	68 13 28 80 00       	push   $0x802813
  8018ce:	e8 97 06 00 00       	call   801f6a <_panic>

008018d3 <shrink>:
}
void shrink(uint32 newSize)
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
  8018d6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018d9:	83 ec 04             	sub    $0x4,%esp
  8018dc:	68 f0 27 80 00       	push   $0x8027f0
  8018e1:	68 a8 00 00 00       	push   $0xa8
  8018e6:	68 13 28 80 00       	push   $0x802813
  8018eb:	e8 7a 06 00 00       	call   801f6a <_panic>

008018f0 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8018f0:	55                   	push   %ebp
  8018f1:	89 e5                	mov    %esp,%ebp
  8018f3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018f6:	83 ec 04             	sub    $0x4,%esp
  8018f9:	68 f0 27 80 00       	push   $0x8027f0
  8018fe:	68 ad 00 00 00       	push   $0xad
  801903:	68 13 28 80 00       	push   $0x802813
  801908:	e8 5d 06 00 00       	call   801f6a <_panic>

0080190d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80190d:	55                   	push   %ebp
  80190e:	89 e5                	mov    %esp,%ebp
  801910:	57                   	push   %edi
  801911:	56                   	push   %esi
  801912:	53                   	push   %ebx
  801913:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801916:	8b 45 08             	mov    0x8(%ebp),%eax
  801919:	8b 55 0c             	mov    0xc(%ebp),%edx
  80191c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80191f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801922:	8b 7d 18             	mov    0x18(%ebp),%edi
  801925:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801928:	cd 30                	int    $0x30
  80192a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80192d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801930:	83 c4 10             	add    $0x10,%esp
  801933:	5b                   	pop    %ebx
  801934:	5e                   	pop    %esi
  801935:	5f                   	pop    %edi
  801936:	5d                   	pop    %ebp
  801937:	c3                   	ret    

00801938 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801938:	55                   	push   %ebp
  801939:	89 e5                	mov    %esp,%ebp
  80193b:	83 ec 04             	sub    $0x4,%esp
  80193e:	8b 45 10             	mov    0x10(%ebp),%eax
  801941:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801944:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801948:	8b 45 08             	mov    0x8(%ebp),%eax
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	52                   	push   %edx
  801950:	ff 75 0c             	pushl  0xc(%ebp)
  801953:	50                   	push   %eax
  801954:	6a 00                	push   $0x0
  801956:	e8 b2 ff ff ff       	call   80190d <syscall>
  80195b:	83 c4 18             	add    $0x18,%esp
}
  80195e:	90                   	nop
  80195f:	c9                   	leave  
  801960:	c3                   	ret    

00801961 <sys_cgetc>:

int
sys_cgetc(void)
{
  801961:	55                   	push   %ebp
  801962:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 01                	push   $0x1
  801970:	e8 98 ff ff ff       	call   80190d <syscall>
  801975:	83 c4 18             	add    $0x18,%esp
}
  801978:	c9                   	leave  
  801979:	c3                   	ret    

0080197a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80197a:	55                   	push   %ebp
  80197b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80197d:	8b 45 08             	mov    0x8(%ebp),%eax
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 00                	push   $0x0
  801988:	50                   	push   %eax
  801989:	6a 05                	push   $0x5
  80198b:	e8 7d ff ff ff       	call   80190d <syscall>
  801990:	83 c4 18             	add    $0x18,%esp
}
  801993:	c9                   	leave  
  801994:	c3                   	ret    

00801995 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801995:	55                   	push   %ebp
  801996:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 02                	push   $0x2
  8019a4:	e8 64 ff ff ff       	call   80190d <syscall>
  8019a9:	83 c4 18             	add    $0x18,%esp
}
  8019ac:	c9                   	leave  
  8019ad:	c3                   	ret    

008019ae <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8019ae:	55                   	push   %ebp
  8019af:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 00                	push   $0x0
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 03                	push   $0x3
  8019bd:	e8 4b ff ff ff       	call   80190d <syscall>
  8019c2:	83 c4 18             	add    $0x18,%esp
}
  8019c5:	c9                   	leave  
  8019c6:	c3                   	ret    

008019c7 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019c7:	55                   	push   %ebp
  8019c8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019ca:	6a 00                	push   $0x0
  8019cc:	6a 00                	push   $0x0
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 04                	push   $0x4
  8019d6:	e8 32 ff ff ff       	call   80190d <syscall>
  8019db:	83 c4 18             	add    $0x18,%esp
}
  8019de:	c9                   	leave  
  8019df:	c3                   	ret    

008019e0 <sys_env_exit>:


void sys_env_exit(void)
{
  8019e0:	55                   	push   %ebp
  8019e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 06                	push   $0x6
  8019ef:	e8 19 ff ff ff       	call   80190d <syscall>
  8019f4:	83 c4 18             	add    $0x18,%esp
}
  8019f7:	90                   	nop
  8019f8:	c9                   	leave  
  8019f9:	c3                   	ret    

008019fa <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8019fa:	55                   	push   %ebp
  8019fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8019fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a00:	8b 45 08             	mov    0x8(%ebp),%eax
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	52                   	push   %edx
  801a0a:	50                   	push   %eax
  801a0b:	6a 07                	push   $0x7
  801a0d:	e8 fb fe ff ff       	call   80190d <syscall>
  801a12:	83 c4 18             	add    $0x18,%esp
}
  801a15:	c9                   	leave  
  801a16:	c3                   	ret    

00801a17 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801a17:	55                   	push   %ebp
  801a18:	89 e5                	mov    %esp,%ebp
  801a1a:	56                   	push   %esi
  801a1b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801a1c:	8b 75 18             	mov    0x18(%ebp),%esi
  801a1f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a22:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a25:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a28:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2b:	56                   	push   %esi
  801a2c:	53                   	push   %ebx
  801a2d:	51                   	push   %ecx
  801a2e:	52                   	push   %edx
  801a2f:	50                   	push   %eax
  801a30:	6a 08                	push   $0x8
  801a32:	e8 d6 fe ff ff       	call   80190d <syscall>
  801a37:	83 c4 18             	add    $0x18,%esp
}
  801a3a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801a3d:	5b                   	pop    %ebx
  801a3e:	5e                   	pop    %esi
  801a3f:	5d                   	pop    %ebp
  801a40:	c3                   	ret    

00801a41 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801a41:	55                   	push   %ebp
  801a42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801a44:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a47:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	52                   	push   %edx
  801a51:	50                   	push   %eax
  801a52:	6a 09                	push   $0x9
  801a54:	e8 b4 fe ff ff       	call   80190d <syscall>
  801a59:	83 c4 18             	add    $0x18,%esp
}
  801a5c:	c9                   	leave  
  801a5d:	c3                   	ret    

00801a5e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801a5e:	55                   	push   %ebp
  801a5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	ff 75 0c             	pushl  0xc(%ebp)
  801a6a:	ff 75 08             	pushl  0x8(%ebp)
  801a6d:	6a 0a                	push   $0xa
  801a6f:	e8 99 fe ff ff       	call   80190d <syscall>
  801a74:	83 c4 18             	add    $0x18,%esp
}
  801a77:	c9                   	leave  
  801a78:	c3                   	ret    

00801a79 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801a79:	55                   	push   %ebp
  801a7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	6a 0b                	push   $0xb
  801a88:	e8 80 fe ff ff       	call   80190d <syscall>
  801a8d:	83 c4 18             	add    $0x18,%esp
}
  801a90:	c9                   	leave  
  801a91:	c3                   	ret    

00801a92 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801a92:	55                   	push   %ebp
  801a93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 0c                	push   $0xc
  801aa1:	e8 67 fe ff ff       	call   80190d <syscall>
  801aa6:	83 c4 18             	add    $0x18,%esp
}
  801aa9:	c9                   	leave  
  801aaa:	c3                   	ret    

00801aab <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801aab:	55                   	push   %ebp
  801aac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 0d                	push   $0xd
  801aba:	e8 4e fe ff ff       	call   80190d <syscall>
  801abf:	83 c4 18             	add    $0x18,%esp
}
  801ac2:	c9                   	leave  
  801ac3:	c3                   	ret    

00801ac4 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ac4:	55                   	push   %ebp
  801ac5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	ff 75 0c             	pushl  0xc(%ebp)
  801ad0:	ff 75 08             	pushl  0x8(%ebp)
  801ad3:	6a 11                	push   $0x11
  801ad5:	e8 33 fe ff ff       	call   80190d <syscall>
  801ada:	83 c4 18             	add    $0x18,%esp
	return;
  801add:	90                   	nop
}
  801ade:	c9                   	leave  
  801adf:	c3                   	ret    

00801ae0 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801ae0:	55                   	push   %ebp
  801ae1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	ff 75 0c             	pushl  0xc(%ebp)
  801aec:	ff 75 08             	pushl  0x8(%ebp)
  801aef:	6a 12                	push   $0x12
  801af1:	e8 17 fe ff ff       	call   80190d <syscall>
  801af6:	83 c4 18             	add    $0x18,%esp
	return ;
  801af9:	90                   	nop
}
  801afa:	c9                   	leave  
  801afb:	c3                   	ret    

00801afc <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801afc:	55                   	push   %ebp
  801afd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	6a 0e                	push   $0xe
  801b0b:	e8 fd fd ff ff       	call   80190d <syscall>
  801b10:	83 c4 18             	add    $0x18,%esp
}
  801b13:	c9                   	leave  
  801b14:	c3                   	ret    

00801b15 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801b15:	55                   	push   %ebp
  801b16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 00                	push   $0x0
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	ff 75 08             	pushl  0x8(%ebp)
  801b23:	6a 0f                	push   $0xf
  801b25:	e8 e3 fd ff ff       	call   80190d <syscall>
  801b2a:	83 c4 18             	add    $0x18,%esp
}
  801b2d:	c9                   	leave  
  801b2e:	c3                   	ret    

00801b2f <sys_scarce_memory>:

void sys_scarce_memory()
{
  801b2f:	55                   	push   %ebp
  801b30:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 00                	push   $0x0
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 10                	push   $0x10
  801b3e:	e8 ca fd ff ff       	call   80190d <syscall>
  801b43:	83 c4 18             	add    $0x18,%esp
}
  801b46:	90                   	nop
  801b47:	c9                   	leave  
  801b48:	c3                   	ret    

00801b49 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801b49:	55                   	push   %ebp
  801b4a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	6a 00                	push   $0x0
  801b54:	6a 00                	push   $0x0
  801b56:	6a 14                	push   $0x14
  801b58:	e8 b0 fd ff ff       	call   80190d <syscall>
  801b5d:	83 c4 18             	add    $0x18,%esp
}
  801b60:	90                   	nop
  801b61:	c9                   	leave  
  801b62:	c3                   	ret    

00801b63 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801b63:	55                   	push   %ebp
  801b64:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801b66:	6a 00                	push   $0x0
  801b68:	6a 00                	push   $0x0
  801b6a:	6a 00                	push   $0x0
  801b6c:	6a 00                	push   $0x0
  801b6e:	6a 00                	push   $0x0
  801b70:	6a 15                	push   $0x15
  801b72:	e8 96 fd ff ff       	call   80190d <syscall>
  801b77:	83 c4 18             	add    $0x18,%esp
}
  801b7a:	90                   	nop
  801b7b:	c9                   	leave  
  801b7c:	c3                   	ret    

00801b7d <sys_cputc>:


void
sys_cputc(const char c)
{
  801b7d:	55                   	push   %ebp
  801b7e:	89 e5                	mov    %esp,%ebp
  801b80:	83 ec 04             	sub    $0x4,%esp
  801b83:	8b 45 08             	mov    0x8(%ebp),%eax
  801b86:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801b89:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	50                   	push   %eax
  801b96:	6a 16                	push   $0x16
  801b98:	e8 70 fd ff ff       	call   80190d <syscall>
  801b9d:	83 c4 18             	add    $0x18,%esp
}
  801ba0:	90                   	nop
  801ba1:	c9                   	leave  
  801ba2:	c3                   	ret    

00801ba3 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ba3:	55                   	push   %ebp
  801ba4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 17                	push   $0x17
  801bb2:	e8 56 fd ff ff       	call   80190d <syscall>
  801bb7:	83 c4 18             	add    $0x18,%esp
}
  801bba:	90                   	nop
  801bbb:	c9                   	leave  
  801bbc:	c3                   	ret    

00801bbd <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801bbd:	55                   	push   %ebp
  801bbe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	ff 75 0c             	pushl  0xc(%ebp)
  801bcc:	50                   	push   %eax
  801bcd:	6a 18                	push   $0x18
  801bcf:	e8 39 fd ff ff       	call   80190d <syscall>
  801bd4:	83 c4 18             	add    $0x18,%esp
}
  801bd7:	c9                   	leave  
  801bd8:	c3                   	ret    

00801bd9 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801bd9:	55                   	push   %ebp
  801bda:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801bdc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	52                   	push   %edx
  801be9:	50                   	push   %eax
  801bea:	6a 1b                	push   $0x1b
  801bec:	e8 1c fd ff ff       	call   80190d <syscall>
  801bf1:	83 c4 18             	add    $0x18,%esp
}
  801bf4:	c9                   	leave  
  801bf5:	c3                   	ret    

00801bf6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801bf6:	55                   	push   %ebp
  801bf7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801bf9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	52                   	push   %edx
  801c06:	50                   	push   %eax
  801c07:	6a 19                	push   $0x19
  801c09:	e8 ff fc ff ff       	call   80190d <syscall>
  801c0e:	83 c4 18             	add    $0x18,%esp
}
  801c11:	90                   	nop
  801c12:	c9                   	leave  
  801c13:	c3                   	ret    

00801c14 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c14:	55                   	push   %ebp
  801c15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c17:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	52                   	push   %edx
  801c24:	50                   	push   %eax
  801c25:	6a 1a                	push   $0x1a
  801c27:	e8 e1 fc ff ff       	call   80190d <syscall>
  801c2c:	83 c4 18             	add    $0x18,%esp
}
  801c2f:	90                   	nop
  801c30:	c9                   	leave  
  801c31:	c3                   	ret    

00801c32 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801c32:	55                   	push   %ebp
  801c33:	89 e5                	mov    %esp,%ebp
  801c35:	83 ec 04             	sub    $0x4,%esp
  801c38:	8b 45 10             	mov    0x10(%ebp),%eax
  801c3b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801c3e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801c41:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c45:	8b 45 08             	mov    0x8(%ebp),%eax
  801c48:	6a 00                	push   $0x0
  801c4a:	51                   	push   %ecx
  801c4b:	52                   	push   %edx
  801c4c:	ff 75 0c             	pushl  0xc(%ebp)
  801c4f:	50                   	push   %eax
  801c50:	6a 1c                	push   $0x1c
  801c52:	e8 b6 fc ff ff       	call   80190d <syscall>
  801c57:	83 c4 18             	add    $0x18,%esp
}
  801c5a:	c9                   	leave  
  801c5b:	c3                   	ret    

00801c5c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801c5c:	55                   	push   %ebp
  801c5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801c5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c62:	8b 45 08             	mov    0x8(%ebp),%eax
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	52                   	push   %edx
  801c6c:	50                   	push   %eax
  801c6d:	6a 1d                	push   $0x1d
  801c6f:	e8 99 fc ff ff       	call   80190d <syscall>
  801c74:	83 c4 18             	add    $0x18,%esp
}
  801c77:	c9                   	leave  
  801c78:	c3                   	ret    

00801c79 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801c79:	55                   	push   %ebp
  801c7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801c7c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c82:	8b 45 08             	mov    0x8(%ebp),%eax
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	51                   	push   %ecx
  801c8a:	52                   	push   %edx
  801c8b:	50                   	push   %eax
  801c8c:	6a 1e                	push   $0x1e
  801c8e:	e8 7a fc ff ff       	call   80190d <syscall>
  801c93:	83 c4 18             	add    $0x18,%esp
}
  801c96:	c9                   	leave  
  801c97:	c3                   	ret    

00801c98 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801c98:	55                   	push   %ebp
  801c99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801c9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca1:	6a 00                	push   $0x0
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	52                   	push   %edx
  801ca8:	50                   	push   %eax
  801ca9:	6a 1f                	push   $0x1f
  801cab:	e8 5d fc ff ff       	call   80190d <syscall>
  801cb0:	83 c4 18             	add    $0x18,%esp
}
  801cb3:	c9                   	leave  
  801cb4:	c3                   	ret    

00801cb5 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801cb5:	55                   	push   %ebp
  801cb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 20                	push   $0x20
  801cc4:	e8 44 fc ff ff       	call   80190d <syscall>
  801cc9:	83 c4 18             	add    $0x18,%esp
}
  801ccc:	c9                   	leave  
  801ccd:	c3                   	ret    

00801cce <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801cce:	55                   	push   %ebp
  801ccf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd4:	6a 00                	push   $0x0
  801cd6:	ff 75 14             	pushl  0x14(%ebp)
  801cd9:	ff 75 10             	pushl  0x10(%ebp)
  801cdc:	ff 75 0c             	pushl  0xc(%ebp)
  801cdf:	50                   	push   %eax
  801ce0:	6a 21                	push   $0x21
  801ce2:	e8 26 fc ff ff       	call   80190d <syscall>
  801ce7:	83 c4 18             	add    $0x18,%esp
}
  801cea:	c9                   	leave  
  801ceb:	c3                   	ret    

00801cec <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801cec:	55                   	push   %ebp
  801ced:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801cef:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	50                   	push   %eax
  801cfb:	6a 22                	push   $0x22
  801cfd:	e8 0b fc ff ff       	call   80190d <syscall>
  801d02:	83 c4 18             	add    $0x18,%esp
}
  801d05:	90                   	nop
  801d06:	c9                   	leave  
  801d07:	c3                   	ret    

00801d08 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801d08:	55                   	push   %ebp
  801d09:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	50                   	push   %eax
  801d17:	6a 23                	push   $0x23
  801d19:	e8 ef fb ff ff       	call   80190d <syscall>
  801d1e:	83 c4 18             	add    $0x18,%esp
}
  801d21:	90                   	nop
  801d22:	c9                   	leave  
  801d23:	c3                   	ret    

00801d24 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801d24:	55                   	push   %ebp
  801d25:	89 e5                	mov    %esp,%ebp
  801d27:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801d2a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d2d:	8d 50 04             	lea    0x4(%eax),%edx
  801d30:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d33:	6a 00                	push   $0x0
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	52                   	push   %edx
  801d3a:	50                   	push   %eax
  801d3b:	6a 24                	push   $0x24
  801d3d:	e8 cb fb ff ff       	call   80190d <syscall>
  801d42:	83 c4 18             	add    $0x18,%esp
	return result;
  801d45:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d48:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d4b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d4e:	89 01                	mov    %eax,(%ecx)
  801d50:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801d53:	8b 45 08             	mov    0x8(%ebp),%eax
  801d56:	c9                   	leave  
  801d57:	c2 04 00             	ret    $0x4

00801d5a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801d5a:	55                   	push   %ebp
  801d5b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	ff 75 10             	pushl  0x10(%ebp)
  801d64:	ff 75 0c             	pushl  0xc(%ebp)
  801d67:	ff 75 08             	pushl  0x8(%ebp)
  801d6a:	6a 13                	push   $0x13
  801d6c:	e8 9c fb ff ff       	call   80190d <syscall>
  801d71:	83 c4 18             	add    $0x18,%esp
	return ;
  801d74:	90                   	nop
}
  801d75:	c9                   	leave  
  801d76:	c3                   	ret    

00801d77 <sys_rcr2>:
uint32 sys_rcr2()
{
  801d77:	55                   	push   %ebp
  801d78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d7a:	6a 00                	push   $0x0
  801d7c:	6a 00                	push   $0x0
  801d7e:	6a 00                	push   $0x0
  801d80:	6a 00                	push   $0x0
  801d82:	6a 00                	push   $0x0
  801d84:	6a 25                	push   $0x25
  801d86:	e8 82 fb ff ff       	call   80190d <syscall>
  801d8b:	83 c4 18             	add    $0x18,%esp
}
  801d8e:	c9                   	leave  
  801d8f:	c3                   	ret    

00801d90 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801d90:	55                   	push   %ebp
  801d91:	89 e5                	mov    %esp,%ebp
  801d93:	83 ec 04             	sub    $0x4,%esp
  801d96:	8b 45 08             	mov    0x8(%ebp),%eax
  801d99:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801d9c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	50                   	push   %eax
  801da9:	6a 26                	push   $0x26
  801dab:	e8 5d fb ff ff       	call   80190d <syscall>
  801db0:	83 c4 18             	add    $0x18,%esp
	return ;
  801db3:	90                   	nop
}
  801db4:	c9                   	leave  
  801db5:	c3                   	ret    

00801db6 <rsttst>:
void rsttst()
{
  801db6:	55                   	push   %ebp
  801db7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 28                	push   $0x28
  801dc5:	e8 43 fb ff ff       	call   80190d <syscall>
  801dca:	83 c4 18             	add    $0x18,%esp
	return ;
  801dcd:	90                   	nop
}
  801dce:	c9                   	leave  
  801dcf:	c3                   	ret    

00801dd0 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801dd0:	55                   	push   %ebp
  801dd1:	89 e5                	mov    %esp,%ebp
  801dd3:	83 ec 04             	sub    $0x4,%esp
  801dd6:	8b 45 14             	mov    0x14(%ebp),%eax
  801dd9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ddc:	8b 55 18             	mov    0x18(%ebp),%edx
  801ddf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801de3:	52                   	push   %edx
  801de4:	50                   	push   %eax
  801de5:	ff 75 10             	pushl  0x10(%ebp)
  801de8:	ff 75 0c             	pushl  0xc(%ebp)
  801deb:	ff 75 08             	pushl  0x8(%ebp)
  801dee:	6a 27                	push   $0x27
  801df0:	e8 18 fb ff ff       	call   80190d <syscall>
  801df5:	83 c4 18             	add    $0x18,%esp
	return ;
  801df8:	90                   	nop
}
  801df9:	c9                   	leave  
  801dfa:	c3                   	ret    

00801dfb <chktst>:
void chktst(uint32 n)
{
  801dfb:	55                   	push   %ebp
  801dfc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 00                	push   $0x0
  801e06:	ff 75 08             	pushl  0x8(%ebp)
  801e09:	6a 29                	push   $0x29
  801e0b:	e8 fd fa ff ff       	call   80190d <syscall>
  801e10:	83 c4 18             	add    $0x18,%esp
	return ;
  801e13:	90                   	nop
}
  801e14:	c9                   	leave  
  801e15:	c3                   	ret    

00801e16 <inctst>:

void inctst()
{
  801e16:	55                   	push   %ebp
  801e17:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	6a 2a                	push   $0x2a
  801e25:	e8 e3 fa ff ff       	call   80190d <syscall>
  801e2a:	83 c4 18             	add    $0x18,%esp
	return ;
  801e2d:	90                   	nop
}
  801e2e:	c9                   	leave  
  801e2f:	c3                   	ret    

00801e30 <gettst>:
uint32 gettst()
{
  801e30:	55                   	push   %ebp
  801e31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	6a 00                	push   $0x0
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 2b                	push   $0x2b
  801e3f:	e8 c9 fa ff ff       	call   80190d <syscall>
  801e44:	83 c4 18             	add    $0x18,%esp
}
  801e47:	c9                   	leave  
  801e48:	c3                   	ret    

00801e49 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801e49:	55                   	push   %ebp
  801e4a:	89 e5                	mov    %esp,%ebp
  801e4c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 2c                	push   $0x2c
  801e5b:	e8 ad fa ff ff       	call   80190d <syscall>
  801e60:	83 c4 18             	add    $0x18,%esp
  801e63:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801e66:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801e6a:	75 07                	jne    801e73 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801e6c:	b8 01 00 00 00       	mov    $0x1,%eax
  801e71:	eb 05                	jmp    801e78 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801e73:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e78:	c9                   	leave  
  801e79:	c3                   	ret    

00801e7a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801e7a:	55                   	push   %ebp
  801e7b:	89 e5                	mov    %esp,%ebp
  801e7d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e80:	6a 00                	push   $0x0
  801e82:	6a 00                	push   $0x0
  801e84:	6a 00                	push   $0x0
  801e86:	6a 00                	push   $0x0
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 2c                	push   $0x2c
  801e8c:	e8 7c fa ff ff       	call   80190d <syscall>
  801e91:	83 c4 18             	add    $0x18,%esp
  801e94:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801e97:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801e9b:	75 07                	jne    801ea4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801e9d:	b8 01 00 00 00       	mov    $0x1,%eax
  801ea2:	eb 05                	jmp    801ea9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ea4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ea9:	c9                   	leave  
  801eaa:	c3                   	ret    

00801eab <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801eab:	55                   	push   %ebp
  801eac:	89 e5                	mov    %esp,%ebp
  801eae:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 00                	push   $0x0
  801eb7:	6a 00                	push   $0x0
  801eb9:	6a 00                	push   $0x0
  801ebb:	6a 2c                	push   $0x2c
  801ebd:	e8 4b fa ff ff       	call   80190d <syscall>
  801ec2:	83 c4 18             	add    $0x18,%esp
  801ec5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ec8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ecc:	75 07                	jne    801ed5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ece:	b8 01 00 00 00       	mov    $0x1,%eax
  801ed3:	eb 05                	jmp    801eda <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ed5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801eda:	c9                   	leave  
  801edb:	c3                   	ret    

00801edc <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801edc:	55                   	push   %ebp
  801edd:	89 e5                	mov    %esp,%ebp
  801edf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 00                	push   $0x0
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 00                	push   $0x0
  801eec:	6a 2c                	push   $0x2c
  801eee:	e8 1a fa ff ff       	call   80190d <syscall>
  801ef3:	83 c4 18             	add    $0x18,%esp
  801ef6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ef9:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801efd:	75 07                	jne    801f06 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801eff:	b8 01 00 00 00       	mov    $0x1,%eax
  801f04:	eb 05                	jmp    801f0b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801f06:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f0b:	c9                   	leave  
  801f0c:	c3                   	ret    

00801f0d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801f0d:	55                   	push   %ebp
  801f0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	ff 75 08             	pushl  0x8(%ebp)
  801f1b:	6a 2d                	push   $0x2d
  801f1d:	e8 eb f9 ff ff       	call   80190d <syscall>
  801f22:	83 c4 18             	add    $0x18,%esp
	return ;
  801f25:	90                   	nop
}
  801f26:	c9                   	leave  
  801f27:	c3                   	ret    

00801f28 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801f28:	55                   	push   %ebp
  801f29:	89 e5                	mov    %esp,%ebp
  801f2b:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801f2c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f2f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f32:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f35:	8b 45 08             	mov    0x8(%ebp),%eax
  801f38:	6a 00                	push   $0x0
  801f3a:	53                   	push   %ebx
  801f3b:	51                   	push   %ecx
  801f3c:	52                   	push   %edx
  801f3d:	50                   	push   %eax
  801f3e:	6a 2e                	push   $0x2e
  801f40:	e8 c8 f9 ff ff       	call   80190d <syscall>
  801f45:	83 c4 18             	add    $0x18,%esp
}
  801f48:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801f4b:	c9                   	leave  
  801f4c:	c3                   	ret    

00801f4d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801f4d:	55                   	push   %ebp
  801f4e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801f50:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f53:	8b 45 08             	mov    0x8(%ebp),%eax
  801f56:	6a 00                	push   $0x0
  801f58:	6a 00                	push   $0x0
  801f5a:	6a 00                	push   $0x0
  801f5c:	52                   	push   %edx
  801f5d:	50                   	push   %eax
  801f5e:	6a 2f                	push   $0x2f
  801f60:	e8 a8 f9 ff ff       	call   80190d <syscall>
  801f65:	83 c4 18             	add    $0x18,%esp
}
  801f68:	c9                   	leave  
  801f69:	c3                   	ret    

00801f6a <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801f6a:	55                   	push   %ebp
  801f6b:	89 e5                	mov    %esp,%ebp
  801f6d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801f70:	8d 45 10             	lea    0x10(%ebp),%eax
  801f73:	83 c0 04             	add    $0x4,%eax
  801f76:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801f79:	a1 00 60 80 00       	mov    0x806000,%eax
  801f7e:	85 c0                	test   %eax,%eax
  801f80:	74 16                	je     801f98 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801f82:	a1 00 60 80 00       	mov    0x806000,%eax
  801f87:	83 ec 08             	sub    $0x8,%esp
  801f8a:	50                   	push   %eax
  801f8b:	68 20 28 80 00       	push   $0x802820
  801f90:	e8 07 e9 ff ff       	call   80089c <cprintf>
  801f95:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801f98:	a1 00 30 80 00       	mov    0x803000,%eax
  801f9d:	ff 75 0c             	pushl  0xc(%ebp)
  801fa0:	ff 75 08             	pushl  0x8(%ebp)
  801fa3:	50                   	push   %eax
  801fa4:	68 25 28 80 00       	push   $0x802825
  801fa9:	e8 ee e8 ff ff       	call   80089c <cprintf>
  801fae:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801fb1:	8b 45 10             	mov    0x10(%ebp),%eax
  801fb4:	83 ec 08             	sub    $0x8,%esp
  801fb7:	ff 75 f4             	pushl  -0xc(%ebp)
  801fba:	50                   	push   %eax
  801fbb:	e8 71 e8 ff ff       	call   800831 <vcprintf>
  801fc0:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801fc3:	83 ec 08             	sub    $0x8,%esp
  801fc6:	6a 00                	push   $0x0
  801fc8:	68 41 28 80 00       	push   $0x802841
  801fcd:	e8 5f e8 ff ff       	call   800831 <vcprintf>
  801fd2:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801fd5:	e8 e0 e7 ff ff       	call   8007ba <exit>

	// should not return here
	while (1) ;
  801fda:	eb fe                	jmp    801fda <_panic+0x70>

00801fdc <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801fdc:	55                   	push   %ebp
  801fdd:	89 e5                	mov    %esp,%ebp
  801fdf:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801fe2:	a1 20 30 80 00       	mov    0x803020,%eax
  801fe7:	8b 50 74             	mov    0x74(%eax),%edx
  801fea:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fed:	39 c2                	cmp    %eax,%edx
  801fef:	74 14                	je     802005 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801ff1:	83 ec 04             	sub    $0x4,%esp
  801ff4:	68 44 28 80 00       	push   $0x802844
  801ff9:	6a 26                	push   $0x26
  801ffb:	68 90 28 80 00       	push   $0x802890
  802000:	e8 65 ff ff ff       	call   801f6a <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  802005:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80200c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  802013:	e9 b6 00 00 00       	jmp    8020ce <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  802018:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80201b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802022:	8b 45 08             	mov    0x8(%ebp),%eax
  802025:	01 d0                	add    %edx,%eax
  802027:	8b 00                	mov    (%eax),%eax
  802029:	85 c0                	test   %eax,%eax
  80202b:	75 08                	jne    802035 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80202d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  802030:	e9 96 00 00 00       	jmp    8020cb <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  802035:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80203c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  802043:	eb 5d                	jmp    8020a2 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  802045:	a1 20 30 80 00       	mov    0x803020,%eax
  80204a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  802050:	8b 55 e8             	mov    -0x18(%ebp),%edx
  802053:	c1 e2 04             	shl    $0x4,%edx
  802056:	01 d0                	add    %edx,%eax
  802058:	8a 40 04             	mov    0x4(%eax),%al
  80205b:	84 c0                	test   %al,%al
  80205d:	75 40                	jne    80209f <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80205f:	a1 20 30 80 00       	mov    0x803020,%eax
  802064:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80206a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80206d:	c1 e2 04             	shl    $0x4,%edx
  802070:	01 d0                	add    %edx,%eax
  802072:	8b 00                	mov    (%eax),%eax
  802074:	89 45 dc             	mov    %eax,-0x24(%ebp)
  802077:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80207a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80207f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  802081:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802084:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80208b:	8b 45 08             	mov    0x8(%ebp),%eax
  80208e:	01 c8                	add    %ecx,%eax
  802090:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  802092:	39 c2                	cmp    %eax,%edx
  802094:	75 09                	jne    80209f <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  802096:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80209d:	eb 12                	jmp    8020b1 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80209f:	ff 45 e8             	incl   -0x18(%ebp)
  8020a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8020a7:	8b 50 74             	mov    0x74(%eax),%edx
  8020aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8020ad:	39 c2                	cmp    %eax,%edx
  8020af:	77 94                	ja     802045 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8020b1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8020b5:	75 14                	jne    8020cb <CheckWSWithoutLastIndex+0xef>
			panic(
  8020b7:	83 ec 04             	sub    $0x4,%esp
  8020ba:	68 9c 28 80 00       	push   $0x80289c
  8020bf:	6a 3a                	push   $0x3a
  8020c1:	68 90 28 80 00       	push   $0x802890
  8020c6:	e8 9f fe ff ff       	call   801f6a <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8020cb:	ff 45 f0             	incl   -0x10(%ebp)
  8020ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8020d1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8020d4:	0f 8c 3e ff ff ff    	jl     802018 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8020da:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8020e1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8020e8:	eb 20                	jmp    80210a <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8020ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8020ef:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8020f5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8020f8:	c1 e2 04             	shl    $0x4,%edx
  8020fb:	01 d0                	add    %edx,%eax
  8020fd:	8a 40 04             	mov    0x4(%eax),%al
  802100:	3c 01                	cmp    $0x1,%al
  802102:	75 03                	jne    802107 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  802104:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802107:	ff 45 e0             	incl   -0x20(%ebp)
  80210a:	a1 20 30 80 00       	mov    0x803020,%eax
  80210f:	8b 50 74             	mov    0x74(%eax),%edx
  802112:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802115:	39 c2                	cmp    %eax,%edx
  802117:	77 d1                	ja     8020ea <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  802119:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80211c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80211f:	74 14                	je     802135 <CheckWSWithoutLastIndex+0x159>
		panic(
  802121:	83 ec 04             	sub    $0x4,%esp
  802124:	68 f0 28 80 00       	push   $0x8028f0
  802129:	6a 44                	push   $0x44
  80212b:	68 90 28 80 00       	push   $0x802890
  802130:	e8 35 fe ff ff       	call   801f6a <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  802135:	90                   	nop
  802136:	c9                   	leave  
  802137:	c3                   	ret    

00802138 <__udivdi3>:
  802138:	55                   	push   %ebp
  802139:	57                   	push   %edi
  80213a:	56                   	push   %esi
  80213b:	53                   	push   %ebx
  80213c:	83 ec 1c             	sub    $0x1c,%esp
  80213f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802143:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802147:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80214b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80214f:	89 ca                	mov    %ecx,%edx
  802151:	89 f8                	mov    %edi,%eax
  802153:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802157:	85 f6                	test   %esi,%esi
  802159:	75 2d                	jne    802188 <__udivdi3+0x50>
  80215b:	39 cf                	cmp    %ecx,%edi
  80215d:	77 65                	ja     8021c4 <__udivdi3+0x8c>
  80215f:	89 fd                	mov    %edi,%ebp
  802161:	85 ff                	test   %edi,%edi
  802163:	75 0b                	jne    802170 <__udivdi3+0x38>
  802165:	b8 01 00 00 00       	mov    $0x1,%eax
  80216a:	31 d2                	xor    %edx,%edx
  80216c:	f7 f7                	div    %edi
  80216e:	89 c5                	mov    %eax,%ebp
  802170:	31 d2                	xor    %edx,%edx
  802172:	89 c8                	mov    %ecx,%eax
  802174:	f7 f5                	div    %ebp
  802176:	89 c1                	mov    %eax,%ecx
  802178:	89 d8                	mov    %ebx,%eax
  80217a:	f7 f5                	div    %ebp
  80217c:	89 cf                	mov    %ecx,%edi
  80217e:	89 fa                	mov    %edi,%edx
  802180:	83 c4 1c             	add    $0x1c,%esp
  802183:	5b                   	pop    %ebx
  802184:	5e                   	pop    %esi
  802185:	5f                   	pop    %edi
  802186:	5d                   	pop    %ebp
  802187:	c3                   	ret    
  802188:	39 ce                	cmp    %ecx,%esi
  80218a:	77 28                	ja     8021b4 <__udivdi3+0x7c>
  80218c:	0f bd fe             	bsr    %esi,%edi
  80218f:	83 f7 1f             	xor    $0x1f,%edi
  802192:	75 40                	jne    8021d4 <__udivdi3+0x9c>
  802194:	39 ce                	cmp    %ecx,%esi
  802196:	72 0a                	jb     8021a2 <__udivdi3+0x6a>
  802198:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80219c:	0f 87 9e 00 00 00    	ja     802240 <__udivdi3+0x108>
  8021a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8021a7:	89 fa                	mov    %edi,%edx
  8021a9:	83 c4 1c             	add    $0x1c,%esp
  8021ac:	5b                   	pop    %ebx
  8021ad:	5e                   	pop    %esi
  8021ae:	5f                   	pop    %edi
  8021af:	5d                   	pop    %ebp
  8021b0:	c3                   	ret    
  8021b1:	8d 76 00             	lea    0x0(%esi),%esi
  8021b4:	31 ff                	xor    %edi,%edi
  8021b6:	31 c0                	xor    %eax,%eax
  8021b8:	89 fa                	mov    %edi,%edx
  8021ba:	83 c4 1c             	add    $0x1c,%esp
  8021bd:	5b                   	pop    %ebx
  8021be:	5e                   	pop    %esi
  8021bf:	5f                   	pop    %edi
  8021c0:	5d                   	pop    %ebp
  8021c1:	c3                   	ret    
  8021c2:	66 90                	xchg   %ax,%ax
  8021c4:	89 d8                	mov    %ebx,%eax
  8021c6:	f7 f7                	div    %edi
  8021c8:	31 ff                	xor    %edi,%edi
  8021ca:	89 fa                	mov    %edi,%edx
  8021cc:	83 c4 1c             	add    $0x1c,%esp
  8021cf:	5b                   	pop    %ebx
  8021d0:	5e                   	pop    %esi
  8021d1:	5f                   	pop    %edi
  8021d2:	5d                   	pop    %ebp
  8021d3:	c3                   	ret    
  8021d4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8021d9:	89 eb                	mov    %ebp,%ebx
  8021db:	29 fb                	sub    %edi,%ebx
  8021dd:	89 f9                	mov    %edi,%ecx
  8021df:	d3 e6                	shl    %cl,%esi
  8021e1:	89 c5                	mov    %eax,%ebp
  8021e3:	88 d9                	mov    %bl,%cl
  8021e5:	d3 ed                	shr    %cl,%ebp
  8021e7:	89 e9                	mov    %ebp,%ecx
  8021e9:	09 f1                	or     %esi,%ecx
  8021eb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8021ef:	89 f9                	mov    %edi,%ecx
  8021f1:	d3 e0                	shl    %cl,%eax
  8021f3:	89 c5                	mov    %eax,%ebp
  8021f5:	89 d6                	mov    %edx,%esi
  8021f7:	88 d9                	mov    %bl,%cl
  8021f9:	d3 ee                	shr    %cl,%esi
  8021fb:	89 f9                	mov    %edi,%ecx
  8021fd:	d3 e2                	shl    %cl,%edx
  8021ff:	8b 44 24 08          	mov    0x8(%esp),%eax
  802203:	88 d9                	mov    %bl,%cl
  802205:	d3 e8                	shr    %cl,%eax
  802207:	09 c2                	or     %eax,%edx
  802209:	89 d0                	mov    %edx,%eax
  80220b:	89 f2                	mov    %esi,%edx
  80220d:	f7 74 24 0c          	divl   0xc(%esp)
  802211:	89 d6                	mov    %edx,%esi
  802213:	89 c3                	mov    %eax,%ebx
  802215:	f7 e5                	mul    %ebp
  802217:	39 d6                	cmp    %edx,%esi
  802219:	72 19                	jb     802234 <__udivdi3+0xfc>
  80221b:	74 0b                	je     802228 <__udivdi3+0xf0>
  80221d:	89 d8                	mov    %ebx,%eax
  80221f:	31 ff                	xor    %edi,%edi
  802221:	e9 58 ff ff ff       	jmp    80217e <__udivdi3+0x46>
  802226:	66 90                	xchg   %ax,%ax
  802228:	8b 54 24 08          	mov    0x8(%esp),%edx
  80222c:	89 f9                	mov    %edi,%ecx
  80222e:	d3 e2                	shl    %cl,%edx
  802230:	39 c2                	cmp    %eax,%edx
  802232:	73 e9                	jae    80221d <__udivdi3+0xe5>
  802234:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802237:	31 ff                	xor    %edi,%edi
  802239:	e9 40 ff ff ff       	jmp    80217e <__udivdi3+0x46>
  80223e:	66 90                	xchg   %ax,%ax
  802240:	31 c0                	xor    %eax,%eax
  802242:	e9 37 ff ff ff       	jmp    80217e <__udivdi3+0x46>
  802247:	90                   	nop

00802248 <__umoddi3>:
  802248:	55                   	push   %ebp
  802249:	57                   	push   %edi
  80224a:	56                   	push   %esi
  80224b:	53                   	push   %ebx
  80224c:	83 ec 1c             	sub    $0x1c,%esp
  80224f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802253:	8b 74 24 34          	mov    0x34(%esp),%esi
  802257:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80225b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80225f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802263:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802267:	89 f3                	mov    %esi,%ebx
  802269:	89 fa                	mov    %edi,%edx
  80226b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80226f:	89 34 24             	mov    %esi,(%esp)
  802272:	85 c0                	test   %eax,%eax
  802274:	75 1a                	jne    802290 <__umoddi3+0x48>
  802276:	39 f7                	cmp    %esi,%edi
  802278:	0f 86 a2 00 00 00    	jbe    802320 <__umoddi3+0xd8>
  80227e:	89 c8                	mov    %ecx,%eax
  802280:	89 f2                	mov    %esi,%edx
  802282:	f7 f7                	div    %edi
  802284:	89 d0                	mov    %edx,%eax
  802286:	31 d2                	xor    %edx,%edx
  802288:	83 c4 1c             	add    $0x1c,%esp
  80228b:	5b                   	pop    %ebx
  80228c:	5e                   	pop    %esi
  80228d:	5f                   	pop    %edi
  80228e:	5d                   	pop    %ebp
  80228f:	c3                   	ret    
  802290:	39 f0                	cmp    %esi,%eax
  802292:	0f 87 ac 00 00 00    	ja     802344 <__umoddi3+0xfc>
  802298:	0f bd e8             	bsr    %eax,%ebp
  80229b:	83 f5 1f             	xor    $0x1f,%ebp
  80229e:	0f 84 ac 00 00 00    	je     802350 <__umoddi3+0x108>
  8022a4:	bf 20 00 00 00       	mov    $0x20,%edi
  8022a9:	29 ef                	sub    %ebp,%edi
  8022ab:	89 fe                	mov    %edi,%esi
  8022ad:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8022b1:	89 e9                	mov    %ebp,%ecx
  8022b3:	d3 e0                	shl    %cl,%eax
  8022b5:	89 d7                	mov    %edx,%edi
  8022b7:	89 f1                	mov    %esi,%ecx
  8022b9:	d3 ef                	shr    %cl,%edi
  8022bb:	09 c7                	or     %eax,%edi
  8022bd:	89 e9                	mov    %ebp,%ecx
  8022bf:	d3 e2                	shl    %cl,%edx
  8022c1:	89 14 24             	mov    %edx,(%esp)
  8022c4:	89 d8                	mov    %ebx,%eax
  8022c6:	d3 e0                	shl    %cl,%eax
  8022c8:	89 c2                	mov    %eax,%edx
  8022ca:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022ce:	d3 e0                	shl    %cl,%eax
  8022d0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8022d4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022d8:	89 f1                	mov    %esi,%ecx
  8022da:	d3 e8                	shr    %cl,%eax
  8022dc:	09 d0                	or     %edx,%eax
  8022de:	d3 eb                	shr    %cl,%ebx
  8022e0:	89 da                	mov    %ebx,%edx
  8022e2:	f7 f7                	div    %edi
  8022e4:	89 d3                	mov    %edx,%ebx
  8022e6:	f7 24 24             	mull   (%esp)
  8022e9:	89 c6                	mov    %eax,%esi
  8022eb:	89 d1                	mov    %edx,%ecx
  8022ed:	39 d3                	cmp    %edx,%ebx
  8022ef:	0f 82 87 00 00 00    	jb     80237c <__umoddi3+0x134>
  8022f5:	0f 84 91 00 00 00    	je     80238c <__umoddi3+0x144>
  8022fb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8022ff:	29 f2                	sub    %esi,%edx
  802301:	19 cb                	sbb    %ecx,%ebx
  802303:	89 d8                	mov    %ebx,%eax
  802305:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802309:	d3 e0                	shl    %cl,%eax
  80230b:	89 e9                	mov    %ebp,%ecx
  80230d:	d3 ea                	shr    %cl,%edx
  80230f:	09 d0                	or     %edx,%eax
  802311:	89 e9                	mov    %ebp,%ecx
  802313:	d3 eb                	shr    %cl,%ebx
  802315:	89 da                	mov    %ebx,%edx
  802317:	83 c4 1c             	add    $0x1c,%esp
  80231a:	5b                   	pop    %ebx
  80231b:	5e                   	pop    %esi
  80231c:	5f                   	pop    %edi
  80231d:	5d                   	pop    %ebp
  80231e:	c3                   	ret    
  80231f:	90                   	nop
  802320:	89 fd                	mov    %edi,%ebp
  802322:	85 ff                	test   %edi,%edi
  802324:	75 0b                	jne    802331 <__umoddi3+0xe9>
  802326:	b8 01 00 00 00       	mov    $0x1,%eax
  80232b:	31 d2                	xor    %edx,%edx
  80232d:	f7 f7                	div    %edi
  80232f:	89 c5                	mov    %eax,%ebp
  802331:	89 f0                	mov    %esi,%eax
  802333:	31 d2                	xor    %edx,%edx
  802335:	f7 f5                	div    %ebp
  802337:	89 c8                	mov    %ecx,%eax
  802339:	f7 f5                	div    %ebp
  80233b:	89 d0                	mov    %edx,%eax
  80233d:	e9 44 ff ff ff       	jmp    802286 <__umoddi3+0x3e>
  802342:	66 90                	xchg   %ax,%ax
  802344:	89 c8                	mov    %ecx,%eax
  802346:	89 f2                	mov    %esi,%edx
  802348:	83 c4 1c             	add    $0x1c,%esp
  80234b:	5b                   	pop    %ebx
  80234c:	5e                   	pop    %esi
  80234d:	5f                   	pop    %edi
  80234e:	5d                   	pop    %ebp
  80234f:	c3                   	ret    
  802350:	3b 04 24             	cmp    (%esp),%eax
  802353:	72 06                	jb     80235b <__umoddi3+0x113>
  802355:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802359:	77 0f                	ja     80236a <__umoddi3+0x122>
  80235b:	89 f2                	mov    %esi,%edx
  80235d:	29 f9                	sub    %edi,%ecx
  80235f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802363:	89 14 24             	mov    %edx,(%esp)
  802366:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80236a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80236e:	8b 14 24             	mov    (%esp),%edx
  802371:	83 c4 1c             	add    $0x1c,%esp
  802374:	5b                   	pop    %ebx
  802375:	5e                   	pop    %esi
  802376:	5f                   	pop    %edi
  802377:	5d                   	pop    %ebp
  802378:	c3                   	ret    
  802379:	8d 76 00             	lea    0x0(%esi),%esi
  80237c:	2b 04 24             	sub    (%esp),%eax
  80237f:	19 fa                	sbb    %edi,%edx
  802381:	89 d1                	mov    %edx,%ecx
  802383:	89 c6                	mov    %eax,%esi
  802385:	e9 71 ff ff ff       	jmp    8022fb <__umoddi3+0xb3>
  80238a:	66 90                	xchg   %ax,%ax
  80238c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802390:	72 ea                	jb     80237c <__umoddi3+0x134>
  802392:	89 d9                	mov    %ebx,%ecx
  802394:	e9 62 ff ff ff       	jmp    8022fb <__umoddi3+0xb3>
