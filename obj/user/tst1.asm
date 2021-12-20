
obj/user/tst1:     file format elf32-i386


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
  800031:	e8 a7 03 00 00       	call   8003dd <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 6c             	sub    $0x6c,%esp
	

	
	

	rsttst();
  800041:	e8 5e 1b 00 00       	call   801ba4 <rsttst>
	int Mega = 1024*1024;
  800046:	c7 45 e4 00 00 10 00 	movl   $0x100000,-0x1c(%ebp)
	int kilo = 1024;
  80004d:	c7 45 e0 00 04 00 00 	movl   $0x400,-0x20(%ebp)
	void* ptr_allocations[20] = {0};
  800054:	8d 55 8c             	lea    -0x74(%ebp),%edx
  800057:	b9 14 00 00 00       	mov    $0x14,%ecx
  80005c:	b8 00 00 00 00       	mov    $0x0,%eax
  800061:	89 d7                	mov    %edx,%edi
  800063:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		int freeFrames = sys_calculate_free_frames() ;
  800065:	e8 fd 17 00 00       	call   801867 <sys_calculate_free_frames>
  80006a:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  80006d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800070:	01 c0                	add    %eax,%eax
  800072:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800075:	83 ec 0c             	sub    $0xc,%esp
  800078:	50                   	push   %eax
  800079:	e8 02 13 00 00       	call   801380 <malloc>
  80007e:	83 c4 10             	add    $0x10,%esp
  800081:	89 45 8c             	mov    %eax,-0x74(%ebp)
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
  800084:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800087:	83 ec 0c             	sub    $0xc,%esp
  80008a:	6a 00                	push   $0x0
  80008c:	6a 62                	push   $0x62
  80008e:	68 00 10 00 80       	push   $0x80001000
  800093:	68 00 00 00 80       	push   $0x80000000
  800098:	50                   	push   %eax
  800099:	e8 20 1b 00 00       	call   801bbe <tst>
  80009e:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  8000a1:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  8000a4:	e8 be 17 00 00       	call   801867 <sys_calculate_free_frames>
  8000a9:	29 c3                	sub    %eax,%ebx
  8000ab:	89 d8                	mov    %ebx,%eax
  8000ad:	83 ec 0c             	sub    $0xc,%esp
  8000b0:	6a 00                	push   $0x0
  8000b2:	6a 65                	push   $0x65
  8000b4:	6a 00                	push   $0x0
  8000b6:	68 01 02 00 00       	push   $0x201
  8000bb:	50                   	push   %eax
  8000bc:	e8 fd 1a 00 00       	call   801bbe <tst>
  8000c1:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  8000c4:	e8 9e 17 00 00       	call   801867 <sys_calculate_free_frames>
  8000c9:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  8000cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000cf:	01 c0                	add    %eax,%eax
  8000d1:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8000d4:	83 ec 0c             	sub    $0xc,%esp
  8000d7:	50                   	push   %eax
  8000d8:	e8 a3 12 00 00       	call   801380 <malloc>
  8000dd:	83 c4 10             	add    $0x10,%esp
  8000e0:	89 45 90             	mov    %eax,-0x70(%ebp)
		tst((uint32) ptr_allocations[1], USER_HEAP_START+ 2*Mega,USER_HEAP_START + 2*Mega + PAGE_SIZE, 'b', 0);
  8000e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000e6:	01 c0                	add    %eax,%eax
  8000e8:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8000ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f1:	01 c0                	add    %eax,%eax
  8000f3:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8000f9:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000fc:	83 ec 0c             	sub    $0xc,%esp
  8000ff:	6a 00                	push   $0x0
  800101:	6a 62                	push   $0x62
  800103:	51                   	push   %ecx
  800104:	52                   	push   %edx
  800105:	50                   	push   %eax
  800106:	e8 b3 1a 00 00       	call   801bbe <tst>
  80010b:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);
  80010e:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  800111:	e8 51 17 00 00       	call   801867 <sys_calculate_free_frames>
  800116:	29 c3                	sub    %eax,%ebx
  800118:	89 d8                	mov    %ebx,%eax
  80011a:	83 ec 0c             	sub    $0xc,%esp
  80011d:	6a 00                	push   $0x0
  80011f:	6a 65                	push   $0x65
  800121:	6a 00                	push   $0x0
  800123:	68 00 02 00 00       	push   $0x200
  800128:	50                   	push   %eax
  800129:	e8 90 1a 00 00       	call   801bbe <tst>
  80012e:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800131:	e8 31 17 00 00       	call   801867 <sys_calculate_free_frames>
  800136:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800139:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80013c:	01 c0                	add    %eax,%eax
  80013e:	83 ec 0c             	sub    $0xc,%esp
  800141:	50                   	push   %eax
  800142:	e8 39 12 00 00       	call   801380 <malloc>
  800147:	83 c4 10             	add    $0x10,%esp
  80014a:	89 45 94             	mov    %eax,-0x6c(%ebp)
		tst((uint32) ptr_allocations[2], USER_HEAP_START+ 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
  80014d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800150:	c1 e0 02             	shl    $0x2,%eax
  800153:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800159:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80015c:	c1 e0 02             	shl    $0x2,%eax
  80015f:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800165:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800168:	83 ec 0c             	sub    $0xc,%esp
  80016b:	6a 00                	push   $0x0
  80016d:	6a 62                	push   $0x62
  80016f:	51                   	push   %ecx
  800170:	52                   	push   %edx
  800171:	50                   	push   %eax
  800172:	e8 47 1a 00 00       	call   801bbe <tst>
  800177:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1+1 ,0, 'e', 0);
  80017a:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  80017d:	e8 e5 16 00 00       	call   801867 <sys_calculate_free_frames>
  800182:	29 c3                	sub    %eax,%ebx
  800184:	89 d8                	mov    %ebx,%eax
  800186:	83 ec 0c             	sub    $0xc,%esp
  800189:	6a 00                	push   $0x0
  80018b:	6a 65                	push   $0x65
  80018d:	6a 00                	push   $0x0
  80018f:	6a 02                	push   $0x2
  800191:	50                   	push   %eax
  800192:	e8 27 1a 00 00       	call   801bbe <tst>
  800197:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  80019a:	e8 c8 16 00 00       	call   801867 <sys_calculate_free_frames>
  80019f:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8001a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001a5:	01 c0                	add    %eax,%eax
  8001a7:	83 ec 0c             	sub    $0xc,%esp
  8001aa:	50                   	push   %eax
  8001ab:	e8 d0 11 00 00       	call   801380 <malloc>
  8001b0:	83 c4 10             	add    $0x10,%esp
  8001b3:	89 45 98             	mov    %eax,-0x68(%ebp)
		tst((uint32) ptr_allocations[3], USER_HEAP_START+ 4*Mega + 4*kilo,USER_HEAP_START + 4*Mega + 4*kilo + PAGE_SIZE, 'b', 0);
  8001b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001b9:	c1 e0 02             	shl    $0x2,%eax
  8001bc:	89 c2                	mov    %eax,%edx
  8001be:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001c1:	c1 e0 02             	shl    $0x2,%eax
  8001c4:	01 d0                	add    %edx,%eax
  8001c6:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8001cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001cf:	c1 e0 02             	shl    $0x2,%eax
  8001d2:	89 c2                	mov    %eax,%edx
  8001d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001d7:	c1 e0 02             	shl    $0x2,%eax
  8001da:	01 d0                	add    %edx,%eax
  8001dc:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8001e2:	8b 45 98             	mov    -0x68(%ebp),%eax
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	6a 00                	push   $0x0
  8001ea:	6a 62                	push   $0x62
  8001ec:	51                   	push   %ecx
  8001ed:	52                   	push   %edx
  8001ee:	50                   	push   %eax
  8001ef:	e8 ca 19 00 00       	call   801bbe <tst>
  8001f4:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 1 ,0, 'e', 0);
  8001f7:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  8001fa:	e8 68 16 00 00       	call   801867 <sys_calculate_free_frames>
  8001ff:	29 c3                	sub    %eax,%ebx
  800201:	89 d8                	mov    %ebx,%eax
  800203:	83 ec 0c             	sub    $0xc,%esp
  800206:	6a 00                	push   $0x0
  800208:	6a 65                	push   $0x65
  80020a:	6a 00                	push   $0x0
  80020c:	6a 01                	push   $0x1
  80020e:	50                   	push   %eax
  80020f:	e8 aa 19 00 00       	call   801bbe <tst>
  800214:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800217:	e8 4b 16 00 00       	call   801867 <sys_calculate_free_frames>
  80021c:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  80021f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800222:	89 d0                	mov    %edx,%eax
  800224:	01 c0                	add    %eax,%eax
  800226:	01 d0                	add    %edx,%eax
  800228:	01 c0                	add    %eax,%eax
  80022a:	01 d0                	add    %edx,%eax
  80022c:	83 ec 0c             	sub    $0xc,%esp
  80022f:	50                   	push   %eax
  800230:	e8 4b 11 00 00       	call   801380 <malloc>
  800235:	83 c4 10             	add    $0x10,%esp
  800238:	89 45 9c             	mov    %eax,-0x64(%ebp)
		tst((uint32) ptr_allocations[4], USER_HEAP_START+ 4*Mega + 8*kilo,USER_HEAP_START + 4*Mega + 8*kilo + PAGE_SIZE, 'b', 0);
  80023b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80023e:	c1 e0 02             	shl    $0x2,%eax
  800241:	89 c2                	mov    %eax,%edx
  800243:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800246:	c1 e0 03             	shl    $0x3,%eax
  800249:	01 d0                	add    %edx,%eax
  80024b:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800251:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800254:	c1 e0 02             	shl    $0x2,%eax
  800257:	89 c2                	mov    %eax,%edx
  800259:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80025c:	c1 e0 03             	shl    $0x3,%eax
  80025f:	01 d0                	add    %edx,%eax
  800261:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  800267:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80026a:	83 ec 0c             	sub    $0xc,%esp
  80026d:	6a 00                	push   $0x0
  80026f:	6a 62                	push   $0x62
  800271:	51                   	push   %ecx
  800272:	52                   	push   %edx
  800273:	50                   	push   %eax
  800274:	e8 45 19 00 00       	call   801bbe <tst>
  800279:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 2 ,0, 'e', 0);
  80027c:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  80027f:	e8 e3 15 00 00       	call   801867 <sys_calculate_free_frames>
  800284:	29 c3                	sub    %eax,%ebx
  800286:	89 d8                	mov    %ebx,%eax
  800288:	83 ec 0c             	sub    $0xc,%esp
  80028b:	6a 00                	push   $0x0
  80028d:	6a 65                	push   $0x65
  80028f:	6a 00                	push   $0x0
  800291:	6a 02                	push   $0x2
  800293:	50                   	push   %eax
  800294:	e8 25 19 00 00       	call   801bbe <tst>
  800299:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  80029c:	e8 c6 15 00 00       	call   801867 <sys_calculate_free_frames>
  8002a1:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8002a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002a7:	89 c2                	mov    %eax,%edx
  8002a9:	01 d2                	add    %edx,%edx
  8002ab:	01 d0                	add    %edx,%eax
  8002ad:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002b0:	83 ec 0c             	sub    $0xc,%esp
  8002b3:	50                   	push   %eax
  8002b4:	e8 c7 10 00 00       	call   801380 <malloc>
  8002b9:	83 c4 10             	add    $0x10,%esp
  8002bc:	89 45 a0             	mov    %eax,-0x60(%ebp)
		tst((uint32) ptr_allocations[5], USER_HEAP_START+ 4*Mega + 16*kilo,USER_HEAP_START + 4*Mega + 16*kilo + PAGE_SIZE, 'b', 0);
  8002bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002c2:	c1 e0 02             	shl    $0x2,%eax
  8002c5:	89 c2                	mov    %eax,%edx
  8002c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002ca:	c1 e0 04             	shl    $0x4,%eax
  8002cd:	01 d0                	add    %edx,%eax
  8002cf:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  8002d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002d8:	c1 e0 02             	shl    $0x2,%eax
  8002db:	89 c2                	mov    %eax,%edx
  8002dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002e0:	c1 e0 04             	shl    $0x4,%eax
  8002e3:	01 d0                	add    %edx,%eax
  8002e5:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  8002eb:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8002ee:	83 ec 0c             	sub    $0xc,%esp
  8002f1:	6a 00                	push   $0x0
  8002f3:	6a 62                	push   $0x62
  8002f5:	51                   	push   %ecx
  8002f6:	52                   	push   %edx
  8002f7:	50                   	push   %eax
  8002f8:	e8 c1 18 00 00       	call   801bbe <tst>
  8002fd:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 3*Mega/4096 ,0, 'e', 0);
  800300:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800303:	89 c2                	mov    %eax,%edx
  800305:	01 d2                	add    %edx,%edx
  800307:	01 d0                	add    %edx,%eax
  800309:	85 c0                	test   %eax,%eax
  80030b:	79 05                	jns    800312 <_main+0x2da>
  80030d:	05 ff 0f 00 00       	add    $0xfff,%eax
  800312:	c1 f8 0c             	sar    $0xc,%eax
  800315:	89 c3                	mov    %eax,%ebx
  800317:	8b 75 dc             	mov    -0x24(%ebp),%esi
  80031a:	e8 48 15 00 00       	call   801867 <sys_calculate_free_frames>
  80031f:	29 c6                	sub    %eax,%esi
  800321:	89 f0                	mov    %esi,%eax
  800323:	83 ec 0c             	sub    $0xc,%esp
  800326:	6a 00                	push   $0x0
  800328:	6a 65                	push   $0x65
  80032a:	6a 00                	push   $0x0
  80032c:	53                   	push   %ebx
  80032d:	50                   	push   %eax
  80032e:	e8 8b 18 00 00       	call   801bbe <tst>
  800333:	83 c4 20             	add    $0x20,%esp

		freeFrames = sys_calculate_free_frames() ;
  800336:	e8 2c 15 00 00       	call   801867 <sys_calculate_free_frames>
  80033b:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[6] = malloc(2*Mega-kilo);
  80033e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800341:	01 c0                	add    %eax,%eax
  800343:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800346:	83 ec 0c             	sub    $0xc,%esp
  800349:	50                   	push   %eax
  80034a:	e8 31 10 00 00       	call   801380 <malloc>
  80034f:	83 c4 10             	add    $0x10,%esp
  800352:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		tst((uint32) ptr_allocations[6], USER_HEAP_START+ 7*Mega + 16*kilo,USER_HEAP_START + 7*Mega + 16*kilo + PAGE_SIZE, 'b', 0);
  800355:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800358:	89 d0                	mov    %edx,%eax
  80035a:	01 c0                	add    %eax,%eax
  80035c:	01 d0                	add    %edx,%eax
  80035e:	01 c0                	add    %eax,%eax
  800360:	01 d0                	add    %edx,%eax
  800362:	89 c2                	mov    %eax,%edx
  800364:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800367:	c1 e0 04             	shl    $0x4,%eax
  80036a:	01 d0                	add    %edx,%eax
  80036c:	8d 88 00 10 00 80    	lea    -0x7ffff000(%eax),%ecx
  800372:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800375:	89 d0                	mov    %edx,%eax
  800377:	01 c0                	add    %eax,%eax
  800379:	01 d0                	add    %edx,%eax
  80037b:	01 c0                	add    %eax,%eax
  80037d:	01 d0                	add    %edx,%eax
  80037f:	89 c2                	mov    %eax,%edx
  800381:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800384:	c1 e0 04             	shl    $0x4,%eax
  800387:	01 d0                	add    %edx,%eax
  800389:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
  80038f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800392:	83 ec 0c             	sub    $0xc,%esp
  800395:	6a 00                	push   $0x0
  800397:	6a 62                	push   $0x62
  800399:	51                   	push   %ecx
  80039a:	52                   	push   %edx
  80039b:	50                   	push   %eax
  80039c:	e8 1d 18 00 00       	call   801bbe <tst>
  8003a1:	83 c4 20             	add    $0x20,%esp
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
  8003a4:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  8003a7:	e8 bb 14 00 00       	call   801867 <sys_calculate_free_frames>
  8003ac:	29 c3                	sub    %eax,%ebx
  8003ae:	89 d8                	mov    %ebx,%eax
  8003b0:	83 ec 0c             	sub    $0xc,%esp
  8003b3:	6a 00                	push   $0x0
  8003b5:	6a 65                	push   $0x65
  8003b7:	6a 00                	push   $0x0
  8003b9:	68 01 02 00 00       	push   $0x201
  8003be:	50                   	push   %eax
  8003bf:	e8 fa 17 00 00       	call   801bbe <tst>
  8003c4:	83 c4 20             	add    $0x20,%esp
	}

	chktst(14);
  8003c7:	83 ec 0c             	sub    $0xc,%esp
  8003ca:	6a 0e                	push   $0xe
  8003cc:	e8 18 18 00 00       	call   801be9 <chktst>
  8003d1:	83 c4 10             	add    $0x10,%esp

	return;
  8003d4:	90                   	nop
}
  8003d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8003d8:	5b                   	pop    %ebx
  8003d9:	5e                   	pop    %esi
  8003da:	5f                   	pop    %edi
  8003db:	5d                   	pop    %ebp
  8003dc:	c3                   	ret    

008003dd <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8003dd:	55                   	push   %ebp
  8003de:	89 e5                	mov    %esp,%ebp
  8003e0:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8003e3:	e8 b4 13 00 00       	call   80179c <sys_getenvindex>
  8003e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8003eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003ee:	89 d0                	mov    %edx,%eax
  8003f0:	c1 e0 03             	shl    $0x3,%eax
  8003f3:	01 d0                	add    %edx,%eax
  8003f5:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8003fc:	01 c8                	add    %ecx,%eax
  8003fe:	01 c0                	add    %eax,%eax
  800400:	01 d0                	add    %edx,%eax
  800402:	01 c0                	add    %eax,%eax
  800404:	01 d0                	add    %edx,%eax
  800406:	89 c2                	mov    %eax,%edx
  800408:	c1 e2 05             	shl    $0x5,%edx
  80040b:	29 c2                	sub    %eax,%edx
  80040d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800414:	89 c2                	mov    %eax,%edx
  800416:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80041c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800421:	a1 20 30 80 00       	mov    0x803020,%eax
  800426:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80042c:	84 c0                	test   %al,%al
  80042e:	74 0f                	je     80043f <libmain+0x62>
		binaryname = myEnv->prog_name;
  800430:	a1 20 30 80 00       	mov    0x803020,%eax
  800435:	05 40 3c 01 00       	add    $0x13c40,%eax
  80043a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80043f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800443:	7e 0a                	jle    80044f <libmain+0x72>
		binaryname = argv[0];
  800445:	8b 45 0c             	mov    0xc(%ebp),%eax
  800448:	8b 00                	mov    (%eax),%eax
  80044a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80044f:	83 ec 08             	sub    $0x8,%esp
  800452:	ff 75 0c             	pushl  0xc(%ebp)
  800455:	ff 75 08             	pushl  0x8(%ebp)
  800458:	e8 db fb ff ff       	call   800038 <_main>
  80045d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800460:	e8 d2 14 00 00       	call   801937 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800465:	83 ec 0c             	sub    $0xc,%esp
  800468:	68 b8 21 80 00       	push   $0x8021b8
  80046d:	e8 84 01 00 00       	call   8005f6 <cprintf>
  800472:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800475:	a1 20 30 80 00       	mov    0x803020,%eax
  80047a:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800480:	a1 20 30 80 00       	mov    0x803020,%eax
  800485:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80048b:	83 ec 04             	sub    $0x4,%esp
  80048e:	52                   	push   %edx
  80048f:	50                   	push   %eax
  800490:	68 e0 21 80 00       	push   $0x8021e0
  800495:	e8 5c 01 00 00       	call   8005f6 <cprintf>
  80049a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80049d:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a2:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8004a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ad:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8004b3:	83 ec 04             	sub    $0x4,%esp
  8004b6:	52                   	push   %edx
  8004b7:	50                   	push   %eax
  8004b8:	68 08 22 80 00       	push   $0x802208
  8004bd:	e8 34 01 00 00       	call   8005f6 <cprintf>
  8004c2:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8004c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ca:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8004d0:	83 ec 08             	sub    $0x8,%esp
  8004d3:	50                   	push   %eax
  8004d4:	68 49 22 80 00       	push   $0x802249
  8004d9:	e8 18 01 00 00       	call   8005f6 <cprintf>
  8004de:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8004e1:	83 ec 0c             	sub    $0xc,%esp
  8004e4:	68 b8 21 80 00       	push   $0x8021b8
  8004e9:	e8 08 01 00 00       	call   8005f6 <cprintf>
  8004ee:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8004f1:	e8 5b 14 00 00       	call   801951 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8004f6:	e8 19 00 00 00       	call   800514 <exit>
}
  8004fb:	90                   	nop
  8004fc:	c9                   	leave  
  8004fd:	c3                   	ret    

008004fe <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004fe:	55                   	push   %ebp
  8004ff:	89 e5                	mov    %esp,%ebp
  800501:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800504:	83 ec 0c             	sub    $0xc,%esp
  800507:	6a 00                	push   $0x0
  800509:	e8 5a 12 00 00       	call   801768 <sys_env_destroy>
  80050e:	83 c4 10             	add    $0x10,%esp
}
  800511:	90                   	nop
  800512:	c9                   	leave  
  800513:	c3                   	ret    

00800514 <exit>:

void
exit(void)
{
  800514:	55                   	push   %ebp
  800515:	89 e5                	mov    %esp,%ebp
  800517:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80051a:	e8 af 12 00 00       	call   8017ce <sys_env_exit>
}
  80051f:	90                   	nop
  800520:	c9                   	leave  
  800521:	c3                   	ret    

00800522 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800522:	55                   	push   %ebp
  800523:	89 e5                	mov    %esp,%ebp
  800525:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800528:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052b:	8b 00                	mov    (%eax),%eax
  80052d:	8d 48 01             	lea    0x1(%eax),%ecx
  800530:	8b 55 0c             	mov    0xc(%ebp),%edx
  800533:	89 0a                	mov    %ecx,(%edx)
  800535:	8b 55 08             	mov    0x8(%ebp),%edx
  800538:	88 d1                	mov    %dl,%cl
  80053a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80053d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800541:	8b 45 0c             	mov    0xc(%ebp),%eax
  800544:	8b 00                	mov    (%eax),%eax
  800546:	3d ff 00 00 00       	cmp    $0xff,%eax
  80054b:	75 2c                	jne    800579 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80054d:	a0 24 30 80 00       	mov    0x803024,%al
  800552:	0f b6 c0             	movzbl %al,%eax
  800555:	8b 55 0c             	mov    0xc(%ebp),%edx
  800558:	8b 12                	mov    (%edx),%edx
  80055a:	89 d1                	mov    %edx,%ecx
  80055c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80055f:	83 c2 08             	add    $0x8,%edx
  800562:	83 ec 04             	sub    $0x4,%esp
  800565:	50                   	push   %eax
  800566:	51                   	push   %ecx
  800567:	52                   	push   %edx
  800568:	e8 b9 11 00 00       	call   801726 <sys_cputs>
  80056d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800570:	8b 45 0c             	mov    0xc(%ebp),%eax
  800573:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800579:	8b 45 0c             	mov    0xc(%ebp),%eax
  80057c:	8b 40 04             	mov    0x4(%eax),%eax
  80057f:	8d 50 01             	lea    0x1(%eax),%edx
  800582:	8b 45 0c             	mov    0xc(%ebp),%eax
  800585:	89 50 04             	mov    %edx,0x4(%eax)
}
  800588:	90                   	nop
  800589:	c9                   	leave  
  80058a:	c3                   	ret    

0080058b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80058b:	55                   	push   %ebp
  80058c:	89 e5                	mov    %esp,%ebp
  80058e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800594:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80059b:	00 00 00 
	b.cnt = 0;
  80059e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8005a5:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8005a8:	ff 75 0c             	pushl  0xc(%ebp)
  8005ab:	ff 75 08             	pushl  0x8(%ebp)
  8005ae:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005b4:	50                   	push   %eax
  8005b5:	68 22 05 80 00       	push   $0x800522
  8005ba:	e8 11 02 00 00       	call   8007d0 <vprintfmt>
  8005bf:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8005c2:	a0 24 30 80 00       	mov    0x803024,%al
  8005c7:	0f b6 c0             	movzbl %al,%eax
  8005ca:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005d0:	83 ec 04             	sub    $0x4,%esp
  8005d3:	50                   	push   %eax
  8005d4:	52                   	push   %edx
  8005d5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005db:	83 c0 08             	add    $0x8,%eax
  8005de:	50                   	push   %eax
  8005df:	e8 42 11 00 00       	call   801726 <sys_cputs>
  8005e4:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005e7:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8005ee:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005f4:	c9                   	leave  
  8005f5:	c3                   	ret    

008005f6 <cprintf>:

int cprintf(const char *fmt, ...) {
  8005f6:	55                   	push   %ebp
  8005f7:	89 e5                	mov    %esp,%ebp
  8005f9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005fc:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800603:	8d 45 0c             	lea    0xc(%ebp),%eax
  800606:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800609:	8b 45 08             	mov    0x8(%ebp),%eax
  80060c:	83 ec 08             	sub    $0x8,%esp
  80060f:	ff 75 f4             	pushl  -0xc(%ebp)
  800612:	50                   	push   %eax
  800613:	e8 73 ff ff ff       	call   80058b <vcprintf>
  800618:	83 c4 10             	add    $0x10,%esp
  80061b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80061e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800621:	c9                   	leave  
  800622:	c3                   	ret    

00800623 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800623:	55                   	push   %ebp
  800624:	89 e5                	mov    %esp,%ebp
  800626:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800629:	e8 09 13 00 00       	call   801937 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80062e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800631:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800634:	8b 45 08             	mov    0x8(%ebp),%eax
  800637:	83 ec 08             	sub    $0x8,%esp
  80063a:	ff 75 f4             	pushl  -0xc(%ebp)
  80063d:	50                   	push   %eax
  80063e:	e8 48 ff ff ff       	call   80058b <vcprintf>
  800643:	83 c4 10             	add    $0x10,%esp
  800646:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800649:	e8 03 13 00 00       	call   801951 <sys_enable_interrupt>
	return cnt;
  80064e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800651:	c9                   	leave  
  800652:	c3                   	ret    

00800653 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800653:	55                   	push   %ebp
  800654:	89 e5                	mov    %esp,%ebp
  800656:	53                   	push   %ebx
  800657:	83 ec 14             	sub    $0x14,%esp
  80065a:	8b 45 10             	mov    0x10(%ebp),%eax
  80065d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800660:	8b 45 14             	mov    0x14(%ebp),%eax
  800663:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800666:	8b 45 18             	mov    0x18(%ebp),%eax
  800669:	ba 00 00 00 00       	mov    $0x0,%edx
  80066e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800671:	77 55                	ja     8006c8 <printnum+0x75>
  800673:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800676:	72 05                	jb     80067d <printnum+0x2a>
  800678:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80067b:	77 4b                	ja     8006c8 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80067d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800680:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800683:	8b 45 18             	mov    0x18(%ebp),%eax
  800686:	ba 00 00 00 00       	mov    $0x0,%edx
  80068b:	52                   	push   %edx
  80068c:	50                   	push   %eax
  80068d:	ff 75 f4             	pushl  -0xc(%ebp)
  800690:	ff 75 f0             	pushl  -0x10(%ebp)
  800693:	e8 90 18 00 00       	call   801f28 <__udivdi3>
  800698:	83 c4 10             	add    $0x10,%esp
  80069b:	83 ec 04             	sub    $0x4,%esp
  80069e:	ff 75 20             	pushl  0x20(%ebp)
  8006a1:	53                   	push   %ebx
  8006a2:	ff 75 18             	pushl  0x18(%ebp)
  8006a5:	52                   	push   %edx
  8006a6:	50                   	push   %eax
  8006a7:	ff 75 0c             	pushl  0xc(%ebp)
  8006aa:	ff 75 08             	pushl  0x8(%ebp)
  8006ad:	e8 a1 ff ff ff       	call   800653 <printnum>
  8006b2:	83 c4 20             	add    $0x20,%esp
  8006b5:	eb 1a                	jmp    8006d1 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006b7:	83 ec 08             	sub    $0x8,%esp
  8006ba:	ff 75 0c             	pushl  0xc(%ebp)
  8006bd:	ff 75 20             	pushl  0x20(%ebp)
  8006c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c3:	ff d0                	call   *%eax
  8006c5:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006c8:	ff 4d 1c             	decl   0x1c(%ebp)
  8006cb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006cf:	7f e6                	jg     8006b7 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006d1:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006d4:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006df:	53                   	push   %ebx
  8006e0:	51                   	push   %ecx
  8006e1:	52                   	push   %edx
  8006e2:	50                   	push   %eax
  8006e3:	e8 50 19 00 00       	call   802038 <__umoddi3>
  8006e8:	83 c4 10             	add    $0x10,%esp
  8006eb:	05 74 24 80 00       	add    $0x802474,%eax
  8006f0:	8a 00                	mov    (%eax),%al
  8006f2:	0f be c0             	movsbl %al,%eax
  8006f5:	83 ec 08             	sub    $0x8,%esp
  8006f8:	ff 75 0c             	pushl  0xc(%ebp)
  8006fb:	50                   	push   %eax
  8006fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ff:	ff d0                	call   *%eax
  800701:	83 c4 10             	add    $0x10,%esp
}
  800704:	90                   	nop
  800705:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800708:	c9                   	leave  
  800709:	c3                   	ret    

0080070a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80070a:	55                   	push   %ebp
  80070b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80070d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800711:	7e 1c                	jle    80072f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800713:	8b 45 08             	mov    0x8(%ebp),%eax
  800716:	8b 00                	mov    (%eax),%eax
  800718:	8d 50 08             	lea    0x8(%eax),%edx
  80071b:	8b 45 08             	mov    0x8(%ebp),%eax
  80071e:	89 10                	mov    %edx,(%eax)
  800720:	8b 45 08             	mov    0x8(%ebp),%eax
  800723:	8b 00                	mov    (%eax),%eax
  800725:	83 e8 08             	sub    $0x8,%eax
  800728:	8b 50 04             	mov    0x4(%eax),%edx
  80072b:	8b 00                	mov    (%eax),%eax
  80072d:	eb 40                	jmp    80076f <getuint+0x65>
	else if (lflag)
  80072f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800733:	74 1e                	je     800753 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800735:	8b 45 08             	mov    0x8(%ebp),%eax
  800738:	8b 00                	mov    (%eax),%eax
  80073a:	8d 50 04             	lea    0x4(%eax),%edx
  80073d:	8b 45 08             	mov    0x8(%ebp),%eax
  800740:	89 10                	mov    %edx,(%eax)
  800742:	8b 45 08             	mov    0x8(%ebp),%eax
  800745:	8b 00                	mov    (%eax),%eax
  800747:	83 e8 04             	sub    $0x4,%eax
  80074a:	8b 00                	mov    (%eax),%eax
  80074c:	ba 00 00 00 00       	mov    $0x0,%edx
  800751:	eb 1c                	jmp    80076f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800753:	8b 45 08             	mov    0x8(%ebp),%eax
  800756:	8b 00                	mov    (%eax),%eax
  800758:	8d 50 04             	lea    0x4(%eax),%edx
  80075b:	8b 45 08             	mov    0x8(%ebp),%eax
  80075e:	89 10                	mov    %edx,(%eax)
  800760:	8b 45 08             	mov    0x8(%ebp),%eax
  800763:	8b 00                	mov    (%eax),%eax
  800765:	83 e8 04             	sub    $0x4,%eax
  800768:	8b 00                	mov    (%eax),%eax
  80076a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80076f:	5d                   	pop    %ebp
  800770:	c3                   	ret    

00800771 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800771:	55                   	push   %ebp
  800772:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800774:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800778:	7e 1c                	jle    800796 <getint+0x25>
		return va_arg(*ap, long long);
  80077a:	8b 45 08             	mov    0x8(%ebp),%eax
  80077d:	8b 00                	mov    (%eax),%eax
  80077f:	8d 50 08             	lea    0x8(%eax),%edx
  800782:	8b 45 08             	mov    0x8(%ebp),%eax
  800785:	89 10                	mov    %edx,(%eax)
  800787:	8b 45 08             	mov    0x8(%ebp),%eax
  80078a:	8b 00                	mov    (%eax),%eax
  80078c:	83 e8 08             	sub    $0x8,%eax
  80078f:	8b 50 04             	mov    0x4(%eax),%edx
  800792:	8b 00                	mov    (%eax),%eax
  800794:	eb 38                	jmp    8007ce <getint+0x5d>
	else if (lflag)
  800796:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80079a:	74 1a                	je     8007b6 <getint+0x45>
		return va_arg(*ap, long);
  80079c:	8b 45 08             	mov    0x8(%ebp),%eax
  80079f:	8b 00                	mov    (%eax),%eax
  8007a1:	8d 50 04             	lea    0x4(%eax),%edx
  8007a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a7:	89 10                	mov    %edx,(%eax)
  8007a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ac:	8b 00                	mov    (%eax),%eax
  8007ae:	83 e8 04             	sub    $0x4,%eax
  8007b1:	8b 00                	mov    (%eax),%eax
  8007b3:	99                   	cltd   
  8007b4:	eb 18                	jmp    8007ce <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b9:	8b 00                	mov    (%eax),%eax
  8007bb:	8d 50 04             	lea    0x4(%eax),%edx
  8007be:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c1:	89 10                	mov    %edx,(%eax)
  8007c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c6:	8b 00                	mov    (%eax),%eax
  8007c8:	83 e8 04             	sub    $0x4,%eax
  8007cb:	8b 00                	mov    (%eax),%eax
  8007cd:	99                   	cltd   
}
  8007ce:	5d                   	pop    %ebp
  8007cf:	c3                   	ret    

008007d0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007d0:	55                   	push   %ebp
  8007d1:	89 e5                	mov    %esp,%ebp
  8007d3:	56                   	push   %esi
  8007d4:	53                   	push   %ebx
  8007d5:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007d8:	eb 17                	jmp    8007f1 <vprintfmt+0x21>
			if (ch == '\0')
  8007da:	85 db                	test   %ebx,%ebx
  8007dc:	0f 84 af 03 00 00    	je     800b91 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007e2:	83 ec 08             	sub    $0x8,%esp
  8007e5:	ff 75 0c             	pushl  0xc(%ebp)
  8007e8:	53                   	push   %ebx
  8007e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ec:	ff d0                	call   *%eax
  8007ee:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f4:	8d 50 01             	lea    0x1(%eax),%edx
  8007f7:	89 55 10             	mov    %edx,0x10(%ebp)
  8007fa:	8a 00                	mov    (%eax),%al
  8007fc:	0f b6 d8             	movzbl %al,%ebx
  8007ff:	83 fb 25             	cmp    $0x25,%ebx
  800802:	75 d6                	jne    8007da <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800804:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800808:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80080f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800816:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80081d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800824:	8b 45 10             	mov    0x10(%ebp),%eax
  800827:	8d 50 01             	lea    0x1(%eax),%edx
  80082a:	89 55 10             	mov    %edx,0x10(%ebp)
  80082d:	8a 00                	mov    (%eax),%al
  80082f:	0f b6 d8             	movzbl %al,%ebx
  800832:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800835:	83 f8 55             	cmp    $0x55,%eax
  800838:	0f 87 2b 03 00 00    	ja     800b69 <vprintfmt+0x399>
  80083e:	8b 04 85 98 24 80 00 	mov    0x802498(,%eax,4),%eax
  800845:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800847:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80084b:	eb d7                	jmp    800824 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80084d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800851:	eb d1                	jmp    800824 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800853:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80085a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80085d:	89 d0                	mov    %edx,%eax
  80085f:	c1 e0 02             	shl    $0x2,%eax
  800862:	01 d0                	add    %edx,%eax
  800864:	01 c0                	add    %eax,%eax
  800866:	01 d8                	add    %ebx,%eax
  800868:	83 e8 30             	sub    $0x30,%eax
  80086b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80086e:	8b 45 10             	mov    0x10(%ebp),%eax
  800871:	8a 00                	mov    (%eax),%al
  800873:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800876:	83 fb 2f             	cmp    $0x2f,%ebx
  800879:	7e 3e                	jle    8008b9 <vprintfmt+0xe9>
  80087b:	83 fb 39             	cmp    $0x39,%ebx
  80087e:	7f 39                	jg     8008b9 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800880:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800883:	eb d5                	jmp    80085a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800885:	8b 45 14             	mov    0x14(%ebp),%eax
  800888:	83 c0 04             	add    $0x4,%eax
  80088b:	89 45 14             	mov    %eax,0x14(%ebp)
  80088e:	8b 45 14             	mov    0x14(%ebp),%eax
  800891:	83 e8 04             	sub    $0x4,%eax
  800894:	8b 00                	mov    (%eax),%eax
  800896:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800899:	eb 1f                	jmp    8008ba <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80089b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80089f:	79 83                	jns    800824 <vprintfmt+0x54>
				width = 0;
  8008a1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008a8:	e9 77 ff ff ff       	jmp    800824 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008ad:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008b4:	e9 6b ff ff ff       	jmp    800824 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008b9:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008ba:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008be:	0f 89 60 ff ff ff    	jns    800824 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008ca:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008d1:	e9 4e ff ff ff       	jmp    800824 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008d6:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008d9:	e9 46 ff ff ff       	jmp    800824 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008de:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e1:	83 c0 04             	add    $0x4,%eax
  8008e4:	89 45 14             	mov    %eax,0x14(%ebp)
  8008e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ea:	83 e8 04             	sub    $0x4,%eax
  8008ed:	8b 00                	mov    (%eax),%eax
  8008ef:	83 ec 08             	sub    $0x8,%esp
  8008f2:	ff 75 0c             	pushl  0xc(%ebp)
  8008f5:	50                   	push   %eax
  8008f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f9:	ff d0                	call   *%eax
  8008fb:	83 c4 10             	add    $0x10,%esp
			break;
  8008fe:	e9 89 02 00 00       	jmp    800b8c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800903:	8b 45 14             	mov    0x14(%ebp),%eax
  800906:	83 c0 04             	add    $0x4,%eax
  800909:	89 45 14             	mov    %eax,0x14(%ebp)
  80090c:	8b 45 14             	mov    0x14(%ebp),%eax
  80090f:	83 e8 04             	sub    $0x4,%eax
  800912:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800914:	85 db                	test   %ebx,%ebx
  800916:	79 02                	jns    80091a <vprintfmt+0x14a>
				err = -err;
  800918:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80091a:	83 fb 64             	cmp    $0x64,%ebx
  80091d:	7f 0b                	jg     80092a <vprintfmt+0x15a>
  80091f:	8b 34 9d e0 22 80 00 	mov    0x8022e0(,%ebx,4),%esi
  800926:	85 f6                	test   %esi,%esi
  800928:	75 19                	jne    800943 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80092a:	53                   	push   %ebx
  80092b:	68 85 24 80 00       	push   $0x802485
  800930:	ff 75 0c             	pushl  0xc(%ebp)
  800933:	ff 75 08             	pushl  0x8(%ebp)
  800936:	e8 5e 02 00 00       	call   800b99 <printfmt>
  80093b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80093e:	e9 49 02 00 00       	jmp    800b8c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800943:	56                   	push   %esi
  800944:	68 8e 24 80 00       	push   $0x80248e
  800949:	ff 75 0c             	pushl  0xc(%ebp)
  80094c:	ff 75 08             	pushl  0x8(%ebp)
  80094f:	e8 45 02 00 00       	call   800b99 <printfmt>
  800954:	83 c4 10             	add    $0x10,%esp
			break;
  800957:	e9 30 02 00 00       	jmp    800b8c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80095c:	8b 45 14             	mov    0x14(%ebp),%eax
  80095f:	83 c0 04             	add    $0x4,%eax
  800962:	89 45 14             	mov    %eax,0x14(%ebp)
  800965:	8b 45 14             	mov    0x14(%ebp),%eax
  800968:	83 e8 04             	sub    $0x4,%eax
  80096b:	8b 30                	mov    (%eax),%esi
  80096d:	85 f6                	test   %esi,%esi
  80096f:	75 05                	jne    800976 <vprintfmt+0x1a6>
				p = "(null)";
  800971:	be 91 24 80 00       	mov    $0x802491,%esi
			if (width > 0 && padc != '-')
  800976:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80097a:	7e 6d                	jle    8009e9 <vprintfmt+0x219>
  80097c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800980:	74 67                	je     8009e9 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800982:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800985:	83 ec 08             	sub    $0x8,%esp
  800988:	50                   	push   %eax
  800989:	56                   	push   %esi
  80098a:	e8 0c 03 00 00       	call   800c9b <strnlen>
  80098f:	83 c4 10             	add    $0x10,%esp
  800992:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800995:	eb 16                	jmp    8009ad <vprintfmt+0x1dd>
					putch(padc, putdat);
  800997:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80099b:	83 ec 08             	sub    $0x8,%esp
  80099e:	ff 75 0c             	pushl  0xc(%ebp)
  8009a1:	50                   	push   %eax
  8009a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a5:	ff d0                	call   *%eax
  8009a7:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009aa:	ff 4d e4             	decl   -0x1c(%ebp)
  8009ad:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009b1:	7f e4                	jg     800997 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009b3:	eb 34                	jmp    8009e9 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009b5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009b9:	74 1c                	je     8009d7 <vprintfmt+0x207>
  8009bb:	83 fb 1f             	cmp    $0x1f,%ebx
  8009be:	7e 05                	jle    8009c5 <vprintfmt+0x1f5>
  8009c0:	83 fb 7e             	cmp    $0x7e,%ebx
  8009c3:	7e 12                	jle    8009d7 <vprintfmt+0x207>
					putch('?', putdat);
  8009c5:	83 ec 08             	sub    $0x8,%esp
  8009c8:	ff 75 0c             	pushl  0xc(%ebp)
  8009cb:	6a 3f                	push   $0x3f
  8009cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d0:	ff d0                	call   *%eax
  8009d2:	83 c4 10             	add    $0x10,%esp
  8009d5:	eb 0f                	jmp    8009e6 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009d7:	83 ec 08             	sub    $0x8,%esp
  8009da:	ff 75 0c             	pushl  0xc(%ebp)
  8009dd:	53                   	push   %ebx
  8009de:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e1:	ff d0                	call   *%eax
  8009e3:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009e6:	ff 4d e4             	decl   -0x1c(%ebp)
  8009e9:	89 f0                	mov    %esi,%eax
  8009eb:	8d 70 01             	lea    0x1(%eax),%esi
  8009ee:	8a 00                	mov    (%eax),%al
  8009f0:	0f be d8             	movsbl %al,%ebx
  8009f3:	85 db                	test   %ebx,%ebx
  8009f5:	74 24                	je     800a1b <vprintfmt+0x24b>
  8009f7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009fb:	78 b8                	js     8009b5 <vprintfmt+0x1e5>
  8009fd:	ff 4d e0             	decl   -0x20(%ebp)
  800a00:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a04:	79 af                	jns    8009b5 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a06:	eb 13                	jmp    800a1b <vprintfmt+0x24b>
				putch(' ', putdat);
  800a08:	83 ec 08             	sub    $0x8,%esp
  800a0b:	ff 75 0c             	pushl  0xc(%ebp)
  800a0e:	6a 20                	push   $0x20
  800a10:	8b 45 08             	mov    0x8(%ebp),%eax
  800a13:	ff d0                	call   *%eax
  800a15:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a18:	ff 4d e4             	decl   -0x1c(%ebp)
  800a1b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a1f:	7f e7                	jg     800a08 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a21:	e9 66 01 00 00       	jmp    800b8c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a26:	83 ec 08             	sub    $0x8,%esp
  800a29:	ff 75 e8             	pushl  -0x18(%ebp)
  800a2c:	8d 45 14             	lea    0x14(%ebp),%eax
  800a2f:	50                   	push   %eax
  800a30:	e8 3c fd ff ff       	call   800771 <getint>
  800a35:	83 c4 10             	add    $0x10,%esp
  800a38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a41:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a44:	85 d2                	test   %edx,%edx
  800a46:	79 23                	jns    800a6b <vprintfmt+0x29b>
				putch('-', putdat);
  800a48:	83 ec 08             	sub    $0x8,%esp
  800a4b:	ff 75 0c             	pushl  0xc(%ebp)
  800a4e:	6a 2d                	push   $0x2d
  800a50:	8b 45 08             	mov    0x8(%ebp),%eax
  800a53:	ff d0                	call   *%eax
  800a55:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a58:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a5b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a5e:	f7 d8                	neg    %eax
  800a60:	83 d2 00             	adc    $0x0,%edx
  800a63:	f7 da                	neg    %edx
  800a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a68:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a6b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a72:	e9 bc 00 00 00       	jmp    800b33 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a77:	83 ec 08             	sub    $0x8,%esp
  800a7a:	ff 75 e8             	pushl  -0x18(%ebp)
  800a7d:	8d 45 14             	lea    0x14(%ebp),%eax
  800a80:	50                   	push   %eax
  800a81:	e8 84 fc ff ff       	call   80070a <getuint>
  800a86:	83 c4 10             	add    $0x10,%esp
  800a89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a8c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a8f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a96:	e9 98 00 00 00       	jmp    800b33 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a9b:	83 ec 08             	sub    $0x8,%esp
  800a9e:	ff 75 0c             	pushl  0xc(%ebp)
  800aa1:	6a 58                	push   $0x58
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	ff d0                	call   *%eax
  800aa8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800aab:	83 ec 08             	sub    $0x8,%esp
  800aae:	ff 75 0c             	pushl  0xc(%ebp)
  800ab1:	6a 58                	push   $0x58
  800ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab6:	ff d0                	call   *%eax
  800ab8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800abb:	83 ec 08             	sub    $0x8,%esp
  800abe:	ff 75 0c             	pushl  0xc(%ebp)
  800ac1:	6a 58                	push   $0x58
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	ff d0                	call   *%eax
  800ac8:	83 c4 10             	add    $0x10,%esp
			break;
  800acb:	e9 bc 00 00 00       	jmp    800b8c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ad0:	83 ec 08             	sub    $0x8,%esp
  800ad3:	ff 75 0c             	pushl  0xc(%ebp)
  800ad6:	6a 30                	push   $0x30
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	ff d0                	call   *%eax
  800add:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ae0:	83 ec 08             	sub    $0x8,%esp
  800ae3:	ff 75 0c             	pushl  0xc(%ebp)
  800ae6:	6a 78                	push   $0x78
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	ff d0                	call   *%eax
  800aed:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800af0:	8b 45 14             	mov    0x14(%ebp),%eax
  800af3:	83 c0 04             	add    $0x4,%eax
  800af6:	89 45 14             	mov    %eax,0x14(%ebp)
  800af9:	8b 45 14             	mov    0x14(%ebp),%eax
  800afc:	83 e8 04             	sub    $0x4,%eax
  800aff:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b01:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b04:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b0b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b12:	eb 1f                	jmp    800b33 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b14:	83 ec 08             	sub    $0x8,%esp
  800b17:	ff 75 e8             	pushl  -0x18(%ebp)
  800b1a:	8d 45 14             	lea    0x14(%ebp),%eax
  800b1d:	50                   	push   %eax
  800b1e:	e8 e7 fb ff ff       	call   80070a <getuint>
  800b23:	83 c4 10             	add    $0x10,%esp
  800b26:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b29:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b2c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b33:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b37:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b3a:	83 ec 04             	sub    $0x4,%esp
  800b3d:	52                   	push   %edx
  800b3e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b41:	50                   	push   %eax
  800b42:	ff 75 f4             	pushl  -0xc(%ebp)
  800b45:	ff 75 f0             	pushl  -0x10(%ebp)
  800b48:	ff 75 0c             	pushl  0xc(%ebp)
  800b4b:	ff 75 08             	pushl  0x8(%ebp)
  800b4e:	e8 00 fb ff ff       	call   800653 <printnum>
  800b53:	83 c4 20             	add    $0x20,%esp
			break;
  800b56:	eb 34                	jmp    800b8c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b58:	83 ec 08             	sub    $0x8,%esp
  800b5b:	ff 75 0c             	pushl  0xc(%ebp)
  800b5e:	53                   	push   %ebx
  800b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b62:	ff d0                	call   *%eax
  800b64:	83 c4 10             	add    $0x10,%esp
			break;
  800b67:	eb 23                	jmp    800b8c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b69:	83 ec 08             	sub    $0x8,%esp
  800b6c:	ff 75 0c             	pushl  0xc(%ebp)
  800b6f:	6a 25                	push   $0x25
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	ff d0                	call   *%eax
  800b76:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b79:	ff 4d 10             	decl   0x10(%ebp)
  800b7c:	eb 03                	jmp    800b81 <vprintfmt+0x3b1>
  800b7e:	ff 4d 10             	decl   0x10(%ebp)
  800b81:	8b 45 10             	mov    0x10(%ebp),%eax
  800b84:	48                   	dec    %eax
  800b85:	8a 00                	mov    (%eax),%al
  800b87:	3c 25                	cmp    $0x25,%al
  800b89:	75 f3                	jne    800b7e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b8b:	90                   	nop
		}
	}
  800b8c:	e9 47 fc ff ff       	jmp    8007d8 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b91:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b92:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b95:	5b                   	pop    %ebx
  800b96:	5e                   	pop    %esi
  800b97:	5d                   	pop    %ebp
  800b98:	c3                   	ret    

00800b99 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b99:	55                   	push   %ebp
  800b9a:	89 e5                	mov    %esp,%ebp
  800b9c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b9f:	8d 45 10             	lea    0x10(%ebp),%eax
  800ba2:	83 c0 04             	add    $0x4,%eax
  800ba5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ba8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bab:	ff 75 f4             	pushl  -0xc(%ebp)
  800bae:	50                   	push   %eax
  800baf:	ff 75 0c             	pushl  0xc(%ebp)
  800bb2:	ff 75 08             	pushl  0x8(%ebp)
  800bb5:	e8 16 fc ff ff       	call   8007d0 <vprintfmt>
  800bba:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800bbd:	90                   	nop
  800bbe:	c9                   	leave  
  800bbf:	c3                   	ret    

00800bc0 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800bc0:	55                   	push   %ebp
  800bc1:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc6:	8b 40 08             	mov    0x8(%eax),%eax
  800bc9:	8d 50 01             	lea    0x1(%eax),%edx
  800bcc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bcf:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800bd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd5:	8b 10                	mov    (%eax),%edx
  800bd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bda:	8b 40 04             	mov    0x4(%eax),%eax
  800bdd:	39 c2                	cmp    %eax,%edx
  800bdf:	73 12                	jae    800bf3 <sprintputch+0x33>
		*b->buf++ = ch;
  800be1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be4:	8b 00                	mov    (%eax),%eax
  800be6:	8d 48 01             	lea    0x1(%eax),%ecx
  800be9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bec:	89 0a                	mov    %ecx,(%edx)
  800bee:	8b 55 08             	mov    0x8(%ebp),%edx
  800bf1:	88 10                	mov    %dl,(%eax)
}
  800bf3:	90                   	nop
  800bf4:	5d                   	pop    %ebp
  800bf5:	c3                   	ret    

00800bf6 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bf6:	55                   	push   %ebp
  800bf7:	89 e5                	mov    %esp,%ebp
  800bf9:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bff:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c05:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c08:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0b:	01 d0                	add    %edx,%eax
  800c0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c10:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c17:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c1b:	74 06                	je     800c23 <vsnprintf+0x2d>
  800c1d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c21:	7f 07                	jg     800c2a <vsnprintf+0x34>
		return -E_INVAL;
  800c23:	b8 03 00 00 00       	mov    $0x3,%eax
  800c28:	eb 20                	jmp    800c4a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c2a:	ff 75 14             	pushl  0x14(%ebp)
  800c2d:	ff 75 10             	pushl  0x10(%ebp)
  800c30:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c33:	50                   	push   %eax
  800c34:	68 c0 0b 80 00       	push   $0x800bc0
  800c39:	e8 92 fb ff ff       	call   8007d0 <vprintfmt>
  800c3e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c41:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c44:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c47:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c4a:	c9                   	leave  
  800c4b:	c3                   	ret    

00800c4c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c4c:	55                   	push   %ebp
  800c4d:	89 e5                	mov    %esp,%ebp
  800c4f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c52:	8d 45 10             	lea    0x10(%ebp),%eax
  800c55:	83 c0 04             	add    $0x4,%eax
  800c58:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c5b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5e:	ff 75 f4             	pushl  -0xc(%ebp)
  800c61:	50                   	push   %eax
  800c62:	ff 75 0c             	pushl  0xc(%ebp)
  800c65:	ff 75 08             	pushl  0x8(%ebp)
  800c68:	e8 89 ff ff ff       	call   800bf6 <vsnprintf>
  800c6d:	83 c4 10             	add    $0x10,%esp
  800c70:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c73:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c76:	c9                   	leave  
  800c77:	c3                   	ret    

00800c78 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c78:	55                   	push   %ebp
  800c79:	89 e5                	mov    %esp,%ebp
  800c7b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c7e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c85:	eb 06                	jmp    800c8d <strlen+0x15>
		n++;
  800c87:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c8a:	ff 45 08             	incl   0x8(%ebp)
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	8a 00                	mov    (%eax),%al
  800c92:	84 c0                	test   %al,%al
  800c94:	75 f1                	jne    800c87 <strlen+0xf>
		n++;
	return n;
  800c96:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c99:	c9                   	leave  
  800c9a:	c3                   	ret    

00800c9b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c9b:	55                   	push   %ebp
  800c9c:	89 e5                	mov    %esp,%ebp
  800c9e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ca1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ca8:	eb 09                	jmp    800cb3 <strnlen+0x18>
		n++;
  800caa:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cad:	ff 45 08             	incl   0x8(%ebp)
  800cb0:	ff 4d 0c             	decl   0xc(%ebp)
  800cb3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cb7:	74 09                	je     800cc2 <strnlen+0x27>
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbc:	8a 00                	mov    (%eax),%al
  800cbe:	84 c0                	test   %al,%al
  800cc0:	75 e8                	jne    800caa <strnlen+0xf>
		n++;
	return n;
  800cc2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cc5:	c9                   	leave  
  800cc6:	c3                   	ret    

00800cc7 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800cc7:	55                   	push   %ebp
  800cc8:	89 e5                	mov    %esp,%ebp
  800cca:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800cd3:	90                   	nop
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	8d 50 01             	lea    0x1(%eax),%edx
  800cda:	89 55 08             	mov    %edx,0x8(%ebp)
  800cdd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ce0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ce3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ce6:	8a 12                	mov    (%edx),%dl
  800ce8:	88 10                	mov    %dl,(%eax)
  800cea:	8a 00                	mov    (%eax),%al
  800cec:	84 c0                	test   %al,%al
  800cee:	75 e4                	jne    800cd4 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800cf0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cf3:	c9                   	leave  
  800cf4:	c3                   	ret    

00800cf5 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800cf5:	55                   	push   %ebp
  800cf6:	89 e5                	mov    %esp,%ebp
  800cf8:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfe:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d01:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d08:	eb 1f                	jmp    800d29 <strncpy+0x34>
		*dst++ = *src;
  800d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0d:	8d 50 01             	lea    0x1(%eax),%edx
  800d10:	89 55 08             	mov    %edx,0x8(%ebp)
  800d13:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d16:	8a 12                	mov    (%edx),%dl
  800d18:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1d:	8a 00                	mov    (%eax),%al
  800d1f:	84 c0                	test   %al,%al
  800d21:	74 03                	je     800d26 <strncpy+0x31>
			src++;
  800d23:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d26:	ff 45 fc             	incl   -0x4(%ebp)
  800d29:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d2c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d2f:	72 d9                	jb     800d0a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d31:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d34:	c9                   	leave  
  800d35:	c3                   	ret    

00800d36 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d36:	55                   	push   %ebp
  800d37:	89 e5                	mov    %esp,%ebp
  800d39:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d42:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d46:	74 30                	je     800d78 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d48:	eb 16                	jmp    800d60 <strlcpy+0x2a>
			*dst++ = *src++;
  800d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4d:	8d 50 01             	lea    0x1(%eax),%edx
  800d50:	89 55 08             	mov    %edx,0x8(%ebp)
  800d53:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d56:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d59:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d5c:	8a 12                	mov    (%edx),%dl
  800d5e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d60:	ff 4d 10             	decl   0x10(%ebp)
  800d63:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d67:	74 09                	je     800d72 <strlcpy+0x3c>
  800d69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6c:	8a 00                	mov    (%eax),%al
  800d6e:	84 c0                	test   %al,%al
  800d70:	75 d8                	jne    800d4a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d72:	8b 45 08             	mov    0x8(%ebp),%eax
  800d75:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d78:	8b 55 08             	mov    0x8(%ebp),%edx
  800d7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d7e:	29 c2                	sub    %eax,%edx
  800d80:	89 d0                	mov    %edx,%eax
}
  800d82:	c9                   	leave  
  800d83:	c3                   	ret    

00800d84 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d84:	55                   	push   %ebp
  800d85:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d87:	eb 06                	jmp    800d8f <strcmp+0xb>
		p++, q++;
  800d89:	ff 45 08             	incl   0x8(%ebp)
  800d8c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d92:	8a 00                	mov    (%eax),%al
  800d94:	84 c0                	test   %al,%al
  800d96:	74 0e                	je     800da6 <strcmp+0x22>
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	8a 10                	mov    (%eax),%dl
  800d9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da0:	8a 00                	mov    (%eax),%al
  800da2:	38 c2                	cmp    %al,%dl
  800da4:	74 e3                	je     800d89 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800da6:	8b 45 08             	mov    0x8(%ebp),%eax
  800da9:	8a 00                	mov    (%eax),%al
  800dab:	0f b6 d0             	movzbl %al,%edx
  800dae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db1:	8a 00                	mov    (%eax),%al
  800db3:	0f b6 c0             	movzbl %al,%eax
  800db6:	29 c2                	sub    %eax,%edx
  800db8:	89 d0                	mov    %edx,%eax
}
  800dba:	5d                   	pop    %ebp
  800dbb:	c3                   	ret    

00800dbc <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800dbc:	55                   	push   %ebp
  800dbd:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800dbf:	eb 09                	jmp    800dca <strncmp+0xe>
		n--, p++, q++;
  800dc1:	ff 4d 10             	decl   0x10(%ebp)
  800dc4:	ff 45 08             	incl   0x8(%ebp)
  800dc7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800dca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dce:	74 17                	je     800de7 <strncmp+0x2b>
  800dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd3:	8a 00                	mov    (%eax),%al
  800dd5:	84 c0                	test   %al,%al
  800dd7:	74 0e                	je     800de7 <strncmp+0x2b>
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	8a 10                	mov    (%eax),%dl
  800dde:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de1:	8a 00                	mov    (%eax),%al
  800de3:	38 c2                	cmp    %al,%dl
  800de5:	74 da                	je     800dc1 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800de7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800deb:	75 07                	jne    800df4 <strncmp+0x38>
		return 0;
  800ded:	b8 00 00 00 00       	mov    $0x0,%eax
  800df2:	eb 14                	jmp    800e08 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800df4:	8b 45 08             	mov    0x8(%ebp),%eax
  800df7:	8a 00                	mov    (%eax),%al
  800df9:	0f b6 d0             	movzbl %al,%edx
  800dfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dff:	8a 00                	mov    (%eax),%al
  800e01:	0f b6 c0             	movzbl %al,%eax
  800e04:	29 c2                	sub    %eax,%edx
  800e06:	89 d0                	mov    %edx,%eax
}
  800e08:	5d                   	pop    %ebp
  800e09:	c3                   	ret    

00800e0a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e0a:	55                   	push   %ebp
  800e0b:	89 e5                	mov    %esp,%ebp
  800e0d:	83 ec 04             	sub    $0x4,%esp
  800e10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e13:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e16:	eb 12                	jmp    800e2a <strchr+0x20>
		if (*s == c)
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	8a 00                	mov    (%eax),%al
  800e1d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e20:	75 05                	jne    800e27 <strchr+0x1d>
			return (char *) s;
  800e22:	8b 45 08             	mov    0x8(%ebp),%eax
  800e25:	eb 11                	jmp    800e38 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e27:	ff 45 08             	incl   0x8(%ebp)
  800e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2d:	8a 00                	mov    (%eax),%al
  800e2f:	84 c0                	test   %al,%al
  800e31:	75 e5                	jne    800e18 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e33:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e38:	c9                   	leave  
  800e39:	c3                   	ret    

00800e3a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e3a:	55                   	push   %ebp
  800e3b:	89 e5                	mov    %esp,%ebp
  800e3d:	83 ec 04             	sub    $0x4,%esp
  800e40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e43:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e46:	eb 0d                	jmp    800e55 <strfind+0x1b>
		if (*s == c)
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	8a 00                	mov    (%eax),%al
  800e4d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e50:	74 0e                	je     800e60 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e52:	ff 45 08             	incl   0x8(%ebp)
  800e55:	8b 45 08             	mov    0x8(%ebp),%eax
  800e58:	8a 00                	mov    (%eax),%al
  800e5a:	84 c0                	test   %al,%al
  800e5c:	75 ea                	jne    800e48 <strfind+0xe>
  800e5e:	eb 01                	jmp    800e61 <strfind+0x27>
		if (*s == c)
			break;
  800e60:	90                   	nop
	return (char *) s;
  800e61:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e64:	c9                   	leave  
  800e65:	c3                   	ret    

00800e66 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e66:	55                   	push   %ebp
  800e67:	89 e5                	mov    %esp,%ebp
  800e69:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e72:	8b 45 10             	mov    0x10(%ebp),%eax
  800e75:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e78:	eb 0e                	jmp    800e88 <memset+0x22>
		*p++ = c;
  800e7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7d:	8d 50 01             	lea    0x1(%eax),%edx
  800e80:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e83:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e86:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e88:	ff 4d f8             	decl   -0x8(%ebp)
  800e8b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e8f:	79 e9                	jns    800e7a <memset+0x14>
		*p++ = c;

	return v;
  800e91:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e94:	c9                   	leave  
  800e95:	c3                   	ret    

00800e96 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e96:	55                   	push   %ebp
  800e97:	89 e5                	mov    %esp,%ebp
  800e99:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800ea8:	eb 16                	jmp    800ec0 <memcpy+0x2a>
		*d++ = *s++;
  800eaa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ead:	8d 50 01             	lea    0x1(%eax),%edx
  800eb0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800eb3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eb6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eb9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ebc:	8a 12                	mov    (%edx),%dl
  800ebe:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ec0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec6:	89 55 10             	mov    %edx,0x10(%ebp)
  800ec9:	85 c0                	test   %eax,%eax
  800ecb:	75 dd                	jne    800eaa <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ed0:	c9                   	leave  
  800ed1:	c3                   	ret    

00800ed2 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ed2:	55                   	push   %ebp
  800ed3:	89 e5                	mov    %esp,%ebp
  800ed5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ed8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800edb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ede:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ee4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800eea:	73 50                	jae    800f3c <memmove+0x6a>
  800eec:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eef:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef2:	01 d0                	add    %edx,%eax
  800ef4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ef7:	76 43                	jbe    800f3c <memmove+0x6a>
		s += n;
  800ef9:	8b 45 10             	mov    0x10(%ebp),%eax
  800efc:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800eff:	8b 45 10             	mov    0x10(%ebp),%eax
  800f02:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f05:	eb 10                	jmp    800f17 <memmove+0x45>
			*--d = *--s;
  800f07:	ff 4d f8             	decl   -0x8(%ebp)
  800f0a:	ff 4d fc             	decl   -0x4(%ebp)
  800f0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f10:	8a 10                	mov    (%eax),%dl
  800f12:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f15:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f17:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f1d:	89 55 10             	mov    %edx,0x10(%ebp)
  800f20:	85 c0                	test   %eax,%eax
  800f22:	75 e3                	jne    800f07 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f24:	eb 23                	jmp    800f49 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f26:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f29:	8d 50 01             	lea    0x1(%eax),%edx
  800f2c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f2f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f32:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f35:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f38:	8a 12                	mov    (%edx),%dl
  800f3a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f3c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f42:	89 55 10             	mov    %edx,0x10(%ebp)
  800f45:	85 c0                	test   %eax,%eax
  800f47:	75 dd                	jne    800f26 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f49:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f4c:	c9                   	leave  
  800f4d:	c3                   	ret    

00800f4e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f4e:	55                   	push   %ebp
  800f4f:	89 e5                	mov    %esp,%ebp
  800f51:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f54:	8b 45 08             	mov    0x8(%ebp),%eax
  800f57:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f60:	eb 2a                	jmp    800f8c <memcmp+0x3e>
		if (*s1 != *s2)
  800f62:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f65:	8a 10                	mov    (%eax),%dl
  800f67:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f6a:	8a 00                	mov    (%eax),%al
  800f6c:	38 c2                	cmp    %al,%dl
  800f6e:	74 16                	je     800f86 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f70:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f73:	8a 00                	mov    (%eax),%al
  800f75:	0f b6 d0             	movzbl %al,%edx
  800f78:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f7b:	8a 00                	mov    (%eax),%al
  800f7d:	0f b6 c0             	movzbl %al,%eax
  800f80:	29 c2                	sub    %eax,%edx
  800f82:	89 d0                	mov    %edx,%eax
  800f84:	eb 18                	jmp    800f9e <memcmp+0x50>
		s1++, s2++;
  800f86:	ff 45 fc             	incl   -0x4(%ebp)
  800f89:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f92:	89 55 10             	mov    %edx,0x10(%ebp)
  800f95:	85 c0                	test   %eax,%eax
  800f97:	75 c9                	jne    800f62 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f99:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f9e:	c9                   	leave  
  800f9f:	c3                   	ret    

00800fa0 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800fa0:	55                   	push   %ebp
  800fa1:	89 e5                	mov    %esp,%ebp
  800fa3:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800fa6:	8b 55 08             	mov    0x8(%ebp),%edx
  800fa9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fac:	01 d0                	add    %edx,%eax
  800fae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800fb1:	eb 15                	jmp    800fc8 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb6:	8a 00                	mov    (%eax),%al
  800fb8:	0f b6 d0             	movzbl %al,%edx
  800fbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbe:	0f b6 c0             	movzbl %al,%eax
  800fc1:	39 c2                	cmp    %eax,%edx
  800fc3:	74 0d                	je     800fd2 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800fc5:	ff 45 08             	incl   0x8(%ebp)
  800fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fce:	72 e3                	jb     800fb3 <memfind+0x13>
  800fd0:	eb 01                	jmp    800fd3 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fd2:	90                   	nop
	return (void *) s;
  800fd3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fd6:	c9                   	leave  
  800fd7:	c3                   	ret    

00800fd8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800fd8:	55                   	push   %ebp
  800fd9:	89 e5                	mov    %esp,%ebp
  800fdb:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800fde:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800fe5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fec:	eb 03                	jmp    800ff1 <strtol+0x19>
		s++;
  800fee:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ff1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff4:	8a 00                	mov    (%eax),%al
  800ff6:	3c 20                	cmp    $0x20,%al
  800ff8:	74 f4                	je     800fee <strtol+0x16>
  800ffa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffd:	8a 00                	mov    (%eax),%al
  800fff:	3c 09                	cmp    $0x9,%al
  801001:	74 eb                	je     800fee <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
  801006:	8a 00                	mov    (%eax),%al
  801008:	3c 2b                	cmp    $0x2b,%al
  80100a:	75 05                	jne    801011 <strtol+0x39>
		s++;
  80100c:	ff 45 08             	incl   0x8(%ebp)
  80100f:	eb 13                	jmp    801024 <strtol+0x4c>
	else if (*s == '-')
  801011:	8b 45 08             	mov    0x8(%ebp),%eax
  801014:	8a 00                	mov    (%eax),%al
  801016:	3c 2d                	cmp    $0x2d,%al
  801018:	75 0a                	jne    801024 <strtol+0x4c>
		s++, neg = 1;
  80101a:	ff 45 08             	incl   0x8(%ebp)
  80101d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801024:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801028:	74 06                	je     801030 <strtol+0x58>
  80102a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80102e:	75 20                	jne    801050 <strtol+0x78>
  801030:	8b 45 08             	mov    0x8(%ebp),%eax
  801033:	8a 00                	mov    (%eax),%al
  801035:	3c 30                	cmp    $0x30,%al
  801037:	75 17                	jne    801050 <strtol+0x78>
  801039:	8b 45 08             	mov    0x8(%ebp),%eax
  80103c:	40                   	inc    %eax
  80103d:	8a 00                	mov    (%eax),%al
  80103f:	3c 78                	cmp    $0x78,%al
  801041:	75 0d                	jne    801050 <strtol+0x78>
		s += 2, base = 16;
  801043:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801047:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80104e:	eb 28                	jmp    801078 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801050:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801054:	75 15                	jne    80106b <strtol+0x93>
  801056:	8b 45 08             	mov    0x8(%ebp),%eax
  801059:	8a 00                	mov    (%eax),%al
  80105b:	3c 30                	cmp    $0x30,%al
  80105d:	75 0c                	jne    80106b <strtol+0x93>
		s++, base = 8;
  80105f:	ff 45 08             	incl   0x8(%ebp)
  801062:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801069:	eb 0d                	jmp    801078 <strtol+0xa0>
	else if (base == 0)
  80106b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80106f:	75 07                	jne    801078 <strtol+0xa0>
		base = 10;
  801071:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801078:	8b 45 08             	mov    0x8(%ebp),%eax
  80107b:	8a 00                	mov    (%eax),%al
  80107d:	3c 2f                	cmp    $0x2f,%al
  80107f:	7e 19                	jle    80109a <strtol+0xc2>
  801081:	8b 45 08             	mov    0x8(%ebp),%eax
  801084:	8a 00                	mov    (%eax),%al
  801086:	3c 39                	cmp    $0x39,%al
  801088:	7f 10                	jg     80109a <strtol+0xc2>
			dig = *s - '0';
  80108a:	8b 45 08             	mov    0x8(%ebp),%eax
  80108d:	8a 00                	mov    (%eax),%al
  80108f:	0f be c0             	movsbl %al,%eax
  801092:	83 e8 30             	sub    $0x30,%eax
  801095:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801098:	eb 42                	jmp    8010dc <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80109a:	8b 45 08             	mov    0x8(%ebp),%eax
  80109d:	8a 00                	mov    (%eax),%al
  80109f:	3c 60                	cmp    $0x60,%al
  8010a1:	7e 19                	jle    8010bc <strtol+0xe4>
  8010a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a6:	8a 00                	mov    (%eax),%al
  8010a8:	3c 7a                	cmp    $0x7a,%al
  8010aa:	7f 10                	jg     8010bc <strtol+0xe4>
			dig = *s - 'a' + 10;
  8010ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8010af:	8a 00                	mov    (%eax),%al
  8010b1:	0f be c0             	movsbl %al,%eax
  8010b4:	83 e8 57             	sub    $0x57,%eax
  8010b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010ba:	eb 20                	jmp    8010dc <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8010bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bf:	8a 00                	mov    (%eax),%al
  8010c1:	3c 40                	cmp    $0x40,%al
  8010c3:	7e 39                	jle    8010fe <strtol+0x126>
  8010c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c8:	8a 00                	mov    (%eax),%al
  8010ca:	3c 5a                	cmp    $0x5a,%al
  8010cc:	7f 30                	jg     8010fe <strtol+0x126>
			dig = *s - 'A' + 10;
  8010ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d1:	8a 00                	mov    (%eax),%al
  8010d3:	0f be c0             	movsbl %al,%eax
  8010d6:	83 e8 37             	sub    $0x37,%eax
  8010d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010df:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010e2:	7d 19                	jge    8010fd <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010e4:	ff 45 08             	incl   0x8(%ebp)
  8010e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ea:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010ee:	89 c2                	mov    %eax,%edx
  8010f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010f3:	01 d0                	add    %edx,%eax
  8010f5:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010f8:	e9 7b ff ff ff       	jmp    801078 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010fd:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010fe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801102:	74 08                	je     80110c <strtol+0x134>
		*endptr = (char *) s;
  801104:	8b 45 0c             	mov    0xc(%ebp),%eax
  801107:	8b 55 08             	mov    0x8(%ebp),%edx
  80110a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80110c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801110:	74 07                	je     801119 <strtol+0x141>
  801112:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801115:	f7 d8                	neg    %eax
  801117:	eb 03                	jmp    80111c <strtol+0x144>
  801119:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80111c:	c9                   	leave  
  80111d:	c3                   	ret    

0080111e <ltostr>:

void
ltostr(long value, char *str)
{
  80111e:	55                   	push   %ebp
  80111f:	89 e5                	mov    %esp,%ebp
  801121:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801124:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80112b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801132:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801136:	79 13                	jns    80114b <ltostr+0x2d>
	{
		neg = 1;
  801138:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80113f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801142:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801145:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801148:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80114b:	8b 45 08             	mov    0x8(%ebp),%eax
  80114e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801153:	99                   	cltd   
  801154:	f7 f9                	idiv   %ecx
  801156:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801159:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80115c:	8d 50 01             	lea    0x1(%eax),%edx
  80115f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801162:	89 c2                	mov    %eax,%edx
  801164:	8b 45 0c             	mov    0xc(%ebp),%eax
  801167:	01 d0                	add    %edx,%eax
  801169:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80116c:	83 c2 30             	add    $0x30,%edx
  80116f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801171:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801174:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801179:	f7 e9                	imul   %ecx
  80117b:	c1 fa 02             	sar    $0x2,%edx
  80117e:	89 c8                	mov    %ecx,%eax
  801180:	c1 f8 1f             	sar    $0x1f,%eax
  801183:	29 c2                	sub    %eax,%edx
  801185:	89 d0                	mov    %edx,%eax
  801187:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80118a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80118d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801192:	f7 e9                	imul   %ecx
  801194:	c1 fa 02             	sar    $0x2,%edx
  801197:	89 c8                	mov    %ecx,%eax
  801199:	c1 f8 1f             	sar    $0x1f,%eax
  80119c:	29 c2                	sub    %eax,%edx
  80119e:	89 d0                	mov    %edx,%eax
  8011a0:	c1 e0 02             	shl    $0x2,%eax
  8011a3:	01 d0                	add    %edx,%eax
  8011a5:	01 c0                	add    %eax,%eax
  8011a7:	29 c1                	sub    %eax,%ecx
  8011a9:	89 ca                	mov    %ecx,%edx
  8011ab:	85 d2                	test   %edx,%edx
  8011ad:	75 9c                	jne    80114b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8011af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8011b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011b9:	48                   	dec    %eax
  8011ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8011bd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011c1:	74 3d                	je     801200 <ltostr+0xe2>
		start = 1 ;
  8011c3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011ca:	eb 34                	jmp    801200 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d2:	01 d0                	add    %edx,%eax
  8011d4:	8a 00                	mov    (%eax),%al
  8011d6:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011df:	01 c2                	add    %eax,%edx
  8011e1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e7:	01 c8                	add    %ecx,%eax
  8011e9:	8a 00                	mov    (%eax),%al
  8011eb:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011ed:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f3:	01 c2                	add    %eax,%edx
  8011f5:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011f8:	88 02                	mov    %al,(%edx)
		start++ ;
  8011fa:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011fd:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801200:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801203:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801206:	7c c4                	jl     8011cc <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801208:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80120b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120e:	01 d0                	add    %edx,%eax
  801210:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801213:	90                   	nop
  801214:	c9                   	leave  
  801215:	c3                   	ret    

00801216 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801216:	55                   	push   %ebp
  801217:	89 e5                	mov    %esp,%ebp
  801219:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80121c:	ff 75 08             	pushl  0x8(%ebp)
  80121f:	e8 54 fa ff ff       	call   800c78 <strlen>
  801224:	83 c4 04             	add    $0x4,%esp
  801227:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80122a:	ff 75 0c             	pushl  0xc(%ebp)
  80122d:	e8 46 fa ff ff       	call   800c78 <strlen>
  801232:	83 c4 04             	add    $0x4,%esp
  801235:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801238:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80123f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801246:	eb 17                	jmp    80125f <strcconcat+0x49>
		final[s] = str1[s] ;
  801248:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80124b:	8b 45 10             	mov    0x10(%ebp),%eax
  80124e:	01 c2                	add    %eax,%edx
  801250:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801253:	8b 45 08             	mov    0x8(%ebp),%eax
  801256:	01 c8                	add    %ecx,%eax
  801258:	8a 00                	mov    (%eax),%al
  80125a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80125c:	ff 45 fc             	incl   -0x4(%ebp)
  80125f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801262:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801265:	7c e1                	jl     801248 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801267:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80126e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801275:	eb 1f                	jmp    801296 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801277:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80127a:	8d 50 01             	lea    0x1(%eax),%edx
  80127d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801280:	89 c2                	mov    %eax,%edx
  801282:	8b 45 10             	mov    0x10(%ebp),%eax
  801285:	01 c2                	add    %eax,%edx
  801287:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80128a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128d:	01 c8                	add    %ecx,%eax
  80128f:	8a 00                	mov    (%eax),%al
  801291:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801293:	ff 45 f8             	incl   -0x8(%ebp)
  801296:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801299:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80129c:	7c d9                	jl     801277 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80129e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a4:	01 d0                	add    %edx,%eax
  8012a6:	c6 00 00             	movb   $0x0,(%eax)
}
  8012a9:	90                   	nop
  8012aa:	c9                   	leave  
  8012ab:	c3                   	ret    

008012ac <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8012ac:	55                   	push   %ebp
  8012ad:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8012af:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8012b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8012bb:	8b 00                	mov    (%eax),%eax
  8012bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c7:	01 d0                	add    %edx,%eax
  8012c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012cf:	eb 0c                	jmp    8012dd <strsplit+0x31>
			*string++ = 0;
  8012d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d4:	8d 50 01             	lea    0x1(%eax),%edx
  8012d7:	89 55 08             	mov    %edx,0x8(%ebp)
  8012da:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e0:	8a 00                	mov    (%eax),%al
  8012e2:	84 c0                	test   %al,%al
  8012e4:	74 18                	je     8012fe <strsplit+0x52>
  8012e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e9:	8a 00                	mov    (%eax),%al
  8012eb:	0f be c0             	movsbl %al,%eax
  8012ee:	50                   	push   %eax
  8012ef:	ff 75 0c             	pushl  0xc(%ebp)
  8012f2:	e8 13 fb ff ff       	call   800e0a <strchr>
  8012f7:	83 c4 08             	add    $0x8,%esp
  8012fa:	85 c0                	test   %eax,%eax
  8012fc:	75 d3                	jne    8012d1 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8012fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801301:	8a 00                	mov    (%eax),%al
  801303:	84 c0                	test   %al,%al
  801305:	74 5a                	je     801361 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801307:	8b 45 14             	mov    0x14(%ebp),%eax
  80130a:	8b 00                	mov    (%eax),%eax
  80130c:	83 f8 0f             	cmp    $0xf,%eax
  80130f:	75 07                	jne    801318 <strsplit+0x6c>
		{
			return 0;
  801311:	b8 00 00 00 00       	mov    $0x0,%eax
  801316:	eb 66                	jmp    80137e <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801318:	8b 45 14             	mov    0x14(%ebp),%eax
  80131b:	8b 00                	mov    (%eax),%eax
  80131d:	8d 48 01             	lea    0x1(%eax),%ecx
  801320:	8b 55 14             	mov    0x14(%ebp),%edx
  801323:	89 0a                	mov    %ecx,(%edx)
  801325:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80132c:	8b 45 10             	mov    0x10(%ebp),%eax
  80132f:	01 c2                	add    %eax,%edx
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801336:	eb 03                	jmp    80133b <strsplit+0x8f>
			string++;
  801338:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80133b:	8b 45 08             	mov    0x8(%ebp),%eax
  80133e:	8a 00                	mov    (%eax),%al
  801340:	84 c0                	test   %al,%al
  801342:	74 8b                	je     8012cf <strsplit+0x23>
  801344:	8b 45 08             	mov    0x8(%ebp),%eax
  801347:	8a 00                	mov    (%eax),%al
  801349:	0f be c0             	movsbl %al,%eax
  80134c:	50                   	push   %eax
  80134d:	ff 75 0c             	pushl  0xc(%ebp)
  801350:	e8 b5 fa ff ff       	call   800e0a <strchr>
  801355:	83 c4 08             	add    $0x8,%esp
  801358:	85 c0                	test   %eax,%eax
  80135a:	74 dc                	je     801338 <strsplit+0x8c>
			string++;
	}
  80135c:	e9 6e ff ff ff       	jmp    8012cf <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801361:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801362:	8b 45 14             	mov    0x14(%ebp),%eax
  801365:	8b 00                	mov    (%eax),%eax
  801367:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80136e:	8b 45 10             	mov    0x10(%ebp),%eax
  801371:	01 d0                	add    %edx,%eax
  801373:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801379:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80137e:	c9                   	leave  
  80137f:	c3                   	ret    

00801380 <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  801380:	55                   	push   %ebp
  801381:	89 e5                	mov    %esp,%ebp
  801383:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801386:	8b 45 08             	mov    0x8(%ebp),%eax
  801389:	c1 e8 0c             	shr    $0xc,%eax
  80138c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  80138f:	8b 45 08             	mov    0x8(%ebp),%eax
  801392:	25 ff 0f 00 00       	and    $0xfff,%eax
  801397:	85 c0                	test   %eax,%eax
  801399:	74 03                	je     80139e <malloc+0x1e>
			num++;
  80139b:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  80139e:	a1 04 30 80 00       	mov    0x803004,%eax
  8013a3:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8013a8:	75 73                	jne    80141d <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8013aa:	83 ec 08             	sub    $0x8,%esp
  8013ad:	ff 75 08             	pushl  0x8(%ebp)
  8013b0:	68 00 00 00 80       	push   $0x80000000
  8013b5:	e8 14 05 00 00       	call   8018ce <sys_allocateMem>
  8013ba:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8013bd:	a1 04 30 80 00       	mov    0x803004,%eax
  8013c2:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8013c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013c8:	c1 e0 0c             	shl    $0xc,%eax
  8013cb:	89 c2                	mov    %eax,%edx
  8013cd:	a1 04 30 80 00       	mov    0x803004,%eax
  8013d2:	01 d0                	add    %edx,%eax
  8013d4:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  8013d9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013e1:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  8013e8:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013ed:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8013f3:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  8013fa:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013ff:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801406:	01 00 00 00 
			sizeofarray++;
  80140a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80140f:	40                   	inc    %eax
  801410:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  801415:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801418:	e9 71 01 00 00       	jmp    80158e <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  80141d:	a1 28 30 80 00       	mov    0x803028,%eax
  801422:	85 c0                	test   %eax,%eax
  801424:	75 71                	jne    801497 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801426:	a1 04 30 80 00       	mov    0x803004,%eax
  80142b:	83 ec 08             	sub    $0x8,%esp
  80142e:	ff 75 08             	pushl  0x8(%ebp)
  801431:	50                   	push   %eax
  801432:	e8 97 04 00 00       	call   8018ce <sys_allocateMem>
  801437:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  80143a:	a1 04 30 80 00       	mov    0x803004,%eax
  80143f:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801442:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801445:	c1 e0 0c             	shl    $0xc,%eax
  801448:	89 c2                	mov    %eax,%edx
  80144a:	a1 04 30 80 00       	mov    0x803004,%eax
  80144f:	01 d0                	add    %edx,%eax
  801451:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801456:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80145b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80145e:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801465:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80146a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80146d:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801474:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801479:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801480:	01 00 00 00 
				sizeofarray++;
  801484:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801489:	40                   	inc    %eax
  80148a:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  80148f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801492:	e9 f7 00 00 00       	jmp    80158e <malloc+0x20e>
			}
			else{
				int count=0;
  801497:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  80149e:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8014a5:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8014ac:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8014b3:	eb 7c                	jmp    801531 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  8014b5:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8014bc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8014c3:	eb 1a                	jmp    8014df <malloc+0x15f>
					{
						if(addresses[j]==i)
  8014c5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8014c8:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8014cf:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8014d2:	75 08                	jne    8014dc <malloc+0x15c>
						{
							index=j;
  8014d4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8014d7:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  8014da:	eb 0d                	jmp    8014e9 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  8014dc:	ff 45 dc             	incl   -0x24(%ebp)
  8014df:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014e4:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8014e7:	7c dc                	jl     8014c5 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  8014e9:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8014ed:	75 05                	jne    8014f4 <malloc+0x174>
					{
						count++;
  8014ef:	ff 45 f0             	incl   -0x10(%ebp)
  8014f2:	eb 36                	jmp    80152a <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  8014f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8014f7:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8014fe:	85 c0                	test   %eax,%eax
  801500:	75 05                	jne    801507 <malloc+0x187>
						{
							count++;
  801502:	ff 45 f0             	incl   -0x10(%ebp)
  801505:	eb 23                	jmp    80152a <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801507:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80150a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80150d:	7d 14                	jge    801523 <malloc+0x1a3>
  80150f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801512:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801515:	7c 0c                	jl     801523 <malloc+0x1a3>
							{
								min=count;
  801517:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80151a:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  80151d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801520:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801523:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80152a:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801531:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801538:	0f 86 77 ff ff ff    	jbe    8014b5 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  80153e:	83 ec 08             	sub    $0x8,%esp
  801541:	ff 75 08             	pushl  0x8(%ebp)
  801544:	ff 75 e4             	pushl  -0x1c(%ebp)
  801547:	e8 82 03 00 00       	call   8018ce <sys_allocateMem>
  80154c:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  80154f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801554:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801557:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  80155e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801563:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801569:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801570:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801575:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  80157c:	01 00 00 00 
				sizeofarray++;
  801580:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801585:	40                   	inc    %eax
  801586:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  80158b:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  80158e:	c9                   	leave  
  80158f:	c3                   	ret    

00801590 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801590:	55                   	push   %ebp
  801591:	89 e5                	mov    %esp,%ebp
  801593:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  801596:	8b 45 08             	mov    0x8(%ebp),%eax
  801599:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int size;
    int is_found=0;
  80159c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  8015a3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8015aa:	eb 30                	jmp    8015dc <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  8015ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015af:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8015b6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8015b9:	75 1e                	jne    8015d9 <free+0x49>
  8015bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015be:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8015c5:	83 f8 01             	cmp    $0x1,%eax
  8015c8:	75 0f                	jne    8015d9 <free+0x49>
    		is_found=1;
  8015ca:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  8015d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  8015d7:	eb 0d                	jmp    8015e6 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    int size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  8015d9:	ff 45 ec             	incl   -0x14(%ebp)
  8015dc:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015e1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  8015e4:	7c c6                	jl     8015ac <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  8015e6:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  8015ea:	75 3b                	jne    801627 <free+0x97>
    	size=numOfPages[index]*PAGE_SIZE;
  8015ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015ef:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  8015f6:	c1 e0 0c             	shl    $0xc,%eax
  8015f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  8015fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8015ff:	83 ec 08             	sub    $0x8,%esp
  801602:	50                   	push   %eax
  801603:	ff 75 e8             	pushl  -0x18(%ebp)
  801606:	e8 a7 02 00 00       	call   8018b2 <sys_freeMem>
  80160b:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  80160e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801611:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801618:	00 00 00 00 
    	changes++;
  80161c:	a1 28 30 80 00       	mov    0x803028,%eax
  801621:	40                   	inc    %eax
  801622:	a3 28 30 80 00       	mov    %eax,0x803028
    }


	//refer to the project presentation and documentation for details
}
  801627:	90                   	nop
  801628:	c9                   	leave  
  801629:	c3                   	ret    

0080162a <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80162a:	55                   	push   %ebp
  80162b:	89 e5                	mov    %esp,%ebp
  80162d:	83 ec 18             	sub    $0x18,%esp
  801630:	8b 45 10             	mov    0x10(%ebp),%eax
  801633:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801636:	83 ec 04             	sub    $0x4,%esp
  801639:	68 f0 25 80 00       	push   $0x8025f0
  80163e:	68 9f 00 00 00       	push   $0x9f
  801643:	68 13 26 80 00       	push   $0x802613
  801648:	e8 0b 07 00 00       	call   801d58 <_panic>

0080164d <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80164d:	55                   	push   %ebp
  80164e:	89 e5                	mov    %esp,%ebp
  801650:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801653:	83 ec 04             	sub    $0x4,%esp
  801656:	68 f0 25 80 00       	push   $0x8025f0
  80165b:	68 a5 00 00 00       	push   $0xa5
  801660:	68 13 26 80 00       	push   $0x802613
  801665:	e8 ee 06 00 00       	call   801d58 <_panic>

0080166a <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80166a:	55                   	push   %ebp
  80166b:	89 e5                	mov    %esp,%ebp
  80166d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801670:	83 ec 04             	sub    $0x4,%esp
  801673:	68 f0 25 80 00       	push   $0x8025f0
  801678:	68 ab 00 00 00       	push   $0xab
  80167d:	68 13 26 80 00       	push   $0x802613
  801682:	e8 d1 06 00 00       	call   801d58 <_panic>

00801687 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801687:	55                   	push   %ebp
  801688:	89 e5                	mov    %esp,%ebp
  80168a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80168d:	83 ec 04             	sub    $0x4,%esp
  801690:	68 f0 25 80 00       	push   $0x8025f0
  801695:	68 b0 00 00 00       	push   $0xb0
  80169a:	68 13 26 80 00       	push   $0x802613
  80169f:	e8 b4 06 00 00       	call   801d58 <_panic>

008016a4 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8016a4:	55                   	push   %ebp
  8016a5:	89 e5                	mov    %esp,%ebp
  8016a7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016aa:	83 ec 04             	sub    $0x4,%esp
  8016ad:	68 f0 25 80 00       	push   $0x8025f0
  8016b2:	68 b6 00 00 00       	push   $0xb6
  8016b7:	68 13 26 80 00       	push   $0x802613
  8016bc:	e8 97 06 00 00       	call   801d58 <_panic>

008016c1 <shrink>:
}
void shrink(uint32 newSize)
{
  8016c1:	55                   	push   %ebp
  8016c2:	89 e5                	mov    %esp,%ebp
  8016c4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016c7:	83 ec 04             	sub    $0x4,%esp
  8016ca:	68 f0 25 80 00       	push   $0x8025f0
  8016cf:	68 ba 00 00 00       	push   $0xba
  8016d4:	68 13 26 80 00       	push   $0x802613
  8016d9:	e8 7a 06 00 00       	call   801d58 <_panic>

008016de <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
  8016e1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016e4:	83 ec 04             	sub    $0x4,%esp
  8016e7:	68 f0 25 80 00       	push   $0x8025f0
  8016ec:	68 bf 00 00 00       	push   $0xbf
  8016f1:	68 13 26 80 00       	push   $0x802613
  8016f6:	e8 5d 06 00 00       	call   801d58 <_panic>

008016fb <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016fb:	55                   	push   %ebp
  8016fc:	89 e5                	mov    %esp,%ebp
  8016fe:	57                   	push   %edi
  8016ff:	56                   	push   %esi
  801700:	53                   	push   %ebx
  801701:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801704:	8b 45 08             	mov    0x8(%ebp),%eax
  801707:	8b 55 0c             	mov    0xc(%ebp),%edx
  80170a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80170d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801710:	8b 7d 18             	mov    0x18(%ebp),%edi
  801713:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801716:	cd 30                	int    $0x30
  801718:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80171b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80171e:	83 c4 10             	add    $0x10,%esp
  801721:	5b                   	pop    %ebx
  801722:	5e                   	pop    %esi
  801723:	5f                   	pop    %edi
  801724:	5d                   	pop    %ebp
  801725:	c3                   	ret    

00801726 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801726:	55                   	push   %ebp
  801727:	89 e5                	mov    %esp,%ebp
  801729:	83 ec 04             	sub    $0x4,%esp
  80172c:	8b 45 10             	mov    0x10(%ebp),%eax
  80172f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801732:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801736:	8b 45 08             	mov    0x8(%ebp),%eax
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	52                   	push   %edx
  80173e:	ff 75 0c             	pushl  0xc(%ebp)
  801741:	50                   	push   %eax
  801742:	6a 00                	push   $0x0
  801744:	e8 b2 ff ff ff       	call   8016fb <syscall>
  801749:	83 c4 18             	add    $0x18,%esp
}
  80174c:	90                   	nop
  80174d:	c9                   	leave  
  80174e:	c3                   	ret    

0080174f <sys_cgetc>:

int
sys_cgetc(void)
{
  80174f:	55                   	push   %ebp
  801750:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 01                	push   $0x1
  80175e:	e8 98 ff ff ff       	call   8016fb <syscall>
  801763:	83 c4 18             	add    $0x18,%esp
}
  801766:	c9                   	leave  
  801767:	c3                   	ret    

00801768 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801768:	55                   	push   %ebp
  801769:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80176b:	8b 45 08             	mov    0x8(%ebp),%eax
  80176e:	6a 00                	push   $0x0
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	50                   	push   %eax
  801777:	6a 05                	push   $0x5
  801779:	e8 7d ff ff ff       	call   8016fb <syscall>
  80177e:	83 c4 18             	add    $0x18,%esp
}
  801781:	c9                   	leave  
  801782:	c3                   	ret    

00801783 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801783:	55                   	push   %ebp
  801784:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 02                	push   $0x2
  801792:	e8 64 ff ff ff       	call   8016fb <syscall>
  801797:	83 c4 18             	add    $0x18,%esp
}
  80179a:	c9                   	leave  
  80179b:	c3                   	ret    

0080179c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80179c:	55                   	push   %ebp
  80179d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 03                	push   $0x3
  8017ab:	e8 4b ff ff ff       	call   8016fb <syscall>
  8017b0:	83 c4 18             	add    $0x18,%esp
}
  8017b3:	c9                   	leave  
  8017b4:	c3                   	ret    

008017b5 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017b5:	55                   	push   %ebp
  8017b6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 04                	push   $0x4
  8017c4:	e8 32 ff ff ff       	call   8016fb <syscall>
  8017c9:	83 c4 18             	add    $0x18,%esp
}
  8017cc:	c9                   	leave  
  8017cd:	c3                   	ret    

008017ce <sys_env_exit>:


void sys_env_exit(void)
{
  8017ce:	55                   	push   %ebp
  8017cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 06                	push   $0x6
  8017dd:	e8 19 ff ff ff       	call   8016fb <syscall>
  8017e2:	83 c4 18             	add    $0x18,%esp
}
  8017e5:	90                   	nop
  8017e6:	c9                   	leave  
  8017e7:	c3                   	ret    

008017e8 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017e8:	55                   	push   %ebp
  8017e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	52                   	push   %edx
  8017f8:	50                   	push   %eax
  8017f9:	6a 07                	push   $0x7
  8017fb:	e8 fb fe ff ff       	call   8016fb <syscall>
  801800:	83 c4 18             	add    $0x18,%esp
}
  801803:	c9                   	leave  
  801804:	c3                   	ret    

00801805 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801805:	55                   	push   %ebp
  801806:	89 e5                	mov    %esp,%ebp
  801808:	56                   	push   %esi
  801809:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80180a:	8b 75 18             	mov    0x18(%ebp),%esi
  80180d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801810:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801813:	8b 55 0c             	mov    0xc(%ebp),%edx
  801816:	8b 45 08             	mov    0x8(%ebp),%eax
  801819:	56                   	push   %esi
  80181a:	53                   	push   %ebx
  80181b:	51                   	push   %ecx
  80181c:	52                   	push   %edx
  80181d:	50                   	push   %eax
  80181e:	6a 08                	push   $0x8
  801820:	e8 d6 fe ff ff       	call   8016fb <syscall>
  801825:	83 c4 18             	add    $0x18,%esp
}
  801828:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80182b:	5b                   	pop    %ebx
  80182c:	5e                   	pop    %esi
  80182d:	5d                   	pop    %ebp
  80182e:	c3                   	ret    

0080182f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80182f:	55                   	push   %ebp
  801830:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801832:	8b 55 0c             	mov    0xc(%ebp),%edx
  801835:	8b 45 08             	mov    0x8(%ebp),%eax
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	52                   	push   %edx
  80183f:	50                   	push   %eax
  801840:	6a 09                	push   $0x9
  801842:	e8 b4 fe ff ff       	call   8016fb <syscall>
  801847:	83 c4 18             	add    $0x18,%esp
}
  80184a:	c9                   	leave  
  80184b:	c3                   	ret    

0080184c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80184c:	55                   	push   %ebp
  80184d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	ff 75 0c             	pushl  0xc(%ebp)
  801858:	ff 75 08             	pushl  0x8(%ebp)
  80185b:	6a 0a                	push   $0xa
  80185d:	e8 99 fe ff ff       	call   8016fb <syscall>
  801862:	83 c4 18             	add    $0x18,%esp
}
  801865:	c9                   	leave  
  801866:	c3                   	ret    

00801867 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801867:	55                   	push   %ebp
  801868:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 00                	push   $0x0
  801874:	6a 0b                	push   $0xb
  801876:	e8 80 fe ff ff       	call   8016fb <syscall>
  80187b:	83 c4 18             	add    $0x18,%esp
}
  80187e:	c9                   	leave  
  80187f:	c3                   	ret    

00801880 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801880:	55                   	push   %ebp
  801881:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 0c                	push   $0xc
  80188f:	e8 67 fe ff ff       	call   8016fb <syscall>
  801894:	83 c4 18             	add    $0x18,%esp
}
  801897:	c9                   	leave  
  801898:	c3                   	ret    

00801899 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801899:	55                   	push   %ebp
  80189a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 0d                	push   $0xd
  8018a8:	e8 4e fe ff ff       	call   8016fb <syscall>
  8018ad:	83 c4 18             	add    $0x18,%esp
}
  8018b0:	c9                   	leave  
  8018b1:	c3                   	ret    

008018b2 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018b2:	55                   	push   %ebp
  8018b3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	ff 75 0c             	pushl  0xc(%ebp)
  8018be:	ff 75 08             	pushl  0x8(%ebp)
  8018c1:	6a 11                	push   $0x11
  8018c3:	e8 33 fe ff ff       	call   8016fb <syscall>
  8018c8:	83 c4 18             	add    $0x18,%esp
	return;
  8018cb:	90                   	nop
}
  8018cc:	c9                   	leave  
  8018cd:	c3                   	ret    

008018ce <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018ce:	55                   	push   %ebp
  8018cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	ff 75 0c             	pushl  0xc(%ebp)
  8018da:	ff 75 08             	pushl  0x8(%ebp)
  8018dd:	6a 12                	push   $0x12
  8018df:	e8 17 fe ff ff       	call   8016fb <syscall>
  8018e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8018e7:	90                   	nop
}
  8018e8:	c9                   	leave  
  8018e9:	c3                   	ret    

008018ea <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018ea:	55                   	push   %ebp
  8018eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 0e                	push   $0xe
  8018f9:	e8 fd fd ff ff       	call   8016fb <syscall>
  8018fe:	83 c4 18             	add    $0x18,%esp
}
  801901:	c9                   	leave  
  801902:	c3                   	ret    

00801903 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801903:	55                   	push   %ebp
  801904:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801906:	6a 00                	push   $0x0
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	ff 75 08             	pushl  0x8(%ebp)
  801911:	6a 0f                	push   $0xf
  801913:	e8 e3 fd ff ff       	call   8016fb <syscall>
  801918:	83 c4 18             	add    $0x18,%esp
}
  80191b:	c9                   	leave  
  80191c:	c3                   	ret    

0080191d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80191d:	55                   	push   %ebp
  80191e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	6a 00                	push   $0x0
  80192a:	6a 10                	push   $0x10
  80192c:	e8 ca fd ff ff       	call   8016fb <syscall>
  801931:	83 c4 18             	add    $0x18,%esp
}
  801934:	90                   	nop
  801935:	c9                   	leave  
  801936:	c3                   	ret    

00801937 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801937:	55                   	push   %ebp
  801938:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	6a 14                	push   $0x14
  801946:	e8 b0 fd ff ff       	call   8016fb <syscall>
  80194b:	83 c4 18             	add    $0x18,%esp
}
  80194e:	90                   	nop
  80194f:	c9                   	leave  
  801950:	c3                   	ret    

00801951 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801951:	55                   	push   %ebp
  801952:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 15                	push   $0x15
  801960:	e8 96 fd ff ff       	call   8016fb <syscall>
  801965:	83 c4 18             	add    $0x18,%esp
}
  801968:	90                   	nop
  801969:	c9                   	leave  
  80196a:	c3                   	ret    

0080196b <sys_cputc>:


void
sys_cputc(const char c)
{
  80196b:	55                   	push   %ebp
  80196c:	89 e5                	mov    %esp,%ebp
  80196e:	83 ec 04             	sub    $0x4,%esp
  801971:	8b 45 08             	mov    0x8(%ebp),%eax
  801974:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801977:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	50                   	push   %eax
  801984:	6a 16                	push   $0x16
  801986:	e8 70 fd ff ff       	call   8016fb <syscall>
  80198b:	83 c4 18             	add    $0x18,%esp
}
  80198e:	90                   	nop
  80198f:	c9                   	leave  
  801990:	c3                   	ret    

00801991 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801991:	55                   	push   %ebp
  801992:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 17                	push   $0x17
  8019a0:	e8 56 fd ff ff       	call   8016fb <syscall>
  8019a5:	83 c4 18             	add    $0x18,%esp
}
  8019a8:	90                   	nop
  8019a9:	c9                   	leave  
  8019aa:	c3                   	ret    

008019ab <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019ab:	55                   	push   %ebp
  8019ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	ff 75 0c             	pushl  0xc(%ebp)
  8019ba:	50                   	push   %eax
  8019bb:	6a 18                	push   $0x18
  8019bd:	e8 39 fd ff ff       	call   8016fb <syscall>
  8019c2:	83 c4 18             	add    $0x18,%esp
}
  8019c5:	c9                   	leave  
  8019c6:	c3                   	ret    

008019c7 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019c7:	55                   	push   %ebp
  8019c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	52                   	push   %edx
  8019d7:	50                   	push   %eax
  8019d8:	6a 1b                	push   $0x1b
  8019da:	e8 1c fd ff ff       	call   8016fb <syscall>
  8019df:	83 c4 18             	add    $0x18,%esp
}
  8019e2:	c9                   	leave  
  8019e3:	c3                   	ret    

008019e4 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019e4:	55                   	push   %ebp
  8019e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	52                   	push   %edx
  8019f4:	50                   	push   %eax
  8019f5:	6a 19                	push   $0x19
  8019f7:	e8 ff fc ff ff       	call   8016fb <syscall>
  8019fc:	83 c4 18             	add    $0x18,%esp
}
  8019ff:	90                   	nop
  801a00:	c9                   	leave  
  801a01:	c3                   	ret    

00801a02 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a02:	55                   	push   %ebp
  801a03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a05:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a08:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	52                   	push   %edx
  801a12:	50                   	push   %eax
  801a13:	6a 1a                	push   $0x1a
  801a15:	e8 e1 fc ff ff       	call   8016fb <syscall>
  801a1a:	83 c4 18             	add    $0x18,%esp
}
  801a1d:	90                   	nop
  801a1e:	c9                   	leave  
  801a1f:	c3                   	ret    

00801a20 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a20:	55                   	push   %ebp
  801a21:	89 e5                	mov    %esp,%ebp
  801a23:	83 ec 04             	sub    $0x4,%esp
  801a26:	8b 45 10             	mov    0x10(%ebp),%eax
  801a29:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a2c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a2f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a33:	8b 45 08             	mov    0x8(%ebp),%eax
  801a36:	6a 00                	push   $0x0
  801a38:	51                   	push   %ecx
  801a39:	52                   	push   %edx
  801a3a:	ff 75 0c             	pushl  0xc(%ebp)
  801a3d:	50                   	push   %eax
  801a3e:	6a 1c                	push   $0x1c
  801a40:	e8 b6 fc ff ff       	call   8016fb <syscall>
  801a45:	83 c4 18             	add    $0x18,%esp
}
  801a48:	c9                   	leave  
  801a49:	c3                   	ret    

00801a4a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a4a:	55                   	push   %ebp
  801a4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a50:	8b 45 08             	mov    0x8(%ebp),%eax
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	6a 00                	push   $0x0
  801a59:	52                   	push   %edx
  801a5a:	50                   	push   %eax
  801a5b:	6a 1d                	push   $0x1d
  801a5d:	e8 99 fc ff ff       	call   8016fb <syscall>
  801a62:	83 c4 18             	add    $0x18,%esp
}
  801a65:	c9                   	leave  
  801a66:	c3                   	ret    

00801a67 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a67:	55                   	push   %ebp
  801a68:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a6a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a70:	8b 45 08             	mov    0x8(%ebp),%eax
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	51                   	push   %ecx
  801a78:	52                   	push   %edx
  801a79:	50                   	push   %eax
  801a7a:	6a 1e                	push   $0x1e
  801a7c:	e8 7a fc ff ff       	call   8016fb <syscall>
  801a81:	83 c4 18             	add    $0x18,%esp
}
  801a84:	c9                   	leave  
  801a85:	c3                   	ret    

00801a86 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a86:	55                   	push   %ebp
  801a87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a89:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	52                   	push   %edx
  801a96:	50                   	push   %eax
  801a97:	6a 1f                	push   $0x1f
  801a99:	e8 5d fc ff ff       	call   8016fb <syscall>
  801a9e:	83 c4 18             	add    $0x18,%esp
}
  801aa1:	c9                   	leave  
  801aa2:	c3                   	ret    

00801aa3 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801aa3:	55                   	push   %ebp
  801aa4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801aa6:	6a 00                	push   $0x0
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 20                	push   $0x20
  801ab2:	e8 44 fc ff ff       	call   8016fb <syscall>
  801ab7:	83 c4 18             	add    $0x18,%esp
}
  801aba:	c9                   	leave  
  801abb:	c3                   	ret    

00801abc <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801abc:	55                   	push   %ebp
  801abd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801abf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac2:	6a 00                	push   $0x0
  801ac4:	ff 75 14             	pushl  0x14(%ebp)
  801ac7:	ff 75 10             	pushl  0x10(%ebp)
  801aca:	ff 75 0c             	pushl  0xc(%ebp)
  801acd:	50                   	push   %eax
  801ace:	6a 21                	push   $0x21
  801ad0:	e8 26 fc ff ff       	call   8016fb <syscall>
  801ad5:	83 c4 18             	add    $0x18,%esp
}
  801ad8:	c9                   	leave  
  801ad9:	c3                   	ret    

00801ada <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ada:	55                   	push   %ebp
  801adb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801add:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	50                   	push   %eax
  801ae9:	6a 22                	push   $0x22
  801aeb:	e8 0b fc ff ff       	call   8016fb <syscall>
  801af0:	83 c4 18             	add    $0x18,%esp
}
  801af3:	90                   	nop
  801af4:	c9                   	leave  
  801af5:	c3                   	ret    

00801af6 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801af6:	55                   	push   %ebp
  801af7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801af9:	8b 45 08             	mov    0x8(%ebp),%eax
  801afc:	6a 00                	push   $0x0
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	50                   	push   %eax
  801b05:	6a 23                	push   $0x23
  801b07:	e8 ef fb ff ff       	call   8016fb <syscall>
  801b0c:	83 c4 18             	add    $0x18,%esp
}
  801b0f:	90                   	nop
  801b10:	c9                   	leave  
  801b11:	c3                   	ret    

00801b12 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b12:	55                   	push   %ebp
  801b13:	89 e5                	mov    %esp,%ebp
  801b15:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b18:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b1b:	8d 50 04             	lea    0x4(%eax),%edx
  801b1e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	52                   	push   %edx
  801b28:	50                   	push   %eax
  801b29:	6a 24                	push   $0x24
  801b2b:	e8 cb fb ff ff       	call   8016fb <syscall>
  801b30:	83 c4 18             	add    $0x18,%esp
	return result;
  801b33:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b36:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b39:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b3c:	89 01                	mov    %eax,(%ecx)
  801b3e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b41:	8b 45 08             	mov    0x8(%ebp),%eax
  801b44:	c9                   	leave  
  801b45:	c2 04 00             	ret    $0x4

00801b48 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b48:	55                   	push   %ebp
  801b49:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	ff 75 10             	pushl  0x10(%ebp)
  801b52:	ff 75 0c             	pushl  0xc(%ebp)
  801b55:	ff 75 08             	pushl  0x8(%ebp)
  801b58:	6a 13                	push   $0x13
  801b5a:	e8 9c fb ff ff       	call   8016fb <syscall>
  801b5f:	83 c4 18             	add    $0x18,%esp
	return ;
  801b62:	90                   	nop
}
  801b63:	c9                   	leave  
  801b64:	c3                   	ret    

00801b65 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b65:	55                   	push   %ebp
  801b66:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b68:	6a 00                	push   $0x0
  801b6a:	6a 00                	push   $0x0
  801b6c:	6a 00                	push   $0x0
  801b6e:	6a 00                	push   $0x0
  801b70:	6a 00                	push   $0x0
  801b72:	6a 25                	push   $0x25
  801b74:	e8 82 fb ff ff       	call   8016fb <syscall>
  801b79:	83 c4 18             	add    $0x18,%esp
}
  801b7c:	c9                   	leave  
  801b7d:	c3                   	ret    

00801b7e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b7e:	55                   	push   %ebp
  801b7f:	89 e5                	mov    %esp,%ebp
  801b81:	83 ec 04             	sub    $0x4,%esp
  801b84:	8b 45 08             	mov    0x8(%ebp),%eax
  801b87:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b8a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	50                   	push   %eax
  801b97:	6a 26                	push   $0x26
  801b99:	e8 5d fb ff ff       	call   8016fb <syscall>
  801b9e:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba1:	90                   	nop
}
  801ba2:	c9                   	leave  
  801ba3:	c3                   	ret    

00801ba4 <rsttst>:
void rsttst()
{
  801ba4:	55                   	push   %ebp
  801ba5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 28                	push   $0x28
  801bb3:	e8 43 fb ff ff       	call   8016fb <syscall>
  801bb8:	83 c4 18             	add    $0x18,%esp
	return ;
  801bbb:	90                   	nop
}
  801bbc:	c9                   	leave  
  801bbd:	c3                   	ret    

00801bbe <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bbe:	55                   	push   %ebp
  801bbf:	89 e5                	mov    %esp,%ebp
  801bc1:	83 ec 04             	sub    $0x4,%esp
  801bc4:	8b 45 14             	mov    0x14(%ebp),%eax
  801bc7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bca:	8b 55 18             	mov    0x18(%ebp),%edx
  801bcd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bd1:	52                   	push   %edx
  801bd2:	50                   	push   %eax
  801bd3:	ff 75 10             	pushl  0x10(%ebp)
  801bd6:	ff 75 0c             	pushl  0xc(%ebp)
  801bd9:	ff 75 08             	pushl  0x8(%ebp)
  801bdc:	6a 27                	push   $0x27
  801bde:	e8 18 fb ff ff       	call   8016fb <syscall>
  801be3:	83 c4 18             	add    $0x18,%esp
	return ;
  801be6:	90                   	nop
}
  801be7:	c9                   	leave  
  801be8:	c3                   	ret    

00801be9 <chktst>:
void chktst(uint32 n)
{
  801be9:	55                   	push   %ebp
  801bea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bec:	6a 00                	push   $0x0
  801bee:	6a 00                	push   $0x0
  801bf0:	6a 00                	push   $0x0
  801bf2:	6a 00                	push   $0x0
  801bf4:	ff 75 08             	pushl  0x8(%ebp)
  801bf7:	6a 29                	push   $0x29
  801bf9:	e8 fd fa ff ff       	call   8016fb <syscall>
  801bfe:	83 c4 18             	add    $0x18,%esp
	return ;
  801c01:	90                   	nop
}
  801c02:	c9                   	leave  
  801c03:	c3                   	ret    

00801c04 <inctst>:

void inctst()
{
  801c04:	55                   	push   %ebp
  801c05:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 00                	push   $0x0
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 2a                	push   $0x2a
  801c13:	e8 e3 fa ff ff       	call   8016fb <syscall>
  801c18:	83 c4 18             	add    $0x18,%esp
	return ;
  801c1b:	90                   	nop
}
  801c1c:	c9                   	leave  
  801c1d:	c3                   	ret    

00801c1e <gettst>:
uint32 gettst()
{
  801c1e:	55                   	push   %ebp
  801c1f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 2b                	push   $0x2b
  801c2d:	e8 c9 fa ff ff       	call   8016fb <syscall>
  801c32:	83 c4 18             	add    $0x18,%esp
}
  801c35:	c9                   	leave  
  801c36:	c3                   	ret    

00801c37 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c37:	55                   	push   %ebp
  801c38:	89 e5                	mov    %esp,%ebp
  801c3a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 00                	push   $0x0
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	6a 2c                	push   $0x2c
  801c49:	e8 ad fa ff ff       	call   8016fb <syscall>
  801c4e:	83 c4 18             	add    $0x18,%esp
  801c51:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c54:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c58:	75 07                	jne    801c61 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c5a:	b8 01 00 00 00       	mov    $0x1,%eax
  801c5f:	eb 05                	jmp    801c66 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c61:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c66:	c9                   	leave  
  801c67:	c3                   	ret    

00801c68 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c68:	55                   	push   %ebp
  801c69:	89 e5                	mov    %esp,%ebp
  801c6b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 2c                	push   $0x2c
  801c7a:	e8 7c fa ff ff       	call   8016fb <syscall>
  801c7f:	83 c4 18             	add    $0x18,%esp
  801c82:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c85:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c89:	75 07                	jne    801c92 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c8b:	b8 01 00 00 00       	mov    $0x1,%eax
  801c90:	eb 05                	jmp    801c97 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c92:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c97:	c9                   	leave  
  801c98:	c3                   	ret    

00801c99 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c99:	55                   	push   %ebp
  801c9a:	89 e5                	mov    %esp,%ebp
  801c9c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 00                	push   $0x0
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 2c                	push   $0x2c
  801cab:	e8 4b fa ff ff       	call   8016fb <syscall>
  801cb0:	83 c4 18             	add    $0x18,%esp
  801cb3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cb6:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cba:	75 07                	jne    801cc3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cbc:	b8 01 00 00 00       	mov    $0x1,%eax
  801cc1:	eb 05                	jmp    801cc8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cc3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cc8:	c9                   	leave  
  801cc9:	c3                   	ret    

00801cca <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cca:	55                   	push   %ebp
  801ccb:	89 e5                	mov    %esp,%ebp
  801ccd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cd0:	6a 00                	push   $0x0
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 2c                	push   $0x2c
  801cdc:	e8 1a fa ff ff       	call   8016fb <syscall>
  801ce1:	83 c4 18             	add    $0x18,%esp
  801ce4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ce7:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ceb:	75 07                	jne    801cf4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ced:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf2:	eb 05                	jmp    801cf9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801cf4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cf9:	c9                   	leave  
  801cfa:	c3                   	ret    

00801cfb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801cfb:	55                   	push   %ebp
  801cfc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	ff 75 08             	pushl  0x8(%ebp)
  801d09:	6a 2d                	push   $0x2d
  801d0b:	e8 eb f9 ff ff       	call   8016fb <syscall>
  801d10:	83 c4 18             	add    $0x18,%esp
	return ;
  801d13:	90                   	nop
}
  801d14:	c9                   	leave  
  801d15:	c3                   	ret    

00801d16 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d16:	55                   	push   %ebp
  801d17:	89 e5                	mov    %esp,%ebp
  801d19:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d1a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d1d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d20:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d23:	8b 45 08             	mov    0x8(%ebp),%eax
  801d26:	6a 00                	push   $0x0
  801d28:	53                   	push   %ebx
  801d29:	51                   	push   %ecx
  801d2a:	52                   	push   %edx
  801d2b:	50                   	push   %eax
  801d2c:	6a 2e                	push   $0x2e
  801d2e:	e8 c8 f9 ff ff       	call   8016fb <syscall>
  801d33:	83 c4 18             	add    $0x18,%esp
}
  801d36:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d39:	c9                   	leave  
  801d3a:	c3                   	ret    

00801d3b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d3b:	55                   	push   %ebp
  801d3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d41:	8b 45 08             	mov    0x8(%ebp),%eax
  801d44:	6a 00                	push   $0x0
  801d46:	6a 00                	push   $0x0
  801d48:	6a 00                	push   $0x0
  801d4a:	52                   	push   %edx
  801d4b:	50                   	push   %eax
  801d4c:	6a 2f                	push   $0x2f
  801d4e:	e8 a8 f9 ff ff       	call   8016fb <syscall>
  801d53:	83 c4 18             	add    $0x18,%esp
}
  801d56:	c9                   	leave  
  801d57:	c3                   	ret    

00801d58 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801d58:	55                   	push   %ebp
  801d59:	89 e5                	mov    %esp,%ebp
  801d5b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801d5e:	8d 45 10             	lea    0x10(%ebp),%eax
  801d61:	83 c0 04             	add    $0x4,%eax
  801d64:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801d67:	a1 a0 80 92 00       	mov    0x9280a0,%eax
  801d6c:	85 c0                	test   %eax,%eax
  801d6e:	74 16                	je     801d86 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801d70:	a1 a0 80 92 00       	mov    0x9280a0,%eax
  801d75:	83 ec 08             	sub    $0x8,%esp
  801d78:	50                   	push   %eax
  801d79:	68 20 26 80 00       	push   $0x802620
  801d7e:	e8 73 e8 ff ff       	call   8005f6 <cprintf>
  801d83:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801d86:	a1 00 30 80 00       	mov    0x803000,%eax
  801d8b:	ff 75 0c             	pushl  0xc(%ebp)
  801d8e:	ff 75 08             	pushl  0x8(%ebp)
  801d91:	50                   	push   %eax
  801d92:	68 25 26 80 00       	push   $0x802625
  801d97:	e8 5a e8 ff ff       	call   8005f6 <cprintf>
  801d9c:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801d9f:	8b 45 10             	mov    0x10(%ebp),%eax
  801da2:	83 ec 08             	sub    $0x8,%esp
  801da5:	ff 75 f4             	pushl  -0xc(%ebp)
  801da8:	50                   	push   %eax
  801da9:	e8 dd e7 ff ff       	call   80058b <vcprintf>
  801dae:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801db1:	83 ec 08             	sub    $0x8,%esp
  801db4:	6a 00                	push   $0x0
  801db6:	68 41 26 80 00       	push   $0x802641
  801dbb:	e8 cb e7 ff ff       	call   80058b <vcprintf>
  801dc0:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801dc3:	e8 4c e7 ff ff       	call   800514 <exit>

	// should not return here
	while (1) ;
  801dc8:	eb fe                	jmp    801dc8 <_panic+0x70>

00801dca <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801dca:	55                   	push   %ebp
  801dcb:	89 e5                	mov    %esp,%ebp
  801dcd:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801dd0:	a1 20 30 80 00       	mov    0x803020,%eax
  801dd5:	8b 50 74             	mov    0x74(%eax),%edx
  801dd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ddb:	39 c2                	cmp    %eax,%edx
  801ddd:	74 14                	je     801df3 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801ddf:	83 ec 04             	sub    $0x4,%esp
  801de2:	68 44 26 80 00       	push   $0x802644
  801de7:	6a 26                	push   $0x26
  801de9:	68 90 26 80 00       	push   $0x802690
  801dee:	e8 65 ff ff ff       	call   801d58 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801df3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801dfa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801e01:	e9 b6 00 00 00       	jmp    801ebc <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801e06:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e09:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e10:	8b 45 08             	mov    0x8(%ebp),%eax
  801e13:	01 d0                	add    %edx,%eax
  801e15:	8b 00                	mov    (%eax),%eax
  801e17:	85 c0                	test   %eax,%eax
  801e19:	75 08                	jne    801e23 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801e1b:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801e1e:	e9 96 00 00 00       	jmp    801eb9 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801e23:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e2a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801e31:	eb 5d                	jmp    801e90 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801e33:	a1 20 30 80 00       	mov    0x803020,%eax
  801e38:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801e3e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801e41:	c1 e2 04             	shl    $0x4,%edx
  801e44:	01 d0                	add    %edx,%eax
  801e46:	8a 40 04             	mov    0x4(%eax),%al
  801e49:	84 c0                	test   %al,%al
  801e4b:	75 40                	jne    801e8d <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801e4d:	a1 20 30 80 00       	mov    0x803020,%eax
  801e52:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801e58:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801e5b:	c1 e2 04             	shl    $0x4,%edx
  801e5e:	01 d0                	add    %edx,%eax
  801e60:	8b 00                	mov    (%eax),%eax
  801e62:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801e65:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801e68:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801e6d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801e6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e72:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801e79:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7c:	01 c8                	add    %ecx,%eax
  801e7e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801e80:	39 c2                	cmp    %eax,%edx
  801e82:	75 09                	jne    801e8d <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801e84:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801e8b:	eb 12                	jmp    801e9f <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e8d:	ff 45 e8             	incl   -0x18(%ebp)
  801e90:	a1 20 30 80 00       	mov    0x803020,%eax
  801e95:	8b 50 74             	mov    0x74(%eax),%edx
  801e98:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e9b:	39 c2                	cmp    %eax,%edx
  801e9d:	77 94                	ja     801e33 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801e9f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801ea3:	75 14                	jne    801eb9 <CheckWSWithoutLastIndex+0xef>
			panic(
  801ea5:	83 ec 04             	sub    $0x4,%esp
  801ea8:	68 9c 26 80 00       	push   $0x80269c
  801ead:	6a 3a                	push   $0x3a
  801eaf:	68 90 26 80 00       	push   $0x802690
  801eb4:	e8 9f fe ff ff       	call   801d58 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801eb9:	ff 45 f0             	incl   -0x10(%ebp)
  801ebc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ebf:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801ec2:	0f 8c 3e ff ff ff    	jl     801e06 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801ec8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ecf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801ed6:	eb 20                	jmp    801ef8 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801ed8:	a1 20 30 80 00       	mov    0x803020,%eax
  801edd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801ee3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801ee6:	c1 e2 04             	shl    $0x4,%edx
  801ee9:	01 d0                	add    %edx,%eax
  801eeb:	8a 40 04             	mov    0x4(%eax),%al
  801eee:	3c 01                	cmp    $0x1,%al
  801ef0:	75 03                	jne    801ef5 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801ef2:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ef5:	ff 45 e0             	incl   -0x20(%ebp)
  801ef8:	a1 20 30 80 00       	mov    0x803020,%eax
  801efd:	8b 50 74             	mov    0x74(%eax),%edx
  801f00:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801f03:	39 c2                	cmp    %eax,%edx
  801f05:	77 d1                	ja     801ed8 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801f07:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f0a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801f0d:	74 14                	je     801f23 <CheckWSWithoutLastIndex+0x159>
		panic(
  801f0f:	83 ec 04             	sub    $0x4,%esp
  801f12:	68 f0 26 80 00       	push   $0x8026f0
  801f17:	6a 44                	push   $0x44
  801f19:	68 90 26 80 00       	push   $0x802690
  801f1e:	e8 35 fe ff ff       	call   801d58 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801f23:	90                   	nop
  801f24:	c9                   	leave  
  801f25:	c3                   	ret    
  801f26:	66 90                	xchg   %ax,%ax

00801f28 <__udivdi3>:
  801f28:	55                   	push   %ebp
  801f29:	57                   	push   %edi
  801f2a:	56                   	push   %esi
  801f2b:	53                   	push   %ebx
  801f2c:	83 ec 1c             	sub    $0x1c,%esp
  801f2f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f33:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801f37:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f3b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801f3f:	89 ca                	mov    %ecx,%edx
  801f41:	89 f8                	mov    %edi,%eax
  801f43:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f47:	85 f6                	test   %esi,%esi
  801f49:	75 2d                	jne    801f78 <__udivdi3+0x50>
  801f4b:	39 cf                	cmp    %ecx,%edi
  801f4d:	77 65                	ja     801fb4 <__udivdi3+0x8c>
  801f4f:	89 fd                	mov    %edi,%ebp
  801f51:	85 ff                	test   %edi,%edi
  801f53:	75 0b                	jne    801f60 <__udivdi3+0x38>
  801f55:	b8 01 00 00 00       	mov    $0x1,%eax
  801f5a:	31 d2                	xor    %edx,%edx
  801f5c:	f7 f7                	div    %edi
  801f5e:	89 c5                	mov    %eax,%ebp
  801f60:	31 d2                	xor    %edx,%edx
  801f62:	89 c8                	mov    %ecx,%eax
  801f64:	f7 f5                	div    %ebp
  801f66:	89 c1                	mov    %eax,%ecx
  801f68:	89 d8                	mov    %ebx,%eax
  801f6a:	f7 f5                	div    %ebp
  801f6c:	89 cf                	mov    %ecx,%edi
  801f6e:	89 fa                	mov    %edi,%edx
  801f70:	83 c4 1c             	add    $0x1c,%esp
  801f73:	5b                   	pop    %ebx
  801f74:	5e                   	pop    %esi
  801f75:	5f                   	pop    %edi
  801f76:	5d                   	pop    %ebp
  801f77:	c3                   	ret    
  801f78:	39 ce                	cmp    %ecx,%esi
  801f7a:	77 28                	ja     801fa4 <__udivdi3+0x7c>
  801f7c:	0f bd fe             	bsr    %esi,%edi
  801f7f:	83 f7 1f             	xor    $0x1f,%edi
  801f82:	75 40                	jne    801fc4 <__udivdi3+0x9c>
  801f84:	39 ce                	cmp    %ecx,%esi
  801f86:	72 0a                	jb     801f92 <__udivdi3+0x6a>
  801f88:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f8c:	0f 87 9e 00 00 00    	ja     802030 <__udivdi3+0x108>
  801f92:	b8 01 00 00 00       	mov    $0x1,%eax
  801f97:	89 fa                	mov    %edi,%edx
  801f99:	83 c4 1c             	add    $0x1c,%esp
  801f9c:	5b                   	pop    %ebx
  801f9d:	5e                   	pop    %esi
  801f9e:	5f                   	pop    %edi
  801f9f:	5d                   	pop    %ebp
  801fa0:	c3                   	ret    
  801fa1:	8d 76 00             	lea    0x0(%esi),%esi
  801fa4:	31 ff                	xor    %edi,%edi
  801fa6:	31 c0                	xor    %eax,%eax
  801fa8:	89 fa                	mov    %edi,%edx
  801faa:	83 c4 1c             	add    $0x1c,%esp
  801fad:	5b                   	pop    %ebx
  801fae:	5e                   	pop    %esi
  801faf:	5f                   	pop    %edi
  801fb0:	5d                   	pop    %ebp
  801fb1:	c3                   	ret    
  801fb2:	66 90                	xchg   %ax,%ax
  801fb4:	89 d8                	mov    %ebx,%eax
  801fb6:	f7 f7                	div    %edi
  801fb8:	31 ff                	xor    %edi,%edi
  801fba:	89 fa                	mov    %edi,%edx
  801fbc:	83 c4 1c             	add    $0x1c,%esp
  801fbf:	5b                   	pop    %ebx
  801fc0:	5e                   	pop    %esi
  801fc1:	5f                   	pop    %edi
  801fc2:	5d                   	pop    %ebp
  801fc3:	c3                   	ret    
  801fc4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801fc9:	89 eb                	mov    %ebp,%ebx
  801fcb:	29 fb                	sub    %edi,%ebx
  801fcd:	89 f9                	mov    %edi,%ecx
  801fcf:	d3 e6                	shl    %cl,%esi
  801fd1:	89 c5                	mov    %eax,%ebp
  801fd3:	88 d9                	mov    %bl,%cl
  801fd5:	d3 ed                	shr    %cl,%ebp
  801fd7:	89 e9                	mov    %ebp,%ecx
  801fd9:	09 f1                	or     %esi,%ecx
  801fdb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801fdf:	89 f9                	mov    %edi,%ecx
  801fe1:	d3 e0                	shl    %cl,%eax
  801fe3:	89 c5                	mov    %eax,%ebp
  801fe5:	89 d6                	mov    %edx,%esi
  801fe7:	88 d9                	mov    %bl,%cl
  801fe9:	d3 ee                	shr    %cl,%esi
  801feb:	89 f9                	mov    %edi,%ecx
  801fed:	d3 e2                	shl    %cl,%edx
  801fef:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ff3:	88 d9                	mov    %bl,%cl
  801ff5:	d3 e8                	shr    %cl,%eax
  801ff7:	09 c2                	or     %eax,%edx
  801ff9:	89 d0                	mov    %edx,%eax
  801ffb:	89 f2                	mov    %esi,%edx
  801ffd:	f7 74 24 0c          	divl   0xc(%esp)
  802001:	89 d6                	mov    %edx,%esi
  802003:	89 c3                	mov    %eax,%ebx
  802005:	f7 e5                	mul    %ebp
  802007:	39 d6                	cmp    %edx,%esi
  802009:	72 19                	jb     802024 <__udivdi3+0xfc>
  80200b:	74 0b                	je     802018 <__udivdi3+0xf0>
  80200d:	89 d8                	mov    %ebx,%eax
  80200f:	31 ff                	xor    %edi,%edi
  802011:	e9 58 ff ff ff       	jmp    801f6e <__udivdi3+0x46>
  802016:	66 90                	xchg   %ax,%ax
  802018:	8b 54 24 08          	mov    0x8(%esp),%edx
  80201c:	89 f9                	mov    %edi,%ecx
  80201e:	d3 e2                	shl    %cl,%edx
  802020:	39 c2                	cmp    %eax,%edx
  802022:	73 e9                	jae    80200d <__udivdi3+0xe5>
  802024:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802027:	31 ff                	xor    %edi,%edi
  802029:	e9 40 ff ff ff       	jmp    801f6e <__udivdi3+0x46>
  80202e:	66 90                	xchg   %ax,%ax
  802030:	31 c0                	xor    %eax,%eax
  802032:	e9 37 ff ff ff       	jmp    801f6e <__udivdi3+0x46>
  802037:	90                   	nop

00802038 <__umoddi3>:
  802038:	55                   	push   %ebp
  802039:	57                   	push   %edi
  80203a:	56                   	push   %esi
  80203b:	53                   	push   %ebx
  80203c:	83 ec 1c             	sub    $0x1c,%esp
  80203f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802043:	8b 74 24 34          	mov    0x34(%esp),%esi
  802047:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80204b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80204f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802053:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802057:	89 f3                	mov    %esi,%ebx
  802059:	89 fa                	mov    %edi,%edx
  80205b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80205f:	89 34 24             	mov    %esi,(%esp)
  802062:	85 c0                	test   %eax,%eax
  802064:	75 1a                	jne    802080 <__umoddi3+0x48>
  802066:	39 f7                	cmp    %esi,%edi
  802068:	0f 86 a2 00 00 00    	jbe    802110 <__umoddi3+0xd8>
  80206e:	89 c8                	mov    %ecx,%eax
  802070:	89 f2                	mov    %esi,%edx
  802072:	f7 f7                	div    %edi
  802074:	89 d0                	mov    %edx,%eax
  802076:	31 d2                	xor    %edx,%edx
  802078:	83 c4 1c             	add    $0x1c,%esp
  80207b:	5b                   	pop    %ebx
  80207c:	5e                   	pop    %esi
  80207d:	5f                   	pop    %edi
  80207e:	5d                   	pop    %ebp
  80207f:	c3                   	ret    
  802080:	39 f0                	cmp    %esi,%eax
  802082:	0f 87 ac 00 00 00    	ja     802134 <__umoddi3+0xfc>
  802088:	0f bd e8             	bsr    %eax,%ebp
  80208b:	83 f5 1f             	xor    $0x1f,%ebp
  80208e:	0f 84 ac 00 00 00    	je     802140 <__umoddi3+0x108>
  802094:	bf 20 00 00 00       	mov    $0x20,%edi
  802099:	29 ef                	sub    %ebp,%edi
  80209b:	89 fe                	mov    %edi,%esi
  80209d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8020a1:	89 e9                	mov    %ebp,%ecx
  8020a3:	d3 e0                	shl    %cl,%eax
  8020a5:	89 d7                	mov    %edx,%edi
  8020a7:	89 f1                	mov    %esi,%ecx
  8020a9:	d3 ef                	shr    %cl,%edi
  8020ab:	09 c7                	or     %eax,%edi
  8020ad:	89 e9                	mov    %ebp,%ecx
  8020af:	d3 e2                	shl    %cl,%edx
  8020b1:	89 14 24             	mov    %edx,(%esp)
  8020b4:	89 d8                	mov    %ebx,%eax
  8020b6:	d3 e0                	shl    %cl,%eax
  8020b8:	89 c2                	mov    %eax,%edx
  8020ba:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020be:	d3 e0                	shl    %cl,%eax
  8020c0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8020c4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020c8:	89 f1                	mov    %esi,%ecx
  8020ca:	d3 e8                	shr    %cl,%eax
  8020cc:	09 d0                	or     %edx,%eax
  8020ce:	d3 eb                	shr    %cl,%ebx
  8020d0:	89 da                	mov    %ebx,%edx
  8020d2:	f7 f7                	div    %edi
  8020d4:	89 d3                	mov    %edx,%ebx
  8020d6:	f7 24 24             	mull   (%esp)
  8020d9:	89 c6                	mov    %eax,%esi
  8020db:	89 d1                	mov    %edx,%ecx
  8020dd:	39 d3                	cmp    %edx,%ebx
  8020df:	0f 82 87 00 00 00    	jb     80216c <__umoddi3+0x134>
  8020e5:	0f 84 91 00 00 00    	je     80217c <__umoddi3+0x144>
  8020eb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8020ef:	29 f2                	sub    %esi,%edx
  8020f1:	19 cb                	sbb    %ecx,%ebx
  8020f3:	89 d8                	mov    %ebx,%eax
  8020f5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8020f9:	d3 e0                	shl    %cl,%eax
  8020fb:	89 e9                	mov    %ebp,%ecx
  8020fd:	d3 ea                	shr    %cl,%edx
  8020ff:	09 d0                	or     %edx,%eax
  802101:	89 e9                	mov    %ebp,%ecx
  802103:	d3 eb                	shr    %cl,%ebx
  802105:	89 da                	mov    %ebx,%edx
  802107:	83 c4 1c             	add    $0x1c,%esp
  80210a:	5b                   	pop    %ebx
  80210b:	5e                   	pop    %esi
  80210c:	5f                   	pop    %edi
  80210d:	5d                   	pop    %ebp
  80210e:	c3                   	ret    
  80210f:	90                   	nop
  802110:	89 fd                	mov    %edi,%ebp
  802112:	85 ff                	test   %edi,%edi
  802114:	75 0b                	jne    802121 <__umoddi3+0xe9>
  802116:	b8 01 00 00 00       	mov    $0x1,%eax
  80211b:	31 d2                	xor    %edx,%edx
  80211d:	f7 f7                	div    %edi
  80211f:	89 c5                	mov    %eax,%ebp
  802121:	89 f0                	mov    %esi,%eax
  802123:	31 d2                	xor    %edx,%edx
  802125:	f7 f5                	div    %ebp
  802127:	89 c8                	mov    %ecx,%eax
  802129:	f7 f5                	div    %ebp
  80212b:	89 d0                	mov    %edx,%eax
  80212d:	e9 44 ff ff ff       	jmp    802076 <__umoddi3+0x3e>
  802132:	66 90                	xchg   %ax,%ax
  802134:	89 c8                	mov    %ecx,%eax
  802136:	89 f2                	mov    %esi,%edx
  802138:	83 c4 1c             	add    $0x1c,%esp
  80213b:	5b                   	pop    %ebx
  80213c:	5e                   	pop    %esi
  80213d:	5f                   	pop    %edi
  80213e:	5d                   	pop    %ebp
  80213f:	c3                   	ret    
  802140:	3b 04 24             	cmp    (%esp),%eax
  802143:	72 06                	jb     80214b <__umoddi3+0x113>
  802145:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802149:	77 0f                	ja     80215a <__umoddi3+0x122>
  80214b:	89 f2                	mov    %esi,%edx
  80214d:	29 f9                	sub    %edi,%ecx
  80214f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802153:	89 14 24             	mov    %edx,(%esp)
  802156:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80215a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80215e:	8b 14 24             	mov    (%esp),%edx
  802161:	83 c4 1c             	add    $0x1c,%esp
  802164:	5b                   	pop    %ebx
  802165:	5e                   	pop    %esi
  802166:	5f                   	pop    %edi
  802167:	5d                   	pop    %ebp
  802168:	c3                   	ret    
  802169:	8d 76 00             	lea    0x0(%esi),%esi
  80216c:	2b 04 24             	sub    (%esp),%eax
  80216f:	19 fa                	sbb    %edi,%edx
  802171:	89 d1                	mov    %edx,%ecx
  802173:	89 c6                	mov    %eax,%esi
  802175:	e9 71 ff ff ff       	jmp    8020eb <__umoddi3+0xb3>
  80217a:	66 90                	xchg   %ax,%ax
  80217c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802180:	72 ea                	jb     80216c <__umoddi3+0x134>
  802182:	89 d9                	mov    %ebx,%ecx
  802184:	e9 62 ff ff ff       	jmp    8020eb <__umoddi3+0xb3>
