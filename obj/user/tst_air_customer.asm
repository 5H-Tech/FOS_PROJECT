
obj/user/tst_air_customer:     file format elf32-i386


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
  800031:	e8 dc 03 00 00       	call   800412 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>
#include <user/air.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 8c 01 00 00    	sub    $0x18c,%esp
	int32 parentenvID = sys_getparentenvid();
  800044:	e8 a1 17 00 00       	call   8017ea <sys_getparentenvid>
  800049:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	char _customers[] = "customers";
  80004c:	8d 45 c2             	lea    -0x3e(%ebp),%eax
  80004f:	bb 09 22 80 00       	mov    $0x802209,%ebx
  800054:	ba 0a 00 00 00       	mov    $0xa,%edx
  800059:	89 c7                	mov    %eax,%edi
  80005b:	89 de                	mov    %ebx,%esi
  80005d:	89 d1                	mov    %edx,%ecx
  80005f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custCounter[] = "custCounter";
  800061:	8d 45 b6             	lea    -0x4a(%ebp),%eax
  800064:	bb 13 22 80 00       	mov    $0x802213,%ebx
  800069:	ba 03 00 00 00       	mov    $0x3,%edx
  80006e:	89 c7                	mov    %eax,%edi
  800070:	89 de                	mov    %ebx,%esi
  800072:	89 d1                	mov    %edx,%ecx
  800074:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1Counter[] = "flight1Counter";
  800076:	8d 45 a7             	lea    -0x59(%ebp),%eax
  800079:	bb 1f 22 80 00       	mov    $0x80221f,%ebx
  80007e:	ba 0f 00 00 00       	mov    $0xf,%edx
  800083:	89 c7                	mov    %eax,%edi
  800085:	89 de                	mov    %ebx,%esi
  800087:	89 d1                	mov    %edx,%ecx
  800089:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2Counter[] = "flight2Counter";
  80008b:	8d 45 98             	lea    -0x68(%ebp),%eax
  80008e:	bb 2e 22 80 00       	mov    $0x80222e,%ebx
  800093:	ba 0f 00 00 00       	mov    $0xf,%edx
  800098:	89 c7                	mov    %eax,%edi
  80009a:	89 de                	mov    %ebx,%esi
  80009c:	89 d1                	mov    %edx,%ecx
  80009e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Counter[] = "flightBooked1Counter";
  8000a0:	8d 45 83             	lea    -0x7d(%ebp),%eax
  8000a3:	bb 3d 22 80 00       	mov    $0x80223d,%ebx
  8000a8:	ba 15 00 00 00       	mov    $0x15,%edx
  8000ad:	89 c7                	mov    %eax,%edi
  8000af:	89 de                	mov    %ebx,%esi
  8000b1:	89 d1                	mov    %edx,%ecx
  8000b3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Counter[] = "flightBooked2Counter";
  8000b5:	8d 85 6e ff ff ff    	lea    -0x92(%ebp),%eax
  8000bb:	bb 52 22 80 00       	mov    $0x802252,%ebx
  8000c0:	ba 15 00 00 00       	mov    $0x15,%edx
  8000c5:	89 c7                	mov    %eax,%edi
  8000c7:	89 de                	mov    %ebx,%esi
  8000c9:	89 d1                	mov    %edx,%ecx
  8000cb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Arr[] = "flightBooked1Arr";
  8000cd:	8d 85 5d ff ff ff    	lea    -0xa3(%ebp),%eax
  8000d3:	bb 67 22 80 00       	mov    $0x802267,%ebx
  8000d8:	ba 11 00 00 00       	mov    $0x11,%edx
  8000dd:	89 c7                	mov    %eax,%edi
  8000df:	89 de                	mov    %ebx,%esi
  8000e1:	89 d1                	mov    %edx,%ecx
  8000e3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Arr[] = "flightBooked2Arr";
  8000e5:	8d 85 4c ff ff ff    	lea    -0xb4(%ebp),%eax
  8000eb:	bb 78 22 80 00       	mov    $0x802278,%ebx
  8000f0:	ba 11 00 00 00       	mov    $0x11,%edx
  8000f5:	89 c7                	mov    %eax,%edi
  8000f7:	89 de                	mov    %ebx,%esi
  8000f9:	89 d1                	mov    %edx,%ecx
  8000fb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _cust_ready_queue[] = "cust_ready_queue";
  8000fd:	8d 85 3b ff ff ff    	lea    -0xc5(%ebp),%eax
  800103:	bb 89 22 80 00       	mov    $0x802289,%ebx
  800108:	ba 11 00 00 00       	mov    $0x11,%edx
  80010d:	89 c7                	mov    %eax,%edi
  80010f:	89 de                	mov    %ebx,%esi
  800111:	89 d1                	mov    %edx,%ecx
  800113:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_in[] = "queue_in";
  800115:	8d 85 32 ff ff ff    	lea    -0xce(%ebp),%eax
  80011b:	bb 9a 22 80 00       	mov    $0x80229a,%ebx
  800120:	ba 09 00 00 00       	mov    $0x9,%edx
  800125:	89 c7                	mov    %eax,%edi
  800127:	89 de                	mov    %ebx,%esi
  800129:	89 d1                	mov    %edx,%ecx
  80012b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_out[] = "queue_out";
  80012d:	8d 85 28 ff ff ff    	lea    -0xd8(%ebp),%eax
  800133:	bb a3 22 80 00       	mov    $0x8022a3,%ebx
  800138:	ba 0a 00 00 00       	mov    $0xa,%edx
  80013d:	89 c7                	mov    %eax,%edi
  80013f:	89 de                	mov    %ebx,%esi
  800141:	89 d1                	mov    %edx,%ecx
  800143:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _cust_ready[] = "cust_ready";
  800145:	8d 85 1d ff ff ff    	lea    -0xe3(%ebp),%eax
  80014b:	bb ad 22 80 00       	mov    $0x8022ad,%ebx
  800150:	ba 0b 00 00 00       	mov    $0xb,%edx
  800155:	89 c7                	mov    %eax,%edi
  800157:	89 de                	mov    %ebx,%esi
  800159:	89 d1                	mov    %edx,%ecx
  80015b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custQueueCS[] = "custQueueCS";
  80015d:	8d 85 11 ff ff ff    	lea    -0xef(%ebp),%eax
  800163:	bb b8 22 80 00       	mov    $0x8022b8,%ebx
  800168:	ba 03 00 00 00       	mov    $0x3,%edx
  80016d:	89 c7                	mov    %eax,%edi
  80016f:	89 de                	mov    %ebx,%esi
  800171:	89 d1                	mov    %edx,%ecx
  800173:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1CS[] = "flight1CS";
  800175:	8d 85 07 ff ff ff    	lea    -0xf9(%ebp),%eax
  80017b:	bb c4 22 80 00       	mov    $0x8022c4,%ebx
  800180:	ba 0a 00 00 00       	mov    $0xa,%edx
  800185:	89 c7                	mov    %eax,%edi
  800187:	89 de                	mov    %ebx,%esi
  800189:	89 d1                	mov    %edx,%ecx
  80018b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2CS[] = "flight2CS";
  80018d:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800193:	bb ce 22 80 00       	mov    $0x8022ce,%ebx
  800198:	ba 0a 00 00 00       	mov    $0xa,%edx
  80019d:	89 c7                	mov    %eax,%edi
  80019f:	89 de                	mov    %ebx,%esi
  8001a1:	89 d1                	mov    %edx,%ecx
  8001a3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _clerk[] = "clerk";
  8001a5:	c7 85 f7 fe ff ff 63 	movl   $0x72656c63,-0x109(%ebp)
  8001ac:	6c 65 72 
  8001af:	66 c7 85 fb fe ff ff 	movw   $0x6b,-0x105(%ebp)
  8001b6:	6b 00 
	char _custCounterCS[] = "custCounterCS";
  8001b8:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8001be:	bb d8 22 80 00       	mov    $0x8022d8,%ebx
  8001c3:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001c8:	89 c7                	mov    %eax,%edi
  8001ca:	89 de                	mov    %ebx,%esi
  8001cc:	89 d1                	mov    %edx,%ecx
  8001ce:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custTerminated[] = "custTerminated";
  8001d0:	8d 85 da fe ff ff    	lea    -0x126(%ebp),%eax
  8001d6:	bb e6 22 80 00       	mov    $0x8022e6,%ebx
  8001db:	ba 0f 00 00 00       	mov    $0xf,%edx
  8001e0:	89 c7                	mov    %eax,%edi
  8001e2:	89 de                	mov    %ebx,%esi
  8001e4:	89 d1                	mov    %edx,%ecx
  8001e6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _taircl[] = "taircl";
  8001e8:	8d 85 d3 fe ff ff    	lea    -0x12d(%ebp),%eax
  8001ee:	bb f5 22 80 00       	mov    $0x8022f5,%ebx
  8001f3:	ba 07 00 00 00       	mov    $0x7,%edx
  8001f8:	89 c7                	mov    %eax,%edi
  8001fa:	89 de                	mov    %ebx,%esi
  8001fc:	89 d1                	mov    %edx,%ecx
  8001fe:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _taircu[] = "taircu";
  800200:	8d 85 cc fe ff ff    	lea    -0x134(%ebp),%eax
  800206:	bb fc 22 80 00       	mov    $0x8022fc,%ebx
  80020b:	ba 07 00 00 00       	mov    $0x7,%edx
  800210:	89 c7                	mov    %eax,%edi
  800212:	89 de                	mov    %ebx,%esi
  800214:	89 d1                	mov    %edx,%ecx
  800216:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	// Get the shared variables from the main program ***********************************

	struct Customer * customers = sget(parentenvID, _customers);
  800218:	83 ec 08             	sub    $0x8,%esp
  80021b:	8d 45 c2             	lea    -0x3e(%ebp),%eax
  80021e:	50                   	push   %eax
  80021f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800222:	e8 5b 14 00 00       	call   801682 <sget>
  800227:	83 c4 10             	add    $0x10,%esp
  80022a:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int* custCounter = sget(parentenvID, _custCounter);
  80022d:	83 ec 08             	sub    $0x8,%esp
  800230:	8d 45 b6             	lea    -0x4a(%ebp),%eax
  800233:	50                   	push   %eax
  800234:	ff 75 e4             	pushl  -0x1c(%ebp)
  800237:	e8 46 14 00 00       	call   801682 <sget>
  80023c:	83 c4 10             	add    $0x10,%esp
  80023f:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int* cust_ready_queue = sget(parentenvID, _cust_ready_queue);
  800242:	83 ec 08             	sub    $0x8,%esp
  800245:	8d 85 3b ff ff ff    	lea    -0xc5(%ebp),%eax
  80024b:	50                   	push   %eax
  80024c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80024f:	e8 2e 14 00 00       	call   801682 <sget>
  800254:	83 c4 10             	add    $0x10,%esp
  800257:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* queue_in = sget(parentenvID, _queue_in);
  80025a:	83 ec 08             	sub    $0x8,%esp
  80025d:	8d 85 32 ff ff ff    	lea    -0xce(%ebp),%eax
  800263:	50                   	push   %eax
  800264:	ff 75 e4             	pushl  -0x1c(%ebp)
  800267:	e8 16 14 00 00       	call   801682 <sget>
  80026c:	83 c4 10             	add    $0x10,%esp
  80026f:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	// *********************************************************************************

	int custId, flightType;
	sys_waitSemaphore(parentenvID, _custCounterCS);
  800272:	83 ec 08             	sub    $0x8,%esp
  800275:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80027b:	50                   	push   %eax
  80027c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80027f:	e8 95 17 00 00       	call   801a19 <sys_waitSemaphore>
  800284:	83 c4 10             	add    $0x10,%esp
	{
		custId = *custCounter;
  800287:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80028a:	8b 00                	mov    (%eax),%eax
  80028c:	89 45 d0             	mov    %eax,-0x30(%ebp)
		//cprintf("custCounter= %d\n", *custCounter);
		*custCounter = *custCounter +1;
  80028f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800292:	8b 00                	mov    (%eax),%eax
  800294:	8d 50 01             	lea    0x1(%eax),%edx
  800297:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80029a:	89 10                	mov    %edx,(%eax)
	}
	sys_signalSemaphore(parentenvID, _custCounterCS);
  80029c:	83 ec 08             	sub    $0x8,%esp
  80029f:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8002a5:	50                   	push   %eax
  8002a6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002a9:	e8 89 17 00 00       	call   801a37 <sys_signalSemaphore>
  8002ae:	83 c4 10             	add    $0x10,%esp

	//wait on one of the clerks
	sys_waitSemaphore(parentenvID, _clerk);
  8002b1:	83 ec 08             	sub    $0x8,%esp
  8002b4:	8d 85 f7 fe ff ff    	lea    -0x109(%ebp),%eax
  8002ba:	50                   	push   %eax
  8002bb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002be:	e8 56 17 00 00       	call   801a19 <sys_waitSemaphore>
  8002c3:	83 c4 10             	add    $0x10,%esp

	//enqueue the request
	flightType = customers[custId].flightType;
  8002c6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8002c9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002d3:	01 d0                	add    %edx,%eax
  8002d5:	8b 00                	mov    (%eax),%eax
  8002d7:	89 45 cc             	mov    %eax,-0x34(%ebp)
	sys_waitSemaphore(parentenvID, _custQueueCS);
  8002da:	83 ec 08             	sub    $0x8,%esp
  8002dd:	8d 85 11 ff ff ff    	lea    -0xef(%ebp),%eax
  8002e3:	50                   	push   %eax
  8002e4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002e7:	e8 2d 17 00 00       	call   801a19 <sys_waitSemaphore>
  8002ec:	83 c4 10             	add    $0x10,%esp
	{
		cust_ready_queue[*queue_in] = custId;
  8002ef:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8002f2:	8b 00                	mov    (%eax),%eax
  8002f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002fb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002fe:	01 c2                	add    %eax,%edx
  800300:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800303:	89 02                	mov    %eax,(%edx)
		*queue_in = *queue_in +1;
  800305:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800308:	8b 00                	mov    (%eax),%eax
  80030a:	8d 50 01             	lea    0x1(%eax),%edx
  80030d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800310:	89 10                	mov    %edx,(%eax)
	}
	sys_signalSemaphore(parentenvID, _custQueueCS);
  800312:	83 ec 08             	sub    $0x8,%esp
  800315:	8d 85 11 ff ff ff    	lea    -0xef(%ebp),%eax
  80031b:	50                   	push   %eax
  80031c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80031f:	e8 13 17 00 00       	call   801a37 <sys_signalSemaphore>
  800324:	83 c4 10             	add    $0x10,%esp

	//signal ready
	sys_signalSemaphore(parentenvID, _cust_ready);
  800327:	83 ec 08             	sub    $0x8,%esp
  80032a:	8d 85 1d ff ff ff    	lea    -0xe3(%ebp),%eax
  800330:	50                   	push   %eax
  800331:	ff 75 e4             	pushl  -0x1c(%ebp)
  800334:	e8 fe 16 00 00       	call   801a37 <sys_signalSemaphore>
  800339:	83 c4 10             	add    $0x10,%esp

	//wait on finished
	char prefix[30]="cust_finished";
  80033c:	8d 85 ae fe ff ff    	lea    -0x152(%ebp),%eax
  800342:	bb 03 23 80 00       	mov    $0x802303,%ebx
  800347:	ba 0e 00 00 00       	mov    $0xe,%edx
  80034c:	89 c7                	mov    %eax,%edi
  80034e:	89 de                	mov    %ebx,%esi
  800350:	89 d1                	mov    %edx,%ecx
  800352:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800354:	8d 95 bc fe ff ff    	lea    -0x144(%ebp),%edx
  80035a:	b9 04 00 00 00       	mov    $0x4,%ecx
  80035f:	b8 00 00 00 00       	mov    $0x0,%eax
  800364:	89 d7                	mov    %edx,%edi
  800366:	f3 ab                	rep stos %eax,%es:(%edi)
	char id[5]; char sname[50];
	ltostr(custId, id);
  800368:	83 ec 08             	sub    $0x8,%esp
  80036b:	8d 85 a9 fe ff ff    	lea    -0x157(%ebp),%eax
  800371:	50                   	push   %eax
  800372:	ff 75 d0             	pushl  -0x30(%ebp)
  800375:	e8 d9 0d 00 00       	call   801153 <ltostr>
  80037a:	83 c4 10             	add    $0x10,%esp
	strcconcat(prefix, id, sname);
  80037d:	83 ec 04             	sub    $0x4,%esp
  800380:	8d 85 77 fe ff ff    	lea    -0x189(%ebp),%eax
  800386:	50                   	push   %eax
  800387:	8d 85 a9 fe ff ff    	lea    -0x157(%ebp),%eax
  80038d:	50                   	push   %eax
  80038e:	8d 85 ae fe ff ff    	lea    -0x152(%ebp),%eax
  800394:	50                   	push   %eax
  800395:	e8 b1 0e 00 00       	call   80124b <strcconcat>
  80039a:	83 c4 10             	add    $0x10,%esp
	sys_waitSemaphore(parentenvID, sname);
  80039d:	83 ec 08             	sub    $0x8,%esp
  8003a0:	8d 85 77 fe ff ff    	lea    -0x189(%ebp),%eax
  8003a6:	50                   	push   %eax
  8003a7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8003aa:	e8 6a 16 00 00       	call   801a19 <sys_waitSemaphore>
  8003af:	83 c4 10             	add    $0x10,%esp

	//print the customer status
	if(customers[custId].booked == 1)
  8003b2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003b5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8003bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003bf:	01 d0                	add    %edx,%eax
  8003c1:	8b 40 04             	mov    0x4(%eax),%eax
  8003c4:	83 f8 01             	cmp    $0x1,%eax
  8003c7:	75 18                	jne    8003e1 <_main+0x3a9>
	{
		cprintf("cust %d: finished (BOOKED flight %d) \n", custId, flightType);
  8003c9:	83 ec 04             	sub    $0x4,%esp
  8003cc:	ff 75 cc             	pushl  -0x34(%ebp)
  8003cf:	ff 75 d0             	pushl  -0x30(%ebp)
  8003d2:	68 c0 21 80 00       	push   $0x8021c0
  8003d7:	e8 4f 02 00 00       	call   80062b <cprintf>
  8003dc:	83 c4 10             	add    $0x10,%esp
  8003df:	eb 13                	jmp    8003f4 <_main+0x3bc>
	}
	else
	{
		cprintf("cust %d: finished (NOT BOOKED) \n", custId);
  8003e1:	83 ec 08             	sub    $0x8,%esp
  8003e4:	ff 75 d0             	pushl  -0x30(%ebp)
  8003e7:	68 e8 21 80 00       	push   $0x8021e8
  8003ec:	e8 3a 02 00 00       	call   80062b <cprintf>
  8003f1:	83 c4 10             	add    $0x10,%esp
	}

	//customer is terminated
	sys_signalSemaphore(parentenvID, _custTerminated);
  8003f4:	83 ec 08             	sub    $0x8,%esp
  8003f7:	8d 85 da fe ff ff    	lea    -0x126(%ebp),%eax
  8003fd:	50                   	push   %eax
  8003fe:	ff 75 e4             	pushl  -0x1c(%ebp)
  800401:	e8 31 16 00 00       	call   801a37 <sys_signalSemaphore>
  800406:	83 c4 10             	add    $0x10,%esp

	return;
  800409:	90                   	nop
}
  80040a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80040d:	5b                   	pop    %ebx
  80040e:	5e                   	pop    %esi
  80040f:	5f                   	pop    %edi
  800410:	5d                   	pop    %ebp
  800411:	c3                   	ret    

00800412 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800412:	55                   	push   %ebp
  800413:	89 e5                	mov    %esp,%ebp
  800415:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800418:	e8 b4 13 00 00       	call   8017d1 <sys_getenvindex>
  80041d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800420:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800423:	89 d0                	mov    %edx,%eax
  800425:	c1 e0 03             	shl    $0x3,%eax
  800428:	01 d0                	add    %edx,%eax
  80042a:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800431:	01 c8                	add    %ecx,%eax
  800433:	01 c0                	add    %eax,%eax
  800435:	01 d0                	add    %edx,%eax
  800437:	01 c0                	add    %eax,%eax
  800439:	01 d0                	add    %edx,%eax
  80043b:	89 c2                	mov    %eax,%edx
  80043d:	c1 e2 05             	shl    $0x5,%edx
  800440:	29 c2                	sub    %eax,%edx
  800442:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800449:	89 c2                	mov    %eax,%edx
  80044b:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800451:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800456:	a1 20 30 80 00       	mov    0x803020,%eax
  80045b:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800461:	84 c0                	test   %al,%al
  800463:	74 0f                	je     800474 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800465:	a1 20 30 80 00       	mov    0x803020,%eax
  80046a:	05 40 3c 01 00       	add    $0x13c40,%eax
  80046f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800474:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800478:	7e 0a                	jle    800484 <libmain+0x72>
		binaryname = argv[0];
  80047a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047d:	8b 00                	mov    (%eax),%eax
  80047f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800484:	83 ec 08             	sub    $0x8,%esp
  800487:	ff 75 0c             	pushl  0xc(%ebp)
  80048a:	ff 75 08             	pushl  0x8(%ebp)
  80048d:	e8 a6 fb ff ff       	call   800038 <_main>
  800492:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800495:	e8 d2 14 00 00       	call   80196c <sys_disable_interrupt>
	cprintf("**************************************\n");
  80049a:	83 ec 0c             	sub    $0xc,%esp
  80049d:	68 3c 23 80 00       	push   $0x80233c
  8004a2:	e8 84 01 00 00       	call   80062b <cprintf>
  8004a7:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8004aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8004af:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8004b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ba:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8004c0:	83 ec 04             	sub    $0x4,%esp
  8004c3:	52                   	push   %edx
  8004c4:	50                   	push   %eax
  8004c5:	68 64 23 80 00       	push   $0x802364
  8004ca:	e8 5c 01 00 00       	call   80062b <cprintf>
  8004cf:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8004d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d7:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8004dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8004e2:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8004e8:	83 ec 04             	sub    $0x4,%esp
  8004eb:	52                   	push   %edx
  8004ec:	50                   	push   %eax
  8004ed:	68 8c 23 80 00       	push   $0x80238c
  8004f2:	e8 34 01 00 00       	call   80062b <cprintf>
  8004f7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8004fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ff:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800505:	83 ec 08             	sub    $0x8,%esp
  800508:	50                   	push   %eax
  800509:	68 cd 23 80 00       	push   $0x8023cd
  80050e:	e8 18 01 00 00       	call   80062b <cprintf>
  800513:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800516:	83 ec 0c             	sub    $0xc,%esp
  800519:	68 3c 23 80 00       	push   $0x80233c
  80051e:	e8 08 01 00 00       	call   80062b <cprintf>
  800523:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800526:	e8 5b 14 00 00       	call   801986 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80052b:	e8 19 00 00 00       	call   800549 <exit>
}
  800530:	90                   	nop
  800531:	c9                   	leave  
  800532:	c3                   	ret    

00800533 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800533:	55                   	push   %ebp
  800534:	89 e5                	mov    %esp,%ebp
  800536:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800539:	83 ec 0c             	sub    $0xc,%esp
  80053c:	6a 00                	push   $0x0
  80053e:	e8 5a 12 00 00       	call   80179d <sys_env_destroy>
  800543:	83 c4 10             	add    $0x10,%esp
}
  800546:	90                   	nop
  800547:	c9                   	leave  
  800548:	c3                   	ret    

00800549 <exit>:

void
exit(void)
{
  800549:	55                   	push   %ebp
  80054a:	89 e5                	mov    %esp,%ebp
  80054c:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80054f:	e8 af 12 00 00       	call   801803 <sys_env_exit>
}
  800554:	90                   	nop
  800555:	c9                   	leave  
  800556:	c3                   	ret    

00800557 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800557:	55                   	push   %ebp
  800558:	89 e5                	mov    %esp,%ebp
  80055a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80055d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800560:	8b 00                	mov    (%eax),%eax
  800562:	8d 48 01             	lea    0x1(%eax),%ecx
  800565:	8b 55 0c             	mov    0xc(%ebp),%edx
  800568:	89 0a                	mov    %ecx,(%edx)
  80056a:	8b 55 08             	mov    0x8(%ebp),%edx
  80056d:	88 d1                	mov    %dl,%cl
  80056f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800572:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800576:	8b 45 0c             	mov    0xc(%ebp),%eax
  800579:	8b 00                	mov    (%eax),%eax
  80057b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800580:	75 2c                	jne    8005ae <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800582:	a0 24 30 80 00       	mov    0x803024,%al
  800587:	0f b6 c0             	movzbl %al,%eax
  80058a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80058d:	8b 12                	mov    (%edx),%edx
  80058f:	89 d1                	mov    %edx,%ecx
  800591:	8b 55 0c             	mov    0xc(%ebp),%edx
  800594:	83 c2 08             	add    $0x8,%edx
  800597:	83 ec 04             	sub    $0x4,%esp
  80059a:	50                   	push   %eax
  80059b:	51                   	push   %ecx
  80059c:	52                   	push   %edx
  80059d:	e8 b9 11 00 00       	call   80175b <sys_cputs>
  8005a2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8005a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8005ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005b1:	8b 40 04             	mov    0x4(%eax),%eax
  8005b4:	8d 50 01             	lea    0x1(%eax),%edx
  8005b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ba:	89 50 04             	mov    %edx,0x4(%eax)
}
  8005bd:	90                   	nop
  8005be:	c9                   	leave  
  8005bf:	c3                   	ret    

008005c0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8005c0:	55                   	push   %ebp
  8005c1:	89 e5                	mov    %esp,%ebp
  8005c3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8005c9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8005d0:	00 00 00 
	b.cnt = 0;
  8005d3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8005da:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8005dd:	ff 75 0c             	pushl  0xc(%ebp)
  8005e0:	ff 75 08             	pushl  0x8(%ebp)
  8005e3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005e9:	50                   	push   %eax
  8005ea:	68 57 05 80 00       	push   $0x800557
  8005ef:	e8 11 02 00 00       	call   800805 <vprintfmt>
  8005f4:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8005f7:	a0 24 30 80 00       	mov    0x803024,%al
  8005fc:	0f b6 c0             	movzbl %al,%eax
  8005ff:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800605:	83 ec 04             	sub    $0x4,%esp
  800608:	50                   	push   %eax
  800609:	52                   	push   %edx
  80060a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800610:	83 c0 08             	add    $0x8,%eax
  800613:	50                   	push   %eax
  800614:	e8 42 11 00 00       	call   80175b <sys_cputs>
  800619:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80061c:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800623:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800629:	c9                   	leave  
  80062a:	c3                   	ret    

0080062b <cprintf>:

int cprintf(const char *fmt, ...) {
  80062b:	55                   	push   %ebp
  80062c:	89 e5                	mov    %esp,%ebp
  80062e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800631:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800638:	8d 45 0c             	lea    0xc(%ebp),%eax
  80063b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80063e:	8b 45 08             	mov    0x8(%ebp),%eax
  800641:	83 ec 08             	sub    $0x8,%esp
  800644:	ff 75 f4             	pushl  -0xc(%ebp)
  800647:	50                   	push   %eax
  800648:	e8 73 ff ff ff       	call   8005c0 <vcprintf>
  80064d:	83 c4 10             	add    $0x10,%esp
  800650:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800653:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800656:	c9                   	leave  
  800657:	c3                   	ret    

00800658 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800658:	55                   	push   %ebp
  800659:	89 e5                	mov    %esp,%ebp
  80065b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80065e:	e8 09 13 00 00       	call   80196c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800663:	8d 45 0c             	lea    0xc(%ebp),%eax
  800666:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800669:	8b 45 08             	mov    0x8(%ebp),%eax
  80066c:	83 ec 08             	sub    $0x8,%esp
  80066f:	ff 75 f4             	pushl  -0xc(%ebp)
  800672:	50                   	push   %eax
  800673:	e8 48 ff ff ff       	call   8005c0 <vcprintf>
  800678:	83 c4 10             	add    $0x10,%esp
  80067b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80067e:	e8 03 13 00 00       	call   801986 <sys_enable_interrupt>
	return cnt;
  800683:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800686:	c9                   	leave  
  800687:	c3                   	ret    

00800688 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800688:	55                   	push   %ebp
  800689:	89 e5                	mov    %esp,%ebp
  80068b:	53                   	push   %ebx
  80068c:	83 ec 14             	sub    $0x14,%esp
  80068f:	8b 45 10             	mov    0x10(%ebp),%eax
  800692:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800695:	8b 45 14             	mov    0x14(%ebp),%eax
  800698:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80069b:	8b 45 18             	mov    0x18(%ebp),%eax
  80069e:	ba 00 00 00 00       	mov    $0x0,%edx
  8006a3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006a6:	77 55                	ja     8006fd <printnum+0x75>
  8006a8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8006ab:	72 05                	jb     8006b2 <printnum+0x2a>
  8006ad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8006b0:	77 4b                	ja     8006fd <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8006b2:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8006b5:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8006b8:	8b 45 18             	mov    0x18(%ebp),%eax
  8006bb:	ba 00 00 00 00       	mov    $0x0,%edx
  8006c0:	52                   	push   %edx
  8006c1:	50                   	push   %eax
  8006c2:	ff 75 f4             	pushl  -0xc(%ebp)
  8006c5:	ff 75 f0             	pushl  -0x10(%ebp)
  8006c8:	e8 8f 18 00 00       	call   801f5c <__udivdi3>
  8006cd:	83 c4 10             	add    $0x10,%esp
  8006d0:	83 ec 04             	sub    $0x4,%esp
  8006d3:	ff 75 20             	pushl  0x20(%ebp)
  8006d6:	53                   	push   %ebx
  8006d7:	ff 75 18             	pushl  0x18(%ebp)
  8006da:	52                   	push   %edx
  8006db:	50                   	push   %eax
  8006dc:	ff 75 0c             	pushl  0xc(%ebp)
  8006df:	ff 75 08             	pushl  0x8(%ebp)
  8006e2:	e8 a1 ff ff ff       	call   800688 <printnum>
  8006e7:	83 c4 20             	add    $0x20,%esp
  8006ea:	eb 1a                	jmp    800706 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006ec:	83 ec 08             	sub    $0x8,%esp
  8006ef:	ff 75 0c             	pushl  0xc(%ebp)
  8006f2:	ff 75 20             	pushl  0x20(%ebp)
  8006f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f8:	ff d0                	call   *%eax
  8006fa:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006fd:	ff 4d 1c             	decl   0x1c(%ebp)
  800700:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800704:	7f e6                	jg     8006ec <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800706:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800709:	bb 00 00 00 00       	mov    $0x0,%ebx
  80070e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800711:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800714:	53                   	push   %ebx
  800715:	51                   	push   %ecx
  800716:	52                   	push   %edx
  800717:	50                   	push   %eax
  800718:	e8 4f 19 00 00       	call   80206c <__umoddi3>
  80071d:	83 c4 10             	add    $0x10,%esp
  800720:	05 14 26 80 00       	add    $0x802614,%eax
  800725:	8a 00                	mov    (%eax),%al
  800727:	0f be c0             	movsbl %al,%eax
  80072a:	83 ec 08             	sub    $0x8,%esp
  80072d:	ff 75 0c             	pushl  0xc(%ebp)
  800730:	50                   	push   %eax
  800731:	8b 45 08             	mov    0x8(%ebp),%eax
  800734:	ff d0                	call   *%eax
  800736:	83 c4 10             	add    $0x10,%esp
}
  800739:	90                   	nop
  80073a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80073d:	c9                   	leave  
  80073e:	c3                   	ret    

0080073f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80073f:	55                   	push   %ebp
  800740:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800742:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800746:	7e 1c                	jle    800764 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800748:	8b 45 08             	mov    0x8(%ebp),%eax
  80074b:	8b 00                	mov    (%eax),%eax
  80074d:	8d 50 08             	lea    0x8(%eax),%edx
  800750:	8b 45 08             	mov    0x8(%ebp),%eax
  800753:	89 10                	mov    %edx,(%eax)
  800755:	8b 45 08             	mov    0x8(%ebp),%eax
  800758:	8b 00                	mov    (%eax),%eax
  80075a:	83 e8 08             	sub    $0x8,%eax
  80075d:	8b 50 04             	mov    0x4(%eax),%edx
  800760:	8b 00                	mov    (%eax),%eax
  800762:	eb 40                	jmp    8007a4 <getuint+0x65>
	else if (lflag)
  800764:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800768:	74 1e                	je     800788 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80076a:	8b 45 08             	mov    0x8(%ebp),%eax
  80076d:	8b 00                	mov    (%eax),%eax
  80076f:	8d 50 04             	lea    0x4(%eax),%edx
  800772:	8b 45 08             	mov    0x8(%ebp),%eax
  800775:	89 10                	mov    %edx,(%eax)
  800777:	8b 45 08             	mov    0x8(%ebp),%eax
  80077a:	8b 00                	mov    (%eax),%eax
  80077c:	83 e8 04             	sub    $0x4,%eax
  80077f:	8b 00                	mov    (%eax),%eax
  800781:	ba 00 00 00 00       	mov    $0x0,%edx
  800786:	eb 1c                	jmp    8007a4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800788:	8b 45 08             	mov    0x8(%ebp),%eax
  80078b:	8b 00                	mov    (%eax),%eax
  80078d:	8d 50 04             	lea    0x4(%eax),%edx
  800790:	8b 45 08             	mov    0x8(%ebp),%eax
  800793:	89 10                	mov    %edx,(%eax)
  800795:	8b 45 08             	mov    0x8(%ebp),%eax
  800798:	8b 00                	mov    (%eax),%eax
  80079a:	83 e8 04             	sub    $0x4,%eax
  80079d:	8b 00                	mov    (%eax),%eax
  80079f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8007a4:	5d                   	pop    %ebp
  8007a5:	c3                   	ret    

008007a6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8007a6:	55                   	push   %ebp
  8007a7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007a9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007ad:	7e 1c                	jle    8007cb <getint+0x25>
		return va_arg(*ap, long long);
  8007af:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b2:	8b 00                	mov    (%eax),%eax
  8007b4:	8d 50 08             	lea    0x8(%eax),%edx
  8007b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ba:	89 10                	mov    %edx,(%eax)
  8007bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bf:	8b 00                	mov    (%eax),%eax
  8007c1:	83 e8 08             	sub    $0x8,%eax
  8007c4:	8b 50 04             	mov    0x4(%eax),%edx
  8007c7:	8b 00                	mov    (%eax),%eax
  8007c9:	eb 38                	jmp    800803 <getint+0x5d>
	else if (lflag)
  8007cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007cf:	74 1a                	je     8007eb <getint+0x45>
		return va_arg(*ap, long);
  8007d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d4:	8b 00                	mov    (%eax),%eax
  8007d6:	8d 50 04             	lea    0x4(%eax),%edx
  8007d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dc:	89 10                	mov    %edx,(%eax)
  8007de:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e1:	8b 00                	mov    (%eax),%eax
  8007e3:	83 e8 04             	sub    $0x4,%eax
  8007e6:	8b 00                	mov    (%eax),%eax
  8007e8:	99                   	cltd   
  8007e9:	eb 18                	jmp    800803 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ee:	8b 00                	mov    (%eax),%eax
  8007f0:	8d 50 04             	lea    0x4(%eax),%edx
  8007f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f6:	89 10                	mov    %edx,(%eax)
  8007f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fb:	8b 00                	mov    (%eax),%eax
  8007fd:	83 e8 04             	sub    $0x4,%eax
  800800:	8b 00                	mov    (%eax),%eax
  800802:	99                   	cltd   
}
  800803:	5d                   	pop    %ebp
  800804:	c3                   	ret    

00800805 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800805:	55                   	push   %ebp
  800806:	89 e5                	mov    %esp,%ebp
  800808:	56                   	push   %esi
  800809:	53                   	push   %ebx
  80080a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80080d:	eb 17                	jmp    800826 <vprintfmt+0x21>
			if (ch == '\0')
  80080f:	85 db                	test   %ebx,%ebx
  800811:	0f 84 af 03 00 00    	je     800bc6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800817:	83 ec 08             	sub    $0x8,%esp
  80081a:	ff 75 0c             	pushl  0xc(%ebp)
  80081d:	53                   	push   %ebx
  80081e:	8b 45 08             	mov    0x8(%ebp),%eax
  800821:	ff d0                	call   *%eax
  800823:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800826:	8b 45 10             	mov    0x10(%ebp),%eax
  800829:	8d 50 01             	lea    0x1(%eax),%edx
  80082c:	89 55 10             	mov    %edx,0x10(%ebp)
  80082f:	8a 00                	mov    (%eax),%al
  800831:	0f b6 d8             	movzbl %al,%ebx
  800834:	83 fb 25             	cmp    $0x25,%ebx
  800837:	75 d6                	jne    80080f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800839:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80083d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800844:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80084b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800852:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800859:	8b 45 10             	mov    0x10(%ebp),%eax
  80085c:	8d 50 01             	lea    0x1(%eax),%edx
  80085f:	89 55 10             	mov    %edx,0x10(%ebp)
  800862:	8a 00                	mov    (%eax),%al
  800864:	0f b6 d8             	movzbl %al,%ebx
  800867:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80086a:	83 f8 55             	cmp    $0x55,%eax
  80086d:	0f 87 2b 03 00 00    	ja     800b9e <vprintfmt+0x399>
  800873:	8b 04 85 38 26 80 00 	mov    0x802638(,%eax,4),%eax
  80087a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80087c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800880:	eb d7                	jmp    800859 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800882:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800886:	eb d1                	jmp    800859 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800888:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80088f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800892:	89 d0                	mov    %edx,%eax
  800894:	c1 e0 02             	shl    $0x2,%eax
  800897:	01 d0                	add    %edx,%eax
  800899:	01 c0                	add    %eax,%eax
  80089b:	01 d8                	add    %ebx,%eax
  80089d:	83 e8 30             	sub    $0x30,%eax
  8008a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8008a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a6:	8a 00                	mov    (%eax),%al
  8008a8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8008ab:	83 fb 2f             	cmp    $0x2f,%ebx
  8008ae:	7e 3e                	jle    8008ee <vprintfmt+0xe9>
  8008b0:	83 fb 39             	cmp    $0x39,%ebx
  8008b3:	7f 39                	jg     8008ee <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008b5:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8008b8:	eb d5                	jmp    80088f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8008ba:	8b 45 14             	mov    0x14(%ebp),%eax
  8008bd:	83 c0 04             	add    $0x4,%eax
  8008c0:	89 45 14             	mov    %eax,0x14(%ebp)
  8008c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c6:	83 e8 04             	sub    $0x4,%eax
  8008c9:	8b 00                	mov    (%eax),%eax
  8008cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8008ce:	eb 1f                	jmp    8008ef <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8008d0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008d4:	79 83                	jns    800859 <vprintfmt+0x54>
				width = 0;
  8008d6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008dd:	e9 77 ff ff ff       	jmp    800859 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008e2:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008e9:	e9 6b ff ff ff       	jmp    800859 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008ee:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008ef:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008f3:	0f 89 60 ff ff ff    	jns    800859 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008fc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008ff:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800906:	e9 4e ff ff ff       	jmp    800859 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80090b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80090e:	e9 46 ff ff ff       	jmp    800859 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800913:	8b 45 14             	mov    0x14(%ebp),%eax
  800916:	83 c0 04             	add    $0x4,%eax
  800919:	89 45 14             	mov    %eax,0x14(%ebp)
  80091c:	8b 45 14             	mov    0x14(%ebp),%eax
  80091f:	83 e8 04             	sub    $0x4,%eax
  800922:	8b 00                	mov    (%eax),%eax
  800924:	83 ec 08             	sub    $0x8,%esp
  800927:	ff 75 0c             	pushl  0xc(%ebp)
  80092a:	50                   	push   %eax
  80092b:	8b 45 08             	mov    0x8(%ebp),%eax
  80092e:	ff d0                	call   *%eax
  800930:	83 c4 10             	add    $0x10,%esp
			break;
  800933:	e9 89 02 00 00       	jmp    800bc1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800938:	8b 45 14             	mov    0x14(%ebp),%eax
  80093b:	83 c0 04             	add    $0x4,%eax
  80093e:	89 45 14             	mov    %eax,0x14(%ebp)
  800941:	8b 45 14             	mov    0x14(%ebp),%eax
  800944:	83 e8 04             	sub    $0x4,%eax
  800947:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800949:	85 db                	test   %ebx,%ebx
  80094b:	79 02                	jns    80094f <vprintfmt+0x14a>
				err = -err;
  80094d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80094f:	83 fb 64             	cmp    $0x64,%ebx
  800952:	7f 0b                	jg     80095f <vprintfmt+0x15a>
  800954:	8b 34 9d 80 24 80 00 	mov    0x802480(,%ebx,4),%esi
  80095b:	85 f6                	test   %esi,%esi
  80095d:	75 19                	jne    800978 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80095f:	53                   	push   %ebx
  800960:	68 25 26 80 00       	push   $0x802625
  800965:	ff 75 0c             	pushl  0xc(%ebp)
  800968:	ff 75 08             	pushl  0x8(%ebp)
  80096b:	e8 5e 02 00 00       	call   800bce <printfmt>
  800970:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800973:	e9 49 02 00 00       	jmp    800bc1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800978:	56                   	push   %esi
  800979:	68 2e 26 80 00       	push   $0x80262e
  80097e:	ff 75 0c             	pushl  0xc(%ebp)
  800981:	ff 75 08             	pushl  0x8(%ebp)
  800984:	e8 45 02 00 00       	call   800bce <printfmt>
  800989:	83 c4 10             	add    $0x10,%esp
			break;
  80098c:	e9 30 02 00 00       	jmp    800bc1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800991:	8b 45 14             	mov    0x14(%ebp),%eax
  800994:	83 c0 04             	add    $0x4,%eax
  800997:	89 45 14             	mov    %eax,0x14(%ebp)
  80099a:	8b 45 14             	mov    0x14(%ebp),%eax
  80099d:	83 e8 04             	sub    $0x4,%eax
  8009a0:	8b 30                	mov    (%eax),%esi
  8009a2:	85 f6                	test   %esi,%esi
  8009a4:	75 05                	jne    8009ab <vprintfmt+0x1a6>
				p = "(null)";
  8009a6:	be 31 26 80 00       	mov    $0x802631,%esi
			if (width > 0 && padc != '-')
  8009ab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009af:	7e 6d                	jle    800a1e <vprintfmt+0x219>
  8009b1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8009b5:	74 67                	je     800a1e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8009b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009ba:	83 ec 08             	sub    $0x8,%esp
  8009bd:	50                   	push   %eax
  8009be:	56                   	push   %esi
  8009bf:	e8 0c 03 00 00       	call   800cd0 <strnlen>
  8009c4:	83 c4 10             	add    $0x10,%esp
  8009c7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8009ca:	eb 16                	jmp    8009e2 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8009cc:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8009d0:	83 ec 08             	sub    $0x8,%esp
  8009d3:	ff 75 0c             	pushl  0xc(%ebp)
  8009d6:	50                   	push   %eax
  8009d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009da:	ff d0                	call   *%eax
  8009dc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009df:	ff 4d e4             	decl   -0x1c(%ebp)
  8009e2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009e6:	7f e4                	jg     8009cc <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009e8:	eb 34                	jmp    800a1e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009ea:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009ee:	74 1c                	je     800a0c <vprintfmt+0x207>
  8009f0:	83 fb 1f             	cmp    $0x1f,%ebx
  8009f3:	7e 05                	jle    8009fa <vprintfmt+0x1f5>
  8009f5:	83 fb 7e             	cmp    $0x7e,%ebx
  8009f8:	7e 12                	jle    800a0c <vprintfmt+0x207>
					putch('?', putdat);
  8009fa:	83 ec 08             	sub    $0x8,%esp
  8009fd:	ff 75 0c             	pushl  0xc(%ebp)
  800a00:	6a 3f                	push   $0x3f
  800a02:	8b 45 08             	mov    0x8(%ebp),%eax
  800a05:	ff d0                	call   *%eax
  800a07:	83 c4 10             	add    $0x10,%esp
  800a0a:	eb 0f                	jmp    800a1b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a0c:	83 ec 08             	sub    $0x8,%esp
  800a0f:	ff 75 0c             	pushl  0xc(%ebp)
  800a12:	53                   	push   %ebx
  800a13:	8b 45 08             	mov    0x8(%ebp),%eax
  800a16:	ff d0                	call   *%eax
  800a18:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a1b:	ff 4d e4             	decl   -0x1c(%ebp)
  800a1e:	89 f0                	mov    %esi,%eax
  800a20:	8d 70 01             	lea    0x1(%eax),%esi
  800a23:	8a 00                	mov    (%eax),%al
  800a25:	0f be d8             	movsbl %al,%ebx
  800a28:	85 db                	test   %ebx,%ebx
  800a2a:	74 24                	je     800a50 <vprintfmt+0x24b>
  800a2c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a30:	78 b8                	js     8009ea <vprintfmt+0x1e5>
  800a32:	ff 4d e0             	decl   -0x20(%ebp)
  800a35:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a39:	79 af                	jns    8009ea <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a3b:	eb 13                	jmp    800a50 <vprintfmt+0x24b>
				putch(' ', putdat);
  800a3d:	83 ec 08             	sub    $0x8,%esp
  800a40:	ff 75 0c             	pushl  0xc(%ebp)
  800a43:	6a 20                	push   $0x20
  800a45:	8b 45 08             	mov    0x8(%ebp),%eax
  800a48:	ff d0                	call   *%eax
  800a4a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a4d:	ff 4d e4             	decl   -0x1c(%ebp)
  800a50:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a54:	7f e7                	jg     800a3d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a56:	e9 66 01 00 00       	jmp    800bc1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a5b:	83 ec 08             	sub    $0x8,%esp
  800a5e:	ff 75 e8             	pushl  -0x18(%ebp)
  800a61:	8d 45 14             	lea    0x14(%ebp),%eax
  800a64:	50                   	push   %eax
  800a65:	e8 3c fd ff ff       	call   8007a6 <getint>
  800a6a:	83 c4 10             	add    $0x10,%esp
  800a6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a70:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a73:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a76:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a79:	85 d2                	test   %edx,%edx
  800a7b:	79 23                	jns    800aa0 <vprintfmt+0x29b>
				putch('-', putdat);
  800a7d:	83 ec 08             	sub    $0x8,%esp
  800a80:	ff 75 0c             	pushl  0xc(%ebp)
  800a83:	6a 2d                	push   $0x2d
  800a85:	8b 45 08             	mov    0x8(%ebp),%eax
  800a88:	ff d0                	call   *%eax
  800a8a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a90:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a93:	f7 d8                	neg    %eax
  800a95:	83 d2 00             	adc    $0x0,%edx
  800a98:	f7 da                	neg    %edx
  800a9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a9d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800aa0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800aa7:	e9 bc 00 00 00       	jmp    800b68 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800aac:	83 ec 08             	sub    $0x8,%esp
  800aaf:	ff 75 e8             	pushl  -0x18(%ebp)
  800ab2:	8d 45 14             	lea    0x14(%ebp),%eax
  800ab5:	50                   	push   %eax
  800ab6:	e8 84 fc ff ff       	call   80073f <getuint>
  800abb:	83 c4 10             	add    $0x10,%esp
  800abe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ac4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800acb:	e9 98 00 00 00       	jmp    800b68 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ad0:	83 ec 08             	sub    $0x8,%esp
  800ad3:	ff 75 0c             	pushl  0xc(%ebp)
  800ad6:	6a 58                	push   $0x58
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	ff d0                	call   *%eax
  800add:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ae0:	83 ec 08             	sub    $0x8,%esp
  800ae3:	ff 75 0c             	pushl  0xc(%ebp)
  800ae6:	6a 58                	push   $0x58
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	ff d0                	call   *%eax
  800aed:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800af0:	83 ec 08             	sub    $0x8,%esp
  800af3:	ff 75 0c             	pushl  0xc(%ebp)
  800af6:	6a 58                	push   $0x58
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	ff d0                	call   *%eax
  800afd:	83 c4 10             	add    $0x10,%esp
			break;
  800b00:	e9 bc 00 00 00       	jmp    800bc1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b05:	83 ec 08             	sub    $0x8,%esp
  800b08:	ff 75 0c             	pushl  0xc(%ebp)
  800b0b:	6a 30                	push   $0x30
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b10:	ff d0                	call   *%eax
  800b12:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b15:	83 ec 08             	sub    $0x8,%esp
  800b18:	ff 75 0c             	pushl  0xc(%ebp)
  800b1b:	6a 78                	push   $0x78
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	ff d0                	call   *%eax
  800b22:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b25:	8b 45 14             	mov    0x14(%ebp),%eax
  800b28:	83 c0 04             	add    $0x4,%eax
  800b2b:	89 45 14             	mov    %eax,0x14(%ebp)
  800b2e:	8b 45 14             	mov    0x14(%ebp),%eax
  800b31:	83 e8 04             	sub    $0x4,%eax
  800b34:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b36:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b39:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b40:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b47:	eb 1f                	jmp    800b68 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b49:	83 ec 08             	sub    $0x8,%esp
  800b4c:	ff 75 e8             	pushl  -0x18(%ebp)
  800b4f:	8d 45 14             	lea    0x14(%ebp),%eax
  800b52:	50                   	push   %eax
  800b53:	e8 e7 fb ff ff       	call   80073f <getuint>
  800b58:	83 c4 10             	add    $0x10,%esp
  800b5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b5e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b61:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b68:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b6f:	83 ec 04             	sub    $0x4,%esp
  800b72:	52                   	push   %edx
  800b73:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b76:	50                   	push   %eax
  800b77:	ff 75 f4             	pushl  -0xc(%ebp)
  800b7a:	ff 75 f0             	pushl  -0x10(%ebp)
  800b7d:	ff 75 0c             	pushl  0xc(%ebp)
  800b80:	ff 75 08             	pushl  0x8(%ebp)
  800b83:	e8 00 fb ff ff       	call   800688 <printnum>
  800b88:	83 c4 20             	add    $0x20,%esp
			break;
  800b8b:	eb 34                	jmp    800bc1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b8d:	83 ec 08             	sub    $0x8,%esp
  800b90:	ff 75 0c             	pushl  0xc(%ebp)
  800b93:	53                   	push   %ebx
  800b94:	8b 45 08             	mov    0x8(%ebp),%eax
  800b97:	ff d0                	call   *%eax
  800b99:	83 c4 10             	add    $0x10,%esp
			break;
  800b9c:	eb 23                	jmp    800bc1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b9e:	83 ec 08             	sub    $0x8,%esp
  800ba1:	ff 75 0c             	pushl  0xc(%ebp)
  800ba4:	6a 25                	push   $0x25
  800ba6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba9:	ff d0                	call   *%eax
  800bab:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800bae:	ff 4d 10             	decl   0x10(%ebp)
  800bb1:	eb 03                	jmp    800bb6 <vprintfmt+0x3b1>
  800bb3:	ff 4d 10             	decl   0x10(%ebp)
  800bb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb9:	48                   	dec    %eax
  800bba:	8a 00                	mov    (%eax),%al
  800bbc:	3c 25                	cmp    $0x25,%al
  800bbe:	75 f3                	jne    800bb3 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800bc0:	90                   	nop
		}
	}
  800bc1:	e9 47 fc ff ff       	jmp    80080d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800bc6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800bc7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800bca:	5b                   	pop    %ebx
  800bcb:	5e                   	pop    %esi
  800bcc:	5d                   	pop    %ebp
  800bcd:	c3                   	ret    

00800bce <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800bce:	55                   	push   %ebp
  800bcf:	89 e5                	mov    %esp,%ebp
  800bd1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800bd4:	8d 45 10             	lea    0x10(%ebp),%eax
  800bd7:	83 c0 04             	add    $0x4,%eax
  800bda:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800bdd:	8b 45 10             	mov    0x10(%ebp),%eax
  800be0:	ff 75 f4             	pushl  -0xc(%ebp)
  800be3:	50                   	push   %eax
  800be4:	ff 75 0c             	pushl  0xc(%ebp)
  800be7:	ff 75 08             	pushl  0x8(%ebp)
  800bea:	e8 16 fc ff ff       	call   800805 <vprintfmt>
  800bef:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800bf2:	90                   	nop
  800bf3:	c9                   	leave  
  800bf4:	c3                   	ret    

00800bf5 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800bf5:	55                   	push   %ebp
  800bf6:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bf8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfb:	8b 40 08             	mov    0x8(%eax),%eax
  800bfe:	8d 50 01             	lea    0x1(%eax),%edx
  800c01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c04:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0a:	8b 10                	mov    (%eax),%edx
  800c0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0f:	8b 40 04             	mov    0x4(%eax),%eax
  800c12:	39 c2                	cmp    %eax,%edx
  800c14:	73 12                	jae    800c28 <sprintputch+0x33>
		*b->buf++ = ch;
  800c16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c19:	8b 00                	mov    (%eax),%eax
  800c1b:	8d 48 01             	lea    0x1(%eax),%ecx
  800c1e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c21:	89 0a                	mov    %ecx,(%edx)
  800c23:	8b 55 08             	mov    0x8(%ebp),%edx
  800c26:	88 10                	mov    %dl,(%eax)
}
  800c28:	90                   	nop
  800c29:	5d                   	pop    %ebp
  800c2a:	c3                   	ret    

00800c2b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800c2b:	55                   	push   %ebp
  800c2c:	89 e5                	mov    %esp,%ebp
  800c2e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800c31:	8b 45 08             	mov    0x8(%ebp),%eax
  800c34:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c40:	01 d0                	add    %edx,%eax
  800c42:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c45:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c4c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c50:	74 06                	je     800c58 <vsnprintf+0x2d>
  800c52:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c56:	7f 07                	jg     800c5f <vsnprintf+0x34>
		return -E_INVAL;
  800c58:	b8 03 00 00 00       	mov    $0x3,%eax
  800c5d:	eb 20                	jmp    800c7f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c5f:	ff 75 14             	pushl  0x14(%ebp)
  800c62:	ff 75 10             	pushl  0x10(%ebp)
  800c65:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c68:	50                   	push   %eax
  800c69:	68 f5 0b 80 00       	push   $0x800bf5
  800c6e:	e8 92 fb ff ff       	call   800805 <vprintfmt>
  800c73:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c76:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c79:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c7f:	c9                   	leave  
  800c80:	c3                   	ret    

00800c81 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c81:	55                   	push   %ebp
  800c82:	89 e5                	mov    %esp,%ebp
  800c84:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c87:	8d 45 10             	lea    0x10(%ebp),%eax
  800c8a:	83 c0 04             	add    $0x4,%eax
  800c8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c90:	8b 45 10             	mov    0x10(%ebp),%eax
  800c93:	ff 75 f4             	pushl  -0xc(%ebp)
  800c96:	50                   	push   %eax
  800c97:	ff 75 0c             	pushl  0xc(%ebp)
  800c9a:	ff 75 08             	pushl  0x8(%ebp)
  800c9d:	e8 89 ff ff ff       	call   800c2b <vsnprintf>
  800ca2:	83 c4 10             	add    $0x10,%esp
  800ca5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ca8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800cab:	c9                   	leave  
  800cac:	c3                   	ret    

00800cad <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800cad:	55                   	push   %ebp
  800cae:	89 e5                	mov    %esp,%ebp
  800cb0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800cb3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cba:	eb 06                	jmp    800cc2 <strlen+0x15>
		n++;
  800cbc:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800cbf:	ff 45 08             	incl   0x8(%ebp)
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	8a 00                	mov    (%eax),%al
  800cc7:	84 c0                	test   %al,%al
  800cc9:	75 f1                	jne    800cbc <strlen+0xf>
		n++;
	return n;
  800ccb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cce:	c9                   	leave  
  800ccf:	c3                   	ret    

00800cd0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800cd0:	55                   	push   %ebp
  800cd1:	89 e5                	mov    %esp,%ebp
  800cd3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cd6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cdd:	eb 09                	jmp    800ce8 <strnlen+0x18>
		n++;
  800cdf:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ce2:	ff 45 08             	incl   0x8(%ebp)
  800ce5:	ff 4d 0c             	decl   0xc(%ebp)
  800ce8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cec:	74 09                	je     800cf7 <strnlen+0x27>
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	8a 00                	mov    (%eax),%al
  800cf3:	84 c0                	test   %al,%al
  800cf5:	75 e8                	jne    800cdf <strnlen+0xf>
		n++;
	return n;
  800cf7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cfa:	c9                   	leave  
  800cfb:	c3                   	ret    

00800cfc <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800cfc:	55                   	push   %ebp
  800cfd:	89 e5                	mov    %esp,%ebp
  800cff:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d02:	8b 45 08             	mov    0x8(%ebp),%eax
  800d05:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d08:	90                   	nop
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	8d 50 01             	lea    0x1(%eax),%edx
  800d0f:	89 55 08             	mov    %edx,0x8(%ebp)
  800d12:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d15:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d18:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d1b:	8a 12                	mov    (%edx),%dl
  800d1d:	88 10                	mov    %dl,(%eax)
  800d1f:	8a 00                	mov    (%eax),%al
  800d21:	84 c0                	test   %al,%al
  800d23:	75 e4                	jne    800d09 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d25:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d28:	c9                   	leave  
  800d29:	c3                   	ret    

00800d2a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d2a:	55                   	push   %ebp
  800d2b:	89 e5                	mov    %esp,%ebp
  800d2d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800d30:	8b 45 08             	mov    0x8(%ebp),%eax
  800d33:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d36:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d3d:	eb 1f                	jmp    800d5e <strncpy+0x34>
		*dst++ = *src;
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	8d 50 01             	lea    0x1(%eax),%edx
  800d45:	89 55 08             	mov    %edx,0x8(%ebp)
  800d48:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d4b:	8a 12                	mov    (%edx),%dl
  800d4d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	84 c0                	test   %al,%al
  800d56:	74 03                	je     800d5b <strncpy+0x31>
			src++;
  800d58:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d5b:	ff 45 fc             	incl   -0x4(%ebp)
  800d5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d61:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d64:	72 d9                	jb     800d3f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d66:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d69:	c9                   	leave  
  800d6a:	c3                   	ret    

00800d6b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d6b:	55                   	push   %ebp
  800d6c:	89 e5                	mov    %esp,%ebp
  800d6e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
  800d74:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d7b:	74 30                	je     800dad <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d7d:	eb 16                	jmp    800d95 <strlcpy+0x2a>
			*dst++ = *src++;
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	8d 50 01             	lea    0x1(%eax),%edx
  800d85:	89 55 08             	mov    %edx,0x8(%ebp)
  800d88:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d8b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d8e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d91:	8a 12                	mov    (%edx),%dl
  800d93:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d95:	ff 4d 10             	decl   0x10(%ebp)
  800d98:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d9c:	74 09                	je     800da7 <strlcpy+0x3c>
  800d9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da1:	8a 00                	mov    (%eax),%al
  800da3:	84 c0                	test   %al,%al
  800da5:	75 d8                	jne    800d7f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800da7:	8b 45 08             	mov    0x8(%ebp),%eax
  800daa:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800dad:	8b 55 08             	mov    0x8(%ebp),%edx
  800db0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db3:	29 c2                	sub    %eax,%edx
  800db5:	89 d0                	mov    %edx,%eax
}
  800db7:	c9                   	leave  
  800db8:	c3                   	ret    

00800db9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800db9:	55                   	push   %ebp
  800dba:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800dbc:	eb 06                	jmp    800dc4 <strcmp+0xb>
		p++, q++;
  800dbe:	ff 45 08             	incl   0x8(%ebp)
  800dc1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800dc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc7:	8a 00                	mov    (%eax),%al
  800dc9:	84 c0                	test   %al,%al
  800dcb:	74 0e                	je     800ddb <strcmp+0x22>
  800dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd0:	8a 10                	mov    (%eax),%dl
  800dd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd5:	8a 00                	mov    (%eax),%al
  800dd7:	38 c2                	cmp    %al,%dl
  800dd9:	74 e3                	je     800dbe <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dde:	8a 00                	mov    (%eax),%al
  800de0:	0f b6 d0             	movzbl %al,%edx
  800de3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de6:	8a 00                	mov    (%eax),%al
  800de8:	0f b6 c0             	movzbl %al,%eax
  800deb:	29 c2                	sub    %eax,%edx
  800ded:	89 d0                	mov    %edx,%eax
}
  800def:	5d                   	pop    %ebp
  800df0:	c3                   	ret    

00800df1 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800df1:	55                   	push   %ebp
  800df2:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800df4:	eb 09                	jmp    800dff <strncmp+0xe>
		n--, p++, q++;
  800df6:	ff 4d 10             	decl   0x10(%ebp)
  800df9:	ff 45 08             	incl   0x8(%ebp)
  800dfc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800dff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e03:	74 17                	je     800e1c <strncmp+0x2b>
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
  800e08:	8a 00                	mov    (%eax),%al
  800e0a:	84 c0                	test   %al,%al
  800e0c:	74 0e                	je     800e1c <strncmp+0x2b>
  800e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e11:	8a 10                	mov    (%eax),%dl
  800e13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e16:	8a 00                	mov    (%eax),%al
  800e18:	38 c2                	cmp    %al,%dl
  800e1a:	74 da                	je     800df6 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e1c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e20:	75 07                	jne    800e29 <strncmp+0x38>
		return 0;
  800e22:	b8 00 00 00 00       	mov    $0x0,%eax
  800e27:	eb 14                	jmp    800e3d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e29:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2c:	8a 00                	mov    (%eax),%al
  800e2e:	0f b6 d0             	movzbl %al,%edx
  800e31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e34:	8a 00                	mov    (%eax),%al
  800e36:	0f b6 c0             	movzbl %al,%eax
  800e39:	29 c2                	sub    %eax,%edx
  800e3b:	89 d0                	mov    %edx,%eax
}
  800e3d:	5d                   	pop    %ebp
  800e3e:	c3                   	ret    

00800e3f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e3f:	55                   	push   %ebp
  800e40:	89 e5                	mov    %esp,%ebp
  800e42:	83 ec 04             	sub    $0x4,%esp
  800e45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e48:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e4b:	eb 12                	jmp    800e5f <strchr+0x20>
		if (*s == c)
  800e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e50:	8a 00                	mov    (%eax),%al
  800e52:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e55:	75 05                	jne    800e5c <strchr+0x1d>
			return (char *) s;
  800e57:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5a:	eb 11                	jmp    800e6d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e5c:	ff 45 08             	incl   0x8(%ebp)
  800e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e62:	8a 00                	mov    (%eax),%al
  800e64:	84 c0                	test   %al,%al
  800e66:	75 e5                	jne    800e4d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e68:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e6d:	c9                   	leave  
  800e6e:	c3                   	ret    

00800e6f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e6f:	55                   	push   %ebp
  800e70:	89 e5                	mov    %esp,%ebp
  800e72:	83 ec 04             	sub    $0x4,%esp
  800e75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e78:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e7b:	eb 0d                	jmp    800e8a <strfind+0x1b>
		if (*s == c)
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e80:	8a 00                	mov    (%eax),%al
  800e82:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e85:	74 0e                	je     800e95 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e87:	ff 45 08             	incl   0x8(%ebp)
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	84 c0                	test   %al,%al
  800e91:	75 ea                	jne    800e7d <strfind+0xe>
  800e93:	eb 01                	jmp    800e96 <strfind+0x27>
		if (*s == c)
			break;
  800e95:	90                   	nop
	return (char *) s;
  800e96:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e99:	c9                   	leave  
  800e9a:	c3                   	ret    

00800e9b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e9b:	55                   	push   %ebp
  800e9c:	89 e5                	mov    %esp,%ebp
  800e9e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ea7:	8b 45 10             	mov    0x10(%ebp),%eax
  800eaa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ead:	eb 0e                	jmp    800ebd <memset+0x22>
		*p++ = c;
  800eaf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb2:	8d 50 01             	lea    0x1(%eax),%edx
  800eb5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800eb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ebb:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ebd:	ff 4d f8             	decl   -0x8(%ebp)
  800ec0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ec4:	79 e9                	jns    800eaf <memset+0x14>
		*p++ = c;

	return v;
  800ec6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ec9:	c9                   	leave  
  800eca:	c3                   	ret    

00800ecb <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ecb:	55                   	push   %ebp
  800ecc:	89 e5                	mov    %esp,%ebp
  800ece:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ed1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eda:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800edd:	eb 16                	jmp    800ef5 <memcpy+0x2a>
		*d++ = *s++;
  800edf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ee2:	8d 50 01             	lea    0x1(%eax),%edx
  800ee5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ee8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eeb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eee:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ef1:	8a 12                	mov    (%edx),%dl
  800ef3:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ef5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800efb:	89 55 10             	mov    %edx,0x10(%ebp)
  800efe:	85 c0                	test   %eax,%eax
  800f00:	75 dd                	jne    800edf <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f05:	c9                   	leave  
  800f06:	c3                   	ret    

00800f07 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f07:	55                   	push   %ebp
  800f08:	89 e5                	mov    %esp,%ebp
  800f0a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f10:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f13:	8b 45 08             	mov    0x8(%ebp),%eax
  800f16:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f19:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f1f:	73 50                	jae    800f71 <memmove+0x6a>
  800f21:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f24:	8b 45 10             	mov    0x10(%ebp),%eax
  800f27:	01 d0                	add    %edx,%eax
  800f29:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f2c:	76 43                	jbe    800f71 <memmove+0x6a>
		s += n;
  800f2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f31:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f34:	8b 45 10             	mov    0x10(%ebp),%eax
  800f37:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f3a:	eb 10                	jmp    800f4c <memmove+0x45>
			*--d = *--s;
  800f3c:	ff 4d f8             	decl   -0x8(%ebp)
  800f3f:	ff 4d fc             	decl   -0x4(%ebp)
  800f42:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f45:	8a 10                	mov    (%eax),%dl
  800f47:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f4a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f52:	89 55 10             	mov    %edx,0x10(%ebp)
  800f55:	85 c0                	test   %eax,%eax
  800f57:	75 e3                	jne    800f3c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f59:	eb 23                	jmp    800f7e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f5e:	8d 50 01             	lea    0x1(%eax),%edx
  800f61:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f64:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f67:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f6a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f6d:	8a 12                	mov    (%edx),%dl
  800f6f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f71:	8b 45 10             	mov    0x10(%ebp),%eax
  800f74:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f77:	89 55 10             	mov    %edx,0x10(%ebp)
  800f7a:	85 c0                	test   %eax,%eax
  800f7c:	75 dd                	jne    800f5b <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f7e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f81:	c9                   	leave  
  800f82:	c3                   	ret    

00800f83 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f83:	55                   	push   %ebp
  800f84:	89 e5                	mov    %esp,%ebp
  800f86:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f92:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f95:	eb 2a                	jmp    800fc1 <memcmp+0x3e>
		if (*s1 != *s2)
  800f97:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f9a:	8a 10                	mov    (%eax),%dl
  800f9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f9f:	8a 00                	mov    (%eax),%al
  800fa1:	38 c2                	cmp    %al,%dl
  800fa3:	74 16                	je     800fbb <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800fa5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa8:	8a 00                	mov    (%eax),%al
  800faa:	0f b6 d0             	movzbl %al,%edx
  800fad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb0:	8a 00                	mov    (%eax),%al
  800fb2:	0f b6 c0             	movzbl %al,%eax
  800fb5:	29 c2                	sub    %eax,%edx
  800fb7:	89 d0                	mov    %edx,%eax
  800fb9:	eb 18                	jmp    800fd3 <memcmp+0x50>
		s1++, s2++;
  800fbb:	ff 45 fc             	incl   -0x4(%ebp)
  800fbe:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800fc1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fc7:	89 55 10             	mov    %edx,0x10(%ebp)
  800fca:	85 c0                	test   %eax,%eax
  800fcc:	75 c9                	jne    800f97 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800fce:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fd3:	c9                   	leave  
  800fd4:	c3                   	ret    

00800fd5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800fd5:	55                   	push   %ebp
  800fd6:	89 e5                	mov    %esp,%ebp
  800fd8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800fdb:	8b 55 08             	mov    0x8(%ebp),%edx
  800fde:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe1:	01 d0                	add    %edx,%eax
  800fe3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800fe6:	eb 15                	jmp    800ffd <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800fe8:	8b 45 08             	mov    0x8(%ebp),%eax
  800feb:	8a 00                	mov    (%eax),%al
  800fed:	0f b6 d0             	movzbl %al,%edx
  800ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff3:	0f b6 c0             	movzbl %al,%eax
  800ff6:	39 c2                	cmp    %eax,%edx
  800ff8:	74 0d                	je     801007 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ffa:	ff 45 08             	incl   0x8(%ebp)
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  801000:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801003:	72 e3                	jb     800fe8 <memfind+0x13>
  801005:	eb 01                	jmp    801008 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801007:	90                   	nop
	return (void *) s;
  801008:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80100b:	c9                   	leave  
  80100c:	c3                   	ret    

0080100d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80100d:	55                   	push   %ebp
  80100e:	89 e5                	mov    %esp,%ebp
  801010:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801013:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80101a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801021:	eb 03                	jmp    801026 <strtol+0x19>
		s++;
  801023:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	8a 00                	mov    (%eax),%al
  80102b:	3c 20                	cmp    $0x20,%al
  80102d:	74 f4                	je     801023 <strtol+0x16>
  80102f:	8b 45 08             	mov    0x8(%ebp),%eax
  801032:	8a 00                	mov    (%eax),%al
  801034:	3c 09                	cmp    $0x9,%al
  801036:	74 eb                	je     801023 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801038:	8b 45 08             	mov    0x8(%ebp),%eax
  80103b:	8a 00                	mov    (%eax),%al
  80103d:	3c 2b                	cmp    $0x2b,%al
  80103f:	75 05                	jne    801046 <strtol+0x39>
		s++;
  801041:	ff 45 08             	incl   0x8(%ebp)
  801044:	eb 13                	jmp    801059 <strtol+0x4c>
	else if (*s == '-')
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	8a 00                	mov    (%eax),%al
  80104b:	3c 2d                	cmp    $0x2d,%al
  80104d:	75 0a                	jne    801059 <strtol+0x4c>
		s++, neg = 1;
  80104f:	ff 45 08             	incl   0x8(%ebp)
  801052:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801059:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80105d:	74 06                	je     801065 <strtol+0x58>
  80105f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801063:	75 20                	jne    801085 <strtol+0x78>
  801065:	8b 45 08             	mov    0x8(%ebp),%eax
  801068:	8a 00                	mov    (%eax),%al
  80106a:	3c 30                	cmp    $0x30,%al
  80106c:	75 17                	jne    801085 <strtol+0x78>
  80106e:	8b 45 08             	mov    0x8(%ebp),%eax
  801071:	40                   	inc    %eax
  801072:	8a 00                	mov    (%eax),%al
  801074:	3c 78                	cmp    $0x78,%al
  801076:	75 0d                	jne    801085 <strtol+0x78>
		s += 2, base = 16;
  801078:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80107c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801083:	eb 28                	jmp    8010ad <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801085:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801089:	75 15                	jne    8010a0 <strtol+0x93>
  80108b:	8b 45 08             	mov    0x8(%ebp),%eax
  80108e:	8a 00                	mov    (%eax),%al
  801090:	3c 30                	cmp    $0x30,%al
  801092:	75 0c                	jne    8010a0 <strtol+0x93>
		s++, base = 8;
  801094:	ff 45 08             	incl   0x8(%ebp)
  801097:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80109e:	eb 0d                	jmp    8010ad <strtol+0xa0>
	else if (base == 0)
  8010a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010a4:	75 07                	jne    8010ad <strtol+0xa0>
		base = 10;
  8010a6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b0:	8a 00                	mov    (%eax),%al
  8010b2:	3c 2f                	cmp    $0x2f,%al
  8010b4:	7e 19                	jle    8010cf <strtol+0xc2>
  8010b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b9:	8a 00                	mov    (%eax),%al
  8010bb:	3c 39                	cmp    $0x39,%al
  8010bd:	7f 10                	jg     8010cf <strtol+0xc2>
			dig = *s - '0';
  8010bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c2:	8a 00                	mov    (%eax),%al
  8010c4:	0f be c0             	movsbl %al,%eax
  8010c7:	83 e8 30             	sub    $0x30,%eax
  8010ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010cd:	eb 42                	jmp    801111 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	8a 00                	mov    (%eax),%al
  8010d4:	3c 60                	cmp    $0x60,%al
  8010d6:	7e 19                	jle    8010f1 <strtol+0xe4>
  8010d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010db:	8a 00                	mov    (%eax),%al
  8010dd:	3c 7a                	cmp    $0x7a,%al
  8010df:	7f 10                	jg     8010f1 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8010e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e4:	8a 00                	mov    (%eax),%al
  8010e6:	0f be c0             	movsbl %al,%eax
  8010e9:	83 e8 57             	sub    $0x57,%eax
  8010ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010ef:	eb 20                	jmp    801111 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8010f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f4:	8a 00                	mov    (%eax),%al
  8010f6:	3c 40                	cmp    $0x40,%al
  8010f8:	7e 39                	jle    801133 <strtol+0x126>
  8010fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fd:	8a 00                	mov    (%eax),%al
  8010ff:	3c 5a                	cmp    $0x5a,%al
  801101:	7f 30                	jg     801133 <strtol+0x126>
			dig = *s - 'A' + 10;
  801103:	8b 45 08             	mov    0x8(%ebp),%eax
  801106:	8a 00                	mov    (%eax),%al
  801108:	0f be c0             	movsbl %al,%eax
  80110b:	83 e8 37             	sub    $0x37,%eax
  80110e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801111:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801114:	3b 45 10             	cmp    0x10(%ebp),%eax
  801117:	7d 19                	jge    801132 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801119:	ff 45 08             	incl   0x8(%ebp)
  80111c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80111f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801123:	89 c2                	mov    %eax,%edx
  801125:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801128:	01 d0                	add    %edx,%eax
  80112a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80112d:	e9 7b ff ff ff       	jmp    8010ad <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801132:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801133:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801137:	74 08                	je     801141 <strtol+0x134>
		*endptr = (char *) s;
  801139:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113c:	8b 55 08             	mov    0x8(%ebp),%edx
  80113f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801141:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801145:	74 07                	je     80114e <strtol+0x141>
  801147:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80114a:	f7 d8                	neg    %eax
  80114c:	eb 03                	jmp    801151 <strtol+0x144>
  80114e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801151:	c9                   	leave  
  801152:	c3                   	ret    

00801153 <ltostr>:

void
ltostr(long value, char *str)
{
  801153:	55                   	push   %ebp
  801154:	89 e5                	mov    %esp,%ebp
  801156:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801159:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801160:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801167:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80116b:	79 13                	jns    801180 <ltostr+0x2d>
	{
		neg = 1;
  80116d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801174:	8b 45 0c             	mov    0xc(%ebp),%eax
  801177:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80117a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80117d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801180:	8b 45 08             	mov    0x8(%ebp),%eax
  801183:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801188:	99                   	cltd   
  801189:	f7 f9                	idiv   %ecx
  80118b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80118e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801191:	8d 50 01             	lea    0x1(%eax),%edx
  801194:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801197:	89 c2                	mov    %eax,%edx
  801199:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119c:	01 d0                	add    %edx,%eax
  80119e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011a1:	83 c2 30             	add    $0x30,%edx
  8011a4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8011a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011a9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011ae:	f7 e9                	imul   %ecx
  8011b0:	c1 fa 02             	sar    $0x2,%edx
  8011b3:	89 c8                	mov    %ecx,%eax
  8011b5:	c1 f8 1f             	sar    $0x1f,%eax
  8011b8:	29 c2                	sub    %eax,%edx
  8011ba:	89 d0                	mov    %edx,%eax
  8011bc:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8011bf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8011c2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8011c7:	f7 e9                	imul   %ecx
  8011c9:	c1 fa 02             	sar    $0x2,%edx
  8011cc:	89 c8                	mov    %ecx,%eax
  8011ce:	c1 f8 1f             	sar    $0x1f,%eax
  8011d1:	29 c2                	sub    %eax,%edx
  8011d3:	89 d0                	mov    %edx,%eax
  8011d5:	c1 e0 02             	shl    $0x2,%eax
  8011d8:	01 d0                	add    %edx,%eax
  8011da:	01 c0                	add    %eax,%eax
  8011dc:	29 c1                	sub    %eax,%ecx
  8011de:	89 ca                	mov    %ecx,%edx
  8011e0:	85 d2                	test   %edx,%edx
  8011e2:	75 9c                	jne    801180 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8011e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8011eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ee:	48                   	dec    %eax
  8011ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8011f2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011f6:	74 3d                	je     801235 <ltostr+0xe2>
		start = 1 ;
  8011f8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011ff:	eb 34                	jmp    801235 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801201:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801204:	8b 45 0c             	mov    0xc(%ebp),%eax
  801207:	01 d0                	add    %edx,%eax
  801209:	8a 00                	mov    (%eax),%al
  80120b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80120e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801211:	8b 45 0c             	mov    0xc(%ebp),%eax
  801214:	01 c2                	add    %eax,%edx
  801216:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801219:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121c:	01 c8                	add    %ecx,%eax
  80121e:	8a 00                	mov    (%eax),%al
  801220:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801222:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801225:	8b 45 0c             	mov    0xc(%ebp),%eax
  801228:	01 c2                	add    %eax,%edx
  80122a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80122d:	88 02                	mov    %al,(%edx)
		start++ ;
  80122f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801232:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801235:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801238:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80123b:	7c c4                	jl     801201 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80123d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801240:	8b 45 0c             	mov    0xc(%ebp),%eax
  801243:	01 d0                	add    %edx,%eax
  801245:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801248:	90                   	nop
  801249:	c9                   	leave  
  80124a:	c3                   	ret    

0080124b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80124b:	55                   	push   %ebp
  80124c:	89 e5                	mov    %esp,%ebp
  80124e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801251:	ff 75 08             	pushl  0x8(%ebp)
  801254:	e8 54 fa ff ff       	call   800cad <strlen>
  801259:	83 c4 04             	add    $0x4,%esp
  80125c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80125f:	ff 75 0c             	pushl  0xc(%ebp)
  801262:	e8 46 fa ff ff       	call   800cad <strlen>
  801267:	83 c4 04             	add    $0x4,%esp
  80126a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80126d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801274:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80127b:	eb 17                	jmp    801294 <strcconcat+0x49>
		final[s] = str1[s] ;
  80127d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801280:	8b 45 10             	mov    0x10(%ebp),%eax
  801283:	01 c2                	add    %eax,%edx
  801285:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801288:	8b 45 08             	mov    0x8(%ebp),%eax
  80128b:	01 c8                	add    %ecx,%eax
  80128d:	8a 00                	mov    (%eax),%al
  80128f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801291:	ff 45 fc             	incl   -0x4(%ebp)
  801294:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801297:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80129a:	7c e1                	jl     80127d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80129c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8012a3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8012aa:	eb 1f                	jmp    8012cb <strcconcat+0x80>
		final[s++] = str2[i] ;
  8012ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012af:	8d 50 01             	lea    0x1(%eax),%edx
  8012b2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8012b5:	89 c2                	mov    %eax,%edx
  8012b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ba:	01 c2                	add    %eax,%edx
  8012bc:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8012bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c2:	01 c8                	add    %ecx,%eax
  8012c4:	8a 00                	mov    (%eax),%al
  8012c6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8012c8:	ff 45 f8             	incl   -0x8(%ebp)
  8012cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ce:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012d1:	7c d9                	jl     8012ac <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8012d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d9:	01 d0                	add    %edx,%eax
  8012db:	c6 00 00             	movb   $0x0,(%eax)
}
  8012de:	90                   	nop
  8012df:	c9                   	leave  
  8012e0:	c3                   	ret    

008012e1 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8012e1:	55                   	push   %ebp
  8012e2:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8012e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8012e7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8012ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8012f0:	8b 00                	mov    (%eax),%eax
  8012f2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012fc:	01 d0                	add    %edx,%eax
  8012fe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801304:	eb 0c                	jmp    801312 <strsplit+0x31>
			*string++ = 0;
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	8d 50 01             	lea    0x1(%eax),%edx
  80130c:	89 55 08             	mov    %edx,0x8(%ebp)
  80130f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801312:	8b 45 08             	mov    0x8(%ebp),%eax
  801315:	8a 00                	mov    (%eax),%al
  801317:	84 c0                	test   %al,%al
  801319:	74 18                	je     801333 <strsplit+0x52>
  80131b:	8b 45 08             	mov    0x8(%ebp),%eax
  80131e:	8a 00                	mov    (%eax),%al
  801320:	0f be c0             	movsbl %al,%eax
  801323:	50                   	push   %eax
  801324:	ff 75 0c             	pushl  0xc(%ebp)
  801327:	e8 13 fb ff ff       	call   800e3f <strchr>
  80132c:	83 c4 08             	add    $0x8,%esp
  80132f:	85 c0                	test   %eax,%eax
  801331:	75 d3                	jne    801306 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801333:	8b 45 08             	mov    0x8(%ebp),%eax
  801336:	8a 00                	mov    (%eax),%al
  801338:	84 c0                	test   %al,%al
  80133a:	74 5a                	je     801396 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80133c:	8b 45 14             	mov    0x14(%ebp),%eax
  80133f:	8b 00                	mov    (%eax),%eax
  801341:	83 f8 0f             	cmp    $0xf,%eax
  801344:	75 07                	jne    80134d <strsplit+0x6c>
		{
			return 0;
  801346:	b8 00 00 00 00       	mov    $0x0,%eax
  80134b:	eb 66                	jmp    8013b3 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80134d:	8b 45 14             	mov    0x14(%ebp),%eax
  801350:	8b 00                	mov    (%eax),%eax
  801352:	8d 48 01             	lea    0x1(%eax),%ecx
  801355:	8b 55 14             	mov    0x14(%ebp),%edx
  801358:	89 0a                	mov    %ecx,(%edx)
  80135a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801361:	8b 45 10             	mov    0x10(%ebp),%eax
  801364:	01 c2                	add    %eax,%edx
  801366:	8b 45 08             	mov    0x8(%ebp),%eax
  801369:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80136b:	eb 03                	jmp    801370 <strsplit+0x8f>
			string++;
  80136d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801370:	8b 45 08             	mov    0x8(%ebp),%eax
  801373:	8a 00                	mov    (%eax),%al
  801375:	84 c0                	test   %al,%al
  801377:	74 8b                	je     801304 <strsplit+0x23>
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	8a 00                	mov    (%eax),%al
  80137e:	0f be c0             	movsbl %al,%eax
  801381:	50                   	push   %eax
  801382:	ff 75 0c             	pushl  0xc(%ebp)
  801385:	e8 b5 fa ff ff       	call   800e3f <strchr>
  80138a:	83 c4 08             	add    $0x8,%esp
  80138d:	85 c0                	test   %eax,%eax
  80138f:	74 dc                	je     80136d <strsplit+0x8c>
			string++;
	}
  801391:	e9 6e ff ff ff       	jmp    801304 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801396:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801397:	8b 45 14             	mov    0x14(%ebp),%eax
  80139a:	8b 00                	mov    (%eax),%eax
  80139c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a6:	01 d0                	add    %edx,%eax
  8013a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8013ae:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8013b3:	c9                   	leave  
  8013b4:	c3                   	ret    

008013b5 <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  8013b5:	55                   	push   %ebp
  8013b6:	89 e5                	mov    %esp,%ebp
  8013b8:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013be:	c1 e8 0c             	shr    $0xc,%eax
  8013c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  8013c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c7:	25 ff 0f 00 00       	and    $0xfff,%eax
  8013cc:	85 c0                	test   %eax,%eax
  8013ce:	74 03                	je     8013d3 <malloc+0x1e>
			num++;
  8013d0:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8013d3:	a1 04 30 80 00       	mov    0x803004,%eax
  8013d8:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8013dd:	75 73                	jne    801452 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8013df:	83 ec 08             	sub    $0x8,%esp
  8013e2:	ff 75 08             	pushl  0x8(%ebp)
  8013e5:	68 00 00 00 80       	push   $0x80000000
  8013ea:	e8 14 05 00 00       	call   801903 <sys_allocateMem>
  8013ef:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8013f2:	a1 04 30 80 00       	mov    0x803004,%eax
  8013f7:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8013fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013fd:	c1 e0 0c             	shl    $0xc,%eax
  801400:	89 c2                	mov    %eax,%edx
  801402:	a1 04 30 80 00       	mov    0x803004,%eax
  801407:	01 d0                	add    %edx,%eax
  801409:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  80140e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801413:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801416:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  80141d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801422:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801428:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  80142f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801434:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  80143b:	01 00 00 00 
			sizeofarray++;
  80143f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801444:	40                   	inc    %eax
  801445:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  80144a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80144d:	e9 71 01 00 00       	jmp    8015c3 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801452:	a1 28 30 80 00       	mov    0x803028,%eax
  801457:	85 c0                	test   %eax,%eax
  801459:	75 71                	jne    8014cc <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  80145b:	a1 04 30 80 00       	mov    0x803004,%eax
  801460:	83 ec 08             	sub    $0x8,%esp
  801463:	ff 75 08             	pushl  0x8(%ebp)
  801466:	50                   	push   %eax
  801467:	e8 97 04 00 00       	call   801903 <sys_allocateMem>
  80146c:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  80146f:	a1 04 30 80 00       	mov    0x803004,%eax
  801474:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801477:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80147a:	c1 e0 0c             	shl    $0xc,%eax
  80147d:	89 c2                	mov    %eax,%edx
  80147f:	a1 04 30 80 00       	mov    0x803004,%eax
  801484:	01 d0                	add    %edx,%eax
  801486:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  80148b:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801490:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801493:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  80149a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80149f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8014a2:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8014a9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014ae:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8014b5:	01 00 00 00 
				sizeofarray++;
  8014b9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014be:	40                   	inc    %eax
  8014bf:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  8014c4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8014c7:	e9 f7 00 00 00       	jmp    8015c3 <malloc+0x20e>
			}
			else{
				int count=0;
  8014cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8014d3:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8014da:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8014e1:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8014e8:	eb 7c                	jmp    801566 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  8014ea:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8014f1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8014f8:	eb 1a                	jmp    801514 <malloc+0x15f>
					{
						if(addresses[j]==i)
  8014fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8014fd:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801504:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801507:	75 08                	jne    801511 <malloc+0x15c>
						{
							index=j;
  801509:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80150c:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  80150f:	eb 0d                	jmp    80151e <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801511:	ff 45 dc             	incl   -0x24(%ebp)
  801514:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801519:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  80151c:	7c dc                	jl     8014fa <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  80151e:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801522:	75 05                	jne    801529 <malloc+0x174>
					{
						count++;
  801524:	ff 45 f0             	incl   -0x10(%ebp)
  801527:	eb 36                	jmp    80155f <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801529:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80152c:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801533:	85 c0                	test   %eax,%eax
  801535:	75 05                	jne    80153c <malloc+0x187>
						{
							count++;
  801537:	ff 45 f0             	incl   -0x10(%ebp)
  80153a:	eb 23                	jmp    80155f <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  80153c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80153f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801542:	7d 14                	jge    801558 <malloc+0x1a3>
  801544:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801547:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80154a:	7c 0c                	jl     801558 <malloc+0x1a3>
							{
								min=count;
  80154c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80154f:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801552:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801555:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801558:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80155f:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801566:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  80156d:	0f 86 77 ff ff ff    	jbe    8014ea <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801573:	83 ec 08             	sub    $0x8,%esp
  801576:	ff 75 08             	pushl  0x8(%ebp)
  801579:	ff 75 e4             	pushl  -0x1c(%ebp)
  80157c:	e8 82 03 00 00       	call   801903 <sys_allocateMem>
  801581:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801584:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801589:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80158c:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801593:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801598:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80159e:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8015a5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015aa:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8015b1:	01 00 00 00 
				sizeofarray++;
  8015b5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015ba:	40                   	inc    %eax
  8015bb:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  8015c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  8015c3:	c9                   	leave  
  8015c4:	c3                   	ret    

008015c5 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
  8015c8:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  8015cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int size;
    int is_found=0;
  8015d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  8015d8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8015df:	eb 30                	jmp    801611 <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  8015e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015e4:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8015eb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8015ee:	75 1e                	jne    80160e <free+0x49>
  8015f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015f3:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  8015fa:	83 f8 01             	cmp    $0x1,%eax
  8015fd:	75 0f                	jne    80160e <free+0x49>
    		is_found=1;
  8015ff:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  801606:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801609:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  80160c:	eb 0d                	jmp    80161b <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    int size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  80160e:	ff 45 ec             	incl   -0x14(%ebp)
  801611:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801616:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801619:	7c c6                	jl     8015e1 <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  80161b:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  80161f:	75 3b                	jne    80165c <free+0x97>
    	size=numOfPages[index]*PAGE_SIZE;
  801621:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801624:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  80162b:	c1 e0 0c             	shl    $0xc,%eax
  80162e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  801631:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801634:	83 ec 08             	sub    $0x8,%esp
  801637:	50                   	push   %eax
  801638:	ff 75 e8             	pushl  -0x18(%ebp)
  80163b:	e8 a7 02 00 00       	call   8018e7 <sys_freeMem>
  801640:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  801643:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801646:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  80164d:	00 00 00 00 
    	changes++;
  801651:	a1 28 30 80 00       	mov    0x803028,%eax
  801656:	40                   	inc    %eax
  801657:	a3 28 30 80 00       	mov    %eax,0x803028
    }


	//refer to the project presentation and documentation for details
}
  80165c:	90                   	nop
  80165d:	c9                   	leave  
  80165e:	c3                   	ret    

0080165f <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80165f:	55                   	push   %ebp
  801660:	89 e5                	mov    %esp,%ebp
  801662:	83 ec 18             	sub    $0x18,%esp
  801665:	8b 45 10             	mov    0x10(%ebp),%eax
  801668:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80166b:	83 ec 04             	sub    $0x4,%esp
  80166e:	68 90 27 80 00       	push   $0x802790
  801673:	68 9f 00 00 00       	push   $0x9f
  801678:	68 b3 27 80 00       	push   $0x8027b3
  80167d:	e8 0b 07 00 00       	call   801d8d <_panic>

00801682 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801682:	55                   	push   %ebp
  801683:	89 e5                	mov    %esp,%ebp
  801685:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801688:	83 ec 04             	sub    $0x4,%esp
  80168b:	68 90 27 80 00       	push   $0x802790
  801690:	68 a5 00 00 00       	push   $0xa5
  801695:	68 b3 27 80 00       	push   $0x8027b3
  80169a:	e8 ee 06 00 00       	call   801d8d <_panic>

0080169f <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80169f:	55                   	push   %ebp
  8016a0:	89 e5                	mov    %esp,%ebp
  8016a2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016a5:	83 ec 04             	sub    $0x4,%esp
  8016a8:	68 90 27 80 00       	push   $0x802790
  8016ad:	68 ab 00 00 00       	push   $0xab
  8016b2:	68 b3 27 80 00       	push   $0x8027b3
  8016b7:	e8 d1 06 00 00       	call   801d8d <_panic>

008016bc <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
  8016bf:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016c2:	83 ec 04             	sub    $0x4,%esp
  8016c5:	68 90 27 80 00       	push   $0x802790
  8016ca:	68 b0 00 00 00       	push   $0xb0
  8016cf:	68 b3 27 80 00       	push   $0x8027b3
  8016d4:	e8 b4 06 00 00       	call   801d8d <_panic>

008016d9 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
  8016dc:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016df:	83 ec 04             	sub    $0x4,%esp
  8016e2:	68 90 27 80 00       	push   $0x802790
  8016e7:	68 b6 00 00 00       	push   $0xb6
  8016ec:	68 b3 27 80 00       	push   $0x8027b3
  8016f1:	e8 97 06 00 00       	call   801d8d <_panic>

008016f6 <shrink>:
}
void shrink(uint32 newSize)
{
  8016f6:	55                   	push   %ebp
  8016f7:	89 e5                	mov    %esp,%ebp
  8016f9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8016fc:	83 ec 04             	sub    $0x4,%esp
  8016ff:	68 90 27 80 00       	push   $0x802790
  801704:	68 ba 00 00 00       	push   $0xba
  801709:	68 b3 27 80 00       	push   $0x8027b3
  80170e:	e8 7a 06 00 00       	call   801d8d <_panic>

00801713 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801713:	55                   	push   %ebp
  801714:	89 e5                	mov    %esp,%ebp
  801716:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801719:	83 ec 04             	sub    $0x4,%esp
  80171c:	68 90 27 80 00       	push   $0x802790
  801721:	68 bf 00 00 00       	push   $0xbf
  801726:	68 b3 27 80 00       	push   $0x8027b3
  80172b:	e8 5d 06 00 00       	call   801d8d <_panic>

00801730 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801730:	55                   	push   %ebp
  801731:	89 e5                	mov    %esp,%ebp
  801733:	57                   	push   %edi
  801734:	56                   	push   %esi
  801735:	53                   	push   %ebx
  801736:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801739:	8b 45 08             	mov    0x8(%ebp),%eax
  80173c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80173f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801742:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801745:	8b 7d 18             	mov    0x18(%ebp),%edi
  801748:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80174b:	cd 30                	int    $0x30
  80174d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801750:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801753:	83 c4 10             	add    $0x10,%esp
  801756:	5b                   	pop    %ebx
  801757:	5e                   	pop    %esi
  801758:	5f                   	pop    %edi
  801759:	5d                   	pop    %ebp
  80175a:	c3                   	ret    

0080175b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80175b:	55                   	push   %ebp
  80175c:	89 e5                	mov    %esp,%ebp
  80175e:	83 ec 04             	sub    $0x4,%esp
  801761:	8b 45 10             	mov    0x10(%ebp),%eax
  801764:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801767:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80176b:	8b 45 08             	mov    0x8(%ebp),%eax
  80176e:	6a 00                	push   $0x0
  801770:	6a 00                	push   $0x0
  801772:	52                   	push   %edx
  801773:	ff 75 0c             	pushl  0xc(%ebp)
  801776:	50                   	push   %eax
  801777:	6a 00                	push   $0x0
  801779:	e8 b2 ff ff ff       	call   801730 <syscall>
  80177e:	83 c4 18             	add    $0x18,%esp
}
  801781:	90                   	nop
  801782:	c9                   	leave  
  801783:	c3                   	ret    

00801784 <sys_cgetc>:

int
sys_cgetc(void)
{
  801784:	55                   	push   %ebp
  801785:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 01                	push   $0x1
  801793:	e8 98 ff ff ff       	call   801730 <syscall>
  801798:	83 c4 18             	add    $0x18,%esp
}
  80179b:	c9                   	leave  
  80179c:	c3                   	ret    

0080179d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80179d:	55                   	push   %ebp
  80179e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8017a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	50                   	push   %eax
  8017ac:	6a 05                	push   $0x5
  8017ae:	e8 7d ff ff ff       	call   801730 <syscall>
  8017b3:	83 c4 18             	add    $0x18,%esp
}
  8017b6:	c9                   	leave  
  8017b7:	c3                   	ret    

008017b8 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017b8:	55                   	push   %ebp
  8017b9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 02                	push   $0x2
  8017c7:	e8 64 ff ff ff       	call   801730 <syscall>
  8017cc:	83 c4 18             	add    $0x18,%esp
}
  8017cf:	c9                   	leave  
  8017d0:	c3                   	ret    

008017d1 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017d1:	55                   	push   %ebp
  8017d2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 03                	push   $0x3
  8017e0:	e8 4b ff ff ff       	call   801730 <syscall>
  8017e5:	83 c4 18             	add    $0x18,%esp
}
  8017e8:	c9                   	leave  
  8017e9:	c3                   	ret    

008017ea <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017ea:	55                   	push   %ebp
  8017eb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 04                	push   $0x4
  8017f9:	e8 32 ff ff ff       	call   801730 <syscall>
  8017fe:	83 c4 18             	add    $0x18,%esp
}
  801801:	c9                   	leave  
  801802:	c3                   	ret    

00801803 <sys_env_exit>:


void sys_env_exit(void)
{
  801803:	55                   	push   %ebp
  801804:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 06                	push   $0x6
  801812:	e8 19 ff ff ff       	call   801730 <syscall>
  801817:	83 c4 18             	add    $0x18,%esp
}
  80181a:	90                   	nop
  80181b:	c9                   	leave  
  80181c:	c3                   	ret    

0080181d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80181d:	55                   	push   %ebp
  80181e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801820:	8b 55 0c             	mov    0xc(%ebp),%edx
  801823:	8b 45 08             	mov    0x8(%ebp),%eax
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	52                   	push   %edx
  80182d:	50                   	push   %eax
  80182e:	6a 07                	push   $0x7
  801830:	e8 fb fe ff ff       	call   801730 <syscall>
  801835:	83 c4 18             	add    $0x18,%esp
}
  801838:	c9                   	leave  
  801839:	c3                   	ret    

0080183a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80183a:	55                   	push   %ebp
  80183b:	89 e5                	mov    %esp,%ebp
  80183d:	56                   	push   %esi
  80183e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80183f:	8b 75 18             	mov    0x18(%ebp),%esi
  801842:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801845:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801848:	8b 55 0c             	mov    0xc(%ebp),%edx
  80184b:	8b 45 08             	mov    0x8(%ebp),%eax
  80184e:	56                   	push   %esi
  80184f:	53                   	push   %ebx
  801850:	51                   	push   %ecx
  801851:	52                   	push   %edx
  801852:	50                   	push   %eax
  801853:	6a 08                	push   $0x8
  801855:	e8 d6 fe ff ff       	call   801730 <syscall>
  80185a:	83 c4 18             	add    $0x18,%esp
}
  80185d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801860:	5b                   	pop    %ebx
  801861:	5e                   	pop    %esi
  801862:	5d                   	pop    %ebp
  801863:	c3                   	ret    

00801864 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801867:	8b 55 0c             	mov    0xc(%ebp),%edx
  80186a:	8b 45 08             	mov    0x8(%ebp),%eax
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	52                   	push   %edx
  801874:	50                   	push   %eax
  801875:	6a 09                	push   $0x9
  801877:	e8 b4 fe ff ff       	call   801730 <syscall>
  80187c:	83 c4 18             	add    $0x18,%esp
}
  80187f:	c9                   	leave  
  801880:	c3                   	ret    

00801881 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801881:	55                   	push   %ebp
  801882:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	ff 75 0c             	pushl  0xc(%ebp)
  80188d:	ff 75 08             	pushl  0x8(%ebp)
  801890:	6a 0a                	push   $0xa
  801892:	e8 99 fe ff ff       	call   801730 <syscall>
  801897:	83 c4 18             	add    $0x18,%esp
}
  80189a:	c9                   	leave  
  80189b:	c3                   	ret    

0080189c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80189c:	55                   	push   %ebp
  80189d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 0b                	push   $0xb
  8018ab:	e8 80 fe ff ff       	call   801730 <syscall>
  8018b0:	83 c4 18             	add    $0x18,%esp
}
  8018b3:	c9                   	leave  
  8018b4:	c3                   	ret    

008018b5 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018b5:	55                   	push   %ebp
  8018b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 0c                	push   $0xc
  8018c4:	e8 67 fe ff ff       	call   801730 <syscall>
  8018c9:	83 c4 18             	add    $0x18,%esp
}
  8018cc:	c9                   	leave  
  8018cd:	c3                   	ret    

008018ce <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018ce:	55                   	push   %ebp
  8018cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 0d                	push   $0xd
  8018dd:	e8 4e fe ff ff       	call   801730 <syscall>
  8018e2:	83 c4 18             	add    $0x18,%esp
}
  8018e5:	c9                   	leave  
  8018e6:	c3                   	ret    

008018e7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018e7:	55                   	push   %ebp
  8018e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	ff 75 0c             	pushl  0xc(%ebp)
  8018f3:	ff 75 08             	pushl  0x8(%ebp)
  8018f6:	6a 11                	push   $0x11
  8018f8:	e8 33 fe ff ff       	call   801730 <syscall>
  8018fd:	83 c4 18             	add    $0x18,%esp
	return;
  801900:	90                   	nop
}
  801901:	c9                   	leave  
  801902:	c3                   	ret    

00801903 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801903:	55                   	push   %ebp
  801904:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801906:	6a 00                	push   $0x0
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	ff 75 0c             	pushl  0xc(%ebp)
  80190f:	ff 75 08             	pushl  0x8(%ebp)
  801912:	6a 12                	push   $0x12
  801914:	e8 17 fe ff ff       	call   801730 <syscall>
  801919:	83 c4 18             	add    $0x18,%esp
	return ;
  80191c:	90                   	nop
}
  80191d:	c9                   	leave  
  80191e:	c3                   	ret    

0080191f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80191f:	55                   	push   %ebp
  801920:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 0e                	push   $0xe
  80192e:	e8 fd fd ff ff       	call   801730 <syscall>
  801933:	83 c4 18             	add    $0x18,%esp
}
  801936:	c9                   	leave  
  801937:	c3                   	ret    

00801938 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801938:	55                   	push   %ebp
  801939:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	ff 75 08             	pushl  0x8(%ebp)
  801946:	6a 0f                	push   $0xf
  801948:	e8 e3 fd ff ff       	call   801730 <syscall>
  80194d:	83 c4 18             	add    $0x18,%esp
}
  801950:	c9                   	leave  
  801951:	c3                   	ret    

00801952 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801952:	55                   	push   %ebp
  801953:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	6a 00                	push   $0x0
  80195d:	6a 00                	push   $0x0
  80195f:	6a 10                	push   $0x10
  801961:	e8 ca fd ff ff       	call   801730 <syscall>
  801966:	83 c4 18             	add    $0x18,%esp
}
  801969:	90                   	nop
  80196a:	c9                   	leave  
  80196b:	c3                   	ret    

0080196c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80196c:	55                   	push   %ebp
  80196d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	6a 00                	push   $0x0
  801979:	6a 14                	push   $0x14
  80197b:	e8 b0 fd ff ff       	call   801730 <syscall>
  801980:	83 c4 18             	add    $0x18,%esp
}
  801983:	90                   	nop
  801984:	c9                   	leave  
  801985:	c3                   	ret    

00801986 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801986:	55                   	push   %ebp
  801987:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 15                	push   $0x15
  801995:	e8 96 fd ff ff       	call   801730 <syscall>
  80199a:	83 c4 18             	add    $0x18,%esp
}
  80199d:	90                   	nop
  80199e:	c9                   	leave  
  80199f:	c3                   	ret    

008019a0 <sys_cputc>:


void
sys_cputc(const char c)
{
  8019a0:	55                   	push   %ebp
  8019a1:	89 e5                	mov    %esp,%ebp
  8019a3:	83 ec 04             	sub    $0x4,%esp
  8019a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8019ac:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	50                   	push   %eax
  8019b9:	6a 16                	push   $0x16
  8019bb:	e8 70 fd ff ff       	call   801730 <syscall>
  8019c0:	83 c4 18             	add    $0x18,%esp
}
  8019c3:	90                   	nop
  8019c4:	c9                   	leave  
  8019c5:	c3                   	ret    

008019c6 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019c6:	55                   	push   %ebp
  8019c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 00                	push   $0x0
  8019cf:	6a 00                	push   $0x0
  8019d1:	6a 00                	push   $0x0
  8019d3:	6a 17                	push   $0x17
  8019d5:	e8 56 fd ff ff       	call   801730 <syscall>
  8019da:	83 c4 18             	add    $0x18,%esp
}
  8019dd:	90                   	nop
  8019de:	c9                   	leave  
  8019df:	c3                   	ret    

008019e0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019e0:	55                   	push   %ebp
  8019e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	ff 75 0c             	pushl  0xc(%ebp)
  8019ef:	50                   	push   %eax
  8019f0:	6a 18                	push   $0x18
  8019f2:	e8 39 fd ff ff       	call   801730 <syscall>
  8019f7:	83 c4 18             	add    $0x18,%esp
}
  8019fa:	c9                   	leave  
  8019fb:	c3                   	ret    

008019fc <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a02:	8b 45 08             	mov    0x8(%ebp),%eax
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	52                   	push   %edx
  801a0c:	50                   	push   %eax
  801a0d:	6a 1b                	push   $0x1b
  801a0f:	e8 1c fd ff ff       	call   801730 <syscall>
  801a14:	83 c4 18             	add    $0x18,%esp
}
  801a17:	c9                   	leave  
  801a18:	c3                   	ret    

00801a19 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a19:	55                   	push   %ebp
  801a1a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	52                   	push   %edx
  801a29:	50                   	push   %eax
  801a2a:	6a 19                	push   $0x19
  801a2c:	e8 ff fc ff ff       	call   801730 <syscall>
  801a31:	83 c4 18             	add    $0x18,%esp
}
  801a34:	90                   	nop
  801a35:	c9                   	leave  
  801a36:	c3                   	ret    

00801a37 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a37:	55                   	push   %ebp
  801a38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a40:	6a 00                	push   $0x0
  801a42:	6a 00                	push   $0x0
  801a44:	6a 00                	push   $0x0
  801a46:	52                   	push   %edx
  801a47:	50                   	push   %eax
  801a48:	6a 1a                	push   $0x1a
  801a4a:	e8 e1 fc ff ff       	call   801730 <syscall>
  801a4f:	83 c4 18             	add    $0x18,%esp
}
  801a52:	90                   	nop
  801a53:	c9                   	leave  
  801a54:	c3                   	ret    

00801a55 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a55:	55                   	push   %ebp
  801a56:	89 e5                	mov    %esp,%ebp
  801a58:	83 ec 04             	sub    $0x4,%esp
  801a5b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a5e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a61:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a64:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a68:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6b:	6a 00                	push   $0x0
  801a6d:	51                   	push   %ecx
  801a6e:	52                   	push   %edx
  801a6f:	ff 75 0c             	pushl  0xc(%ebp)
  801a72:	50                   	push   %eax
  801a73:	6a 1c                	push   $0x1c
  801a75:	e8 b6 fc ff ff       	call   801730 <syscall>
  801a7a:	83 c4 18             	add    $0x18,%esp
}
  801a7d:	c9                   	leave  
  801a7e:	c3                   	ret    

00801a7f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a7f:	55                   	push   %ebp
  801a80:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a82:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a85:	8b 45 08             	mov    0x8(%ebp),%eax
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 00                	push   $0x0
  801a8c:	6a 00                	push   $0x0
  801a8e:	52                   	push   %edx
  801a8f:	50                   	push   %eax
  801a90:	6a 1d                	push   $0x1d
  801a92:	e8 99 fc ff ff       	call   801730 <syscall>
  801a97:	83 c4 18             	add    $0x18,%esp
}
  801a9a:	c9                   	leave  
  801a9b:	c3                   	ret    

00801a9c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a9c:	55                   	push   %ebp
  801a9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a9f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801aa2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa8:	6a 00                	push   $0x0
  801aaa:	6a 00                	push   $0x0
  801aac:	51                   	push   %ecx
  801aad:	52                   	push   %edx
  801aae:	50                   	push   %eax
  801aaf:	6a 1e                	push   $0x1e
  801ab1:	e8 7a fc ff ff       	call   801730 <syscall>
  801ab6:	83 c4 18             	add    $0x18,%esp
}
  801ab9:	c9                   	leave  
  801aba:	c3                   	ret    

00801abb <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801abb:	55                   	push   %ebp
  801abc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801abe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 00                	push   $0x0
  801ac8:	6a 00                	push   $0x0
  801aca:	52                   	push   %edx
  801acb:	50                   	push   %eax
  801acc:	6a 1f                	push   $0x1f
  801ace:	e8 5d fc ff ff       	call   801730 <syscall>
  801ad3:	83 c4 18             	add    $0x18,%esp
}
  801ad6:	c9                   	leave  
  801ad7:	c3                   	ret    

00801ad8 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ad8:	55                   	push   %ebp
  801ad9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 20                	push   $0x20
  801ae7:	e8 44 fc ff ff       	call   801730 <syscall>
  801aec:	83 c4 18             	add    $0x18,%esp
}
  801aef:	c9                   	leave  
  801af0:	c3                   	ret    

00801af1 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801af1:	55                   	push   %ebp
  801af2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801af4:	8b 45 08             	mov    0x8(%ebp),%eax
  801af7:	6a 00                	push   $0x0
  801af9:	ff 75 14             	pushl  0x14(%ebp)
  801afc:	ff 75 10             	pushl  0x10(%ebp)
  801aff:	ff 75 0c             	pushl  0xc(%ebp)
  801b02:	50                   	push   %eax
  801b03:	6a 21                	push   $0x21
  801b05:	e8 26 fc ff ff       	call   801730 <syscall>
  801b0a:	83 c4 18             	add    $0x18,%esp
}
  801b0d:	c9                   	leave  
  801b0e:	c3                   	ret    

00801b0f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801b0f:	55                   	push   %ebp
  801b10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b12:	8b 45 08             	mov    0x8(%ebp),%eax
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	50                   	push   %eax
  801b1e:	6a 22                	push   $0x22
  801b20:	e8 0b fc ff ff       	call   801730 <syscall>
  801b25:	83 c4 18             	add    $0x18,%esp
}
  801b28:	90                   	nop
  801b29:	c9                   	leave  
  801b2a:	c3                   	ret    

00801b2b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b2b:	55                   	push   %ebp
  801b2c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	6a 00                	push   $0x0
  801b39:	50                   	push   %eax
  801b3a:	6a 23                	push   $0x23
  801b3c:	e8 ef fb ff ff       	call   801730 <syscall>
  801b41:	83 c4 18             	add    $0x18,%esp
}
  801b44:	90                   	nop
  801b45:	c9                   	leave  
  801b46:	c3                   	ret    

00801b47 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b47:	55                   	push   %ebp
  801b48:	89 e5                	mov    %esp,%ebp
  801b4a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b4d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b50:	8d 50 04             	lea    0x4(%eax),%edx
  801b53:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b56:	6a 00                	push   $0x0
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	52                   	push   %edx
  801b5d:	50                   	push   %eax
  801b5e:	6a 24                	push   $0x24
  801b60:	e8 cb fb ff ff       	call   801730 <syscall>
  801b65:	83 c4 18             	add    $0x18,%esp
	return result;
  801b68:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b6e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b71:	89 01                	mov    %eax,(%ecx)
  801b73:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b76:	8b 45 08             	mov    0x8(%ebp),%eax
  801b79:	c9                   	leave  
  801b7a:	c2 04 00             	ret    $0x4

00801b7d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b7d:	55                   	push   %ebp
  801b7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	ff 75 10             	pushl  0x10(%ebp)
  801b87:	ff 75 0c             	pushl  0xc(%ebp)
  801b8a:	ff 75 08             	pushl  0x8(%ebp)
  801b8d:	6a 13                	push   $0x13
  801b8f:	e8 9c fb ff ff       	call   801730 <syscall>
  801b94:	83 c4 18             	add    $0x18,%esp
	return ;
  801b97:	90                   	nop
}
  801b98:	c9                   	leave  
  801b99:	c3                   	ret    

00801b9a <sys_rcr2>:
uint32 sys_rcr2()
{
  801b9a:	55                   	push   %ebp
  801b9b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 00                	push   $0x0
  801ba3:	6a 00                	push   $0x0
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 25                	push   $0x25
  801ba9:	e8 82 fb ff ff       	call   801730 <syscall>
  801bae:	83 c4 18             	add    $0x18,%esp
}
  801bb1:	c9                   	leave  
  801bb2:	c3                   	ret    

00801bb3 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801bb3:	55                   	push   %ebp
  801bb4:	89 e5                	mov    %esp,%ebp
  801bb6:	83 ec 04             	sub    $0x4,%esp
  801bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801bbf:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	50                   	push   %eax
  801bcc:	6a 26                	push   $0x26
  801bce:	e8 5d fb ff ff       	call   801730 <syscall>
  801bd3:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd6:	90                   	nop
}
  801bd7:	c9                   	leave  
  801bd8:	c3                   	ret    

00801bd9 <rsttst>:
void rsttst()
{
  801bd9:	55                   	push   %ebp
  801bda:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 28                	push   $0x28
  801be8:	e8 43 fb ff ff       	call   801730 <syscall>
  801bed:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf0:	90                   	nop
}
  801bf1:	c9                   	leave  
  801bf2:	c3                   	ret    

00801bf3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bf3:	55                   	push   %ebp
  801bf4:	89 e5                	mov    %esp,%ebp
  801bf6:	83 ec 04             	sub    $0x4,%esp
  801bf9:	8b 45 14             	mov    0x14(%ebp),%eax
  801bfc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bff:	8b 55 18             	mov    0x18(%ebp),%edx
  801c02:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c06:	52                   	push   %edx
  801c07:	50                   	push   %eax
  801c08:	ff 75 10             	pushl  0x10(%ebp)
  801c0b:	ff 75 0c             	pushl  0xc(%ebp)
  801c0e:	ff 75 08             	pushl  0x8(%ebp)
  801c11:	6a 27                	push   $0x27
  801c13:	e8 18 fb ff ff       	call   801730 <syscall>
  801c18:	83 c4 18             	add    $0x18,%esp
	return ;
  801c1b:	90                   	nop
}
  801c1c:	c9                   	leave  
  801c1d:	c3                   	ret    

00801c1e <chktst>:
void chktst(uint32 n)
{
  801c1e:	55                   	push   %ebp
  801c1f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	ff 75 08             	pushl  0x8(%ebp)
  801c2c:	6a 29                	push   $0x29
  801c2e:	e8 fd fa ff ff       	call   801730 <syscall>
  801c33:	83 c4 18             	add    $0x18,%esp
	return ;
  801c36:	90                   	nop
}
  801c37:	c9                   	leave  
  801c38:	c3                   	ret    

00801c39 <inctst>:

void inctst()
{
  801c39:	55                   	push   %ebp
  801c3a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 2a                	push   $0x2a
  801c48:	e8 e3 fa ff ff       	call   801730 <syscall>
  801c4d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c50:	90                   	nop
}
  801c51:	c9                   	leave  
  801c52:	c3                   	ret    

00801c53 <gettst>:
uint32 gettst()
{
  801c53:	55                   	push   %ebp
  801c54:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 2b                	push   $0x2b
  801c62:	e8 c9 fa ff ff       	call   801730 <syscall>
  801c67:	83 c4 18             	add    $0x18,%esp
}
  801c6a:	c9                   	leave  
  801c6b:	c3                   	ret    

00801c6c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c6c:	55                   	push   %ebp
  801c6d:	89 e5                	mov    %esp,%ebp
  801c6f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 2c                	push   $0x2c
  801c7e:	e8 ad fa ff ff       	call   801730 <syscall>
  801c83:	83 c4 18             	add    $0x18,%esp
  801c86:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c89:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c8d:	75 07                	jne    801c96 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c8f:	b8 01 00 00 00       	mov    $0x1,%eax
  801c94:	eb 05                	jmp    801c9b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c96:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c9b:	c9                   	leave  
  801c9c:	c3                   	ret    

00801c9d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c9d:	55                   	push   %ebp
  801c9e:	89 e5                	mov    %esp,%ebp
  801ca0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 2c                	push   $0x2c
  801caf:	e8 7c fa ff ff       	call   801730 <syscall>
  801cb4:	83 c4 18             	add    $0x18,%esp
  801cb7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801cba:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801cbe:	75 07                	jne    801cc7 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801cc0:	b8 01 00 00 00       	mov    $0x1,%eax
  801cc5:	eb 05                	jmp    801ccc <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801cc7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ccc:	c9                   	leave  
  801ccd:	c3                   	ret    

00801cce <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801cce:	55                   	push   %ebp
  801ccf:	89 e5                	mov    %esp,%ebp
  801cd1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 00                	push   $0x0
  801cde:	6a 2c                	push   $0x2c
  801ce0:	e8 4b fa ff ff       	call   801730 <syscall>
  801ce5:	83 c4 18             	add    $0x18,%esp
  801ce8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ceb:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cef:	75 07                	jne    801cf8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cf1:	b8 01 00 00 00       	mov    $0x1,%eax
  801cf6:	eb 05                	jmp    801cfd <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cf8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cfd:	c9                   	leave  
  801cfe:	c3                   	ret    

00801cff <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cff:	55                   	push   %ebp
  801d00:	89 e5                	mov    %esp,%ebp
  801d02:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d05:	6a 00                	push   $0x0
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 2c                	push   $0x2c
  801d11:	e8 1a fa ff ff       	call   801730 <syscall>
  801d16:	83 c4 18             	add    $0x18,%esp
  801d19:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d1c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d20:	75 07                	jne    801d29 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d22:	b8 01 00 00 00       	mov    $0x1,%eax
  801d27:	eb 05                	jmp    801d2e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d29:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d2e:	c9                   	leave  
  801d2f:	c3                   	ret    

00801d30 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d30:	55                   	push   %ebp
  801d31:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d33:	6a 00                	push   $0x0
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	ff 75 08             	pushl  0x8(%ebp)
  801d3e:	6a 2d                	push   $0x2d
  801d40:	e8 eb f9 ff ff       	call   801730 <syscall>
  801d45:	83 c4 18             	add    $0x18,%esp
	return ;
  801d48:	90                   	nop
}
  801d49:	c9                   	leave  
  801d4a:	c3                   	ret    

00801d4b <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d4b:	55                   	push   %ebp
  801d4c:	89 e5                	mov    %esp,%ebp
  801d4e:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d4f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d52:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d55:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d58:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5b:	6a 00                	push   $0x0
  801d5d:	53                   	push   %ebx
  801d5e:	51                   	push   %ecx
  801d5f:	52                   	push   %edx
  801d60:	50                   	push   %eax
  801d61:	6a 2e                	push   $0x2e
  801d63:	e8 c8 f9 ff ff       	call   801730 <syscall>
  801d68:	83 c4 18             	add    $0x18,%esp
}
  801d6b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d6e:	c9                   	leave  
  801d6f:	c3                   	ret    

00801d70 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d70:	55                   	push   %ebp
  801d71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d73:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d76:	8b 45 08             	mov    0x8(%ebp),%eax
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	52                   	push   %edx
  801d80:	50                   	push   %eax
  801d81:	6a 2f                	push   $0x2f
  801d83:	e8 a8 f9 ff ff       	call   801730 <syscall>
  801d88:	83 c4 18             	add    $0x18,%esp
}
  801d8b:	c9                   	leave  
  801d8c:	c3                   	ret    

00801d8d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801d8d:	55                   	push   %ebp
  801d8e:	89 e5                	mov    %esp,%ebp
  801d90:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801d93:	8d 45 10             	lea    0x10(%ebp),%eax
  801d96:	83 c0 04             	add    $0x4,%eax
  801d99:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801d9c:	a1 a0 80 92 00       	mov    0x9280a0,%eax
  801da1:	85 c0                	test   %eax,%eax
  801da3:	74 16                	je     801dbb <_panic+0x2e>
		cprintf("%s: ", argv0);
  801da5:	a1 a0 80 92 00       	mov    0x9280a0,%eax
  801daa:	83 ec 08             	sub    $0x8,%esp
  801dad:	50                   	push   %eax
  801dae:	68 c0 27 80 00       	push   $0x8027c0
  801db3:	e8 73 e8 ff ff       	call   80062b <cprintf>
  801db8:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801dbb:	a1 00 30 80 00       	mov    0x803000,%eax
  801dc0:	ff 75 0c             	pushl  0xc(%ebp)
  801dc3:	ff 75 08             	pushl  0x8(%ebp)
  801dc6:	50                   	push   %eax
  801dc7:	68 c5 27 80 00       	push   $0x8027c5
  801dcc:	e8 5a e8 ff ff       	call   80062b <cprintf>
  801dd1:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801dd4:	8b 45 10             	mov    0x10(%ebp),%eax
  801dd7:	83 ec 08             	sub    $0x8,%esp
  801dda:	ff 75 f4             	pushl  -0xc(%ebp)
  801ddd:	50                   	push   %eax
  801dde:	e8 dd e7 ff ff       	call   8005c0 <vcprintf>
  801de3:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801de6:	83 ec 08             	sub    $0x8,%esp
  801de9:	6a 00                	push   $0x0
  801deb:	68 e1 27 80 00       	push   $0x8027e1
  801df0:	e8 cb e7 ff ff       	call   8005c0 <vcprintf>
  801df5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801df8:	e8 4c e7 ff ff       	call   800549 <exit>

	// should not return here
	while (1) ;
  801dfd:	eb fe                	jmp    801dfd <_panic+0x70>

00801dff <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801dff:	55                   	push   %ebp
  801e00:	89 e5                	mov    %esp,%ebp
  801e02:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801e05:	a1 20 30 80 00       	mov    0x803020,%eax
  801e0a:	8b 50 74             	mov    0x74(%eax),%edx
  801e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e10:	39 c2                	cmp    %eax,%edx
  801e12:	74 14                	je     801e28 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801e14:	83 ec 04             	sub    $0x4,%esp
  801e17:	68 e4 27 80 00       	push   $0x8027e4
  801e1c:	6a 26                	push   $0x26
  801e1e:	68 30 28 80 00       	push   $0x802830
  801e23:	e8 65 ff ff ff       	call   801d8d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801e28:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801e2f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801e36:	e9 b6 00 00 00       	jmp    801ef1 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801e3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e3e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e45:	8b 45 08             	mov    0x8(%ebp),%eax
  801e48:	01 d0                	add    %edx,%eax
  801e4a:	8b 00                	mov    (%eax),%eax
  801e4c:	85 c0                	test   %eax,%eax
  801e4e:	75 08                	jne    801e58 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801e50:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801e53:	e9 96 00 00 00       	jmp    801eee <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801e58:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e5f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801e66:	eb 5d                	jmp    801ec5 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801e68:	a1 20 30 80 00       	mov    0x803020,%eax
  801e6d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801e73:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801e76:	c1 e2 04             	shl    $0x4,%edx
  801e79:	01 d0                	add    %edx,%eax
  801e7b:	8a 40 04             	mov    0x4(%eax),%al
  801e7e:	84 c0                	test   %al,%al
  801e80:	75 40                	jne    801ec2 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801e82:	a1 20 30 80 00       	mov    0x803020,%eax
  801e87:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801e8d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801e90:	c1 e2 04             	shl    $0x4,%edx
  801e93:	01 d0                	add    %edx,%eax
  801e95:	8b 00                	mov    (%eax),%eax
  801e97:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801e9a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801e9d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801ea2:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801ea4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ea7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801eae:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb1:	01 c8                	add    %ecx,%eax
  801eb3:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801eb5:	39 c2                	cmp    %eax,%edx
  801eb7:	75 09                	jne    801ec2 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801eb9:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801ec0:	eb 12                	jmp    801ed4 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801ec2:	ff 45 e8             	incl   -0x18(%ebp)
  801ec5:	a1 20 30 80 00       	mov    0x803020,%eax
  801eca:	8b 50 74             	mov    0x74(%eax),%edx
  801ecd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ed0:	39 c2                	cmp    %eax,%edx
  801ed2:	77 94                	ja     801e68 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801ed4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801ed8:	75 14                	jne    801eee <CheckWSWithoutLastIndex+0xef>
			panic(
  801eda:	83 ec 04             	sub    $0x4,%esp
  801edd:	68 3c 28 80 00       	push   $0x80283c
  801ee2:	6a 3a                	push   $0x3a
  801ee4:	68 30 28 80 00       	push   $0x802830
  801ee9:	e8 9f fe ff ff       	call   801d8d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801eee:	ff 45 f0             	incl   -0x10(%ebp)
  801ef1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ef4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801ef7:	0f 8c 3e ff ff ff    	jl     801e3b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801efd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f04:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801f0b:	eb 20                	jmp    801f2d <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801f0d:	a1 20 30 80 00       	mov    0x803020,%eax
  801f12:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801f18:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801f1b:	c1 e2 04             	shl    $0x4,%edx
  801f1e:	01 d0                	add    %edx,%eax
  801f20:	8a 40 04             	mov    0x4(%eax),%al
  801f23:	3c 01                	cmp    $0x1,%al
  801f25:	75 03                	jne    801f2a <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801f27:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801f2a:	ff 45 e0             	incl   -0x20(%ebp)
  801f2d:	a1 20 30 80 00       	mov    0x803020,%eax
  801f32:	8b 50 74             	mov    0x74(%eax),%edx
  801f35:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801f38:	39 c2                	cmp    %eax,%edx
  801f3a:	77 d1                	ja     801f0d <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801f3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f3f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801f42:	74 14                	je     801f58 <CheckWSWithoutLastIndex+0x159>
		panic(
  801f44:	83 ec 04             	sub    $0x4,%esp
  801f47:	68 90 28 80 00       	push   $0x802890
  801f4c:	6a 44                	push   $0x44
  801f4e:	68 30 28 80 00       	push   $0x802830
  801f53:	e8 35 fe ff ff       	call   801d8d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801f58:	90                   	nop
  801f59:	c9                   	leave  
  801f5a:	c3                   	ret    
  801f5b:	90                   	nop

00801f5c <__udivdi3>:
  801f5c:	55                   	push   %ebp
  801f5d:	57                   	push   %edi
  801f5e:	56                   	push   %esi
  801f5f:	53                   	push   %ebx
  801f60:	83 ec 1c             	sub    $0x1c,%esp
  801f63:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f67:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801f6b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f6f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801f73:	89 ca                	mov    %ecx,%edx
  801f75:	89 f8                	mov    %edi,%eax
  801f77:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f7b:	85 f6                	test   %esi,%esi
  801f7d:	75 2d                	jne    801fac <__udivdi3+0x50>
  801f7f:	39 cf                	cmp    %ecx,%edi
  801f81:	77 65                	ja     801fe8 <__udivdi3+0x8c>
  801f83:	89 fd                	mov    %edi,%ebp
  801f85:	85 ff                	test   %edi,%edi
  801f87:	75 0b                	jne    801f94 <__udivdi3+0x38>
  801f89:	b8 01 00 00 00       	mov    $0x1,%eax
  801f8e:	31 d2                	xor    %edx,%edx
  801f90:	f7 f7                	div    %edi
  801f92:	89 c5                	mov    %eax,%ebp
  801f94:	31 d2                	xor    %edx,%edx
  801f96:	89 c8                	mov    %ecx,%eax
  801f98:	f7 f5                	div    %ebp
  801f9a:	89 c1                	mov    %eax,%ecx
  801f9c:	89 d8                	mov    %ebx,%eax
  801f9e:	f7 f5                	div    %ebp
  801fa0:	89 cf                	mov    %ecx,%edi
  801fa2:	89 fa                	mov    %edi,%edx
  801fa4:	83 c4 1c             	add    $0x1c,%esp
  801fa7:	5b                   	pop    %ebx
  801fa8:	5e                   	pop    %esi
  801fa9:	5f                   	pop    %edi
  801faa:	5d                   	pop    %ebp
  801fab:	c3                   	ret    
  801fac:	39 ce                	cmp    %ecx,%esi
  801fae:	77 28                	ja     801fd8 <__udivdi3+0x7c>
  801fb0:	0f bd fe             	bsr    %esi,%edi
  801fb3:	83 f7 1f             	xor    $0x1f,%edi
  801fb6:	75 40                	jne    801ff8 <__udivdi3+0x9c>
  801fb8:	39 ce                	cmp    %ecx,%esi
  801fba:	72 0a                	jb     801fc6 <__udivdi3+0x6a>
  801fbc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801fc0:	0f 87 9e 00 00 00    	ja     802064 <__udivdi3+0x108>
  801fc6:	b8 01 00 00 00       	mov    $0x1,%eax
  801fcb:	89 fa                	mov    %edi,%edx
  801fcd:	83 c4 1c             	add    $0x1c,%esp
  801fd0:	5b                   	pop    %ebx
  801fd1:	5e                   	pop    %esi
  801fd2:	5f                   	pop    %edi
  801fd3:	5d                   	pop    %ebp
  801fd4:	c3                   	ret    
  801fd5:	8d 76 00             	lea    0x0(%esi),%esi
  801fd8:	31 ff                	xor    %edi,%edi
  801fda:	31 c0                	xor    %eax,%eax
  801fdc:	89 fa                	mov    %edi,%edx
  801fde:	83 c4 1c             	add    $0x1c,%esp
  801fe1:	5b                   	pop    %ebx
  801fe2:	5e                   	pop    %esi
  801fe3:	5f                   	pop    %edi
  801fe4:	5d                   	pop    %ebp
  801fe5:	c3                   	ret    
  801fe6:	66 90                	xchg   %ax,%ax
  801fe8:	89 d8                	mov    %ebx,%eax
  801fea:	f7 f7                	div    %edi
  801fec:	31 ff                	xor    %edi,%edi
  801fee:	89 fa                	mov    %edi,%edx
  801ff0:	83 c4 1c             	add    $0x1c,%esp
  801ff3:	5b                   	pop    %ebx
  801ff4:	5e                   	pop    %esi
  801ff5:	5f                   	pop    %edi
  801ff6:	5d                   	pop    %ebp
  801ff7:	c3                   	ret    
  801ff8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ffd:	89 eb                	mov    %ebp,%ebx
  801fff:	29 fb                	sub    %edi,%ebx
  802001:	89 f9                	mov    %edi,%ecx
  802003:	d3 e6                	shl    %cl,%esi
  802005:	89 c5                	mov    %eax,%ebp
  802007:	88 d9                	mov    %bl,%cl
  802009:	d3 ed                	shr    %cl,%ebp
  80200b:	89 e9                	mov    %ebp,%ecx
  80200d:	09 f1                	or     %esi,%ecx
  80200f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802013:	89 f9                	mov    %edi,%ecx
  802015:	d3 e0                	shl    %cl,%eax
  802017:	89 c5                	mov    %eax,%ebp
  802019:	89 d6                	mov    %edx,%esi
  80201b:	88 d9                	mov    %bl,%cl
  80201d:	d3 ee                	shr    %cl,%esi
  80201f:	89 f9                	mov    %edi,%ecx
  802021:	d3 e2                	shl    %cl,%edx
  802023:	8b 44 24 08          	mov    0x8(%esp),%eax
  802027:	88 d9                	mov    %bl,%cl
  802029:	d3 e8                	shr    %cl,%eax
  80202b:	09 c2                	or     %eax,%edx
  80202d:	89 d0                	mov    %edx,%eax
  80202f:	89 f2                	mov    %esi,%edx
  802031:	f7 74 24 0c          	divl   0xc(%esp)
  802035:	89 d6                	mov    %edx,%esi
  802037:	89 c3                	mov    %eax,%ebx
  802039:	f7 e5                	mul    %ebp
  80203b:	39 d6                	cmp    %edx,%esi
  80203d:	72 19                	jb     802058 <__udivdi3+0xfc>
  80203f:	74 0b                	je     80204c <__udivdi3+0xf0>
  802041:	89 d8                	mov    %ebx,%eax
  802043:	31 ff                	xor    %edi,%edi
  802045:	e9 58 ff ff ff       	jmp    801fa2 <__udivdi3+0x46>
  80204a:	66 90                	xchg   %ax,%ax
  80204c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802050:	89 f9                	mov    %edi,%ecx
  802052:	d3 e2                	shl    %cl,%edx
  802054:	39 c2                	cmp    %eax,%edx
  802056:	73 e9                	jae    802041 <__udivdi3+0xe5>
  802058:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80205b:	31 ff                	xor    %edi,%edi
  80205d:	e9 40 ff ff ff       	jmp    801fa2 <__udivdi3+0x46>
  802062:	66 90                	xchg   %ax,%ax
  802064:	31 c0                	xor    %eax,%eax
  802066:	e9 37 ff ff ff       	jmp    801fa2 <__udivdi3+0x46>
  80206b:	90                   	nop

0080206c <__umoddi3>:
  80206c:	55                   	push   %ebp
  80206d:	57                   	push   %edi
  80206e:	56                   	push   %esi
  80206f:	53                   	push   %ebx
  802070:	83 ec 1c             	sub    $0x1c,%esp
  802073:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802077:	8b 74 24 34          	mov    0x34(%esp),%esi
  80207b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80207f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802083:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802087:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80208b:	89 f3                	mov    %esi,%ebx
  80208d:	89 fa                	mov    %edi,%edx
  80208f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802093:	89 34 24             	mov    %esi,(%esp)
  802096:	85 c0                	test   %eax,%eax
  802098:	75 1a                	jne    8020b4 <__umoddi3+0x48>
  80209a:	39 f7                	cmp    %esi,%edi
  80209c:	0f 86 a2 00 00 00    	jbe    802144 <__umoddi3+0xd8>
  8020a2:	89 c8                	mov    %ecx,%eax
  8020a4:	89 f2                	mov    %esi,%edx
  8020a6:	f7 f7                	div    %edi
  8020a8:	89 d0                	mov    %edx,%eax
  8020aa:	31 d2                	xor    %edx,%edx
  8020ac:	83 c4 1c             	add    $0x1c,%esp
  8020af:	5b                   	pop    %ebx
  8020b0:	5e                   	pop    %esi
  8020b1:	5f                   	pop    %edi
  8020b2:	5d                   	pop    %ebp
  8020b3:	c3                   	ret    
  8020b4:	39 f0                	cmp    %esi,%eax
  8020b6:	0f 87 ac 00 00 00    	ja     802168 <__umoddi3+0xfc>
  8020bc:	0f bd e8             	bsr    %eax,%ebp
  8020bf:	83 f5 1f             	xor    $0x1f,%ebp
  8020c2:	0f 84 ac 00 00 00    	je     802174 <__umoddi3+0x108>
  8020c8:	bf 20 00 00 00       	mov    $0x20,%edi
  8020cd:	29 ef                	sub    %ebp,%edi
  8020cf:	89 fe                	mov    %edi,%esi
  8020d1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8020d5:	89 e9                	mov    %ebp,%ecx
  8020d7:	d3 e0                	shl    %cl,%eax
  8020d9:	89 d7                	mov    %edx,%edi
  8020db:	89 f1                	mov    %esi,%ecx
  8020dd:	d3 ef                	shr    %cl,%edi
  8020df:	09 c7                	or     %eax,%edi
  8020e1:	89 e9                	mov    %ebp,%ecx
  8020e3:	d3 e2                	shl    %cl,%edx
  8020e5:	89 14 24             	mov    %edx,(%esp)
  8020e8:	89 d8                	mov    %ebx,%eax
  8020ea:	d3 e0                	shl    %cl,%eax
  8020ec:	89 c2                	mov    %eax,%edx
  8020ee:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020f2:	d3 e0                	shl    %cl,%eax
  8020f4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8020f8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020fc:	89 f1                	mov    %esi,%ecx
  8020fe:	d3 e8                	shr    %cl,%eax
  802100:	09 d0                	or     %edx,%eax
  802102:	d3 eb                	shr    %cl,%ebx
  802104:	89 da                	mov    %ebx,%edx
  802106:	f7 f7                	div    %edi
  802108:	89 d3                	mov    %edx,%ebx
  80210a:	f7 24 24             	mull   (%esp)
  80210d:	89 c6                	mov    %eax,%esi
  80210f:	89 d1                	mov    %edx,%ecx
  802111:	39 d3                	cmp    %edx,%ebx
  802113:	0f 82 87 00 00 00    	jb     8021a0 <__umoddi3+0x134>
  802119:	0f 84 91 00 00 00    	je     8021b0 <__umoddi3+0x144>
  80211f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802123:	29 f2                	sub    %esi,%edx
  802125:	19 cb                	sbb    %ecx,%ebx
  802127:	89 d8                	mov    %ebx,%eax
  802129:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80212d:	d3 e0                	shl    %cl,%eax
  80212f:	89 e9                	mov    %ebp,%ecx
  802131:	d3 ea                	shr    %cl,%edx
  802133:	09 d0                	or     %edx,%eax
  802135:	89 e9                	mov    %ebp,%ecx
  802137:	d3 eb                	shr    %cl,%ebx
  802139:	89 da                	mov    %ebx,%edx
  80213b:	83 c4 1c             	add    $0x1c,%esp
  80213e:	5b                   	pop    %ebx
  80213f:	5e                   	pop    %esi
  802140:	5f                   	pop    %edi
  802141:	5d                   	pop    %ebp
  802142:	c3                   	ret    
  802143:	90                   	nop
  802144:	89 fd                	mov    %edi,%ebp
  802146:	85 ff                	test   %edi,%edi
  802148:	75 0b                	jne    802155 <__umoddi3+0xe9>
  80214a:	b8 01 00 00 00       	mov    $0x1,%eax
  80214f:	31 d2                	xor    %edx,%edx
  802151:	f7 f7                	div    %edi
  802153:	89 c5                	mov    %eax,%ebp
  802155:	89 f0                	mov    %esi,%eax
  802157:	31 d2                	xor    %edx,%edx
  802159:	f7 f5                	div    %ebp
  80215b:	89 c8                	mov    %ecx,%eax
  80215d:	f7 f5                	div    %ebp
  80215f:	89 d0                	mov    %edx,%eax
  802161:	e9 44 ff ff ff       	jmp    8020aa <__umoddi3+0x3e>
  802166:	66 90                	xchg   %ax,%ax
  802168:	89 c8                	mov    %ecx,%eax
  80216a:	89 f2                	mov    %esi,%edx
  80216c:	83 c4 1c             	add    $0x1c,%esp
  80216f:	5b                   	pop    %ebx
  802170:	5e                   	pop    %esi
  802171:	5f                   	pop    %edi
  802172:	5d                   	pop    %ebp
  802173:	c3                   	ret    
  802174:	3b 04 24             	cmp    (%esp),%eax
  802177:	72 06                	jb     80217f <__umoddi3+0x113>
  802179:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80217d:	77 0f                	ja     80218e <__umoddi3+0x122>
  80217f:	89 f2                	mov    %esi,%edx
  802181:	29 f9                	sub    %edi,%ecx
  802183:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802187:	89 14 24             	mov    %edx,(%esp)
  80218a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80218e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802192:	8b 14 24             	mov    (%esp),%edx
  802195:	83 c4 1c             	add    $0x1c,%esp
  802198:	5b                   	pop    %ebx
  802199:	5e                   	pop    %esi
  80219a:	5f                   	pop    %edi
  80219b:	5d                   	pop    %ebp
  80219c:	c3                   	ret    
  80219d:	8d 76 00             	lea    0x0(%esi),%esi
  8021a0:	2b 04 24             	sub    (%esp),%eax
  8021a3:	19 fa                	sbb    %edi,%edx
  8021a5:	89 d1                	mov    %edx,%ecx
  8021a7:	89 c6                	mov    %eax,%esi
  8021a9:	e9 71 ff ff ff       	jmp    80211f <__umoddi3+0xb3>
  8021ae:	66 90                	xchg   %ax,%ax
  8021b0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8021b4:	72 ea                	jb     8021a0 <__umoddi3+0x134>
  8021b6:	89 d9                	mov    %ebx,%ecx
  8021b8:	e9 62 ff ff ff       	jmp    80211f <__umoddi3+0xb3>
