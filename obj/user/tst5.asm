
obj/user/tst5:     file format elf32-i386


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
  800031:	e8 58 07 00 00       	call   80078e <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 ec 60             	sub    $0x60,%esp
	
	rsttst();
  800040:	e8 36 1e 00 00       	call   801e7b <rsttst>
	
	

	int Mega = 1024*1024;
  800045:	c7 45 f4 00 00 10 00 	movl   $0x100000,-0xc(%ebp)
	int kilo = 1024;
  80004c:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
	void* ptr_allocations[20] = {0};
  800053:	8d 55 9c             	lea    -0x64(%ebp),%edx
  800056:	b9 14 00 00 00       	mov    $0x14,%ecx
  80005b:	b8 00 00 00 00       	mov    $0x0,%eax
  800060:	89 d7                	mov    %edx,%edi
  800062:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	//[1] Allocate all
	{
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800064:	e8 d5 1a 00 00       	call   801b3e <sys_calculate_free_frames>
  800069:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[0] = malloc(1*Mega-kilo);
  80006c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80006f:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800072:	83 ec 0c             	sub    $0xc,%esp
  800075:	50                   	push   %eax
  800076:	e8 b6 16 00 00       	call   801731 <malloc>
  80007b:	83 c4 10             	add    $0x10,%esp
  80007e:	89 45 9c             	mov    %eax,-0x64(%ebp)
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
  800081:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800084:	83 ec 0c             	sub    $0xc,%esp
  800087:	6a 00                	push   $0x0
  800089:	6a 62                	push   $0x62
  80008b:	68 00 10 00 80       	push   $0x80001000
  800090:	68 00 00 00 80       	push   $0x80000000
  800095:	50                   	push   %eax
  800096:	e8 fa 1d 00 00       	call   801e95 <tst>
  80009b:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256+1 ,0, 'e', 0);
  80009e:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8000a1:	e8 98 1a 00 00       	call   801b3e <sys_calculate_free_frames>
  8000a6:	29 c3                	sub    %eax,%ebx
  8000a8:	89 d8                	mov    %ebx,%eax
  8000aa:	83 ec 0c             	sub    $0xc,%esp
  8000ad:	6a 00                	push   $0x0
  8000af:	6a 65                	push   $0x65
  8000b1:	6a 00                	push   $0x0
  8000b3:	68 01 01 00 00       	push   $0x101
  8000b8:	50                   	push   %eax
  8000b9:	e8 d7 1d 00 00       	call   801e95 <tst>
  8000be:	83 c4 20             	add    $0x20,%esp

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000c1:	e8 78 1a 00 00       	call   801b3e <sys_calculate_free_frames>
  8000c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  8000c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cc:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	50                   	push   %eax
  8000d3:	e8 59 16 00 00       	call   801731 <malloc>
  8000d8:	83 c4 10             	add    $0x10,%esp
  8000db:	89 45 a0             	mov    %eax,-0x60(%ebp)
		tst((uint32) ptr_allocations[1], USER_HEAP_START + 1*Mega,USER_HEAP_START + 1*Mega + PAGE_SIZE, 'b', 0);
  8000de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000e1:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8000e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000ea:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8000f0:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8000f3:	83 ec 0c             	sub    $0xc,%esp
  8000f6:	6a 00                	push   $0x0
  8000f8:	6a 62                	push   $0x62
  8000fa:	51                   	push   %ecx
  8000fb:	52                   	push   %edx
  8000fc:	50                   	push   %eax
  8000fd:	e8 93 1d 00 00       	call   801e95 <tst>
  800102:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256 ,0, 'e', 0);
  800105:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800108:	e8 31 1a 00 00       	call   801b3e <sys_calculate_free_frames>
  80010d:	29 c3                	sub    %eax,%ebx
  80010f:	89 d8                	mov    %ebx,%eax
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	6a 00                	push   $0x0
  800116:	6a 65                	push   $0x65
  800118:	6a 00                	push   $0x0
  80011a:	68 00 01 00 00       	push   $0x100
  80011f:	50                   	push   %eax
  800120:	e8 70 1d 00 00       	call   801e95 <tst>
  800125:	83 c4 20             	add    $0x20,%esp

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800128:	e8 11 1a 00 00       	call   801b3e <sys_calculate_free_frames>
  80012d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  800130:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800133:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800136:	83 ec 0c             	sub    $0xc,%esp
  800139:	50                   	push   %eax
  80013a:	e8 f2 15 00 00       	call   801731 <malloc>
  80013f:	83 c4 10             	add    $0x10,%esp
  800142:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		tst((uint32) ptr_allocations[2], USER_HEAP_START + 2*Mega,USER_HEAP_START + 2*Mega + PAGE_SIZE, 'b', 0);
  800145:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800148:	01 c0                	add    %eax,%eax
  80014a:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800150:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800153:	01 c0                	add    %eax,%eax
  800155:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80015b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80015e:	83 ec 0c             	sub    $0xc,%esp
  800161:	6a 00                	push   $0x0
  800163:	6a 62                	push   $0x62
  800165:	51                   	push   %ecx
  800166:	52                   	push   %edx
  800167:	50                   	push   %eax
  800168:	e8 28 1d 00 00       	call   801e95 <tst>
  80016d:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256 ,0, 'e', 0);
  800170:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800173:	e8 c6 19 00 00       	call   801b3e <sys_calculate_free_frames>
  800178:	29 c3                	sub    %eax,%ebx
  80017a:	89 d8                	mov    %ebx,%eax
  80017c:	83 ec 0c             	sub    $0xc,%esp
  80017f:	6a 00                	push   $0x0
  800181:	6a 65                	push   $0x65
  800183:	6a 00                	push   $0x0
  800185:	68 00 01 00 00       	push   $0x100
  80018a:	50                   	push   %eax
  80018b:	e8 05 1d 00 00       	call   801e95 <tst>
  800190:	83 c4 20             	add    $0x20,%esp

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800193:	e8 a6 19 00 00       	call   801b3e <sys_calculate_free_frames>
  800198:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  80019b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80019e:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8001a1:	83 ec 0c             	sub    $0xc,%esp
  8001a4:	50                   	push   %eax
  8001a5:	e8 87 15 00 00       	call   801731 <malloc>
  8001aa:	83 c4 10             	add    $0x10,%esp
  8001ad:	89 45 a8             	mov    %eax,-0x58(%ebp)
		tst((uint32) ptr_allocations[3], USER_HEAP_START + 3*Mega,USER_HEAP_START + 3*Mega + PAGE_SIZE, 'b', 0);
  8001b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001b3:	89 c2                	mov    %eax,%edx
  8001b5:	01 d2                	add    %edx,%edx
  8001b7:	01 d0                	add    %edx,%eax
  8001b9:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8001bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001c2:	89 c2                	mov    %eax,%edx
  8001c4:	01 d2                	add    %edx,%edx
  8001c6:	01 d0                	add    %edx,%eax
  8001c8:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8001ce:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8001d1:	83 ec 0c             	sub    $0xc,%esp
  8001d4:	6a 00                	push   $0x0
  8001d6:	6a 62                	push   $0x62
  8001d8:	51                   	push   %ecx
  8001d9:	52                   	push   %edx
  8001da:	50                   	push   %eax
  8001db:	e8 b5 1c 00 00       	call   801e95 <tst>
  8001e0:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256 ,0, 'e', 0);
  8001e3:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8001e6:	e8 53 19 00 00       	call   801b3e <sys_calculate_free_frames>
  8001eb:	29 c3                	sub    %eax,%ebx
  8001ed:	89 d8                	mov    %ebx,%eax
  8001ef:	83 ec 0c             	sub    $0xc,%esp
  8001f2:	6a 00                	push   $0x0
  8001f4:	6a 65                	push   $0x65
  8001f6:	6a 00                	push   $0x0
  8001f8:	68 00 01 00 00       	push   $0x100
  8001fd:	50                   	push   %eax
  8001fe:	e8 92 1c 00 00       	call   801e95 <tst>
  800203:	83 c4 20             	add    $0x20,%esp

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800206:	e8 33 19 00 00       	call   801b3e <sys_calculate_free_frames>
  80020b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  80020e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800211:	01 c0                	add    %eax,%eax
  800213:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800216:	83 ec 0c             	sub    $0xc,%esp
  800219:	50                   	push   %eax
  80021a:	e8 12 15 00 00       	call   801731 <malloc>
  80021f:	83 c4 10             	add    $0x10,%esp
  800222:	89 45 ac             	mov    %eax,-0x54(%ebp)
		tst((uint32) ptr_allocations[4], USER_HEAP_START + 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
  800225:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800228:	c1 e0 02             	shl    $0x2,%eax
  80022b:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800231:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800234:	c1 e0 02             	shl    $0x2,%eax
  800237:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80023d:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	6a 00                	push   $0x0
  800245:	6a 62                	push   $0x62
  800247:	51                   	push   %ecx
  800248:	52                   	push   %edx
  800249:	50                   	push   %eax
  80024a:	e8 46 1c 00 00       	call   801e95 <tst>
  80024f:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  800252:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800255:	e8 e4 18 00 00       	call   801b3e <sys_calculate_free_frames>
  80025a:	29 c3                	sub    %eax,%ebx
  80025c:	89 d8                	mov    %ebx,%eax
  80025e:	83 ec 0c             	sub    $0xc,%esp
  800261:	6a 00                	push   $0x0
  800263:	6a 65                	push   $0x65
  800265:	6a 00                	push   $0x0
  800267:	68 01 02 00 00       	push   $0x201
  80026c:	50                   	push   %eax
  80026d:	e8 23 1c 00 00       	call   801e95 <tst>
  800272:	83 c4 20             	add    $0x20,%esp

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800275:	e8 c4 18 00 00       	call   801b3e <sys_calculate_free_frames>
  80027a:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[5] = malloc(2*Mega-kilo);
  80027d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800280:	01 c0                	add    %eax,%eax
  800282:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800285:	83 ec 0c             	sub    $0xc,%esp
  800288:	50                   	push   %eax
  800289:	e8 a3 14 00 00       	call   801731 <malloc>
  80028e:	83 c4 10             	add    $0x10,%esp
  800291:	89 45 b0             	mov    %eax,-0x50(%ebp)
		tst((uint32) ptr_allocations[5], USER_HEAP_START + 6*Mega,USER_HEAP_START + 6*Mega + PAGE_SIZE, 'b', 0);
  800294:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800297:	89 d0                	mov    %edx,%eax
  800299:	01 c0                	add    %eax,%eax
  80029b:	01 d0                	add    %edx,%eax
  80029d:	01 c0                	add    %eax,%eax
  80029f:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8002a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002a8:	89 d0                	mov    %edx,%eax
  8002aa:	01 c0                	add    %eax,%eax
  8002ac:	01 d0                	add    %edx,%eax
  8002ae:	01 c0                	add    %eax,%eax
  8002b0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8002b6:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002b9:	83 ec 0c             	sub    $0xc,%esp
  8002bc:	6a 00                	push   $0x0
  8002be:	6a 62                	push   $0x62
  8002c0:	51                   	push   %ecx
  8002c1:	52                   	push   %edx
  8002c2:	50                   	push   %eax
  8002c3:	e8 cd 1b 00 00       	call   801e95 <tst>
  8002c8:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);
  8002cb:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8002ce:	e8 6b 18 00 00       	call   801b3e <sys_calculate_free_frames>
  8002d3:	29 c3                	sub    %eax,%ebx
  8002d5:	89 d8                	mov    %ebx,%eax
  8002d7:	83 ec 0c             	sub    $0xc,%esp
  8002da:	6a 00                	push   $0x0
  8002dc:	6a 65                	push   $0x65
  8002de:	6a 00                	push   $0x0
  8002e0:	68 00 02 00 00       	push   $0x200
  8002e5:	50                   	push   %eax
  8002e6:	e8 aa 1b 00 00       	call   801e95 <tst>
  8002eb:	83 c4 20             	add    $0x20,%esp

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8002ee:	e8 4b 18 00 00       	call   801b3e <sys_calculate_free_frames>
  8002f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  8002f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002f9:	89 c2                	mov    %eax,%edx
  8002fb:	01 d2                	add    %edx,%edx
  8002fd:	01 d0                	add    %edx,%eax
  8002ff:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800302:	83 ec 0c             	sub    $0xc,%esp
  800305:	50                   	push   %eax
  800306:	e8 26 14 00 00       	call   801731 <malloc>
  80030b:	83 c4 10             	add    $0x10,%esp
  80030e:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		tst((uint32) ptr_allocations[6], USER_HEAP_START + 8*Mega,USER_HEAP_START + 8*Mega + PAGE_SIZE, 'b', 0);
  800311:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800314:	c1 e0 03             	shl    $0x3,%eax
  800317:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  80031d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800320:	c1 e0 03             	shl    $0x3,%eax
  800323:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800329:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80032c:	83 ec 0c             	sub    $0xc,%esp
  80032f:	6a 00                	push   $0x0
  800331:	6a 62                	push   $0x62
  800333:	51                   	push   %ecx
  800334:	52                   	push   %edx
  800335:	50                   	push   %eax
  800336:	e8 5a 1b 00 00       	call   801e95 <tst>
  80033b:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 768+1 ,0, 'e', 0);
  80033e:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800341:	e8 f8 17 00 00       	call   801b3e <sys_calculate_free_frames>
  800346:	29 c3                	sub    %eax,%ebx
  800348:	89 d8                	mov    %ebx,%eax
  80034a:	83 ec 0c             	sub    $0xc,%esp
  80034d:	6a 00                	push   $0x0
  80034f:	6a 65                	push   $0x65
  800351:	6a 00                	push   $0x0
  800353:	68 01 03 00 00       	push   $0x301
  800358:	50                   	push   %eax
  800359:	e8 37 1b 00 00       	call   801e95 <tst>
  80035e:	83 c4 20             	add    $0x20,%esp

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  800361:	e8 d8 17 00 00       	call   801b3e <sys_calculate_free_frames>
  800366:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[7] = malloc(3*Mega-kilo);
  800369:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80036c:	89 c2                	mov    %eax,%edx
  80036e:	01 d2                	add    %edx,%edx
  800370:	01 d0                	add    %edx,%eax
  800372:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800375:	83 ec 0c             	sub    $0xc,%esp
  800378:	50                   	push   %eax
  800379:	e8 b3 13 00 00       	call   801731 <malloc>
  80037e:	83 c4 10             	add    $0x10,%esp
  800381:	89 45 b8             	mov    %eax,-0x48(%ebp)
		tst((uint32) ptr_allocations[7], USER_HEAP_START + 11*Mega,USER_HEAP_START + 11*Mega + PAGE_SIZE, 'b', 0);
  800384:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800387:	89 d0                	mov    %edx,%eax
  800389:	c1 e0 02             	shl    $0x2,%eax
  80038c:	01 d0                	add    %edx,%eax
  80038e:	01 c0                	add    %eax,%eax
  800390:	01 d0                	add    %edx,%eax
  800392:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800398:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80039b:	89 d0                	mov    %edx,%eax
  80039d:	c1 e0 02             	shl    $0x2,%eax
  8003a0:	01 d0                	add    %edx,%eax
  8003a2:	01 c0                	add    %eax,%eax
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8003ac:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8003af:	83 ec 0c             	sub    $0xc,%esp
  8003b2:	6a 00                	push   $0x0
  8003b4:	6a 62                	push   $0x62
  8003b6:	51                   	push   %ecx
  8003b7:	52                   	push   %edx
  8003b8:	50                   	push   %eax
  8003b9:	e8 d7 1a 00 00       	call   801e95 <tst>
  8003be:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 768+1 ,0, 'e', 0);
  8003c1:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8003c4:	e8 75 17 00 00       	call   801b3e <sys_calculate_free_frames>
  8003c9:	29 c3                	sub    %eax,%ebx
  8003cb:	89 d8                	mov    %ebx,%eax
  8003cd:	83 ec 0c             	sub    $0xc,%esp
  8003d0:	6a 00                	push   $0x0
  8003d2:	6a 65                	push   $0x65
  8003d4:	6a 00                	push   $0x0
  8003d6:	68 01 03 00 00       	push   $0x301
  8003db:	50                   	push   %eax
  8003dc:	e8 b4 1a 00 00       	call   801e95 <tst>
  8003e1:	83 c4 20             	add    $0x20,%esp
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8003e4:	e8 55 17 00 00       	call   801b3e <sys_calculate_free_frames>
  8003e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
		free(ptr_allocations[1]);
  8003ec:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003ef:	83 ec 0c             	sub    $0xc,%esp
  8003f2:	50                   	push   %eax
  8003f3:	e8 ef 14 00 00       	call   8018e7 <free>
  8003f8:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 256,0, 'e', 0);
  8003fb:	e8 3e 17 00 00       	call   801b3e <sys_calculate_free_frames>
  800400:	89 c2                	mov    %eax,%edx
  800402:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800405:	29 c2                	sub    %eax,%edx
  800407:	89 d0                	mov    %edx,%eax
  800409:	83 ec 0c             	sub    $0xc,%esp
  80040c:	6a 00                	push   $0x0
  80040e:	6a 65                	push   $0x65
  800410:	6a 00                	push   $0x0
  800412:	68 00 01 00 00       	push   $0x100
  800417:	50                   	push   %eax
  800418:	e8 78 1a 00 00       	call   801e95 <tst>
  80041d:	83 c4 20             	add    $0x20,%esp

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800420:	e8 19 17 00 00       	call   801b3e <sys_calculate_free_frames>
  800425:	89 45 ec             	mov    %eax,-0x14(%ebp)
		free(ptr_allocations[4]);
  800428:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80042b:	83 ec 0c             	sub    $0xc,%esp
  80042e:	50                   	push   %eax
  80042f:	e8 b3 14 00 00       	call   8018e7 <free>
  800434:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 512,0, 'e', 0);
  800437:	e8 02 17 00 00       	call   801b3e <sys_calculate_free_frames>
  80043c:	89 c2                	mov    %eax,%edx
  80043e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800441:	29 c2                	sub    %eax,%edx
  800443:	89 d0                	mov    %edx,%eax
  800445:	83 ec 0c             	sub    $0xc,%esp
  800448:	6a 00                	push   $0x0
  80044a:	6a 65                	push   $0x65
  80044c:	6a 00                	push   $0x0
  80044e:	68 00 02 00 00       	push   $0x200
  800453:	50                   	push   %eax
  800454:	e8 3c 1a 00 00       	call   801e95 <tst>
  800459:	83 c4 20             	add    $0x20,%esp

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80045c:	e8 dd 16 00 00       	call   801b3e <sys_calculate_free_frames>
  800461:	89 45 ec             	mov    %eax,-0x14(%ebp)
		free(ptr_allocations[6]);
  800464:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800467:	83 ec 0c             	sub    $0xc,%esp
  80046a:	50                   	push   %eax
  80046b:	e8 77 14 00 00       	call   8018e7 <free>
  800470:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 768,0, 'e', 0);
  800473:	e8 c6 16 00 00       	call   801b3e <sys_calculate_free_frames>
  800478:	89 c2                	mov    %eax,%edx
  80047a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80047d:	29 c2                	sub    %eax,%edx
  80047f:	89 d0                	mov    %edx,%eax
  800481:	83 ec 0c             	sub    $0xc,%esp
  800484:	6a 00                	push   $0x0
  800486:	6a 65                	push   $0x65
  800488:	6a 00                	push   $0x0
  80048a:	68 00 03 00 00       	push   $0x300
  80048f:	50                   	push   %eax
  800490:	e8 00 1a 00 00       	call   801e95 <tst>
  800495:	83 c4 20             	add    $0x20,%esp
	}

	//[3] Allocate again [test first fit]
	{
		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  800498:	e8 a1 16 00 00       	call   801b3e <sys_calculate_free_frames>
  80049d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[8] = malloc(512*kilo - kilo);
  8004a0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8004a3:	89 d0                	mov    %edx,%eax
  8004a5:	c1 e0 09             	shl    $0x9,%eax
  8004a8:	29 d0                	sub    %edx,%eax
  8004aa:	83 ec 0c             	sub    $0xc,%esp
  8004ad:	50                   	push   %eax
  8004ae:	e8 7e 12 00 00       	call   801731 <malloc>
  8004b3:	83 c4 10             	add    $0x10,%esp
  8004b6:	89 45 bc             	mov    %eax,-0x44(%ebp)
		tst((uint32) ptr_allocations[8], USER_HEAP_START + 1*Mega,USER_HEAP_START + 1*Mega + PAGE_SIZE, 'b', 0);
  8004b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004bc:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8004c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004c5:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8004cb:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8004ce:	83 ec 0c             	sub    $0xc,%esp
  8004d1:	6a 00                	push   $0x0
  8004d3:	6a 62                	push   $0x62
  8004d5:	51                   	push   %ecx
  8004d6:	52                   	push   %edx
  8004d7:	50                   	push   %eax
  8004d8:	e8 b8 19 00 00       	call   801e95 <tst>
  8004dd:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 128 ,0, 'e', 0);
  8004e0:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8004e3:	e8 56 16 00 00       	call   801b3e <sys_calculate_free_frames>
  8004e8:	29 c3                	sub    %eax,%ebx
  8004ea:	89 d8                	mov    %ebx,%eax
  8004ec:	83 ec 0c             	sub    $0xc,%esp
  8004ef:	6a 00                	push   $0x0
  8004f1:	6a 65                	push   $0x65
  8004f3:	6a 00                	push   $0x0
  8004f5:	68 80 00 00 00       	push   $0x80
  8004fa:	50                   	push   %eax
  8004fb:	e8 95 19 00 00       	call   801e95 <tst>
  800500:	83 c4 20             	add    $0x20,%esp

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800503:	e8 36 16 00 00       	call   801b3e <sys_calculate_free_frames>
  800508:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  80050b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80050e:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800511:	83 ec 0c             	sub    $0xc,%esp
  800514:	50                   	push   %eax
  800515:	e8 17 12 00 00       	call   801731 <malloc>
  80051a:	83 c4 10             	add    $0x10,%esp
  80051d:	89 45 c0             	mov    %eax,-0x40(%ebp)
		tst((uint32) ptr_allocations[9], USER_HEAP_START + 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
  800520:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800523:	c1 e0 02             	shl    $0x2,%eax
  800526:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  80052c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80052f:	c1 e0 02             	shl    $0x2,%eax
  800532:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800538:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80053b:	83 ec 0c             	sub    $0xc,%esp
  80053e:	6a 00                	push   $0x0
  800540:	6a 62                	push   $0x62
  800542:	51                   	push   %ecx
  800543:	52                   	push   %edx
  800544:	50                   	push   %eax
  800545:	e8 4b 19 00 00       	call   801e95 <tst>
  80054a:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 256,0, 'e', 0);
  80054d:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800550:	e8 e9 15 00 00       	call   801b3e <sys_calculate_free_frames>
  800555:	29 c3                	sub    %eax,%ebx
  800557:	89 d8                	mov    %ebx,%eax
  800559:	83 ec 0c             	sub    $0xc,%esp
  80055c:	6a 00                	push   $0x0
  80055e:	6a 65                	push   $0x65
  800560:	6a 00                	push   $0x0
  800562:	68 00 01 00 00       	push   $0x100
  800567:	50                   	push   %eax
  800568:	e8 28 19 00 00       	call   801e95 <tst>
  80056d:	83 c4 20             	add    $0x20,%esp

		//Allocate 256 KB - should be placed in remaining of 1st hole
		freeFrames = sys_calculate_free_frames() ;
  800570:	e8 c9 15 00 00       	call   801b3e <sys_calculate_free_frames>
  800575:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  800578:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80057b:	89 d0                	mov    %edx,%eax
  80057d:	c1 e0 08             	shl    $0x8,%eax
  800580:	29 d0                	sub    %edx,%eax
  800582:	83 ec 0c             	sub    $0xc,%esp
  800585:	50                   	push   %eax
  800586:	e8 a6 11 00 00       	call   801731 <malloc>
  80058b:	83 c4 10             	add    $0x10,%esp
  80058e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		tst((uint32) ptr_allocations[10], USER_HEAP_START + 1*Mega + 512*kilo,USER_HEAP_START + 1*Mega + 512*kilo + PAGE_SIZE, 'b', 0);
  800591:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800594:	c1 e0 09             	shl    $0x9,%eax
  800597:	89 c2                	mov    %eax,%edx
  800599:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80059c:	01 d0                	add    %edx,%eax
  80059e:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8005a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005a7:	c1 e0 09             	shl    $0x9,%eax
  8005aa:	89 c2                	mov    %eax,%edx
  8005ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005af:	01 d0                	add    %edx,%eax
  8005b1:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8005b7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8005ba:	83 ec 0c             	sub    $0xc,%esp
  8005bd:	6a 00                	push   $0x0
  8005bf:	6a 62                	push   $0x62
  8005c1:	51                   	push   %ecx
  8005c2:	52                   	push   %edx
  8005c3:	50                   	push   %eax
  8005c4:	e8 cc 18 00 00       	call   801e95 <tst>
  8005c9:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 64,0, 'e', 0);
  8005cc:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  8005cf:	e8 6a 15 00 00       	call   801b3e <sys_calculate_free_frames>
  8005d4:	29 c3                	sub    %eax,%ebx
  8005d6:	89 d8                	mov    %ebx,%eax
  8005d8:	83 ec 0c             	sub    $0xc,%esp
  8005db:	6a 00                	push   $0x0
  8005dd:	6a 65                	push   $0x65
  8005df:	6a 00                	push   $0x0
  8005e1:	6a 40                	push   $0x40
  8005e3:	50                   	push   %eax
  8005e4:	e8 ac 18 00 00       	call   801e95 <tst>
  8005e9:	83 c4 20             	add    $0x20,%esp

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  8005ec:	e8 4d 15 00 00       	call   801b3e <sys_calculate_free_frames>
  8005f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[11] = malloc(4*Mega - kilo);
  8005f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f7:	c1 e0 02             	shl    $0x2,%eax
  8005fa:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8005fd:	83 ec 0c             	sub    $0xc,%esp
  800600:	50                   	push   %eax
  800601:	e8 2b 11 00 00       	call   801731 <malloc>
  800606:	83 c4 10             	add    $0x10,%esp
  800609:	89 45 c8             	mov    %eax,-0x38(%ebp)
		tst((uint32) ptr_allocations[11], USER_HEAP_START + 14*Mega,USER_HEAP_START + 14*Mega + PAGE_SIZE, 'b', 0);
  80060c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80060f:	89 d0                	mov    %edx,%eax
  800611:	01 c0                	add    %eax,%eax
  800613:	01 d0                	add    %edx,%eax
  800615:	01 c0                	add    %eax,%eax
  800617:	01 d0                	add    %edx,%eax
  800619:	01 c0                	add    %eax,%eax
  80061b:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800621:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800624:	89 d0                	mov    %edx,%eax
  800626:	01 c0                	add    %eax,%eax
  800628:	01 d0                	add    %edx,%eax
  80062a:	01 c0                	add    %eax,%eax
  80062c:	01 d0                	add    %edx,%eax
  80062e:	01 c0                	add    %eax,%eax
  800630:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800636:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800639:	83 ec 0c             	sub    $0xc,%esp
  80063c:	6a 00                	push   $0x0
  80063e:	6a 62                	push   $0x62
  800640:	51                   	push   %ecx
  800641:	52                   	push   %edx
  800642:	50                   	push   %eax
  800643:	e8 4d 18 00 00       	call   801e95 <tst>
  800648:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1024 + 1,0, 'e', 0);
  80064b:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  80064e:	e8 eb 14 00 00       	call   801b3e <sys_calculate_free_frames>
  800653:	29 c3                	sub    %eax,%ebx
  800655:	89 d8                	mov    %ebx,%eax
  800657:	83 ec 0c             	sub    $0xc,%esp
  80065a:	6a 00                	push   $0x0
  80065c:	6a 65                	push   $0x65
  80065e:	6a 00                	push   $0x0
  800660:	68 01 04 00 00       	push   $0x401
  800665:	50                   	push   %eax
  800666:	e8 2a 18 00 00       	call   801e95 <tst>
  80066b:	83 c4 20             	add    $0x20,%esp
	}

	//[4] Free contiguous allocations
	{
		//1 MB Hole appended to previous 256 KB hole
		freeFrames = sys_calculate_free_frames() ;
  80066e:	e8 cb 14 00 00       	call   801b3e <sys_calculate_free_frames>
  800673:	89 45 ec             	mov    %eax,-0x14(%ebp)
		free(ptr_allocations[2]);
  800676:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800679:	83 ec 0c             	sub    $0xc,%esp
  80067c:	50                   	push   %eax
  80067d:	e8 65 12 00 00       	call   8018e7 <free>
  800682:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 256,0, 'e', 0);
  800685:	e8 b4 14 00 00       	call   801b3e <sys_calculate_free_frames>
  80068a:	89 c2                	mov    %eax,%edx
  80068c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80068f:	29 c2                	sub    %eax,%edx
  800691:	89 d0                	mov    %edx,%eax
  800693:	83 ec 0c             	sub    $0xc,%esp
  800696:	6a 00                	push   $0x0
  800698:	6a 65                	push   $0x65
  80069a:	6a 00                	push   $0x0
  80069c:	68 00 01 00 00       	push   $0x100
  8006a1:	50                   	push   %eax
  8006a2:	e8 ee 17 00 00       	call   801e95 <tst>
  8006a7:	83 c4 20             	add    $0x20,%esp

		//Next 1 MB Hole appended also
		freeFrames = sys_calculate_free_frames() ;
  8006aa:	e8 8f 14 00 00       	call   801b3e <sys_calculate_free_frames>
  8006af:	89 45 ec             	mov    %eax,-0x14(%ebp)
		free(ptr_allocations[3]);
  8006b2:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8006b5:	83 ec 0c             	sub    $0xc,%esp
  8006b8:	50                   	push   %eax
  8006b9:	e8 29 12 00 00       	call   8018e7 <free>
  8006be:	83 c4 10             	add    $0x10,%esp
		tst((sys_calculate_free_frames() - freeFrames) , 256,0, 'e', 0);
  8006c1:	e8 78 14 00 00       	call   801b3e <sys_calculate_free_frames>
  8006c6:	89 c2                	mov    %eax,%edx
  8006c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8006cb:	29 c2                	sub    %eax,%edx
  8006cd:	89 d0                	mov    %edx,%eax
  8006cf:	83 ec 0c             	sub    $0xc,%esp
  8006d2:	6a 00                	push   $0x0
  8006d4:	6a 65                	push   $0x65
  8006d6:	6a 00                	push   $0x0
  8006d8:	68 00 01 00 00       	push   $0x100
  8006dd:	50                   	push   %eax
  8006de:	e8 b2 17 00 00       	call   801e95 <tst>
  8006e3:	83 c4 20             	add    $0x20,%esp
	}

	//[5] Allocate again [test first fit]
	{
		//Allocate 2 MB + 128 KB - should be placed in the contiguous hole (256 KB + 2 MB)
		freeFrames = sys_calculate_free_frames() ;
  8006e6:	e8 53 14 00 00       	call   801b3e <sys_calculate_free_frames>
  8006eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
		ptr_allocations[12] = malloc(2*Mega + 128*kilo - kilo);
  8006ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f1:	c1 e0 06             	shl    $0x6,%eax
  8006f4:	89 c2                	mov    %eax,%edx
  8006f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006f9:	01 d0                	add    %edx,%eax
  8006fb:	01 c0                	add    %eax,%eax
  8006fd:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800700:	83 ec 0c             	sub    $0xc,%esp
  800703:	50                   	push   %eax
  800704:	e8 28 10 00 00       	call   801731 <malloc>
  800709:	83 c4 10             	add    $0x10,%esp
  80070c:	89 45 cc             	mov    %eax,-0x34(%ebp)
		tst((uint32) ptr_allocations[12], USER_HEAP_START + 1*Mega+ 768*kilo,USER_HEAP_START + 1*Mega+ 768*kilo + PAGE_SIZE, 'b', 0);
  80070f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800712:	89 d0                	mov    %edx,%eax
  800714:	01 c0                	add    %eax,%eax
  800716:	01 d0                	add    %edx,%eax
  800718:	c1 e0 08             	shl    $0x8,%eax
  80071b:	89 c2                	mov    %eax,%edx
  80071d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800720:	01 d0                	add    %edx,%eax
  800722:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800728:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80072b:	89 d0                	mov    %edx,%eax
  80072d:	01 c0                	add    %eax,%eax
  80072f:	01 d0                	add    %edx,%eax
  800731:	c1 e0 08             	shl    $0x8,%eax
  800734:	89 c2                	mov    %eax,%edx
  800736:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800739:	01 d0                	add    %edx,%eax
  80073b:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800741:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800744:	83 ec 0c             	sub    $0xc,%esp
  800747:	6a 00                	push   $0x0
  800749:	6a 62                	push   $0x62
  80074b:	51                   	push   %ecx
  80074c:	52                   	push   %edx
  80074d:	50                   	push   %eax
  80074e:	e8 42 17 00 00       	call   801e95 <tst>
  800753:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+32,0, 'e', 0);
  800756:	8b 5d ec             	mov    -0x14(%ebp),%ebx
  800759:	e8 e0 13 00 00       	call   801b3e <sys_calculate_free_frames>
  80075e:	29 c3                	sub    %eax,%ebx
  800760:	89 d8                	mov    %ebx,%eax
  800762:	83 ec 0c             	sub    $0xc,%esp
  800765:	6a 00                	push   $0x0
  800767:	6a 65                	push   $0x65
  800769:	6a 00                	push   $0x0
  80076b:	68 20 02 00 00       	push   $0x220
  800770:	50                   	push   %eax
  800771:	e8 1f 17 00 00       	call   801e95 <tst>
  800776:	83 c4 20             	add    $0x20,%esp
	}

	chktst(31);
  800779:	83 ec 0c             	sub    $0xc,%esp
  80077c:	6a 1f                	push   $0x1f
  80077e:	e8 3d 17 00 00       	call   801ec0 <chktst>
  800783:	83 c4 10             	add    $0x10,%esp

	return;
  800786:	90                   	nop
}
  800787:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80078a:	5b                   	pop    %ebx
  80078b:	5f                   	pop    %edi
  80078c:	5d                   	pop    %ebp
  80078d:	c3                   	ret    

0080078e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80078e:	55                   	push   %ebp
  80078f:	89 e5                	mov    %esp,%ebp
  800791:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800794:	e8 da 12 00 00       	call   801a73 <sys_getenvindex>
  800799:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80079c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80079f:	89 d0                	mov    %edx,%eax
  8007a1:	c1 e0 03             	shl    $0x3,%eax
  8007a4:	01 d0                	add    %edx,%eax
  8007a6:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8007ad:	01 c8                	add    %ecx,%eax
  8007af:	01 c0                	add    %eax,%eax
  8007b1:	01 d0                	add    %edx,%eax
  8007b3:	01 c0                	add    %eax,%eax
  8007b5:	01 d0                	add    %edx,%eax
  8007b7:	89 c2                	mov    %eax,%edx
  8007b9:	c1 e2 05             	shl    $0x5,%edx
  8007bc:	29 c2                	sub    %eax,%edx
  8007be:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8007c5:	89 c2                	mov    %eax,%edx
  8007c7:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8007cd:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8007d7:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8007dd:	84 c0                	test   %al,%al
  8007df:	74 0f                	je     8007f0 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8007e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8007e6:	05 40 3c 01 00       	add    $0x13c40,%eax
  8007eb:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007f0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8007f4:	7e 0a                	jle    800800 <libmain+0x72>
		binaryname = argv[0];
  8007f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007f9:	8b 00                	mov    (%eax),%eax
  8007fb:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800800:	83 ec 08             	sub    $0x8,%esp
  800803:	ff 75 0c             	pushl  0xc(%ebp)
  800806:	ff 75 08             	pushl  0x8(%ebp)
  800809:	e8 2a f8 ff ff       	call   800038 <_main>
  80080e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800811:	e8 f8 13 00 00       	call   801c0e <sys_disable_interrupt>
	cprintf("**************************************\n");
  800816:	83 ec 0c             	sub    $0xc,%esp
  800819:	68 98 24 80 00       	push   $0x802498
  80081e:	e8 84 01 00 00       	call   8009a7 <cprintf>
  800823:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800826:	a1 20 30 80 00       	mov    0x803020,%eax
  80082b:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800831:	a1 20 30 80 00       	mov    0x803020,%eax
  800836:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80083c:	83 ec 04             	sub    $0x4,%esp
  80083f:	52                   	push   %edx
  800840:	50                   	push   %eax
  800841:	68 c0 24 80 00       	push   $0x8024c0
  800846:	e8 5c 01 00 00       	call   8009a7 <cprintf>
  80084b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80084e:	a1 20 30 80 00       	mov    0x803020,%eax
  800853:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800859:	a1 20 30 80 00       	mov    0x803020,%eax
  80085e:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800864:	83 ec 04             	sub    $0x4,%esp
  800867:	52                   	push   %edx
  800868:	50                   	push   %eax
  800869:	68 e8 24 80 00       	push   $0x8024e8
  80086e:	e8 34 01 00 00       	call   8009a7 <cprintf>
  800873:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800876:	a1 20 30 80 00       	mov    0x803020,%eax
  80087b:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800881:	83 ec 08             	sub    $0x8,%esp
  800884:	50                   	push   %eax
  800885:	68 29 25 80 00       	push   $0x802529
  80088a:	e8 18 01 00 00       	call   8009a7 <cprintf>
  80088f:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800892:	83 ec 0c             	sub    $0xc,%esp
  800895:	68 98 24 80 00       	push   $0x802498
  80089a:	e8 08 01 00 00       	call   8009a7 <cprintf>
  80089f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008a2:	e8 81 13 00 00       	call   801c28 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008a7:	e8 19 00 00 00       	call   8008c5 <exit>
}
  8008ac:	90                   	nop
  8008ad:	c9                   	leave  
  8008ae:	c3                   	ret    

008008af <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008af:	55                   	push   %ebp
  8008b0:	89 e5                	mov    %esp,%ebp
  8008b2:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008b5:	83 ec 0c             	sub    $0xc,%esp
  8008b8:	6a 00                	push   $0x0
  8008ba:	e8 80 11 00 00       	call   801a3f <sys_env_destroy>
  8008bf:	83 c4 10             	add    $0x10,%esp
}
  8008c2:	90                   	nop
  8008c3:	c9                   	leave  
  8008c4:	c3                   	ret    

008008c5 <exit>:

void
exit(void)
{
  8008c5:	55                   	push   %ebp
  8008c6:	89 e5                	mov    %esp,%ebp
  8008c8:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008cb:	e8 d5 11 00 00       	call   801aa5 <sys_env_exit>
}
  8008d0:	90                   	nop
  8008d1:	c9                   	leave  
  8008d2:	c3                   	ret    

008008d3 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008d3:	55                   	push   %ebp
  8008d4:	89 e5                	mov    %esp,%ebp
  8008d6:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008dc:	8b 00                	mov    (%eax),%eax
  8008de:	8d 48 01             	lea    0x1(%eax),%ecx
  8008e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e4:	89 0a                	mov    %ecx,(%edx)
  8008e6:	8b 55 08             	mov    0x8(%ebp),%edx
  8008e9:	88 d1                	mov    %dl,%cl
  8008eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ee:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f5:	8b 00                	mov    (%eax),%eax
  8008f7:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008fc:	75 2c                	jne    80092a <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008fe:	a0 24 30 80 00       	mov    0x803024,%al
  800903:	0f b6 c0             	movzbl %al,%eax
  800906:	8b 55 0c             	mov    0xc(%ebp),%edx
  800909:	8b 12                	mov    (%edx),%edx
  80090b:	89 d1                	mov    %edx,%ecx
  80090d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800910:	83 c2 08             	add    $0x8,%edx
  800913:	83 ec 04             	sub    $0x4,%esp
  800916:	50                   	push   %eax
  800917:	51                   	push   %ecx
  800918:	52                   	push   %edx
  800919:	e8 df 10 00 00       	call   8019fd <sys_cputs>
  80091e:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800921:	8b 45 0c             	mov    0xc(%ebp),%eax
  800924:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80092a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092d:	8b 40 04             	mov    0x4(%eax),%eax
  800930:	8d 50 01             	lea    0x1(%eax),%edx
  800933:	8b 45 0c             	mov    0xc(%ebp),%eax
  800936:	89 50 04             	mov    %edx,0x4(%eax)
}
  800939:	90                   	nop
  80093a:	c9                   	leave  
  80093b:	c3                   	ret    

0080093c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80093c:	55                   	push   %ebp
  80093d:	89 e5                	mov    %esp,%ebp
  80093f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800945:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80094c:	00 00 00 
	b.cnt = 0;
  80094f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800956:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800959:	ff 75 0c             	pushl  0xc(%ebp)
  80095c:	ff 75 08             	pushl  0x8(%ebp)
  80095f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800965:	50                   	push   %eax
  800966:	68 d3 08 80 00       	push   $0x8008d3
  80096b:	e8 11 02 00 00       	call   800b81 <vprintfmt>
  800970:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800973:	a0 24 30 80 00       	mov    0x803024,%al
  800978:	0f b6 c0             	movzbl %al,%eax
  80097b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800981:	83 ec 04             	sub    $0x4,%esp
  800984:	50                   	push   %eax
  800985:	52                   	push   %edx
  800986:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80098c:	83 c0 08             	add    $0x8,%eax
  80098f:	50                   	push   %eax
  800990:	e8 68 10 00 00       	call   8019fd <sys_cputs>
  800995:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800998:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80099f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009a5:	c9                   	leave  
  8009a6:	c3                   	ret    

008009a7 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009a7:	55                   	push   %ebp
  8009a8:	89 e5                	mov    %esp,%ebp
  8009aa:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009ad:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009b4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bd:	83 ec 08             	sub    $0x8,%esp
  8009c0:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c3:	50                   	push   %eax
  8009c4:	e8 73 ff ff ff       	call   80093c <vcprintf>
  8009c9:	83 c4 10             	add    $0x10,%esp
  8009cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009d2:	c9                   	leave  
  8009d3:	c3                   	ret    

008009d4 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009d4:	55                   	push   %ebp
  8009d5:	89 e5                	mov    %esp,%ebp
  8009d7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009da:	e8 2f 12 00 00       	call   801c0e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009df:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e8:	83 ec 08             	sub    $0x8,%esp
  8009eb:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ee:	50                   	push   %eax
  8009ef:	e8 48 ff ff ff       	call   80093c <vcprintf>
  8009f4:	83 c4 10             	add    $0x10,%esp
  8009f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009fa:	e8 29 12 00 00       	call   801c28 <sys_enable_interrupt>
	return cnt;
  8009ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a02:	c9                   	leave  
  800a03:	c3                   	ret    

00800a04 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a04:	55                   	push   %ebp
  800a05:	89 e5                	mov    %esp,%ebp
  800a07:	53                   	push   %ebx
  800a08:	83 ec 14             	sub    $0x14,%esp
  800a0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800a0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a11:	8b 45 14             	mov    0x14(%ebp),%eax
  800a14:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a17:	8b 45 18             	mov    0x18(%ebp),%eax
  800a1a:	ba 00 00 00 00       	mov    $0x0,%edx
  800a1f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a22:	77 55                	ja     800a79 <printnum+0x75>
  800a24:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a27:	72 05                	jb     800a2e <printnum+0x2a>
  800a29:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a2c:	77 4b                	ja     800a79 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a2e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a31:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a34:	8b 45 18             	mov    0x18(%ebp),%eax
  800a37:	ba 00 00 00 00       	mov    $0x0,%edx
  800a3c:	52                   	push   %edx
  800a3d:	50                   	push   %eax
  800a3e:	ff 75 f4             	pushl  -0xc(%ebp)
  800a41:	ff 75 f0             	pushl  -0x10(%ebp)
  800a44:	e8 b7 17 00 00       	call   802200 <__udivdi3>
  800a49:	83 c4 10             	add    $0x10,%esp
  800a4c:	83 ec 04             	sub    $0x4,%esp
  800a4f:	ff 75 20             	pushl  0x20(%ebp)
  800a52:	53                   	push   %ebx
  800a53:	ff 75 18             	pushl  0x18(%ebp)
  800a56:	52                   	push   %edx
  800a57:	50                   	push   %eax
  800a58:	ff 75 0c             	pushl  0xc(%ebp)
  800a5b:	ff 75 08             	pushl  0x8(%ebp)
  800a5e:	e8 a1 ff ff ff       	call   800a04 <printnum>
  800a63:	83 c4 20             	add    $0x20,%esp
  800a66:	eb 1a                	jmp    800a82 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a68:	83 ec 08             	sub    $0x8,%esp
  800a6b:	ff 75 0c             	pushl  0xc(%ebp)
  800a6e:	ff 75 20             	pushl  0x20(%ebp)
  800a71:	8b 45 08             	mov    0x8(%ebp),%eax
  800a74:	ff d0                	call   *%eax
  800a76:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a79:	ff 4d 1c             	decl   0x1c(%ebp)
  800a7c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a80:	7f e6                	jg     800a68 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a82:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a85:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a8d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a90:	53                   	push   %ebx
  800a91:	51                   	push   %ecx
  800a92:	52                   	push   %edx
  800a93:	50                   	push   %eax
  800a94:	e8 77 18 00 00       	call   802310 <__umoddi3>
  800a99:	83 c4 10             	add    $0x10,%esp
  800a9c:	05 54 27 80 00       	add    $0x802754,%eax
  800aa1:	8a 00                	mov    (%eax),%al
  800aa3:	0f be c0             	movsbl %al,%eax
  800aa6:	83 ec 08             	sub    $0x8,%esp
  800aa9:	ff 75 0c             	pushl  0xc(%ebp)
  800aac:	50                   	push   %eax
  800aad:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab0:	ff d0                	call   *%eax
  800ab2:	83 c4 10             	add    $0x10,%esp
}
  800ab5:	90                   	nop
  800ab6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ab9:	c9                   	leave  
  800aba:	c3                   	ret    

00800abb <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800abb:	55                   	push   %ebp
  800abc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800abe:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ac2:	7e 1c                	jle    800ae0 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac7:	8b 00                	mov    (%eax),%eax
  800ac9:	8d 50 08             	lea    0x8(%eax),%edx
  800acc:	8b 45 08             	mov    0x8(%ebp),%eax
  800acf:	89 10                	mov    %edx,(%eax)
  800ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad4:	8b 00                	mov    (%eax),%eax
  800ad6:	83 e8 08             	sub    $0x8,%eax
  800ad9:	8b 50 04             	mov    0x4(%eax),%edx
  800adc:	8b 00                	mov    (%eax),%eax
  800ade:	eb 40                	jmp    800b20 <getuint+0x65>
	else if (lflag)
  800ae0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ae4:	74 1e                	je     800b04 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	8b 00                	mov    (%eax),%eax
  800aeb:	8d 50 04             	lea    0x4(%eax),%edx
  800aee:	8b 45 08             	mov    0x8(%ebp),%eax
  800af1:	89 10                	mov    %edx,(%eax)
  800af3:	8b 45 08             	mov    0x8(%ebp),%eax
  800af6:	8b 00                	mov    (%eax),%eax
  800af8:	83 e8 04             	sub    $0x4,%eax
  800afb:	8b 00                	mov    (%eax),%eax
  800afd:	ba 00 00 00 00       	mov    $0x0,%edx
  800b02:	eb 1c                	jmp    800b20 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b04:	8b 45 08             	mov    0x8(%ebp),%eax
  800b07:	8b 00                	mov    (%eax),%eax
  800b09:	8d 50 04             	lea    0x4(%eax),%edx
  800b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0f:	89 10                	mov    %edx,(%eax)
  800b11:	8b 45 08             	mov    0x8(%ebp),%eax
  800b14:	8b 00                	mov    (%eax),%eax
  800b16:	83 e8 04             	sub    $0x4,%eax
  800b19:	8b 00                	mov    (%eax),%eax
  800b1b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b20:	5d                   	pop    %ebp
  800b21:	c3                   	ret    

00800b22 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b22:	55                   	push   %ebp
  800b23:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b25:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b29:	7e 1c                	jle    800b47 <getint+0x25>
		return va_arg(*ap, long long);
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	8b 00                	mov    (%eax),%eax
  800b30:	8d 50 08             	lea    0x8(%eax),%edx
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	89 10                	mov    %edx,(%eax)
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	8b 00                	mov    (%eax),%eax
  800b3d:	83 e8 08             	sub    $0x8,%eax
  800b40:	8b 50 04             	mov    0x4(%eax),%edx
  800b43:	8b 00                	mov    (%eax),%eax
  800b45:	eb 38                	jmp    800b7f <getint+0x5d>
	else if (lflag)
  800b47:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b4b:	74 1a                	je     800b67 <getint+0x45>
		return va_arg(*ap, long);
  800b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b50:	8b 00                	mov    (%eax),%eax
  800b52:	8d 50 04             	lea    0x4(%eax),%edx
  800b55:	8b 45 08             	mov    0x8(%ebp),%eax
  800b58:	89 10                	mov    %edx,(%eax)
  800b5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5d:	8b 00                	mov    (%eax),%eax
  800b5f:	83 e8 04             	sub    $0x4,%eax
  800b62:	8b 00                	mov    (%eax),%eax
  800b64:	99                   	cltd   
  800b65:	eb 18                	jmp    800b7f <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	8b 00                	mov    (%eax),%eax
  800b6c:	8d 50 04             	lea    0x4(%eax),%edx
  800b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b72:	89 10                	mov    %edx,(%eax)
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	8b 00                	mov    (%eax),%eax
  800b79:	83 e8 04             	sub    $0x4,%eax
  800b7c:	8b 00                	mov    (%eax),%eax
  800b7e:	99                   	cltd   
}
  800b7f:	5d                   	pop    %ebp
  800b80:	c3                   	ret    

00800b81 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b81:	55                   	push   %ebp
  800b82:	89 e5                	mov    %esp,%ebp
  800b84:	56                   	push   %esi
  800b85:	53                   	push   %ebx
  800b86:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b89:	eb 17                	jmp    800ba2 <vprintfmt+0x21>
			if (ch == '\0')
  800b8b:	85 db                	test   %ebx,%ebx
  800b8d:	0f 84 af 03 00 00    	je     800f42 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b93:	83 ec 08             	sub    $0x8,%esp
  800b96:	ff 75 0c             	pushl  0xc(%ebp)
  800b99:	53                   	push   %ebx
  800b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9d:	ff d0                	call   *%eax
  800b9f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ba2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba5:	8d 50 01             	lea    0x1(%eax),%edx
  800ba8:	89 55 10             	mov    %edx,0x10(%ebp)
  800bab:	8a 00                	mov    (%eax),%al
  800bad:	0f b6 d8             	movzbl %al,%ebx
  800bb0:	83 fb 25             	cmp    $0x25,%ebx
  800bb3:	75 d6                	jne    800b8b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bb5:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bb9:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bc0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bc7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bce:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd8:	8d 50 01             	lea    0x1(%eax),%edx
  800bdb:	89 55 10             	mov    %edx,0x10(%ebp)
  800bde:	8a 00                	mov    (%eax),%al
  800be0:	0f b6 d8             	movzbl %al,%ebx
  800be3:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800be6:	83 f8 55             	cmp    $0x55,%eax
  800be9:	0f 87 2b 03 00 00    	ja     800f1a <vprintfmt+0x399>
  800bef:	8b 04 85 78 27 80 00 	mov    0x802778(,%eax,4),%eax
  800bf6:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bf8:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bfc:	eb d7                	jmp    800bd5 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bfe:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c02:	eb d1                	jmp    800bd5 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c04:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c0b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c0e:	89 d0                	mov    %edx,%eax
  800c10:	c1 e0 02             	shl    $0x2,%eax
  800c13:	01 d0                	add    %edx,%eax
  800c15:	01 c0                	add    %eax,%eax
  800c17:	01 d8                	add    %ebx,%eax
  800c19:	83 e8 30             	sub    $0x30,%eax
  800c1c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c22:	8a 00                	mov    (%eax),%al
  800c24:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c27:	83 fb 2f             	cmp    $0x2f,%ebx
  800c2a:	7e 3e                	jle    800c6a <vprintfmt+0xe9>
  800c2c:	83 fb 39             	cmp    $0x39,%ebx
  800c2f:	7f 39                	jg     800c6a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c31:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c34:	eb d5                	jmp    800c0b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c36:	8b 45 14             	mov    0x14(%ebp),%eax
  800c39:	83 c0 04             	add    $0x4,%eax
  800c3c:	89 45 14             	mov    %eax,0x14(%ebp)
  800c3f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c42:	83 e8 04             	sub    $0x4,%eax
  800c45:	8b 00                	mov    (%eax),%eax
  800c47:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c4a:	eb 1f                	jmp    800c6b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c4c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c50:	79 83                	jns    800bd5 <vprintfmt+0x54>
				width = 0;
  800c52:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c59:	e9 77 ff ff ff       	jmp    800bd5 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c5e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c65:	e9 6b ff ff ff       	jmp    800bd5 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c6a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c6b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c6f:	0f 89 60 ff ff ff    	jns    800bd5 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c75:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c78:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c7b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c82:	e9 4e ff ff ff       	jmp    800bd5 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c87:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c8a:	e9 46 ff ff ff       	jmp    800bd5 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c92:	83 c0 04             	add    $0x4,%eax
  800c95:	89 45 14             	mov    %eax,0x14(%ebp)
  800c98:	8b 45 14             	mov    0x14(%ebp),%eax
  800c9b:	83 e8 04             	sub    $0x4,%eax
  800c9e:	8b 00                	mov    (%eax),%eax
  800ca0:	83 ec 08             	sub    $0x8,%esp
  800ca3:	ff 75 0c             	pushl  0xc(%ebp)
  800ca6:	50                   	push   %eax
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	ff d0                	call   *%eax
  800cac:	83 c4 10             	add    $0x10,%esp
			break;
  800caf:	e9 89 02 00 00       	jmp    800f3d <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cb4:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb7:	83 c0 04             	add    $0x4,%eax
  800cba:	89 45 14             	mov    %eax,0x14(%ebp)
  800cbd:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc0:	83 e8 04             	sub    $0x4,%eax
  800cc3:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cc5:	85 db                	test   %ebx,%ebx
  800cc7:	79 02                	jns    800ccb <vprintfmt+0x14a>
				err = -err;
  800cc9:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ccb:	83 fb 64             	cmp    $0x64,%ebx
  800cce:	7f 0b                	jg     800cdb <vprintfmt+0x15a>
  800cd0:	8b 34 9d c0 25 80 00 	mov    0x8025c0(,%ebx,4),%esi
  800cd7:	85 f6                	test   %esi,%esi
  800cd9:	75 19                	jne    800cf4 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cdb:	53                   	push   %ebx
  800cdc:	68 65 27 80 00       	push   $0x802765
  800ce1:	ff 75 0c             	pushl  0xc(%ebp)
  800ce4:	ff 75 08             	pushl  0x8(%ebp)
  800ce7:	e8 5e 02 00 00       	call   800f4a <printfmt>
  800cec:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cef:	e9 49 02 00 00       	jmp    800f3d <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cf4:	56                   	push   %esi
  800cf5:	68 6e 27 80 00       	push   $0x80276e
  800cfa:	ff 75 0c             	pushl  0xc(%ebp)
  800cfd:	ff 75 08             	pushl  0x8(%ebp)
  800d00:	e8 45 02 00 00       	call   800f4a <printfmt>
  800d05:	83 c4 10             	add    $0x10,%esp
			break;
  800d08:	e9 30 02 00 00       	jmp    800f3d <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d0d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d10:	83 c0 04             	add    $0x4,%eax
  800d13:	89 45 14             	mov    %eax,0x14(%ebp)
  800d16:	8b 45 14             	mov    0x14(%ebp),%eax
  800d19:	83 e8 04             	sub    $0x4,%eax
  800d1c:	8b 30                	mov    (%eax),%esi
  800d1e:	85 f6                	test   %esi,%esi
  800d20:	75 05                	jne    800d27 <vprintfmt+0x1a6>
				p = "(null)";
  800d22:	be 71 27 80 00       	mov    $0x802771,%esi
			if (width > 0 && padc != '-')
  800d27:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d2b:	7e 6d                	jle    800d9a <vprintfmt+0x219>
  800d2d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d31:	74 67                	je     800d9a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d33:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d36:	83 ec 08             	sub    $0x8,%esp
  800d39:	50                   	push   %eax
  800d3a:	56                   	push   %esi
  800d3b:	e8 0c 03 00 00       	call   80104c <strnlen>
  800d40:	83 c4 10             	add    $0x10,%esp
  800d43:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d46:	eb 16                	jmp    800d5e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d48:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d4c:	83 ec 08             	sub    $0x8,%esp
  800d4f:	ff 75 0c             	pushl  0xc(%ebp)
  800d52:	50                   	push   %eax
  800d53:	8b 45 08             	mov    0x8(%ebp),%eax
  800d56:	ff d0                	call   *%eax
  800d58:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d5b:	ff 4d e4             	decl   -0x1c(%ebp)
  800d5e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d62:	7f e4                	jg     800d48 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d64:	eb 34                	jmp    800d9a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d66:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d6a:	74 1c                	je     800d88 <vprintfmt+0x207>
  800d6c:	83 fb 1f             	cmp    $0x1f,%ebx
  800d6f:	7e 05                	jle    800d76 <vprintfmt+0x1f5>
  800d71:	83 fb 7e             	cmp    $0x7e,%ebx
  800d74:	7e 12                	jle    800d88 <vprintfmt+0x207>
					putch('?', putdat);
  800d76:	83 ec 08             	sub    $0x8,%esp
  800d79:	ff 75 0c             	pushl  0xc(%ebp)
  800d7c:	6a 3f                	push   $0x3f
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	ff d0                	call   *%eax
  800d83:	83 c4 10             	add    $0x10,%esp
  800d86:	eb 0f                	jmp    800d97 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d88:	83 ec 08             	sub    $0x8,%esp
  800d8b:	ff 75 0c             	pushl  0xc(%ebp)
  800d8e:	53                   	push   %ebx
  800d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d92:	ff d0                	call   *%eax
  800d94:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d97:	ff 4d e4             	decl   -0x1c(%ebp)
  800d9a:	89 f0                	mov    %esi,%eax
  800d9c:	8d 70 01             	lea    0x1(%eax),%esi
  800d9f:	8a 00                	mov    (%eax),%al
  800da1:	0f be d8             	movsbl %al,%ebx
  800da4:	85 db                	test   %ebx,%ebx
  800da6:	74 24                	je     800dcc <vprintfmt+0x24b>
  800da8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dac:	78 b8                	js     800d66 <vprintfmt+0x1e5>
  800dae:	ff 4d e0             	decl   -0x20(%ebp)
  800db1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800db5:	79 af                	jns    800d66 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800db7:	eb 13                	jmp    800dcc <vprintfmt+0x24b>
				putch(' ', putdat);
  800db9:	83 ec 08             	sub    $0x8,%esp
  800dbc:	ff 75 0c             	pushl  0xc(%ebp)
  800dbf:	6a 20                	push   $0x20
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	ff d0                	call   *%eax
  800dc6:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dc9:	ff 4d e4             	decl   -0x1c(%ebp)
  800dcc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dd0:	7f e7                	jg     800db9 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dd2:	e9 66 01 00 00       	jmp    800f3d <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dd7:	83 ec 08             	sub    $0x8,%esp
  800dda:	ff 75 e8             	pushl  -0x18(%ebp)
  800ddd:	8d 45 14             	lea    0x14(%ebp),%eax
  800de0:	50                   	push   %eax
  800de1:	e8 3c fd ff ff       	call   800b22 <getint>
  800de6:	83 c4 10             	add    $0x10,%esp
  800de9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dec:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800def:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800df2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800df5:	85 d2                	test   %edx,%edx
  800df7:	79 23                	jns    800e1c <vprintfmt+0x29b>
				putch('-', putdat);
  800df9:	83 ec 08             	sub    $0x8,%esp
  800dfc:	ff 75 0c             	pushl  0xc(%ebp)
  800dff:	6a 2d                	push   $0x2d
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
  800e04:	ff d0                	call   *%eax
  800e06:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e0c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e0f:	f7 d8                	neg    %eax
  800e11:	83 d2 00             	adc    $0x0,%edx
  800e14:	f7 da                	neg    %edx
  800e16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e19:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e1c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e23:	e9 bc 00 00 00       	jmp    800ee4 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e28:	83 ec 08             	sub    $0x8,%esp
  800e2b:	ff 75 e8             	pushl  -0x18(%ebp)
  800e2e:	8d 45 14             	lea    0x14(%ebp),%eax
  800e31:	50                   	push   %eax
  800e32:	e8 84 fc ff ff       	call   800abb <getuint>
  800e37:	83 c4 10             	add    $0x10,%esp
  800e3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e3d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e40:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e47:	e9 98 00 00 00       	jmp    800ee4 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e4c:	83 ec 08             	sub    $0x8,%esp
  800e4f:	ff 75 0c             	pushl  0xc(%ebp)
  800e52:	6a 58                	push   $0x58
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
  800e57:	ff d0                	call   *%eax
  800e59:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e5c:	83 ec 08             	sub    $0x8,%esp
  800e5f:	ff 75 0c             	pushl  0xc(%ebp)
  800e62:	6a 58                	push   $0x58
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	ff d0                	call   *%eax
  800e69:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e6c:	83 ec 08             	sub    $0x8,%esp
  800e6f:	ff 75 0c             	pushl  0xc(%ebp)
  800e72:	6a 58                	push   $0x58
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
  800e77:	ff d0                	call   *%eax
  800e79:	83 c4 10             	add    $0x10,%esp
			break;
  800e7c:	e9 bc 00 00 00       	jmp    800f3d <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e81:	83 ec 08             	sub    $0x8,%esp
  800e84:	ff 75 0c             	pushl  0xc(%ebp)
  800e87:	6a 30                	push   $0x30
  800e89:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8c:	ff d0                	call   *%eax
  800e8e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e91:	83 ec 08             	sub    $0x8,%esp
  800e94:	ff 75 0c             	pushl  0xc(%ebp)
  800e97:	6a 78                	push   $0x78
  800e99:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9c:	ff d0                	call   *%eax
  800e9e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ea1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea4:	83 c0 04             	add    $0x4,%eax
  800ea7:	89 45 14             	mov    %eax,0x14(%ebp)
  800eaa:	8b 45 14             	mov    0x14(%ebp),%eax
  800ead:	83 e8 04             	sub    $0x4,%eax
  800eb0:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800eb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eb5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ebc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ec3:	eb 1f                	jmp    800ee4 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ec5:	83 ec 08             	sub    $0x8,%esp
  800ec8:	ff 75 e8             	pushl  -0x18(%ebp)
  800ecb:	8d 45 14             	lea    0x14(%ebp),%eax
  800ece:	50                   	push   %eax
  800ecf:	e8 e7 fb ff ff       	call   800abb <getuint>
  800ed4:	83 c4 10             	add    $0x10,%esp
  800ed7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eda:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800edd:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ee4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ee8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800eeb:	83 ec 04             	sub    $0x4,%esp
  800eee:	52                   	push   %edx
  800eef:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ef2:	50                   	push   %eax
  800ef3:	ff 75 f4             	pushl  -0xc(%ebp)
  800ef6:	ff 75 f0             	pushl  -0x10(%ebp)
  800ef9:	ff 75 0c             	pushl  0xc(%ebp)
  800efc:	ff 75 08             	pushl  0x8(%ebp)
  800eff:	e8 00 fb ff ff       	call   800a04 <printnum>
  800f04:	83 c4 20             	add    $0x20,%esp
			break;
  800f07:	eb 34                	jmp    800f3d <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f09:	83 ec 08             	sub    $0x8,%esp
  800f0c:	ff 75 0c             	pushl  0xc(%ebp)
  800f0f:	53                   	push   %ebx
  800f10:	8b 45 08             	mov    0x8(%ebp),%eax
  800f13:	ff d0                	call   *%eax
  800f15:	83 c4 10             	add    $0x10,%esp
			break;
  800f18:	eb 23                	jmp    800f3d <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f1a:	83 ec 08             	sub    $0x8,%esp
  800f1d:	ff 75 0c             	pushl  0xc(%ebp)
  800f20:	6a 25                	push   $0x25
  800f22:	8b 45 08             	mov    0x8(%ebp),%eax
  800f25:	ff d0                	call   *%eax
  800f27:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f2a:	ff 4d 10             	decl   0x10(%ebp)
  800f2d:	eb 03                	jmp    800f32 <vprintfmt+0x3b1>
  800f2f:	ff 4d 10             	decl   0x10(%ebp)
  800f32:	8b 45 10             	mov    0x10(%ebp),%eax
  800f35:	48                   	dec    %eax
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	3c 25                	cmp    $0x25,%al
  800f3a:	75 f3                	jne    800f2f <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f3c:	90                   	nop
		}
	}
  800f3d:	e9 47 fc ff ff       	jmp    800b89 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f42:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f43:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f46:	5b                   	pop    %ebx
  800f47:	5e                   	pop    %esi
  800f48:	5d                   	pop    %ebp
  800f49:	c3                   	ret    

00800f4a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f4a:	55                   	push   %ebp
  800f4b:	89 e5                	mov    %esp,%ebp
  800f4d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f50:	8d 45 10             	lea    0x10(%ebp),%eax
  800f53:	83 c0 04             	add    $0x4,%eax
  800f56:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f59:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5c:	ff 75 f4             	pushl  -0xc(%ebp)
  800f5f:	50                   	push   %eax
  800f60:	ff 75 0c             	pushl  0xc(%ebp)
  800f63:	ff 75 08             	pushl  0x8(%ebp)
  800f66:	e8 16 fc ff ff       	call   800b81 <vprintfmt>
  800f6b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f6e:	90                   	nop
  800f6f:	c9                   	leave  
  800f70:	c3                   	ret    

00800f71 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f71:	55                   	push   %ebp
  800f72:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f77:	8b 40 08             	mov    0x8(%eax),%eax
  800f7a:	8d 50 01             	lea    0x1(%eax),%edx
  800f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f80:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f86:	8b 10                	mov    (%eax),%edx
  800f88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8b:	8b 40 04             	mov    0x4(%eax),%eax
  800f8e:	39 c2                	cmp    %eax,%edx
  800f90:	73 12                	jae    800fa4 <sprintputch+0x33>
		*b->buf++ = ch;
  800f92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f95:	8b 00                	mov    (%eax),%eax
  800f97:	8d 48 01             	lea    0x1(%eax),%ecx
  800f9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f9d:	89 0a                	mov    %ecx,(%edx)
  800f9f:	8b 55 08             	mov    0x8(%ebp),%edx
  800fa2:	88 10                	mov    %dl,(%eax)
}
  800fa4:	90                   	nop
  800fa5:	5d                   	pop    %ebp
  800fa6:	c3                   	ret    

00800fa7 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fa7:	55                   	push   %ebp
  800fa8:	89 e5                	mov    %esp,%ebp
  800faa:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fad:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbc:	01 d0                	add    %edx,%eax
  800fbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fc8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fcc:	74 06                	je     800fd4 <vsnprintf+0x2d>
  800fce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fd2:	7f 07                	jg     800fdb <vsnprintf+0x34>
		return -E_INVAL;
  800fd4:	b8 03 00 00 00       	mov    $0x3,%eax
  800fd9:	eb 20                	jmp    800ffb <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fdb:	ff 75 14             	pushl  0x14(%ebp)
  800fde:	ff 75 10             	pushl  0x10(%ebp)
  800fe1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fe4:	50                   	push   %eax
  800fe5:	68 71 0f 80 00       	push   $0x800f71
  800fea:	e8 92 fb ff ff       	call   800b81 <vprintfmt>
  800fef:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ff2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ff5:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800ff8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ffb:	c9                   	leave  
  800ffc:	c3                   	ret    

00800ffd <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ffd:	55                   	push   %ebp
  800ffe:	89 e5                	mov    %esp,%ebp
  801000:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801003:	8d 45 10             	lea    0x10(%ebp),%eax
  801006:	83 c0 04             	add    $0x4,%eax
  801009:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80100c:	8b 45 10             	mov    0x10(%ebp),%eax
  80100f:	ff 75 f4             	pushl  -0xc(%ebp)
  801012:	50                   	push   %eax
  801013:	ff 75 0c             	pushl  0xc(%ebp)
  801016:	ff 75 08             	pushl  0x8(%ebp)
  801019:	e8 89 ff ff ff       	call   800fa7 <vsnprintf>
  80101e:	83 c4 10             	add    $0x10,%esp
  801021:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801024:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801027:	c9                   	leave  
  801028:	c3                   	ret    

00801029 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801029:	55                   	push   %ebp
  80102a:	89 e5                	mov    %esp,%ebp
  80102c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80102f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801036:	eb 06                	jmp    80103e <strlen+0x15>
		n++;
  801038:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80103b:	ff 45 08             	incl   0x8(%ebp)
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	8a 00                	mov    (%eax),%al
  801043:	84 c0                	test   %al,%al
  801045:	75 f1                	jne    801038 <strlen+0xf>
		n++;
	return n;
  801047:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80104a:	c9                   	leave  
  80104b:	c3                   	ret    

0080104c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80104c:	55                   	push   %ebp
  80104d:	89 e5                	mov    %esp,%ebp
  80104f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801052:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801059:	eb 09                	jmp    801064 <strnlen+0x18>
		n++;
  80105b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80105e:	ff 45 08             	incl   0x8(%ebp)
  801061:	ff 4d 0c             	decl   0xc(%ebp)
  801064:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801068:	74 09                	je     801073 <strnlen+0x27>
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	8a 00                	mov    (%eax),%al
  80106f:	84 c0                	test   %al,%al
  801071:	75 e8                	jne    80105b <strnlen+0xf>
		n++;
	return n;
  801073:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801076:	c9                   	leave  
  801077:	c3                   	ret    

00801078 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801078:	55                   	push   %ebp
  801079:	89 e5                	mov    %esp,%ebp
  80107b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80107e:	8b 45 08             	mov    0x8(%ebp),%eax
  801081:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801084:	90                   	nop
  801085:	8b 45 08             	mov    0x8(%ebp),%eax
  801088:	8d 50 01             	lea    0x1(%eax),%edx
  80108b:	89 55 08             	mov    %edx,0x8(%ebp)
  80108e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801091:	8d 4a 01             	lea    0x1(%edx),%ecx
  801094:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801097:	8a 12                	mov    (%edx),%dl
  801099:	88 10                	mov    %dl,(%eax)
  80109b:	8a 00                	mov    (%eax),%al
  80109d:	84 c0                	test   %al,%al
  80109f:	75 e4                	jne    801085 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010a4:	c9                   	leave  
  8010a5:	c3                   	ret    

008010a6 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010a6:	55                   	push   %ebp
  8010a7:	89 e5                	mov    %esp,%ebp
  8010a9:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8010af:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010b9:	eb 1f                	jmp    8010da <strncpy+0x34>
		*dst++ = *src;
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	8d 50 01             	lea    0x1(%eax),%edx
  8010c1:	89 55 08             	mov    %edx,0x8(%ebp)
  8010c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c7:	8a 12                	mov    (%edx),%dl
  8010c9:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ce:	8a 00                	mov    (%eax),%al
  8010d0:	84 c0                	test   %al,%al
  8010d2:	74 03                	je     8010d7 <strncpy+0x31>
			src++;
  8010d4:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010d7:	ff 45 fc             	incl   -0x4(%ebp)
  8010da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010dd:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010e0:	72 d9                	jb     8010bb <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010e5:	c9                   	leave  
  8010e6:	c3                   	ret    

008010e7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010e7:	55                   	push   %ebp
  8010e8:	89 e5                	mov    %esp,%ebp
  8010ea:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010f7:	74 30                	je     801129 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010f9:	eb 16                	jmp    801111 <strlcpy+0x2a>
			*dst++ = *src++;
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	8d 50 01             	lea    0x1(%eax),%edx
  801101:	89 55 08             	mov    %edx,0x8(%ebp)
  801104:	8b 55 0c             	mov    0xc(%ebp),%edx
  801107:	8d 4a 01             	lea    0x1(%edx),%ecx
  80110a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80110d:	8a 12                	mov    (%edx),%dl
  80110f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801111:	ff 4d 10             	decl   0x10(%ebp)
  801114:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801118:	74 09                	je     801123 <strlcpy+0x3c>
  80111a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111d:	8a 00                	mov    (%eax),%al
  80111f:	84 c0                	test   %al,%al
  801121:	75 d8                	jne    8010fb <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801123:	8b 45 08             	mov    0x8(%ebp),%eax
  801126:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801129:	8b 55 08             	mov    0x8(%ebp),%edx
  80112c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80112f:	29 c2                	sub    %eax,%edx
  801131:	89 d0                	mov    %edx,%eax
}
  801133:	c9                   	leave  
  801134:	c3                   	ret    

00801135 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801135:	55                   	push   %ebp
  801136:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801138:	eb 06                	jmp    801140 <strcmp+0xb>
		p++, q++;
  80113a:	ff 45 08             	incl   0x8(%ebp)
  80113d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801140:	8b 45 08             	mov    0x8(%ebp),%eax
  801143:	8a 00                	mov    (%eax),%al
  801145:	84 c0                	test   %al,%al
  801147:	74 0e                	je     801157 <strcmp+0x22>
  801149:	8b 45 08             	mov    0x8(%ebp),%eax
  80114c:	8a 10                	mov    (%eax),%dl
  80114e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801151:	8a 00                	mov    (%eax),%al
  801153:	38 c2                	cmp    %al,%dl
  801155:	74 e3                	je     80113a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801157:	8b 45 08             	mov    0x8(%ebp),%eax
  80115a:	8a 00                	mov    (%eax),%al
  80115c:	0f b6 d0             	movzbl %al,%edx
  80115f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801162:	8a 00                	mov    (%eax),%al
  801164:	0f b6 c0             	movzbl %al,%eax
  801167:	29 c2                	sub    %eax,%edx
  801169:	89 d0                	mov    %edx,%eax
}
  80116b:	5d                   	pop    %ebp
  80116c:	c3                   	ret    

0080116d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80116d:	55                   	push   %ebp
  80116e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801170:	eb 09                	jmp    80117b <strncmp+0xe>
		n--, p++, q++;
  801172:	ff 4d 10             	decl   0x10(%ebp)
  801175:	ff 45 08             	incl   0x8(%ebp)
  801178:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80117b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80117f:	74 17                	je     801198 <strncmp+0x2b>
  801181:	8b 45 08             	mov    0x8(%ebp),%eax
  801184:	8a 00                	mov    (%eax),%al
  801186:	84 c0                	test   %al,%al
  801188:	74 0e                	je     801198 <strncmp+0x2b>
  80118a:	8b 45 08             	mov    0x8(%ebp),%eax
  80118d:	8a 10                	mov    (%eax),%dl
  80118f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801192:	8a 00                	mov    (%eax),%al
  801194:	38 c2                	cmp    %al,%dl
  801196:	74 da                	je     801172 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801198:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80119c:	75 07                	jne    8011a5 <strncmp+0x38>
		return 0;
  80119e:	b8 00 00 00 00       	mov    $0x0,%eax
  8011a3:	eb 14                	jmp    8011b9 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a8:	8a 00                	mov    (%eax),%al
  8011aa:	0f b6 d0             	movzbl %al,%edx
  8011ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b0:	8a 00                	mov    (%eax),%al
  8011b2:	0f b6 c0             	movzbl %al,%eax
  8011b5:	29 c2                	sub    %eax,%edx
  8011b7:	89 d0                	mov    %edx,%eax
}
  8011b9:	5d                   	pop    %ebp
  8011ba:	c3                   	ret    

008011bb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011bb:	55                   	push   %ebp
  8011bc:	89 e5                	mov    %esp,%ebp
  8011be:	83 ec 04             	sub    $0x4,%esp
  8011c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011c7:	eb 12                	jmp    8011db <strchr+0x20>
		if (*s == c)
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	8a 00                	mov    (%eax),%al
  8011ce:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011d1:	75 05                	jne    8011d8 <strchr+0x1d>
			return (char *) s;
  8011d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d6:	eb 11                	jmp    8011e9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011d8:	ff 45 08             	incl   0x8(%ebp)
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	8a 00                	mov    (%eax),%al
  8011e0:	84 c0                	test   %al,%al
  8011e2:	75 e5                	jne    8011c9 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011e9:	c9                   	leave  
  8011ea:	c3                   	ret    

008011eb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011eb:	55                   	push   %ebp
  8011ec:	89 e5                	mov    %esp,%ebp
  8011ee:	83 ec 04             	sub    $0x4,%esp
  8011f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011f7:	eb 0d                	jmp    801206 <strfind+0x1b>
		if (*s == c)
  8011f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fc:	8a 00                	mov    (%eax),%al
  8011fe:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801201:	74 0e                	je     801211 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801203:	ff 45 08             	incl   0x8(%ebp)
  801206:	8b 45 08             	mov    0x8(%ebp),%eax
  801209:	8a 00                	mov    (%eax),%al
  80120b:	84 c0                	test   %al,%al
  80120d:	75 ea                	jne    8011f9 <strfind+0xe>
  80120f:	eb 01                	jmp    801212 <strfind+0x27>
		if (*s == c)
			break;
  801211:	90                   	nop
	return (char *) s;
  801212:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801215:	c9                   	leave  
  801216:	c3                   	ret    

00801217 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801217:	55                   	push   %ebp
  801218:	89 e5                	mov    %esp,%ebp
  80121a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80121d:	8b 45 08             	mov    0x8(%ebp),%eax
  801220:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801223:	8b 45 10             	mov    0x10(%ebp),%eax
  801226:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801229:	eb 0e                	jmp    801239 <memset+0x22>
		*p++ = c;
  80122b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80122e:	8d 50 01             	lea    0x1(%eax),%edx
  801231:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801234:	8b 55 0c             	mov    0xc(%ebp),%edx
  801237:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801239:	ff 4d f8             	decl   -0x8(%ebp)
  80123c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801240:	79 e9                	jns    80122b <memset+0x14>
		*p++ = c;

	return v;
  801242:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801245:	c9                   	leave  
  801246:	c3                   	ret    

00801247 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801247:	55                   	push   %ebp
  801248:	89 e5                	mov    %esp,%ebp
  80124a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80124d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801250:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801253:	8b 45 08             	mov    0x8(%ebp),%eax
  801256:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801259:	eb 16                	jmp    801271 <memcpy+0x2a>
		*d++ = *s++;
  80125b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80125e:	8d 50 01             	lea    0x1(%eax),%edx
  801261:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801264:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801267:	8d 4a 01             	lea    0x1(%edx),%ecx
  80126a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80126d:	8a 12                	mov    (%edx),%dl
  80126f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801271:	8b 45 10             	mov    0x10(%ebp),%eax
  801274:	8d 50 ff             	lea    -0x1(%eax),%edx
  801277:	89 55 10             	mov    %edx,0x10(%ebp)
  80127a:	85 c0                	test   %eax,%eax
  80127c:	75 dd                	jne    80125b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80127e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801281:	c9                   	leave  
  801282:	c3                   	ret    

00801283 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801283:	55                   	push   %ebp
  801284:	89 e5                	mov    %esp,%ebp
  801286:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801289:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80128f:	8b 45 08             	mov    0x8(%ebp),%eax
  801292:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801295:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801298:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80129b:	73 50                	jae    8012ed <memmove+0x6a>
  80129d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a3:	01 d0                	add    %edx,%eax
  8012a5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012a8:	76 43                	jbe    8012ed <memmove+0x6a>
		s += n;
  8012aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ad:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012b6:	eb 10                	jmp    8012c8 <memmove+0x45>
			*--d = *--s;
  8012b8:	ff 4d f8             	decl   -0x8(%ebp)
  8012bb:	ff 4d fc             	decl   -0x4(%ebp)
  8012be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c1:	8a 10                	mov    (%eax),%dl
  8012c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012ce:	89 55 10             	mov    %edx,0x10(%ebp)
  8012d1:	85 c0                	test   %eax,%eax
  8012d3:	75 e3                	jne    8012b8 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012d5:	eb 23                	jmp    8012fa <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012da:	8d 50 01             	lea    0x1(%eax),%edx
  8012dd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012e3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012e6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012e9:	8a 12                	mov    (%edx),%dl
  8012eb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012f3:	89 55 10             	mov    %edx,0x10(%ebp)
  8012f6:	85 c0                	test   %eax,%eax
  8012f8:	75 dd                	jne    8012d7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012fa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012fd:	c9                   	leave  
  8012fe:	c3                   	ret    

008012ff <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012ff:	55                   	push   %ebp
  801300:	89 e5                	mov    %esp,%ebp
  801302:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801305:	8b 45 08             	mov    0x8(%ebp),%eax
  801308:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80130b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801311:	eb 2a                	jmp    80133d <memcmp+0x3e>
		if (*s1 != *s2)
  801313:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801316:	8a 10                	mov    (%eax),%dl
  801318:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80131b:	8a 00                	mov    (%eax),%al
  80131d:	38 c2                	cmp    %al,%dl
  80131f:	74 16                	je     801337 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801321:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801324:	8a 00                	mov    (%eax),%al
  801326:	0f b6 d0             	movzbl %al,%edx
  801329:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80132c:	8a 00                	mov    (%eax),%al
  80132e:	0f b6 c0             	movzbl %al,%eax
  801331:	29 c2                	sub    %eax,%edx
  801333:	89 d0                	mov    %edx,%eax
  801335:	eb 18                	jmp    80134f <memcmp+0x50>
		s1++, s2++;
  801337:	ff 45 fc             	incl   -0x4(%ebp)
  80133a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80133d:	8b 45 10             	mov    0x10(%ebp),%eax
  801340:	8d 50 ff             	lea    -0x1(%eax),%edx
  801343:	89 55 10             	mov    %edx,0x10(%ebp)
  801346:	85 c0                	test   %eax,%eax
  801348:	75 c9                	jne    801313 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80134a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80134f:	c9                   	leave  
  801350:	c3                   	ret    

00801351 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
  801354:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801357:	8b 55 08             	mov    0x8(%ebp),%edx
  80135a:	8b 45 10             	mov    0x10(%ebp),%eax
  80135d:	01 d0                	add    %edx,%eax
  80135f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801362:	eb 15                	jmp    801379 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801364:	8b 45 08             	mov    0x8(%ebp),%eax
  801367:	8a 00                	mov    (%eax),%al
  801369:	0f b6 d0             	movzbl %al,%edx
  80136c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136f:	0f b6 c0             	movzbl %al,%eax
  801372:	39 c2                	cmp    %eax,%edx
  801374:	74 0d                	je     801383 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801376:	ff 45 08             	incl   0x8(%ebp)
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80137f:	72 e3                	jb     801364 <memfind+0x13>
  801381:	eb 01                	jmp    801384 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801383:	90                   	nop
	return (void *) s;
  801384:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801387:	c9                   	leave  
  801388:	c3                   	ret    

00801389 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801389:	55                   	push   %ebp
  80138a:	89 e5                	mov    %esp,%ebp
  80138c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80138f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801396:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80139d:	eb 03                	jmp    8013a2 <strtol+0x19>
		s++;
  80139f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a5:	8a 00                	mov    (%eax),%al
  8013a7:	3c 20                	cmp    $0x20,%al
  8013a9:	74 f4                	je     80139f <strtol+0x16>
  8013ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ae:	8a 00                	mov    (%eax),%al
  8013b0:	3c 09                	cmp    $0x9,%al
  8013b2:	74 eb                	je     80139f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	8a 00                	mov    (%eax),%al
  8013b9:	3c 2b                	cmp    $0x2b,%al
  8013bb:	75 05                	jne    8013c2 <strtol+0x39>
		s++;
  8013bd:	ff 45 08             	incl   0x8(%ebp)
  8013c0:	eb 13                	jmp    8013d5 <strtol+0x4c>
	else if (*s == '-')
  8013c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c5:	8a 00                	mov    (%eax),%al
  8013c7:	3c 2d                	cmp    $0x2d,%al
  8013c9:	75 0a                	jne    8013d5 <strtol+0x4c>
		s++, neg = 1;
  8013cb:	ff 45 08             	incl   0x8(%ebp)
  8013ce:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d9:	74 06                	je     8013e1 <strtol+0x58>
  8013db:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013df:	75 20                	jne    801401 <strtol+0x78>
  8013e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e4:	8a 00                	mov    (%eax),%al
  8013e6:	3c 30                	cmp    $0x30,%al
  8013e8:	75 17                	jne    801401 <strtol+0x78>
  8013ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ed:	40                   	inc    %eax
  8013ee:	8a 00                	mov    (%eax),%al
  8013f0:	3c 78                	cmp    $0x78,%al
  8013f2:	75 0d                	jne    801401 <strtol+0x78>
		s += 2, base = 16;
  8013f4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013f8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013ff:	eb 28                	jmp    801429 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801401:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801405:	75 15                	jne    80141c <strtol+0x93>
  801407:	8b 45 08             	mov    0x8(%ebp),%eax
  80140a:	8a 00                	mov    (%eax),%al
  80140c:	3c 30                	cmp    $0x30,%al
  80140e:	75 0c                	jne    80141c <strtol+0x93>
		s++, base = 8;
  801410:	ff 45 08             	incl   0x8(%ebp)
  801413:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80141a:	eb 0d                	jmp    801429 <strtol+0xa0>
	else if (base == 0)
  80141c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801420:	75 07                	jne    801429 <strtol+0xa0>
		base = 10;
  801422:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801429:	8b 45 08             	mov    0x8(%ebp),%eax
  80142c:	8a 00                	mov    (%eax),%al
  80142e:	3c 2f                	cmp    $0x2f,%al
  801430:	7e 19                	jle    80144b <strtol+0xc2>
  801432:	8b 45 08             	mov    0x8(%ebp),%eax
  801435:	8a 00                	mov    (%eax),%al
  801437:	3c 39                	cmp    $0x39,%al
  801439:	7f 10                	jg     80144b <strtol+0xc2>
			dig = *s - '0';
  80143b:	8b 45 08             	mov    0x8(%ebp),%eax
  80143e:	8a 00                	mov    (%eax),%al
  801440:	0f be c0             	movsbl %al,%eax
  801443:	83 e8 30             	sub    $0x30,%eax
  801446:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801449:	eb 42                	jmp    80148d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80144b:	8b 45 08             	mov    0x8(%ebp),%eax
  80144e:	8a 00                	mov    (%eax),%al
  801450:	3c 60                	cmp    $0x60,%al
  801452:	7e 19                	jle    80146d <strtol+0xe4>
  801454:	8b 45 08             	mov    0x8(%ebp),%eax
  801457:	8a 00                	mov    (%eax),%al
  801459:	3c 7a                	cmp    $0x7a,%al
  80145b:	7f 10                	jg     80146d <strtol+0xe4>
			dig = *s - 'a' + 10;
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	8a 00                	mov    (%eax),%al
  801462:	0f be c0             	movsbl %al,%eax
  801465:	83 e8 57             	sub    $0x57,%eax
  801468:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80146b:	eb 20                	jmp    80148d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80146d:	8b 45 08             	mov    0x8(%ebp),%eax
  801470:	8a 00                	mov    (%eax),%al
  801472:	3c 40                	cmp    $0x40,%al
  801474:	7e 39                	jle    8014af <strtol+0x126>
  801476:	8b 45 08             	mov    0x8(%ebp),%eax
  801479:	8a 00                	mov    (%eax),%al
  80147b:	3c 5a                	cmp    $0x5a,%al
  80147d:	7f 30                	jg     8014af <strtol+0x126>
			dig = *s - 'A' + 10;
  80147f:	8b 45 08             	mov    0x8(%ebp),%eax
  801482:	8a 00                	mov    (%eax),%al
  801484:	0f be c0             	movsbl %al,%eax
  801487:	83 e8 37             	sub    $0x37,%eax
  80148a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80148d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801490:	3b 45 10             	cmp    0x10(%ebp),%eax
  801493:	7d 19                	jge    8014ae <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801495:	ff 45 08             	incl   0x8(%ebp)
  801498:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80149b:	0f af 45 10          	imul   0x10(%ebp),%eax
  80149f:	89 c2                	mov    %eax,%edx
  8014a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014a4:	01 d0                	add    %edx,%eax
  8014a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014a9:	e9 7b ff ff ff       	jmp    801429 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014ae:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014af:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014b3:	74 08                	je     8014bd <strtol+0x134>
		*endptr = (char *) s;
  8014b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b8:	8b 55 08             	mov    0x8(%ebp),%edx
  8014bb:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014bd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014c1:	74 07                	je     8014ca <strtol+0x141>
  8014c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014c6:	f7 d8                	neg    %eax
  8014c8:	eb 03                	jmp    8014cd <strtol+0x144>
  8014ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014cd:	c9                   	leave  
  8014ce:	c3                   	ret    

008014cf <ltostr>:

void
ltostr(long value, char *str)
{
  8014cf:	55                   	push   %ebp
  8014d0:	89 e5                	mov    %esp,%ebp
  8014d2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014e7:	79 13                	jns    8014fc <ltostr+0x2d>
	{
		neg = 1;
  8014e9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014f6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014f9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ff:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801504:	99                   	cltd   
  801505:	f7 f9                	idiv   %ecx
  801507:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80150a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80150d:	8d 50 01             	lea    0x1(%eax),%edx
  801510:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801513:	89 c2                	mov    %eax,%edx
  801515:	8b 45 0c             	mov    0xc(%ebp),%eax
  801518:	01 d0                	add    %edx,%eax
  80151a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80151d:	83 c2 30             	add    $0x30,%edx
  801520:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801522:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801525:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80152a:	f7 e9                	imul   %ecx
  80152c:	c1 fa 02             	sar    $0x2,%edx
  80152f:	89 c8                	mov    %ecx,%eax
  801531:	c1 f8 1f             	sar    $0x1f,%eax
  801534:	29 c2                	sub    %eax,%edx
  801536:	89 d0                	mov    %edx,%eax
  801538:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80153b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80153e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801543:	f7 e9                	imul   %ecx
  801545:	c1 fa 02             	sar    $0x2,%edx
  801548:	89 c8                	mov    %ecx,%eax
  80154a:	c1 f8 1f             	sar    $0x1f,%eax
  80154d:	29 c2                	sub    %eax,%edx
  80154f:	89 d0                	mov    %edx,%eax
  801551:	c1 e0 02             	shl    $0x2,%eax
  801554:	01 d0                	add    %edx,%eax
  801556:	01 c0                	add    %eax,%eax
  801558:	29 c1                	sub    %eax,%ecx
  80155a:	89 ca                	mov    %ecx,%edx
  80155c:	85 d2                	test   %edx,%edx
  80155e:	75 9c                	jne    8014fc <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801560:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801567:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80156a:	48                   	dec    %eax
  80156b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80156e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801572:	74 3d                	je     8015b1 <ltostr+0xe2>
		start = 1 ;
  801574:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80157b:	eb 34                	jmp    8015b1 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80157d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801580:	8b 45 0c             	mov    0xc(%ebp),%eax
  801583:	01 d0                	add    %edx,%eax
  801585:	8a 00                	mov    (%eax),%al
  801587:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80158a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80158d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801590:	01 c2                	add    %eax,%edx
  801592:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801595:	8b 45 0c             	mov    0xc(%ebp),%eax
  801598:	01 c8                	add    %ecx,%eax
  80159a:	8a 00                	mov    (%eax),%al
  80159c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80159e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a4:	01 c2                	add    %eax,%edx
  8015a6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015a9:	88 02                	mov    %al,(%edx)
		start++ ;
  8015ab:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015ae:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015b4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015b7:	7c c4                	jl     80157d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015b9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015bf:	01 d0                	add    %edx,%eax
  8015c1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015c4:	90                   	nop
  8015c5:	c9                   	leave  
  8015c6:	c3                   	ret    

008015c7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015c7:	55                   	push   %ebp
  8015c8:	89 e5                	mov    %esp,%ebp
  8015ca:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015cd:	ff 75 08             	pushl  0x8(%ebp)
  8015d0:	e8 54 fa ff ff       	call   801029 <strlen>
  8015d5:	83 c4 04             	add    $0x4,%esp
  8015d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015db:	ff 75 0c             	pushl  0xc(%ebp)
  8015de:	e8 46 fa ff ff       	call   801029 <strlen>
  8015e3:	83 c4 04             	add    $0x4,%esp
  8015e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015f7:	eb 17                	jmp    801610 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ff:	01 c2                	add    %eax,%edx
  801601:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801604:	8b 45 08             	mov    0x8(%ebp),%eax
  801607:	01 c8                	add    %ecx,%eax
  801609:	8a 00                	mov    (%eax),%al
  80160b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80160d:	ff 45 fc             	incl   -0x4(%ebp)
  801610:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801613:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801616:	7c e1                	jl     8015f9 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801618:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80161f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801626:	eb 1f                	jmp    801647 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801628:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80162b:	8d 50 01             	lea    0x1(%eax),%edx
  80162e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801631:	89 c2                	mov    %eax,%edx
  801633:	8b 45 10             	mov    0x10(%ebp),%eax
  801636:	01 c2                	add    %eax,%edx
  801638:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80163b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80163e:	01 c8                	add    %ecx,%eax
  801640:	8a 00                	mov    (%eax),%al
  801642:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801644:	ff 45 f8             	incl   -0x8(%ebp)
  801647:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80164a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80164d:	7c d9                	jl     801628 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80164f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801652:	8b 45 10             	mov    0x10(%ebp),%eax
  801655:	01 d0                	add    %edx,%eax
  801657:	c6 00 00             	movb   $0x0,(%eax)
}
  80165a:	90                   	nop
  80165b:	c9                   	leave  
  80165c:	c3                   	ret    

0080165d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80165d:	55                   	push   %ebp
  80165e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801660:	8b 45 14             	mov    0x14(%ebp),%eax
  801663:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801669:	8b 45 14             	mov    0x14(%ebp),%eax
  80166c:	8b 00                	mov    (%eax),%eax
  80166e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801675:	8b 45 10             	mov    0x10(%ebp),%eax
  801678:	01 d0                	add    %edx,%eax
  80167a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801680:	eb 0c                	jmp    80168e <strsplit+0x31>
			*string++ = 0;
  801682:	8b 45 08             	mov    0x8(%ebp),%eax
  801685:	8d 50 01             	lea    0x1(%eax),%edx
  801688:	89 55 08             	mov    %edx,0x8(%ebp)
  80168b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80168e:	8b 45 08             	mov    0x8(%ebp),%eax
  801691:	8a 00                	mov    (%eax),%al
  801693:	84 c0                	test   %al,%al
  801695:	74 18                	je     8016af <strsplit+0x52>
  801697:	8b 45 08             	mov    0x8(%ebp),%eax
  80169a:	8a 00                	mov    (%eax),%al
  80169c:	0f be c0             	movsbl %al,%eax
  80169f:	50                   	push   %eax
  8016a0:	ff 75 0c             	pushl  0xc(%ebp)
  8016a3:	e8 13 fb ff ff       	call   8011bb <strchr>
  8016a8:	83 c4 08             	add    $0x8,%esp
  8016ab:	85 c0                	test   %eax,%eax
  8016ad:	75 d3                	jne    801682 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016af:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b2:	8a 00                	mov    (%eax),%al
  8016b4:	84 c0                	test   %al,%al
  8016b6:	74 5a                	je     801712 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8016bb:	8b 00                	mov    (%eax),%eax
  8016bd:	83 f8 0f             	cmp    $0xf,%eax
  8016c0:	75 07                	jne    8016c9 <strsplit+0x6c>
		{
			return 0;
  8016c2:	b8 00 00 00 00       	mov    $0x0,%eax
  8016c7:	eb 66                	jmp    80172f <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8016cc:	8b 00                	mov    (%eax),%eax
  8016ce:	8d 48 01             	lea    0x1(%eax),%ecx
  8016d1:	8b 55 14             	mov    0x14(%ebp),%edx
  8016d4:	89 0a                	mov    %ecx,(%edx)
  8016d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8016e0:	01 c2                	add    %eax,%edx
  8016e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016e7:	eb 03                	jmp    8016ec <strsplit+0x8f>
			string++;
  8016e9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ef:	8a 00                	mov    (%eax),%al
  8016f1:	84 c0                	test   %al,%al
  8016f3:	74 8b                	je     801680 <strsplit+0x23>
  8016f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f8:	8a 00                	mov    (%eax),%al
  8016fa:	0f be c0             	movsbl %al,%eax
  8016fd:	50                   	push   %eax
  8016fe:	ff 75 0c             	pushl  0xc(%ebp)
  801701:	e8 b5 fa ff ff       	call   8011bb <strchr>
  801706:	83 c4 08             	add    $0x8,%esp
  801709:	85 c0                	test   %eax,%eax
  80170b:	74 dc                	je     8016e9 <strsplit+0x8c>
			string++;
	}
  80170d:	e9 6e ff ff ff       	jmp    801680 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801712:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801713:	8b 45 14             	mov    0x14(%ebp),%eax
  801716:	8b 00                	mov    (%eax),%eax
  801718:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80171f:	8b 45 10             	mov    0x10(%ebp),%eax
  801722:	01 d0                	add    %edx,%eax
  801724:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80172a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80172f:	c9                   	leave  
  801730:	c3                   	ret    

00801731 <malloc>:
int changes=0;
int sizeofarray=0;
uint32 addresses[100];
int changed[100];
void* malloc(uint32 size)
{
  801731:	55                   	push   %ebp
  801732:	89 e5                	mov    %esp,%ebp
  801734:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801737:	8b 45 08             	mov    0x8(%ebp),%eax
  80173a:	c1 e8 0c             	shr    $0xc,%eax
  80173d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;
		if(size%PAGE_SIZE!=0)
  801740:	8b 45 08             	mov    0x8(%ebp),%eax
  801743:	25 ff 0f 00 00       	and    $0xfff,%eax
  801748:	85 c0                	test   %eax,%eax
  80174a:	74 03                	je     80174f <malloc+0x1e>
			num++;
  80174c:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  80174f:	a1 04 30 80 00       	mov    0x803004,%eax
  801754:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801759:	75 64                	jne    8017bf <malloc+0x8e>
		{
			sys_allocateMem(USER_HEAP_START,size);
  80175b:	83 ec 08             	sub    $0x8,%esp
  80175e:	ff 75 08             	pushl  0x8(%ebp)
  801761:	68 00 00 00 80       	push   $0x80000000
  801766:	e8 3a 04 00 00       	call   801ba5 <sys_allocateMem>
  80176b:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  80176e:	a1 04 30 80 00       	mov    0x803004,%eax
  801773:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801776:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801779:	c1 e0 0c             	shl    $0xc,%eax
  80177c:	89 c2                	mov    %eax,%edx
  80177e:	a1 04 30 80 00       	mov    0x803004,%eax
  801783:	01 d0                	add    %edx,%eax
  801785:	a3 04 30 80 00       	mov    %eax,0x803004
			addresses[sizeofarray]=last_addres;
  80178a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80178f:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801795:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  80179c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017a1:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  8017a8:	01 00 00 00 
			sizeofarray++;
  8017ac:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017b1:	40                   	inc    %eax
  8017b2:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  8017b7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8017ba:	e9 26 01 00 00       	jmp    8018e5 <malloc+0x1b4>
		}
		else
		{
			if(changes==0)
  8017bf:	a1 28 30 80 00       	mov    0x803028,%eax
  8017c4:	85 c0                	test   %eax,%eax
  8017c6:	75 62                	jne    80182a <malloc+0xf9>
			{
				sys_allocateMem(last_addres,size);
  8017c8:	a1 04 30 80 00       	mov    0x803004,%eax
  8017cd:	83 ec 08             	sub    $0x8,%esp
  8017d0:	ff 75 08             	pushl  0x8(%ebp)
  8017d3:	50                   	push   %eax
  8017d4:	e8 cc 03 00 00       	call   801ba5 <sys_allocateMem>
  8017d9:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8017dc:	a1 04 30 80 00       	mov    0x803004,%eax
  8017e1:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  8017e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017e7:	c1 e0 0c             	shl    $0xc,%eax
  8017ea:	89 c2                	mov    %eax,%edx
  8017ec:	a1 04 30 80 00       	mov    0x803004,%eax
  8017f1:	01 d0                	add    %edx,%eax
  8017f3:	a3 04 30 80 00       	mov    %eax,0x803004
				addresses[sizeofarray]=return_addres;
  8017f8:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017fd:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801800:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801807:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80180c:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  801813:	01 00 00 00 
				sizeofarray++;
  801817:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80181c:	40                   	inc    %eax
  80181d:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  801822:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801825:	e9 bb 00 00 00       	jmp    8018e5 <malloc+0x1b4>
			}
			else{
				int count=0;
  80182a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801831:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801838:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80183f:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801846:	eb 7c                	jmp    8018c4 <malloc+0x193>
				{
					uint32 *pg=NULL;
  801848:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  80184f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801856:	eb 1a                	jmp    801872 <malloc+0x141>
					{
						if(addresses[j]==i)
  801858:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80185b:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801862:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801865:	75 08                	jne    80186f <malloc+0x13e>
						{
							index=j;
  801867:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80186a:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  80186d:	eb 0d                	jmp    80187c <malloc+0x14b>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  80186f:	ff 45 dc             	incl   -0x24(%ebp)
  801872:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801877:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  80187a:	7c dc                	jl     801858 <malloc+0x127>
							index=j;
							break;
						}
					}

					if(index==-1)
  80187c:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801880:	75 05                	jne    801887 <malloc+0x156>
					{
						count++;
  801882:	ff 45 f0             	incl   -0x10(%ebp)
  801885:	eb 36                	jmp    8018bd <malloc+0x18c>
					}
					else
					{
						if(changed[index]==0)
  801887:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80188a:	8b 04 85 c0 32 80 00 	mov    0x8032c0(,%eax,4),%eax
  801891:	85 c0                	test   %eax,%eax
  801893:	75 05                	jne    80189a <malloc+0x169>
						{
							count++;
  801895:	ff 45 f0             	incl   -0x10(%ebp)
  801898:	eb 23                	jmp    8018bd <malloc+0x18c>
						}
						else
						{
							if(count<min&&count>=num)
  80189a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80189d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8018a0:	7d 14                	jge    8018b6 <malloc+0x185>
  8018a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018a5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018a8:	7c 0c                	jl     8018b6 <malloc+0x185>
							{
								min=count;
  8018aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8018b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8018b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8018bd:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8018c4:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8018cb:	0f 86 77 ff ff ff    	jbe    801848 <malloc+0x117>

					}

					}

				sys_allocateMem(min_addresss,size);
  8018d1:	83 ec 08             	sub    $0x8,%esp
  8018d4:	ff 75 08             	pushl  0x8(%ebp)
  8018d7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8018da:	e8 c6 02 00 00       	call   801ba5 <sys_allocateMem>
  8018df:	83 c4 10             	add    $0x10,%esp

				return(void*) min_addresss;
  8018e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  8018e5:	c9                   	leave  
  8018e6:	c3                   	ret    

008018e7 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8018e7:	55                   	push   %ebp
  8018e8:	89 e5                	mov    %esp,%ebp
  8018ea:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8018ed:	83 ec 04             	sub    $0x4,%esp
  8018f0:	68 d0 28 80 00       	push   $0x8028d0
  8018f5:	6a 7b                	push   $0x7b
  8018f7:	68 f3 28 80 00       	push   $0x8028f3
  8018fc:	e8 2e 07 00 00       	call   80202f <_panic>

00801901 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801901:	55                   	push   %ebp
  801902:	89 e5                	mov    %esp,%ebp
  801904:	83 ec 18             	sub    $0x18,%esp
  801907:	8b 45 10             	mov    0x10(%ebp),%eax
  80190a:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80190d:	83 ec 04             	sub    $0x4,%esp
  801910:	68 00 29 80 00       	push   $0x802900
  801915:	68 88 00 00 00       	push   $0x88
  80191a:	68 f3 28 80 00       	push   $0x8028f3
  80191f:	e8 0b 07 00 00       	call   80202f <_panic>

00801924 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801924:	55                   	push   %ebp
  801925:	89 e5                	mov    %esp,%ebp
  801927:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80192a:	83 ec 04             	sub    $0x4,%esp
  80192d:	68 00 29 80 00       	push   $0x802900
  801932:	68 8e 00 00 00       	push   $0x8e
  801937:	68 f3 28 80 00       	push   $0x8028f3
  80193c:	e8 ee 06 00 00       	call   80202f <_panic>

00801941 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801941:	55                   	push   %ebp
  801942:	89 e5                	mov    %esp,%ebp
  801944:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801947:	83 ec 04             	sub    $0x4,%esp
  80194a:	68 00 29 80 00       	push   $0x802900
  80194f:	68 94 00 00 00       	push   $0x94
  801954:	68 f3 28 80 00       	push   $0x8028f3
  801959:	e8 d1 06 00 00       	call   80202f <_panic>

0080195e <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  80195e:	55                   	push   %ebp
  80195f:	89 e5                	mov    %esp,%ebp
  801961:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801964:	83 ec 04             	sub    $0x4,%esp
  801967:	68 00 29 80 00       	push   $0x802900
  80196c:	68 99 00 00 00       	push   $0x99
  801971:	68 f3 28 80 00       	push   $0x8028f3
  801976:	e8 b4 06 00 00       	call   80202f <_panic>

0080197b <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  80197b:	55                   	push   %ebp
  80197c:	89 e5                	mov    %esp,%ebp
  80197e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801981:	83 ec 04             	sub    $0x4,%esp
  801984:	68 00 29 80 00       	push   $0x802900
  801989:	68 9f 00 00 00       	push   $0x9f
  80198e:	68 f3 28 80 00       	push   $0x8028f3
  801993:	e8 97 06 00 00       	call   80202f <_panic>

00801998 <shrink>:
}
void shrink(uint32 newSize)
{
  801998:	55                   	push   %ebp
  801999:	89 e5                	mov    %esp,%ebp
  80199b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80199e:	83 ec 04             	sub    $0x4,%esp
  8019a1:	68 00 29 80 00       	push   $0x802900
  8019a6:	68 a3 00 00 00       	push   $0xa3
  8019ab:	68 f3 28 80 00       	push   $0x8028f3
  8019b0:	e8 7a 06 00 00       	call   80202f <_panic>

008019b5 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
  8019b8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019bb:	83 ec 04             	sub    $0x4,%esp
  8019be:	68 00 29 80 00       	push   $0x802900
  8019c3:	68 a8 00 00 00       	push   $0xa8
  8019c8:	68 f3 28 80 00       	push   $0x8028f3
  8019cd:	e8 5d 06 00 00       	call   80202f <_panic>

008019d2 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8019d2:	55                   	push   %ebp
  8019d3:	89 e5                	mov    %esp,%ebp
  8019d5:	57                   	push   %edi
  8019d6:	56                   	push   %esi
  8019d7:	53                   	push   %ebx
  8019d8:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8019db:	8b 45 08             	mov    0x8(%ebp),%eax
  8019de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019e1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019e4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8019e7:	8b 7d 18             	mov    0x18(%ebp),%edi
  8019ea:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8019ed:	cd 30                	int    $0x30
  8019ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8019f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8019f5:	83 c4 10             	add    $0x10,%esp
  8019f8:	5b                   	pop    %ebx
  8019f9:	5e                   	pop    %esi
  8019fa:	5f                   	pop    %edi
  8019fb:	5d                   	pop    %ebp
  8019fc:	c3                   	ret    

008019fd <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8019fd:	55                   	push   %ebp
  8019fe:	89 e5                	mov    %esp,%ebp
  801a00:	83 ec 04             	sub    $0x4,%esp
  801a03:	8b 45 10             	mov    0x10(%ebp),%eax
  801a06:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a09:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	52                   	push   %edx
  801a15:	ff 75 0c             	pushl  0xc(%ebp)
  801a18:	50                   	push   %eax
  801a19:	6a 00                	push   $0x0
  801a1b:	e8 b2 ff ff ff       	call   8019d2 <syscall>
  801a20:	83 c4 18             	add    $0x18,%esp
}
  801a23:	90                   	nop
  801a24:	c9                   	leave  
  801a25:	c3                   	ret    

00801a26 <sys_cgetc>:

int
sys_cgetc(void)
{
  801a26:	55                   	push   %ebp
  801a27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	6a 01                	push   $0x1
  801a35:	e8 98 ff ff ff       	call   8019d2 <syscall>
  801a3a:	83 c4 18             	add    $0x18,%esp
}
  801a3d:	c9                   	leave  
  801a3e:	c3                   	ret    

00801a3f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a3f:	55                   	push   %ebp
  801a40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a42:	8b 45 08             	mov    0x8(%ebp),%eax
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	50                   	push   %eax
  801a4e:	6a 05                	push   $0x5
  801a50:	e8 7d ff ff ff       	call   8019d2 <syscall>
  801a55:	83 c4 18             	add    $0x18,%esp
}
  801a58:	c9                   	leave  
  801a59:	c3                   	ret    

00801a5a <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 02                	push   $0x2
  801a69:	e8 64 ff ff ff       	call   8019d2 <syscall>
  801a6e:	83 c4 18             	add    $0x18,%esp
}
  801a71:	c9                   	leave  
  801a72:	c3                   	ret    

00801a73 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801a73:	55                   	push   %ebp
  801a74:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 03                	push   $0x3
  801a82:	e8 4b ff ff ff       	call   8019d2 <syscall>
  801a87:	83 c4 18             	add    $0x18,%esp
}
  801a8a:	c9                   	leave  
  801a8b:	c3                   	ret    

00801a8c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801a8c:	55                   	push   %ebp
  801a8d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 04                	push   $0x4
  801a9b:	e8 32 ff ff ff       	call   8019d2 <syscall>
  801aa0:	83 c4 18             	add    $0x18,%esp
}
  801aa3:	c9                   	leave  
  801aa4:	c3                   	ret    

00801aa5 <sys_env_exit>:


void sys_env_exit(void)
{
  801aa5:	55                   	push   %ebp
  801aa6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 06                	push   $0x6
  801ab4:	e8 19 ff ff ff       	call   8019d2 <syscall>
  801ab9:	83 c4 18             	add    $0x18,%esp
}
  801abc:	90                   	nop
  801abd:	c9                   	leave  
  801abe:	c3                   	ret    

00801abf <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801abf:	55                   	push   %ebp
  801ac0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ac2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	52                   	push   %edx
  801acf:	50                   	push   %eax
  801ad0:	6a 07                	push   $0x7
  801ad2:	e8 fb fe ff ff       	call   8019d2 <syscall>
  801ad7:	83 c4 18             	add    $0x18,%esp
}
  801ada:	c9                   	leave  
  801adb:	c3                   	ret    

00801adc <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801adc:	55                   	push   %ebp
  801add:	89 e5                	mov    %esp,%ebp
  801adf:	56                   	push   %esi
  801ae0:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801ae1:	8b 75 18             	mov    0x18(%ebp),%esi
  801ae4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ae7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801aea:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aed:	8b 45 08             	mov    0x8(%ebp),%eax
  801af0:	56                   	push   %esi
  801af1:	53                   	push   %ebx
  801af2:	51                   	push   %ecx
  801af3:	52                   	push   %edx
  801af4:	50                   	push   %eax
  801af5:	6a 08                	push   $0x8
  801af7:	e8 d6 fe ff ff       	call   8019d2 <syscall>
  801afc:	83 c4 18             	add    $0x18,%esp
}
  801aff:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b02:	5b                   	pop    %ebx
  801b03:	5e                   	pop    %esi
  801b04:	5d                   	pop    %ebp
  801b05:	c3                   	ret    

00801b06 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b06:	55                   	push   %ebp
  801b07:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b09:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	52                   	push   %edx
  801b16:	50                   	push   %eax
  801b17:	6a 09                	push   $0x9
  801b19:	e8 b4 fe ff ff       	call   8019d2 <syscall>
  801b1e:	83 c4 18             	add    $0x18,%esp
}
  801b21:	c9                   	leave  
  801b22:	c3                   	ret    

00801b23 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b23:	55                   	push   %ebp
  801b24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b26:	6a 00                	push   $0x0
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	ff 75 0c             	pushl  0xc(%ebp)
  801b2f:	ff 75 08             	pushl  0x8(%ebp)
  801b32:	6a 0a                	push   $0xa
  801b34:	e8 99 fe ff ff       	call   8019d2 <syscall>
  801b39:	83 c4 18             	add    $0x18,%esp
}
  801b3c:	c9                   	leave  
  801b3d:	c3                   	ret    

00801b3e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b3e:	55                   	push   %ebp
  801b3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	6a 00                	push   $0x0
  801b49:	6a 00                	push   $0x0
  801b4b:	6a 0b                	push   $0xb
  801b4d:	e8 80 fe ff ff       	call   8019d2 <syscall>
  801b52:	83 c4 18             	add    $0x18,%esp
}
  801b55:	c9                   	leave  
  801b56:	c3                   	ret    

00801b57 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b57:	55                   	push   %ebp
  801b58:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 0c                	push   $0xc
  801b66:	e8 67 fe ff ff       	call   8019d2 <syscall>
  801b6b:	83 c4 18             	add    $0x18,%esp
}
  801b6e:	c9                   	leave  
  801b6f:	c3                   	ret    

00801b70 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b70:	55                   	push   %ebp
  801b71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 0d                	push   $0xd
  801b7f:	e8 4e fe ff ff       	call   8019d2 <syscall>
  801b84:	83 c4 18             	add    $0x18,%esp
}
  801b87:	c9                   	leave  
  801b88:	c3                   	ret    

00801b89 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801b89:	55                   	push   %ebp
  801b8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 00                	push   $0x0
  801b92:	ff 75 0c             	pushl  0xc(%ebp)
  801b95:	ff 75 08             	pushl  0x8(%ebp)
  801b98:	6a 11                	push   $0x11
  801b9a:	e8 33 fe ff ff       	call   8019d2 <syscall>
  801b9f:	83 c4 18             	add    $0x18,%esp
	return;
  801ba2:	90                   	nop
}
  801ba3:	c9                   	leave  
  801ba4:	c3                   	ret    

00801ba5 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801ba5:	55                   	push   %ebp
  801ba6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	ff 75 0c             	pushl  0xc(%ebp)
  801bb1:	ff 75 08             	pushl  0x8(%ebp)
  801bb4:	6a 12                	push   $0x12
  801bb6:	e8 17 fe ff ff       	call   8019d2 <syscall>
  801bbb:	83 c4 18             	add    $0x18,%esp
	return ;
  801bbe:	90                   	nop
}
  801bbf:	c9                   	leave  
  801bc0:	c3                   	ret    

00801bc1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801bc1:	55                   	push   %ebp
  801bc2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 0e                	push   $0xe
  801bd0:	e8 fd fd ff ff       	call   8019d2 <syscall>
  801bd5:	83 c4 18             	add    $0x18,%esp
}
  801bd8:	c9                   	leave  
  801bd9:	c3                   	ret    

00801bda <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801bda:	55                   	push   %ebp
  801bdb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	ff 75 08             	pushl  0x8(%ebp)
  801be8:	6a 0f                	push   $0xf
  801bea:	e8 e3 fd ff ff       	call   8019d2 <syscall>
  801bef:	83 c4 18             	add    $0x18,%esp
}
  801bf2:	c9                   	leave  
  801bf3:	c3                   	ret    

00801bf4 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801bf4:	55                   	push   %ebp
  801bf5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	6a 10                	push   $0x10
  801c03:	e8 ca fd ff ff       	call   8019d2 <syscall>
  801c08:	83 c4 18             	add    $0x18,%esp
}
  801c0b:	90                   	nop
  801c0c:	c9                   	leave  
  801c0d:	c3                   	ret    

00801c0e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c0e:	55                   	push   %ebp
  801c0f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 14                	push   $0x14
  801c1d:	e8 b0 fd ff ff       	call   8019d2 <syscall>
  801c22:	83 c4 18             	add    $0x18,%esp
}
  801c25:	90                   	nop
  801c26:	c9                   	leave  
  801c27:	c3                   	ret    

00801c28 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c28:	55                   	push   %ebp
  801c29:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 15                	push   $0x15
  801c37:	e8 96 fd ff ff       	call   8019d2 <syscall>
  801c3c:	83 c4 18             	add    $0x18,%esp
}
  801c3f:	90                   	nop
  801c40:	c9                   	leave  
  801c41:	c3                   	ret    

00801c42 <sys_cputc>:


void
sys_cputc(const char c)
{
  801c42:	55                   	push   %ebp
  801c43:	89 e5                	mov    %esp,%ebp
  801c45:	83 ec 04             	sub    $0x4,%esp
  801c48:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801c4e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	50                   	push   %eax
  801c5b:	6a 16                	push   $0x16
  801c5d:	e8 70 fd ff ff       	call   8019d2 <syscall>
  801c62:	83 c4 18             	add    $0x18,%esp
}
  801c65:	90                   	nop
  801c66:	c9                   	leave  
  801c67:	c3                   	ret    

00801c68 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c68:	55                   	push   %ebp
  801c69:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 17                	push   $0x17
  801c77:	e8 56 fd ff ff       	call   8019d2 <syscall>
  801c7c:	83 c4 18             	add    $0x18,%esp
}
  801c7f:	90                   	nop
  801c80:	c9                   	leave  
  801c81:	c3                   	ret    

00801c82 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801c82:	55                   	push   %ebp
  801c83:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801c85:	8b 45 08             	mov    0x8(%ebp),%eax
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	ff 75 0c             	pushl  0xc(%ebp)
  801c91:	50                   	push   %eax
  801c92:	6a 18                	push   $0x18
  801c94:	e8 39 fd ff ff       	call   8019d2 <syscall>
  801c99:	83 c4 18             	add    $0x18,%esp
}
  801c9c:	c9                   	leave  
  801c9d:	c3                   	ret    

00801c9e <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801c9e:	55                   	push   %ebp
  801c9f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ca1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	52                   	push   %edx
  801cae:	50                   	push   %eax
  801caf:	6a 1b                	push   $0x1b
  801cb1:	e8 1c fd ff ff       	call   8019d2 <syscall>
  801cb6:	83 c4 18             	add    $0x18,%esp
}
  801cb9:	c9                   	leave  
  801cba:	c3                   	ret    

00801cbb <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cbb:	55                   	push   %ebp
  801cbc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	52                   	push   %edx
  801ccb:	50                   	push   %eax
  801ccc:	6a 19                	push   $0x19
  801cce:	e8 ff fc ff ff       	call   8019d2 <syscall>
  801cd3:	83 c4 18             	add    $0x18,%esp
}
  801cd6:	90                   	nop
  801cd7:	c9                   	leave  
  801cd8:	c3                   	ret    

00801cd9 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cd9:	55                   	push   %ebp
  801cda:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cdc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	52                   	push   %edx
  801ce9:	50                   	push   %eax
  801cea:	6a 1a                	push   $0x1a
  801cec:	e8 e1 fc ff ff       	call   8019d2 <syscall>
  801cf1:	83 c4 18             	add    $0x18,%esp
}
  801cf4:	90                   	nop
  801cf5:	c9                   	leave  
  801cf6:	c3                   	ret    

00801cf7 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801cf7:	55                   	push   %ebp
  801cf8:	89 e5                	mov    %esp,%ebp
  801cfa:	83 ec 04             	sub    $0x4,%esp
  801cfd:	8b 45 10             	mov    0x10(%ebp),%eax
  801d00:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d03:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d06:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0d:	6a 00                	push   $0x0
  801d0f:	51                   	push   %ecx
  801d10:	52                   	push   %edx
  801d11:	ff 75 0c             	pushl  0xc(%ebp)
  801d14:	50                   	push   %eax
  801d15:	6a 1c                	push   $0x1c
  801d17:	e8 b6 fc ff ff       	call   8019d2 <syscall>
  801d1c:	83 c4 18             	add    $0x18,%esp
}
  801d1f:	c9                   	leave  
  801d20:	c3                   	ret    

00801d21 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d21:	55                   	push   %ebp
  801d22:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d24:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d27:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	52                   	push   %edx
  801d31:	50                   	push   %eax
  801d32:	6a 1d                	push   $0x1d
  801d34:	e8 99 fc ff ff       	call   8019d2 <syscall>
  801d39:	83 c4 18             	add    $0x18,%esp
}
  801d3c:	c9                   	leave  
  801d3d:	c3                   	ret    

00801d3e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d3e:	55                   	push   %ebp
  801d3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d41:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d44:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d47:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	51                   	push   %ecx
  801d4f:	52                   	push   %edx
  801d50:	50                   	push   %eax
  801d51:	6a 1e                	push   $0x1e
  801d53:	e8 7a fc ff ff       	call   8019d2 <syscall>
  801d58:	83 c4 18             	add    $0x18,%esp
}
  801d5b:	c9                   	leave  
  801d5c:	c3                   	ret    

00801d5d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d5d:	55                   	push   %ebp
  801d5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d63:	8b 45 08             	mov    0x8(%ebp),%eax
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	52                   	push   %edx
  801d6d:	50                   	push   %eax
  801d6e:	6a 1f                	push   $0x1f
  801d70:	e8 5d fc ff ff       	call   8019d2 <syscall>
  801d75:	83 c4 18             	add    $0x18,%esp
}
  801d78:	c9                   	leave  
  801d79:	c3                   	ret    

00801d7a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801d7a:	55                   	push   %ebp
  801d7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	6a 20                	push   $0x20
  801d89:	e8 44 fc ff ff       	call   8019d2 <syscall>
  801d8e:	83 c4 18             	add    $0x18,%esp
}
  801d91:	c9                   	leave  
  801d92:	c3                   	ret    

00801d93 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801d93:	55                   	push   %ebp
  801d94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801d96:	8b 45 08             	mov    0x8(%ebp),%eax
  801d99:	6a 00                	push   $0x0
  801d9b:	ff 75 14             	pushl  0x14(%ebp)
  801d9e:	ff 75 10             	pushl  0x10(%ebp)
  801da1:	ff 75 0c             	pushl  0xc(%ebp)
  801da4:	50                   	push   %eax
  801da5:	6a 21                	push   $0x21
  801da7:	e8 26 fc ff ff       	call   8019d2 <syscall>
  801dac:	83 c4 18             	add    $0x18,%esp
}
  801daf:	c9                   	leave  
  801db0:	c3                   	ret    

00801db1 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801db1:	55                   	push   %ebp
  801db2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801db4:	8b 45 08             	mov    0x8(%ebp),%eax
  801db7:	6a 00                	push   $0x0
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	50                   	push   %eax
  801dc0:	6a 22                	push   $0x22
  801dc2:	e8 0b fc ff ff       	call   8019d2 <syscall>
  801dc7:	83 c4 18             	add    $0x18,%esp
}
  801dca:	90                   	nop
  801dcb:	c9                   	leave  
  801dcc:	c3                   	ret    

00801dcd <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801dcd:	55                   	push   %ebp
  801dce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	50                   	push   %eax
  801ddc:	6a 23                	push   $0x23
  801dde:	e8 ef fb ff ff       	call   8019d2 <syscall>
  801de3:	83 c4 18             	add    $0x18,%esp
}
  801de6:	90                   	nop
  801de7:	c9                   	leave  
  801de8:	c3                   	ret    

00801de9 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801de9:	55                   	push   %ebp
  801dea:	89 e5                	mov    %esp,%ebp
  801dec:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801def:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801df2:	8d 50 04             	lea    0x4(%eax),%edx
  801df5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801df8:	6a 00                	push   $0x0
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	52                   	push   %edx
  801dff:	50                   	push   %eax
  801e00:	6a 24                	push   $0x24
  801e02:	e8 cb fb ff ff       	call   8019d2 <syscall>
  801e07:	83 c4 18             	add    $0x18,%esp
	return result;
  801e0a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e0d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e10:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e13:	89 01                	mov    %eax,(%ecx)
  801e15:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e18:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1b:	c9                   	leave  
  801e1c:	c2 04 00             	ret    $0x4

00801e1f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e1f:	55                   	push   %ebp
  801e20:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	ff 75 10             	pushl  0x10(%ebp)
  801e29:	ff 75 0c             	pushl  0xc(%ebp)
  801e2c:	ff 75 08             	pushl  0x8(%ebp)
  801e2f:	6a 13                	push   $0x13
  801e31:	e8 9c fb ff ff       	call   8019d2 <syscall>
  801e36:	83 c4 18             	add    $0x18,%esp
	return ;
  801e39:	90                   	nop
}
  801e3a:	c9                   	leave  
  801e3b:	c3                   	ret    

00801e3c <sys_rcr2>:
uint32 sys_rcr2()
{
  801e3c:	55                   	push   %ebp
  801e3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 00                	push   $0x0
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	6a 25                	push   $0x25
  801e4b:	e8 82 fb ff ff       	call   8019d2 <syscall>
  801e50:	83 c4 18             	add    $0x18,%esp
}
  801e53:	c9                   	leave  
  801e54:	c3                   	ret    

00801e55 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e55:	55                   	push   %ebp
  801e56:	89 e5                	mov    %esp,%ebp
  801e58:	83 ec 04             	sub    $0x4,%esp
  801e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e61:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	50                   	push   %eax
  801e6e:	6a 26                	push   $0x26
  801e70:	e8 5d fb ff ff       	call   8019d2 <syscall>
  801e75:	83 c4 18             	add    $0x18,%esp
	return ;
  801e78:	90                   	nop
}
  801e79:	c9                   	leave  
  801e7a:	c3                   	ret    

00801e7b <rsttst>:
void rsttst()
{
  801e7b:	55                   	push   %ebp
  801e7c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	6a 00                	push   $0x0
  801e84:	6a 00                	push   $0x0
  801e86:	6a 00                	push   $0x0
  801e88:	6a 28                	push   $0x28
  801e8a:	e8 43 fb ff ff       	call   8019d2 <syscall>
  801e8f:	83 c4 18             	add    $0x18,%esp
	return ;
  801e92:	90                   	nop
}
  801e93:	c9                   	leave  
  801e94:	c3                   	ret    

00801e95 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801e95:	55                   	push   %ebp
  801e96:	89 e5                	mov    %esp,%ebp
  801e98:	83 ec 04             	sub    $0x4,%esp
  801e9b:	8b 45 14             	mov    0x14(%ebp),%eax
  801e9e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ea1:	8b 55 18             	mov    0x18(%ebp),%edx
  801ea4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ea8:	52                   	push   %edx
  801ea9:	50                   	push   %eax
  801eaa:	ff 75 10             	pushl  0x10(%ebp)
  801ead:	ff 75 0c             	pushl  0xc(%ebp)
  801eb0:	ff 75 08             	pushl  0x8(%ebp)
  801eb3:	6a 27                	push   $0x27
  801eb5:	e8 18 fb ff ff       	call   8019d2 <syscall>
  801eba:	83 c4 18             	add    $0x18,%esp
	return ;
  801ebd:	90                   	nop
}
  801ebe:	c9                   	leave  
  801ebf:	c3                   	ret    

00801ec0 <chktst>:
void chktst(uint32 n)
{
  801ec0:	55                   	push   %ebp
  801ec1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ec3:	6a 00                	push   $0x0
  801ec5:	6a 00                	push   $0x0
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 00                	push   $0x0
  801ecb:	ff 75 08             	pushl  0x8(%ebp)
  801ece:	6a 29                	push   $0x29
  801ed0:	e8 fd fa ff ff       	call   8019d2 <syscall>
  801ed5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ed8:	90                   	nop
}
  801ed9:	c9                   	leave  
  801eda:	c3                   	ret    

00801edb <inctst>:

void inctst()
{
  801edb:	55                   	push   %ebp
  801edc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ede:	6a 00                	push   $0x0
  801ee0:	6a 00                	push   $0x0
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 00                	push   $0x0
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 2a                	push   $0x2a
  801eea:	e8 e3 fa ff ff       	call   8019d2 <syscall>
  801eef:	83 c4 18             	add    $0x18,%esp
	return ;
  801ef2:	90                   	nop
}
  801ef3:	c9                   	leave  
  801ef4:	c3                   	ret    

00801ef5 <gettst>:
uint32 gettst()
{
  801ef5:	55                   	push   %ebp
  801ef6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 2b                	push   $0x2b
  801f04:	e8 c9 fa ff ff       	call   8019d2 <syscall>
  801f09:	83 c4 18             	add    $0x18,%esp
}
  801f0c:	c9                   	leave  
  801f0d:	c3                   	ret    

00801f0e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f0e:	55                   	push   %ebp
  801f0f:	89 e5                	mov    %esp,%ebp
  801f11:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 2c                	push   $0x2c
  801f20:	e8 ad fa ff ff       	call   8019d2 <syscall>
  801f25:	83 c4 18             	add    $0x18,%esp
  801f28:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f2b:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f2f:	75 07                	jne    801f38 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f31:	b8 01 00 00 00       	mov    $0x1,%eax
  801f36:	eb 05                	jmp    801f3d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f38:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f3d:	c9                   	leave  
  801f3e:	c3                   	ret    

00801f3f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f3f:	55                   	push   %ebp
  801f40:	89 e5                	mov    %esp,%ebp
  801f42:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f45:	6a 00                	push   $0x0
  801f47:	6a 00                	push   $0x0
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 2c                	push   $0x2c
  801f51:	e8 7c fa ff ff       	call   8019d2 <syscall>
  801f56:	83 c4 18             	add    $0x18,%esp
  801f59:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f5c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f60:	75 07                	jne    801f69 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f62:	b8 01 00 00 00       	mov    $0x1,%eax
  801f67:	eb 05                	jmp    801f6e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801f69:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f6e:	c9                   	leave  
  801f6f:	c3                   	ret    

00801f70 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801f70:	55                   	push   %ebp
  801f71:	89 e5                	mov    %esp,%ebp
  801f73:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f76:	6a 00                	push   $0x0
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 00                	push   $0x0
  801f7c:	6a 00                	push   $0x0
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 2c                	push   $0x2c
  801f82:	e8 4b fa ff ff       	call   8019d2 <syscall>
  801f87:	83 c4 18             	add    $0x18,%esp
  801f8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801f8d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801f91:	75 07                	jne    801f9a <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801f93:	b8 01 00 00 00       	mov    $0x1,%eax
  801f98:	eb 05                	jmp    801f9f <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801f9a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f9f:	c9                   	leave  
  801fa0:	c3                   	ret    

00801fa1 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801fa1:	55                   	push   %ebp
  801fa2:	89 e5                	mov    %esp,%ebp
  801fa4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fa7:	6a 00                	push   $0x0
  801fa9:	6a 00                	push   $0x0
  801fab:	6a 00                	push   $0x0
  801fad:	6a 00                	push   $0x0
  801faf:	6a 00                	push   $0x0
  801fb1:	6a 2c                	push   $0x2c
  801fb3:	e8 1a fa ff ff       	call   8019d2 <syscall>
  801fb8:	83 c4 18             	add    $0x18,%esp
  801fbb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801fbe:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801fc2:	75 07                	jne    801fcb <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801fc4:	b8 01 00 00 00       	mov    $0x1,%eax
  801fc9:	eb 05                	jmp    801fd0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801fcb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fd0:	c9                   	leave  
  801fd1:	c3                   	ret    

00801fd2 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801fd2:	55                   	push   %ebp
  801fd3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 00                	push   $0x0
  801fdb:	6a 00                	push   $0x0
  801fdd:	ff 75 08             	pushl  0x8(%ebp)
  801fe0:	6a 2d                	push   $0x2d
  801fe2:	e8 eb f9 ff ff       	call   8019d2 <syscall>
  801fe7:	83 c4 18             	add    $0x18,%esp
	return ;
  801fea:	90                   	nop
}
  801feb:	c9                   	leave  
  801fec:	c3                   	ret    

00801fed <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801fed:	55                   	push   %ebp
  801fee:	89 e5                	mov    %esp,%ebp
  801ff0:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801ff1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ff4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ff7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ffa:	8b 45 08             	mov    0x8(%ebp),%eax
  801ffd:	6a 00                	push   $0x0
  801fff:	53                   	push   %ebx
  802000:	51                   	push   %ecx
  802001:	52                   	push   %edx
  802002:	50                   	push   %eax
  802003:	6a 2e                	push   $0x2e
  802005:	e8 c8 f9 ff ff       	call   8019d2 <syscall>
  80200a:	83 c4 18             	add    $0x18,%esp
}
  80200d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802010:	c9                   	leave  
  802011:	c3                   	ret    

00802012 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802012:	55                   	push   %ebp
  802013:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802015:	8b 55 0c             	mov    0xc(%ebp),%edx
  802018:	8b 45 08             	mov    0x8(%ebp),%eax
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	52                   	push   %edx
  802022:	50                   	push   %eax
  802023:	6a 2f                	push   $0x2f
  802025:	e8 a8 f9 ff ff       	call   8019d2 <syscall>
  80202a:	83 c4 18             	add    $0x18,%esp
}
  80202d:	c9                   	leave  
  80202e:	c3                   	ret    

0080202f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80202f:	55                   	push   %ebp
  802030:	89 e5                	mov    %esp,%ebp
  802032:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  802035:	8d 45 10             	lea    0x10(%ebp),%eax
  802038:	83 c0 04             	add    $0x4,%eax
  80203b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80203e:	a1 50 34 80 00       	mov    0x803450,%eax
  802043:	85 c0                	test   %eax,%eax
  802045:	74 16                	je     80205d <_panic+0x2e>
		cprintf("%s: ", argv0);
  802047:	a1 50 34 80 00       	mov    0x803450,%eax
  80204c:	83 ec 08             	sub    $0x8,%esp
  80204f:	50                   	push   %eax
  802050:	68 24 29 80 00       	push   $0x802924
  802055:	e8 4d e9 ff ff       	call   8009a7 <cprintf>
  80205a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80205d:	a1 00 30 80 00       	mov    0x803000,%eax
  802062:	ff 75 0c             	pushl  0xc(%ebp)
  802065:	ff 75 08             	pushl  0x8(%ebp)
  802068:	50                   	push   %eax
  802069:	68 29 29 80 00       	push   $0x802929
  80206e:	e8 34 e9 ff ff       	call   8009a7 <cprintf>
  802073:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  802076:	8b 45 10             	mov    0x10(%ebp),%eax
  802079:	83 ec 08             	sub    $0x8,%esp
  80207c:	ff 75 f4             	pushl  -0xc(%ebp)
  80207f:	50                   	push   %eax
  802080:	e8 b7 e8 ff ff       	call   80093c <vcprintf>
  802085:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  802088:	83 ec 08             	sub    $0x8,%esp
  80208b:	6a 00                	push   $0x0
  80208d:	68 45 29 80 00       	push   $0x802945
  802092:	e8 a5 e8 ff ff       	call   80093c <vcprintf>
  802097:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80209a:	e8 26 e8 ff ff       	call   8008c5 <exit>

	// should not return here
	while (1) ;
  80209f:	eb fe                	jmp    80209f <_panic+0x70>

008020a1 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8020a1:	55                   	push   %ebp
  8020a2:	89 e5                	mov    %esp,%ebp
  8020a4:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8020a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8020ac:	8b 50 74             	mov    0x74(%eax),%edx
  8020af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020b2:	39 c2                	cmp    %eax,%edx
  8020b4:	74 14                	je     8020ca <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8020b6:	83 ec 04             	sub    $0x4,%esp
  8020b9:	68 48 29 80 00       	push   $0x802948
  8020be:	6a 26                	push   $0x26
  8020c0:	68 94 29 80 00       	push   $0x802994
  8020c5:	e8 65 ff ff ff       	call   80202f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8020ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8020d1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8020d8:	e9 b6 00 00 00       	jmp    802193 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8020dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8020e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8020e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ea:	01 d0                	add    %edx,%eax
  8020ec:	8b 00                	mov    (%eax),%eax
  8020ee:	85 c0                	test   %eax,%eax
  8020f0:	75 08                	jne    8020fa <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8020f2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8020f5:	e9 96 00 00 00       	jmp    802190 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8020fa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802101:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  802108:	eb 5d                	jmp    802167 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80210a:	a1 20 30 80 00       	mov    0x803020,%eax
  80210f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  802115:	8b 55 e8             	mov    -0x18(%ebp),%edx
  802118:	c1 e2 04             	shl    $0x4,%edx
  80211b:	01 d0                	add    %edx,%eax
  80211d:	8a 40 04             	mov    0x4(%eax),%al
  802120:	84 c0                	test   %al,%al
  802122:	75 40                	jne    802164 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  802124:	a1 20 30 80 00       	mov    0x803020,%eax
  802129:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80212f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  802132:	c1 e2 04             	shl    $0x4,%edx
  802135:	01 d0                	add    %edx,%eax
  802137:	8b 00                	mov    (%eax),%eax
  802139:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80213c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80213f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  802144:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  802146:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802149:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  802150:	8b 45 08             	mov    0x8(%ebp),%eax
  802153:	01 c8                	add    %ecx,%eax
  802155:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  802157:	39 c2                	cmp    %eax,%edx
  802159:	75 09                	jne    802164 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80215b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  802162:	eb 12                	jmp    802176 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  802164:	ff 45 e8             	incl   -0x18(%ebp)
  802167:	a1 20 30 80 00       	mov    0x803020,%eax
  80216c:	8b 50 74             	mov    0x74(%eax),%edx
  80216f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802172:	39 c2                	cmp    %eax,%edx
  802174:	77 94                	ja     80210a <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  802176:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80217a:	75 14                	jne    802190 <CheckWSWithoutLastIndex+0xef>
			panic(
  80217c:	83 ec 04             	sub    $0x4,%esp
  80217f:	68 a0 29 80 00       	push   $0x8029a0
  802184:	6a 3a                	push   $0x3a
  802186:	68 94 29 80 00       	push   $0x802994
  80218b:	e8 9f fe ff ff       	call   80202f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  802190:	ff 45 f0             	incl   -0x10(%ebp)
  802193:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802196:	3b 45 0c             	cmp    0xc(%ebp),%eax
  802199:	0f 8c 3e ff ff ff    	jl     8020dd <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80219f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8021a6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8021ad:	eb 20                	jmp    8021cf <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8021af:	a1 20 30 80 00       	mov    0x803020,%eax
  8021b4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8021ba:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8021bd:	c1 e2 04             	shl    $0x4,%edx
  8021c0:	01 d0                	add    %edx,%eax
  8021c2:	8a 40 04             	mov    0x4(%eax),%al
  8021c5:	3c 01                	cmp    $0x1,%al
  8021c7:	75 03                	jne    8021cc <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8021c9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8021cc:	ff 45 e0             	incl   -0x20(%ebp)
  8021cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8021d4:	8b 50 74             	mov    0x74(%eax),%edx
  8021d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8021da:	39 c2                	cmp    %eax,%edx
  8021dc:	77 d1                	ja     8021af <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8021de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8021e1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8021e4:	74 14                	je     8021fa <CheckWSWithoutLastIndex+0x159>
		panic(
  8021e6:	83 ec 04             	sub    $0x4,%esp
  8021e9:	68 f4 29 80 00       	push   $0x8029f4
  8021ee:	6a 44                	push   $0x44
  8021f0:	68 94 29 80 00       	push   $0x802994
  8021f5:	e8 35 fe ff ff       	call   80202f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8021fa:	90                   	nop
  8021fb:	c9                   	leave  
  8021fc:	c3                   	ret    
  8021fd:	66 90                	xchg   %ax,%ax
  8021ff:	90                   	nop

00802200 <__udivdi3>:
  802200:	55                   	push   %ebp
  802201:	57                   	push   %edi
  802202:	56                   	push   %esi
  802203:	53                   	push   %ebx
  802204:	83 ec 1c             	sub    $0x1c,%esp
  802207:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80220b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80220f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802213:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802217:	89 ca                	mov    %ecx,%edx
  802219:	89 f8                	mov    %edi,%eax
  80221b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80221f:	85 f6                	test   %esi,%esi
  802221:	75 2d                	jne    802250 <__udivdi3+0x50>
  802223:	39 cf                	cmp    %ecx,%edi
  802225:	77 65                	ja     80228c <__udivdi3+0x8c>
  802227:	89 fd                	mov    %edi,%ebp
  802229:	85 ff                	test   %edi,%edi
  80222b:	75 0b                	jne    802238 <__udivdi3+0x38>
  80222d:	b8 01 00 00 00       	mov    $0x1,%eax
  802232:	31 d2                	xor    %edx,%edx
  802234:	f7 f7                	div    %edi
  802236:	89 c5                	mov    %eax,%ebp
  802238:	31 d2                	xor    %edx,%edx
  80223a:	89 c8                	mov    %ecx,%eax
  80223c:	f7 f5                	div    %ebp
  80223e:	89 c1                	mov    %eax,%ecx
  802240:	89 d8                	mov    %ebx,%eax
  802242:	f7 f5                	div    %ebp
  802244:	89 cf                	mov    %ecx,%edi
  802246:	89 fa                	mov    %edi,%edx
  802248:	83 c4 1c             	add    $0x1c,%esp
  80224b:	5b                   	pop    %ebx
  80224c:	5e                   	pop    %esi
  80224d:	5f                   	pop    %edi
  80224e:	5d                   	pop    %ebp
  80224f:	c3                   	ret    
  802250:	39 ce                	cmp    %ecx,%esi
  802252:	77 28                	ja     80227c <__udivdi3+0x7c>
  802254:	0f bd fe             	bsr    %esi,%edi
  802257:	83 f7 1f             	xor    $0x1f,%edi
  80225a:	75 40                	jne    80229c <__udivdi3+0x9c>
  80225c:	39 ce                	cmp    %ecx,%esi
  80225e:	72 0a                	jb     80226a <__udivdi3+0x6a>
  802260:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802264:	0f 87 9e 00 00 00    	ja     802308 <__udivdi3+0x108>
  80226a:	b8 01 00 00 00       	mov    $0x1,%eax
  80226f:	89 fa                	mov    %edi,%edx
  802271:	83 c4 1c             	add    $0x1c,%esp
  802274:	5b                   	pop    %ebx
  802275:	5e                   	pop    %esi
  802276:	5f                   	pop    %edi
  802277:	5d                   	pop    %ebp
  802278:	c3                   	ret    
  802279:	8d 76 00             	lea    0x0(%esi),%esi
  80227c:	31 ff                	xor    %edi,%edi
  80227e:	31 c0                	xor    %eax,%eax
  802280:	89 fa                	mov    %edi,%edx
  802282:	83 c4 1c             	add    $0x1c,%esp
  802285:	5b                   	pop    %ebx
  802286:	5e                   	pop    %esi
  802287:	5f                   	pop    %edi
  802288:	5d                   	pop    %ebp
  802289:	c3                   	ret    
  80228a:	66 90                	xchg   %ax,%ax
  80228c:	89 d8                	mov    %ebx,%eax
  80228e:	f7 f7                	div    %edi
  802290:	31 ff                	xor    %edi,%edi
  802292:	89 fa                	mov    %edi,%edx
  802294:	83 c4 1c             	add    $0x1c,%esp
  802297:	5b                   	pop    %ebx
  802298:	5e                   	pop    %esi
  802299:	5f                   	pop    %edi
  80229a:	5d                   	pop    %ebp
  80229b:	c3                   	ret    
  80229c:	bd 20 00 00 00       	mov    $0x20,%ebp
  8022a1:	89 eb                	mov    %ebp,%ebx
  8022a3:	29 fb                	sub    %edi,%ebx
  8022a5:	89 f9                	mov    %edi,%ecx
  8022a7:	d3 e6                	shl    %cl,%esi
  8022a9:	89 c5                	mov    %eax,%ebp
  8022ab:	88 d9                	mov    %bl,%cl
  8022ad:	d3 ed                	shr    %cl,%ebp
  8022af:	89 e9                	mov    %ebp,%ecx
  8022b1:	09 f1                	or     %esi,%ecx
  8022b3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8022b7:	89 f9                	mov    %edi,%ecx
  8022b9:	d3 e0                	shl    %cl,%eax
  8022bb:	89 c5                	mov    %eax,%ebp
  8022bd:	89 d6                	mov    %edx,%esi
  8022bf:	88 d9                	mov    %bl,%cl
  8022c1:	d3 ee                	shr    %cl,%esi
  8022c3:	89 f9                	mov    %edi,%ecx
  8022c5:	d3 e2                	shl    %cl,%edx
  8022c7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022cb:	88 d9                	mov    %bl,%cl
  8022cd:	d3 e8                	shr    %cl,%eax
  8022cf:	09 c2                	or     %eax,%edx
  8022d1:	89 d0                	mov    %edx,%eax
  8022d3:	89 f2                	mov    %esi,%edx
  8022d5:	f7 74 24 0c          	divl   0xc(%esp)
  8022d9:	89 d6                	mov    %edx,%esi
  8022db:	89 c3                	mov    %eax,%ebx
  8022dd:	f7 e5                	mul    %ebp
  8022df:	39 d6                	cmp    %edx,%esi
  8022e1:	72 19                	jb     8022fc <__udivdi3+0xfc>
  8022e3:	74 0b                	je     8022f0 <__udivdi3+0xf0>
  8022e5:	89 d8                	mov    %ebx,%eax
  8022e7:	31 ff                	xor    %edi,%edi
  8022e9:	e9 58 ff ff ff       	jmp    802246 <__udivdi3+0x46>
  8022ee:	66 90                	xchg   %ax,%ax
  8022f0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022f4:	89 f9                	mov    %edi,%ecx
  8022f6:	d3 e2                	shl    %cl,%edx
  8022f8:	39 c2                	cmp    %eax,%edx
  8022fa:	73 e9                	jae    8022e5 <__udivdi3+0xe5>
  8022fc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022ff:	31 ff                	xor    %edi,%edi
  802301:	e9 40 ff ff ff       	jmp    802246 <__udivdi3+0x46>
  802306:	66 90                	xchg   %ax,%ax
  802308:	31 c0                	xor    %eax,%eax
  80230a:	e9 37 ff ff ff       	jmp    802246 <__udivdi3+0x46>
  80230f:	90                   	nop

00802310 <__umoddi3>:
  802310:	55                   	push   %ebp
  802311:	57                   	push   %edi
  802312:	56                   	push   %esi
  802313:	53                   	push   %ebx
  802314:	83 ec 1c             	sub    $0x1c,%esp
  802317:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80231b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80231f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802323:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802327:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80232b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80232f:	89 f3                	mov    %esi,%ebx
  802331:	89 fa                	mov    %edi,%edx
  802333:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802337:	89 34 24             	mov    %esi,(%esp)
  80233a:	85 c0                	test   %eax,%eax
  80233c:	75 1a                	jne    802358 <__umoddi3+0x48>
  80233e:	39 f7                	cmp    %esi,%edi
  802340:	0f 86 a2 00 00 00    	jbe    8023e8 <__umoddi3+0xd8>
  802346:	89 c8                	mov    %ecx,%eax
  802348:	89 f2                	mov    %esi,%edx
  80234a:	f7 f7                	div    %edi
  80234c:	89 d0                	mov    %edx,%eax
  80234e:	31 d2                	xor    %edx,%edx
  802350:	83 c4 1c             	add    $0x1c,%esp
  802353:	5b                   	pop    %ebx
  802354:	5e                   	pop    %esi
  802355:	5f                   	pop    %edi
  802356:	5d                   	pop    %ebp
  802357:	c3                   	ret    
  802358:	39 f0                	cmp    %esi,%eax
  80235a:	0f 87 ac 00 00 00    	ja     80240c <__umoddi3+0xfc>
  802360:	0f bd e8             	bsr    %eax,%ebp
  802363:	83 f5 1f             	xor    $0x1f,%ebp
  802366:	0f 84 ac 00 00 00    	je     802418 <__umoddi3+0x108>
  80236c:	bf 20 00 00 00       	mov    $0x20,%edi
  802371:	29 ef                	sub    %ebp,%edi
  802373:	89 fe                	mov    %edi,%esi
  802375:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802379:	89 e9                	mov    %ebp,%ecx
  80237b:	d3 e0                	shl    %cl,%eax
  80237d:	89 d7                	mov    %edx,%edi
  80237f:	89 f1                	mov    %esi,%ecx
  802381:	d3 ef                	shr    %cl,%edi
  802383:	09 c7                	or     %eax,%edi
  802385:	89 e9                	mov    %ebp,%ecx
  802387:	d3 e2                	shl    %cl,%edx
  802389:	89 14 24             	mov    %edx,(%esp)
  80238c:	89 d8                	mov    %ebx,%eax
  80238e:	d3 e0                	shl    %cl,%eax
  802390:	89 c2                	mov    %eax,%edx
  802392:	8b 44 24 08          	mov    0x8(%esp),%eax
  802396:	d3 e0                	shl    %cl,%eax
  802398:	89 44 24 04          	mov    %eax,0x4(%esp)
  80239c:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023a0:	89 f1                	mov    %esi,%ecx
  8023a2:	d3 e8                	shr    %cl,%eax
  8023a4:	09 d0                	or     %edx,%eax
  8023a6:	d3 eb                	shr    %cl,%ebx
  8023a8:	89 da                	mov    %ebx,%edx
  8023aa:	f7 f7                	div    %edi
  8023ac:	89 d3                	mov    %edx,%ebx
  8023ae:	f7 24 24             	mull   (%esp)
  8023b1:	89 c6                	mov    %eax,%esi
  8023b3:	89 d1                	mov    %edx,%ecx
  8023b5:	39 d3                	cmp    %edx,%ebx
  8023b7:	0f 82 87 00 00 00    	jb     802444 <__umoddi3+0x134>
  8023bd:	0f 84 91 00 00 00    	je     802454 <__umoddi3+0x144>
  8023c3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8023c7:	29 f2                	sub    %esi,%edx
  8023c9:	19 cb                	sbb    %ecx,%ebx
  8023cb:	89 d8                	mov    %ebx,%eax
  8023cd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8023d1:	d3 e0                	shl    %cl,%eax
  8023d3:	89 e9                	mov    %ebp,%ecx
  8023d5:	d3 ea                	shr    %cl,%edx
  8023d7:	09 d0                	or     %edx,%eax
  8023d9:	89 e9                	mov    %ebp,%ecx
  8023db:	d3 eb                	shr    %cl,%ebx
  8023dd:	89 da                	mov    %ebx,%edx
  8023df:	83 c4 1c             	add    $0x1c,%esp
  8023e2:	5b                   	pop    %ebx
  8023e3:	5e                   	pop    %esi
  8023e4:	5f                   	pop    %edi
  8023e5:	5d                   	pop    %ebp
  8023e6:	c3                   	ret    
  8023e7:	90                   	nop
  8023e8:	89 fd                	mov    %edi,%ebp
  8023ea:	85 ff                	test   %edi,%edi
  8023ec:	75 0b                	jne    8023f9 <__umoddi3+0xe9>
  8023ee:	b8 01 00 00 00       	mov    $0x1,%eax
  8023f3:	31 d2                	xor    %edx,%edx
  8023f5:	f7 f7                	div    %edi
  8023f7:	89 c5                	mov    %eax,%ebp
  8023f9:	89 f0                	mov    %esi,%eax
  8023fb:	31 d2                	xor    %edx,%edx
  8023fd:	f7 f5                	div    %ebp
  8023ff:	89 c8                	mov    %ecx,%eax
  802401:	f7 f5                	div    %ebp
  802403:	89 d0                	mov    %edx,%eax
  802405:	e9 44 ff ff ff       	jmp    80234e <__umoddi3+0x3e>
  80240a:	66 90                	xchg   %ax,%ax
  80240c:	89 c8                	mov    %ecx,%eax
  80240e:	89 f2                	mov    %esi,%edx
  802410:	83 c4 1c             	add    $0x1c,%esp
  802413:	5b                   	pop    %ebx
  802414:	5e                   	pop    %esi
  802415:	5f                   	pop    %edi
  802416:	5d                   	pop    %ebp
  802417:	c3                   	ret    
  802418:	3b 04 24             	cmp    (%esp),%eax
  80241b:	72 06                	jb     802423 <__umoddi3+0x113>
  80241d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802421:	77 0f                	ja     802432 <__umoddi3+0x122>
  802423:	89 f2                	mov    %esi,%edx
  802425:	29 f9                	sub    %edi,%ecx
  802427:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80242b:	89 14 24             	mov    %edx,(%esp)
  80242e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802432:	8b 44 24 04          	mov    0x4(%esp),%eax
  802436:	8b 14 24             	mov    (%esp),%edx
  802439:	83 c4 1c             	add    $0x1c,%esp
  80243c:	5b                   	pop    %ebx
  80243d:	5e                   	pop    %esi
  80243e:	5f                   	pop    %edi
  80243f:	5d                   	pop    %ebp
  802440:	c3                   	ret    
  802441:	8d 76 00             	lea    0x0(%esi),%esi
  802444:	2b 04 24             	sub    (%esp),%eax
  802447:	19 fa                	sbb    %edi,%edx
  802449:	89 d1                	mov    %edx,%ecx
  80244b:	89 c6                	mov    %eax,%esi
  80244d:	e9 71 ff ff ff       	jmp    8023c3 <__umoddi3+0xb3>
  802452:	66 90                	xchg   %ax,%ax
  802454:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802458:	72 ea                	jb     802444 <__umoddi3+0x134>
  80245a:	89 d9                	mov    %ebx,%ecx
  80245c:	e9 62 ff ff ff       	jmp    8023c3 <__umoddi3+0xb3>
