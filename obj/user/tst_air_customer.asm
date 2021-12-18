
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
  800044:	e8 0d 17 00 00       	call   801756 <sys_getparentenvid>
  800049:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	char _customers[] = "customers";
  80004c:	8d 45 c2             	lea    -0x3e(%ebp),%eax
  80004f:	bb 89 21 80 00       	mov    $0x802189,%ebx
  800054:	ba 0a 00 00 00       	mov    $0xa,%edx
  800059:	89 c7                	mov    %eax,%edi
  80005b:	89 de                	mov    %ebx,%esi
  80005d:	89 d1                	mov    %edx,%ecx
  80005f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custCounter[] = "custCounter";
  800061:	8d 45 b6             	lea    -0x4a(%ebp),%eax
  800064:	bb 93 21 80 00       	mov    $0x802193,%ebx
  800069:	ba 03 00 00 00       	mov    $0x3,%edx
  80006e:	89 c7                	mov    %eax,%edi
  800070:	89 de                	mov    %ebx,%esi
  800072:	89 d1                	mov    %edx,%ecx
  800074:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1Counter[] = "flight1Counter";
  800076:	8d 45 a7             	lea    -0x59(%ebp),%eax
  800079:	bb 9f 21 80 00       	mov    $0x80219f,%ebx
  80007e:	ba 0f 00 00 00       	mov    $0xf,%edx
  800083:	89 c7                	mov    %eax,%edi
  800085:	89 de                	mov    %ebx,%esi
  800087:	89 d1                	mov    %edx,%ecx
  800089:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2Counter[] = "flight2Counter";
  80008b:	8d 45 98             	lea    -0x68(%ebp),%eax
  80008e:	bb ae 21 80 00       	mov    $0x8021ae,%ebx
  800093:	ba 0f 00 00 00       	mov    $0xf,%edx
  800098:	89 c7                	mov    %eax,%edi
  80009a:	89 de                	mov    %ebx,%esi
  80009c:	89 d1                	mov    %edx,%ecx
  80009e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Counter[] = "flightBooked1Counter";
  8000a0:	8d 45 83             	lea    -0x7d(%ebp),%eax
  8000a3:	bb bd 21 80 00       	mov    $0x8021bd,%ebx
  8000a8:	ba 15 00 00 00       	mov    $0x15,%edx
  8000ad:	89 c7                	mov    %eax,%edi
  8000af:	89 de                	mov    %ebx,%esi
  8000b1:	89 d1                	mov    %edx,%ecx
  8000b3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Counter[] = "flightBooked2Counter";
  8000b5:	8d 85 6e ff ff ff    	lea    -0x92(%ebp),%eax
  8000bb:	bb d2 21 80 00       	mov    $0x8021d2,%ebx
  8000c0:	ba 15 00 00 00       	mov    $0x15,%edx
  8000c5:	89 c7                	mov    %eax,%edi
  8000c7:	89 de                	mov    %ebx,%esi
  8000c9:	89 d1                	mov    %edx,%ecx
  8000cb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Arr[] = "flightBooked1Arr";
  8000cd:	8d 85 5d ff ff ff    	lea    -0xa3(%ebp),%eax
  8000d3:	bb e7 21 80 00       	mov    $0x8021e7,%ebx
  8000d8:	ba 11 00 00 00       	mov    $0x11,%edx
  8000dd:	89 c7                	mov    %eax,%edi
  8000df:	89 de                	mov    %ebx,%esi
  8000e1:	89 d1                	mov    %edx,%ecx
  8000e3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Arr[] = "flightBooked2Arr";
  8000e5:	8d 85 4c ff ff ff    	lea    -0xb4(%ebp),%eax
  8000eb:	bb f8 21 80 00       	mov    $0x8021f8,%ebx
  8000f0:	ba 11 00 00 00       	mov    $0x11,%edx
  8000f5:	89 c7                	mov    %eax,%edi
  8000f7:	89 de                	mov    %ebx,%esi
  8000f9:	89 d1                	mov    %edx,%ecx
  8000fb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _cust_ready_queue[] = "cust_ready_queue";
  8000fd:	8d 85 3b ff ff ff    	lea    -0xc5(%ebp),%eax
  800103:	bb 09 22 80 00       	mov    $0x802209,%ebx
  800108:	ba 11 00 00 00       	mov    $0x11,%edx
  80010d:	89 c7                	mov    %eax,%edi
  80010f:	89 de                	mov    %ebx,%esi
  800111:	89 d1                	mov    %edx,%ecx
  800113:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_in[] = "queue_in";
  800115:	8d 85 32 ff ff ff    	lea    -0xce(%ebp),%eax
  80011b:	bb 1a 22 80 00       	mov    $0x80221a,%ebx
  800120:	ba 09 00 00 00       	mov    $0x9,%edx
  800125:	89 c7                	mov    %eax,%edi
  800127:	89 de                	mov    %ebx,%esi
  800129:	89 d1                	mov    %edx,%ecx
  80012b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_out[] = "queue_out";
  80012d:	8d 85 28 ff ff ff    	lea    -0xd8(%ebp),%eax
  800133:	bb 23 22 80 00       	mov    $0x802223,%ebx
  800138:	ba 0a 00 00 00       	mov    $0xa,%edx
  80013d:	89 c7                	mov    %eax,%edi
  80013f:	89 de                	mov    %ebx,%esi
  800141:	89 d1                	mov    %edx,%ecx
  800143:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _cust_ready[] = "cust_ready";
  800145:	8d 85 1d ff ff ff    	lea    -0xe3(%ebp),%eax
  80014b:	bb 2d 22 80 00       	mov    $0x80222d,%ebx
  800150:	ba 0b 00 00 00       	mov    $0xb,%edx
  800155:	89 c7                	mov    %eax,%edi
  800157:	89 de                	mov    %ebx,%esi
  800159:	89 d1                	mov    %edx,%ecx
  80015b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custQueueCS[] = "custQueueCS";
  80015d:	8d 85 11 ff ff ff    	lea    -0xef(%ebp),%eax
  800163:	bb 38 22 80 00       	mov    $0x802238,%ebx
  800168:	ba 03 00 00 00       	mov    $0x3,%edx
  80016d:	89 c7                	mov    %eax,%edi
  80016f:	89 de                	mov    %ebx,%esi
  800171:	89 d1                	mov    %edx,%ecx
  800173:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1CS[] = "flight1CS";
  800175:	8d 85 07 ff ff ff    	lea    -0xf9(%ebp),%eax
  80017b:	bb 44 22 80 00       	mov    $0x802244,%ebx
  800180:	ba 0a 00 00 00       	mov    $0xa,%edx
  800185:	89 c7                	mov    %eax,%edi
  800187:	89 de                	mov    %ebx,%esi
  800189:	89 d1                	mov    %edx,%ecx
  80018b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2CS[] = "flight2CS";
  80018d:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800193:	bb 4e 22 80 00       	mov    $0x80224e,%ebx
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
  8001be:	bb 58 22 80 00       	mov    $0x802258,%ebx
  8001c3:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001c8:	89 c7                	mov    %eax,%edi
  8001ca:	89 de                	mov    %ebx,%esi
  8001cc:	89 d1                	mov    %edx,%ecx
  8001ce:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custTerminated[] = "custTerminated";
  8001d0:	8d 85 da fe ff ff    	lea    -0x126(%ebp),%eax
  8001d6:	bb 66 22 80 00       	mov    $0x802266,%ebx
  8001db:	ba 0f 00 00 00       	mov    $0xf,%edx
  8001e0:	89 c7                	mov    %eax,%edi
  8001e2:	89 de                	mov    %ebx,%esi
  8001e4:	89 d1                	mov    %edx,%ecx
  8001e6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _taircl[] = "taircl";
  8001e8:	8d 85 d3 fe ff ff    	lea    -0x12d(%ebp),%eax
  8001ee:	bb 75 22 80 00       	mov    $0x802275,%ebx
  8001f3:	ba 07 00 00 00       	mov    $0x7,%edx
  8001f8:	89 c7                	mov    %eax,%edi
  8001fa:	89 de                	mov    %ebx,%esi
  8001fc:	89 d1                	mov    %edx,%ecx
  8001fe:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _taircu[] = "taircu";
  800200:	8d 85 cc fe ff ff    	lea    -0x134(%ebp),%eax
  800206:	bb 7c 22 80 00       	mov    $0x80227c,%ebx
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
  800222:	e8 c7 13 00 00       	call   8015ee <sget>
  800227:	83 c4 10             	add    $0x10,%esp
  80022a:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int* custCounter = sget(parentenvID, _custCounter);
  80022d:	83 ec 08             	sub    $0x8,%esp
  800230:	8d 45 b6             	lea    -0x4a(%ebp),%eax
  800233:	50                   	push   %eax
  800234:	ff 75 e4             	pushl  -0x1c(%ebp)
  800237:	e8 b2 13 00 00       	call   8015ee <sget>
  80023c:	83 c4 10             	add    $0x10,%esp
  80023f:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int* cust_ready_queue = sget(parentenvID, _cust_ready_queue);
  800242:	83 ec 08             	sub    $0x8,%esp
  800245:	8d 85 3b ff ff ff    	lea    -0xc5(%ebp),%eax
  80024b:	50                   	push   %eax
  80024c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80024f:	e8 9a 13 00 00       	call   8015ee <sget>
  800254:	83 c4 10             	add    $0x10,%esp
  800257:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* queue_in = sget(parentenvID, _queue_in);
  80025a:	83 ec 08             	sub    $0x8,%esp
  80025d:	8d 85 32 ff ff ff    	lea    -0xce(%ebp),%eax
  800263:	50                   	push   %eax
  800264:	ff 75 e4             	pushl  -0x1c(%ebp)
  800267:	e8 82 13 00 00       	call   8015ee <sget>
  80026c:	83 c4 10             	add    $0x10,%esp
  80026f:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	// *********************************************************************************

	int custId, flightType;
	sys_waitSemaphore(parentenvID, _custCounterCS);
  800272:	83 ec 08             	sub    $0x8,%esp
  800275:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80027b:	50                   	push   %eax
  80027c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80027f:	e8 01 17 00 00       	call   801985 <sys_waitSemaphore>
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
  8002a9:	e8 f5 16 00 00       	call   8019a3 <sys_signalSemaphore>
  8002ae:	83 c4 10             	add    $0x10,%esp

	//wait on one of the clerks
	sys_waitSemaphore(parentenvID, _clerk);
  8002b1:	83 ec 08             	sub    $0x8,%esp
  8002b4:	8d 85 f7 fe ff ff    	lea    -0x109(%ebp),%eax
  8002ba:	50                   	push   %eax
  8002bb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002be:	e8 c2 16 00 00       	call   801985 <sys_waitSemaphore>
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
  8002e7:	e8 99 16 00 00       	call   801985 <sys_waitSemaphore>
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
  80031f:	e8 7f 16 00 00       	call   8019a3 <sys_signalSemaphore>
  800324:	83 c4 10             	add    $0x10,%esp

	//signal ready
	sys_signalSemaphore(parentenvID, _cust_ready);
  800327:	83 ec 08             	sub    $0x8,%esp
  80032a:	8d 85 1d ff ff ff    	lea    -0xe3(%ebp),%eax
  800330:	50                   	push   %eax
  800331:	ff 75 e4             	pushl  -0x1c(%ebp)
  800334:	e8 6a 16 00 00       	call   8019a3 <sys_signalSemaphore>
  800339:	83 c4 10             	add    $0x10,%esp

	//wait on finished
	char prefix[30]="cust_finished";
  80033c:	8d 85 ae fe ff ff    	lea    -0x152(%ebp),%eax
  800342:	bb 83 22 80 00       	mov    $0x802283,%ebx
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
  8003aa:	e8 d6 15 00 00       	call   801985 <sys_waitSemaphore>
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
  8003d2:	68 40 21 80 00       	push   $0x802140
  8003d7:	e8 4f 02 00 00       	call   80062b <cprintf>
  8003dc:	83 c4 10             	add    $0x10,%esp
  8003df:	eb 13                	jmp    8003f4 <_main+0x3bc>
	}
	else
	{
		cprintf("cust %d: finished (NOT BOOKED) \n", custId);
  8003e1:	83 ec 08             	sub    $0x8,%esp
  8003e4:	ff 75 d0             	pushl  -0x30(%ebp)
  8003e7:	68 68 21 80 00       	push   $0x802168
  8003ec:	e8 3a 02 00 00       	call   80062b <cprintf>
  8003f1:	83 c4 10             	add    $0x10,%esp
	}

	//customer is terminated
	sys_signalSemaphore(parentenvID, _custTerminated);
  8003f4:	83 ec 08             	sub    $0x8,%esp
  8003f7:	8d 85 da fe ff ff    	lea    -0x126(%ebp),%eax
  8003fd:	50                   	push   %eax
  8003fe:	ff 75 e4             	pushl  -0x1c(%ebp)
  800401:	e8 9d 15 00 00       	call   8019a3 <sys_signalSemaphore>
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
  800418:	e8 20 13 00 00       	call   80173d <sys_getenvindex>
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
  800495:	e8 3e 14 00 00       	call   8018d8 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80049a:	83 ec 0c             	sub    $0xc,%esp
  80049d:	68 bc 22 80 00       	push   $0x8022bc
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
  8004c5:	68 e4 22 80 00       	push   $0x8022e4
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
  8004ed:	68 0c 23 80 00       	push   $0x80230c
  8004f2:	e8 34 01 00 00       	call   80062b <cprintf>
  8004f7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8004fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ff:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800505:	83 ec 08             	sub    $0x8,%esp
  800508:	50                   	push   %eax
  800509:	68 4d 23 80 00       	push   $0x80234d
  80050e:	e8 18 01 00 00       	call   80062b <cprintf>
  800513:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800516:	83 ec 0c             	sub    $0xc,%esp
  800519:	68 bc 22 80 00       	push   $0x8022bc
  80051e:	e8 08 01 00 00       	call   80062b <cprintf>
  800523:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800526:	e8 c7 13 00 00       	call   8018f2 <sys_enable_interrupt>

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
  80053e:	e8 c6 11 00 00       	call   801709 <sys_env_destroy>
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
  80054f:	e8 1b 12 00 00       	call   80176f <sys_env_exit>
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
  80059d:	e8 25 11 00 00       	call   8016c7 <sys_cputs>
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
  800614:	e8 ae 10 00 00       	call   8016c7 <sys_cputs>
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
  80065e:	e8 75 12 00 00       	call   8018d8 <sys_disable_interrupt>
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
  80067e:	e8 6f 12 00 00       	call   8018f2 <sys_enable_interrupt>
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
  8006c8:	e8 fb 17 00 00       	call   801ec8 <__udivdi3>
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
  800718:	e8 bb 18 00 00       	call   801fd8 <__umoddi3>
  80071d:	83 c4 10             	add    $0x10,%esp
  800720:	05 94 25 80 00       	add    $0x802594,%eax
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
  800873:	8b 04 85 b8 25 80 00 	mov    0x8025b8(,%eax,4),%eax
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
  800954:	8b 34 9d 00 24 80 00 	mov    0x802400(,%ebx,4),%esi
  80095b:	85 f6                	test   %esi,%esi
  80095d:	75 19                	jne    800978 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80095f:	53                   	push   %ebx
  800960:	68 a5 25 80 00       	push   $0x8025a5
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
  800979:	68 ae 25 80 00       	push   $0x8025ae
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
  8009a6:	be b1 25 80 00       	mov    $0x8025b1,%esi
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
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
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
  8013ea:	e8 80 04 00 00       	call   80186f <sys_allocateMem>
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
  801416:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  80141d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801422:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801428:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  80142f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801434:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
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
  801467:	e8 03 04 00 00       	call   80186f <sys_allocateMem>
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
  801493:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  80149a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80149f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8014a2:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8014a9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014ae:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
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
  80152c:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
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
  80157c:	e8 ee 02 00 00       	call   80186f <sys_allocateMem>
  801581:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801584:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801589:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80158c:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801593:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801598:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80159e:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8015a5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8015aa:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
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
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details
}
  8015c8:	90                   	nop
  8015c9:	5d                   	pop    %ebp
  8015ca:	c3                   	ret    

008015cb <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8015cb:	55                   	push   %ebp
  8015cc:	89 e5                	mov    %esp,%ebp
  8015ce:	83 ec 18             	sub    $0x18,%esp
  8015d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d4:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8015d7:	83 ec 04             	sub    $0x4,%esp
  8015da:	68 10 27 80 00       	push   $0x802710
  8015df:	68 8d 00 00 00       	push   $0x8d
  8015e4:	68 33 27 80 00       	push   $0x802733
  8015e9:	e8 0b 07 00 00       	call   801cf9 <_panic>

008015ee <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8015ee:	55                   	push   %ebp
  8015ef:	89 e5                	mov    %esp,%ebp
  8015f1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015f4:	83 ec 04             	sub    $0x4,%esp
  8015f7:	68 10 27 80 00       	push   $0x802710
  8015fc:	68 93 00 00 00       	push   $0x93
  801601:	68 33 27 80 00       	push   $0x802733
  801606:	e8 ee 06 00 00       	call   801cf9 <_panic>

0080160b <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
  80160e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801611:	83 ec 04             	sub    $0x4,%esp
  801614:	68 10 27 80 00       	push   $0x802710
  801619:	68 99 00 00 00       	push   $0x99
  80161e:	68 33 27 80 00       	push   $0x802733
  801623:	e8 d1 06 00 00       	call   801cf9 <_panic>

00801628 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801628:	55                   	push   %ebp
  801629:	89 e5                	mov    %esp,%ebp
  80162b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80162e:	83 ec 04             	sub    $0x4,%esp
  801631:	68 10 27 80 00       	push   $0x802710
  801636:	68 9e 00 00 00       	push   $0x9e
  80163b:	68 33 27 80 00       	push   $0x802733
  801640:	e8 b4 06 00 00       	call   801cf9 <_panic>

00801645 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801645:	55                   	push   %ebp
  801646:	89 e5                	mov    %esp,%ebp
  801648:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80164b:	83 ec 04             	sub    $0x4,%esp
  80164e:	68 10 27 80 00       	push   $0x802710
  801653:	68 a4 00 00 00       	push   $0xa4
  801658:	68 33 27 80 00       	push   $0x802733
  80165d:	e8 97 06 00 00       	call   801cf9 <_panic>

00801662 <shrink>:
}
void shrink(uint32 newSize)
{
  801662:	55                   	push   %ebp
  801663:	89 e5                	mov    %esp,%ebp
  801665:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801668:	83 ec 04             	sub    $0x4,%esp
  80166b:	68 10 27 80 00       	push   $0x802710
  801670:	68 a8 00 00 00       	push   $0xa8
  801675:	68 33 27 80 00       	push   $0x802733
  80167a:	e8 7a 06 00 00       	call   801cf9 <_panic>

0080167f <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  80167f:	55                   	push   %ebp
  801680:	89 e5                	mov    %esp,%ebp
  801682:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801685:	83 ec 04             	sub    $0x4,%esp
  801688:	68 10 27 80 00       	push   $0x802710
  80168d:	68 ad 00 00 00       	push   $0xad
  801692:	68 33 27 80 00       	push   $0x802733
  801697:	e8 5d 06 00 00       	call   801cf9 <_panic>

0080169c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80169c:	55                   	push   %ebp
  80169d:	89 e5                	mov    %esp,%ebp
  80169f:	57                   	push   %edi
  8016a0:	56                   	push   %esi
  8016a1:	53                   	push   %ebx
  8016a2:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016ae:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016b1:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016b4:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016b7:	cd 30                	int    $0x30
  8016b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016bf:	83 c4 10             	add    $0x10,%esp
  8016c2:	5b                   	pop    %ebx
  8016c3:	5e                   	pop    %esi
  8016c4:	5f                   	pop    %edi
  8016c5:	5d                   	pop    %ebp
  8016c6:	c3                   	ret    

008016c7 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8016c7:	55                   	push   %ebp
  8016c8:	89 e5                	mov    %esp,%ebp
  8016ca:	83 ec 04             	sub    $0x4,%esp
  8016cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8016d3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8016d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	52                   	push   %edx
  8016df:	ff 75 0c             	pushl  0xc(%ebp)
  8016e2:	50                   	push   %eax
  8016e3:	6a 00                	push   $0x0
  8016e5:	e8 b2 ff ff ff       	call   80169c <syscall>
  8016ea:	83 c4 18             	add    $0x18,%esp
}
  8016ed:	90                   	nop
  8016ee:	c9                   	leave  
  8016ef:	c3                   	ret    

008016f0 <sys_cgetc>:

int
sys_cgetc(void)
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 01                	push   $0x1
  8016ff:	e8 98 ff ff ff       	call   80169c <syscall>
  801704:	83 c4 18             	add    $0x18,%esp
}
  801707:	c9                   	leave  
  801708:	c3                   	ret    

00801709 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801709:	55                   	push   %ebp
  80170a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80170c:	8b 45 08             	mov    0x8(%ebp),%eax
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	50                   	push   %eax
  801718:	6a 05                	push   $0x5
  80171a:	e8 7d ff ff ff       	call   80169c <syscall>
  80171f:	83 c4 18             	add    $0x18,%esp
}
  801722:	c9                   	leave  
  801723:	c3                   	ret    

00801724 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801724:	55                   	push   %ebp
  801725:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 02                	push   $0x2
  801733:	e8 64 ff ff ff       	call   80169c <syscall>
  801738:	83 c4 18             	add    $0x18,%esp
}
  80173b:	c9                   	leave  
  80173c:	c3                   	ret    

0080173d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80173d:	55                   	push   %ebp
  80173e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 03                	push   $0x3
  80174c:	e8 4b ff ff ff       	call   80169c <syscall>
  801751:	83 c4 18             	add    $0x18,%esp
}
  801754:	c9                   	leave  
  801755:	c3                   	ret    

00801756 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801756:	55                   	push   %ebp
  801757:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 04                	push   $0x4
  801765:	e8 32 ff ff ff       	call   80169c <syscall>
  80176a:	83 c4 18             	add    $0x18,%esp
}
  80176d:	c9                   	leave  
  80176e:	c3                   	ret    

0080176f <sys_env_exit>:


void sys_env_exit(void)
{
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 06                	push   $0x6
  80177e:	e8 19 ff ff ff       	call   80169c <syscall>
  801783:	83 c4 18             	add    $0x18,%esp
}
  801786:	90                   	nop
  801787:	c9                   	leave  
  801788:	c3                   	ret    

00801789 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801789:	55                   	push   %ebp
  80178a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80178c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80178f:	8b 45 08             	mov    0x8(%ebp),%eax
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	52                   	push   %edx
  801799:	50                   	push   %eax
  80179a:	6a 07                	push   $0x7
  80179c:	e8 fb fe ff ff       	call   80169c <syscall>
  8017a1:	83 c4 18             	add    $0x18,%esp
}
  8017a4:	c9                   	leave  
  8017a5:	c3                   	ret    

008017a6 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017a6:	55                   	push   %ebp
  8017a7:	89 e5                	mov    %esp,%ebp
  8017a9:	56                   	push   %esi
  8017aa:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017ab:	8b 75 18             	mov    0x18(%ebp),%esi
  8017ae:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017b1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ba:	56                   	push   %esi
  8017bb:	53                   	push   %ebx
  8017bc:	51                   	push   %ecx
  8017bd:	52                   	push   %edx
  8017be:	50                   	push   %eax
  8017bf:	6a 08                	push   $0x8
  8017c1:	e8 d6 fe ff ff       	call   80169c <syscall>
  8017c6:	83 c4 18             	add    $0x18,%esp
}
  8017c9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017cc:	5b                   	pop    %ebx
  8017cd:	5e                   	pop    %esi
  8017ce:	5d                   	pop    %ebp
  8017cf:	c3                   	ret    

008017d0 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8017d0:	55                   	push   %ebp
  8017d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8017d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	52                   	push   %edx
  8017e0:	50                   	push   %eax
  8017e1:	6a 09                	push   $0x9
  8017e3:	e8 b4 fe ff ff       	call   80169c <syscall>
  8017e8:	83 c4 18             	add    $0x18,%esp
}
  8017eb:	c9                   	leave  
  8017ec:	c3                   	ret    

008017ed <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8017ed:	55                   	push   %ebp
  8017ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	ff 75 0c             	pushl  0xc(%ebp)
  8017f9:	ff 75 08             	pushl  0x8(%ebp)
  8017fc:	6a 0a                	push   $0xa
  8017fe:	e8 99 fe ff ff       	call   80169c <syscall>
  801803:	83 c4 18             	add    $0x18,%esp
}
  801806:	c9                   	leave  
  801807:	c3                   	ret    

00801808 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801808:	55                   	push   %ebp
  801809:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 0b                	push   $0xb
  801817:	e8 80 fe ff ff       	call   80169c <syscall>
  80181c:	83 c4 18             	add    $0x18,%esp
}
  80181f:	c9                   	leave  
  801820:	c3                   	ret    

00801821 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801821:	55                   	push   %ebp
  801822:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 0c                	push   $0xc
  801830:	e8 67 fe ff ff       	call   80169c <syscall>
  801835:	83 c4 18             	add    $0x18,%esp
}
  801838:	c9                   	leave  
  801839:	c3                   	ret    

0080183a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80183a:	55                   	push   %ebp
  80183b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 0d                	push   $0xd
  801849:	e8 4e fe ff ff       	call   80169c <syscall>
  80184e:	83 c4 18             	add    $0x18,%esp
}
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801853:	55                   	push   %ebp
  801854:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	ff 75 0c             	pushl  0xc(%ebp)
  80185f:	ff 75 08             	pushl  0x8(%ebp)
  801862:	6a 11                	push   $0x11
  801864:	e8 33 fe ff ff       	call   80169c <syscall>
  801869:	83 c4 18             	add    $0x18,%esp
	return;
  80186c:	90                   	nop
}
  80186d:	c9                   	leave  
  80186e:	c3                   	ret    

0080186f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80186f:	55                   	push   %ebp
  801870:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	ff 75 0c             	pushl  0xc(%ebp)
  80187b:	ff 75 08             	pushl  0x8(%ebp)
  80187e:	6a 12                	push   $0x12
  801880:	e8 17 fe ff ff       	call   80169c <syscall>
  801885:	83 c4 18             	add    $0x18,%esp
	return ;
  801888:	90                   	nop
}
  801889:	c9                   	leave  
  80188a:	c3                   	ret    

0080188b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80188b:	55                   	push   %ebp
  80188c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 0e                	push   $0xe
  80189a:	e8 fd fd ff ff       	call   80169c <syscall>
  80189f:	83 c4 18             	add    $0x18,%esp
}
  8018a2:	c9                   	leave  
  8018a3:	c3                   	ret    

008018a4 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018a4:	55                   	push   %ebp
  8018a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	ff 75 08             	pushl  0x8(%ebp)
  8018b2:	6a 0f                	push   $0xf
  8018b4:	e8 e3 fd ff ff       	call   80169c <syscall>
  8018b9:	83 c4 18             	add    $0x18,%esp
}
  8018bc:	c9                   	leave  
  8018bd:	c3                   	ret    

008018be <sys_scarce_memory>:

void sys_scarce_memory()
{
  8018be:	55                   	push   %ebp
  8018bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 10                	push   $0x10
  8018cd:	e8 ca fd ff ff       	call   80169c <syscall>
  8018d2:	83 c4 18             	add    $0x18,%esp
}
  8018d5:	90                   	nop
  8018d6:	c9                   	leave  
  8018d7:	c3                   	ret    

008018d8 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8018d8:	55                   	push   %ebp
  8018d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 14                	push   $0x14
  8018e7:	e8 b0 fd ff ff       	call   80169c <syscall>
  8018ec:	83 c4 18             	add    $0x18,%esp
}
  8018ef:	90                   	nop
  8018f0:	c9                   	leave  
  8018f1:	c3                   	ret    

008018f2 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8018f2:	55                   	push   %ebp
  8018f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 15                	push   $0x15
  801901:	e8 96 fd ff ff       	call   80169c <syscall>
  801906:	83 c4 18             	add    $0x18,%esp
}
  801909:	90                   	nop
  80190a:	c9                   	leave  
  80190b:	c3                   	ret    

0080190c <sys_cputc>:


void
sys_cputc(const char c)
{
  80190c:	55                   	push   %ebp
  80190d:	89 e5                	mov    %esp,%ebp
  80190f:	83 ec 04             	sub    $0x4,%esp
  801912:	8b 45 08             	mov    0x8(%ebp),%eax
  801915:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801918:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	50                   	push   %eax
  801925:	6a 16                	push   $0x16
  801927:	e8 70 fd ff ff       	call   80169c <syscall>
  80192c:	83 c4 18             	add    $0x18,%esp
}
  80192f:	90                   	nop
  801930:	c9                   	leave  
  801931:	c3                   	ret    

00801932 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801932:	55                   	push   %ebp
  801933:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 17                	push   $0x17
  801941:	e8 56 fd ff ff       	call   80169c <syscall>
  801946:	83 c4 18             	add    $0x18,%esp
}
  801949:	90                   	nop
  80194a:	c9                   	leave  
  80194b:	c3                   	ret    

0080194c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80194c:	55                   	push   %ebp
  80194d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80194f:	8b 45 08             	mov    0x8(%ebp),%eax
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	ff 75 0c             	pushl  0xc(%ebp)
  80195b:	50                   	push   %eax
  80195c:	6a 18                	push   $0x18
  80195e:	e8 39 fd ff ff       	call   80169c <syscall>
  801963:	83 c4 18             	add    $0x18,%esp
}
  801966:	c9                   	leave  
  801967:	c3                   	ret    

00801968 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801968:	55                   	push   %ebp
  801969:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80196b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80196e:	8b 45 08             	mov    0x8(%ebp),%eax
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	52                   	push   %edx
  801978:	50                   	push   %eax
  801979:	6a 1b                	push   $0x1b
  80197b:	e8 1c fd ff ff       	call   80169c <syscall>
  801980:	83 c4 18             	add    $0x18,%esp
}
  801983:	c9                   	leave  
  801984:	c3                   	ret    

00801985 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801985:	55                   	push   %ebp
  801986:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801988:	8b 55 0c             	mov    0xc(%ebp),%edx
  80198b:	8b 45 08             	mov    0x8(%ebp),%eax
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	52                   	push   %edx
  801995:	50                   	push   %eax
  801996:	6a 19                	push   $0x19
  801998:	e8 ff fc ff ff       	call   80169c <syscall>
  80199d:	83 c4 18             	add    $0x18,%esp
}
  8019a0:	90                   	nop
  8019a1:	c9                   	leave  
  8019a2:	c3                   	ret    

008019a3 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019a3:	55                   	push   %ebp
  8019a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	52                   	push   %edx
  8019b3:	50                   	push   %eax
  8019b4:	6a 1a                	push   $0x1a
  8019b6:	e8 e1 fc ff ff       	call   80169c <syscall>
  8019bb:	83 c4 18             	add    $0x18,%esp
}
  8019be:	90                   	nop
  8019bf:	c9                   	leave  
  8019c0:	c3                   	ret    

008019c1 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8019c1:	55                   	push   %ebp
  8019c2:	89 e5                	mov    %esp,%ebp
  8019c4:	83 ec 04             	sub    $0x4,%esp
  8019c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ca:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8019cd:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8019d0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8019d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d7:	6a 00                	push   $0x0
  8019d9:	51                   	push   %ecx
  8019da:	52                   	push   %edx
  8019db:	ff 75 0c             	pushl  0xc(%ebp)
  8019de:	50                   	push   %eax
  8019df:	6a 1c                	push   $0x1c
  8019e1:	e8 b6 fc ff ff       	call   80169c <syscall>
  8019e6:	83 c4 18             	add    $0x18,%esp
}
  8019e9:	c9                   	leave  
  8019ea:	c3                   	ret    

008019eb <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8019eb:	55                   	push   %ebp
  8019ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8019ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	52                   	push   %edx
  8019fb:	50                   	push   %eax
  8019fc:	6a 1d                	push   $0x1d
  8019fe:	e8 99 fc ff ff       	call   80169c <syscall>
  801a03:	83 c4 18             	add    $0x18,%esp
}
  801a06:	c9                   	leave  
  801a07:	c3                   	ret    

00801a08 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a08:	55                   	push   %ebp
  801a09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a0b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a0e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a11:	8b 45 08             	mov    0x8(%ebp),%eax
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	51                   	push   %ecx
  801a19:	52                   	push   %edx
  801a1a:	50                   	push   %eax
  801a1b:	6a 1e                	push   $0x1e
  801a1d:	e8 7a fc ff ff       	call   80169c <syscall>
  801a22:	83 c4 18             	add    $0x18,%esp
}
  801a25:	c9                   	leave  
  801a26:	c3                   	ret    

00801a27 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a27:	55                   	push   %ebp
  801a28:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	52                   	push   %edx
  801a37:	50                   	push   %eax
  801a38:	6a 1f                	push   $0x1f
  801a3a:	e8 5d fc ff ff       	call   80169c <syscall>
  801a3f:	83 c4 18             	add    $0x18,%esp
}
  801a42:	c9                   	leave  
  801a43:	c3                   	ret    

00801a44 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a44:	55                   	push   %ebp
  801a45:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 00                	push   $0x0
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 20                	push   $0x20
  801a53:	e8 44 fc ff ff       	call   80169c <syscall>
  801a58:	83 c4 18             	add    $0x18,%esp
}
  801a5b:	c9                   	leave  
  801a5c:	c3                   	ret    

00801a5d <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801a5d:	55                   	push   %ebp
  801a5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801a60:	8b 45 08             	mov    0x8(%ebp),%eax
  801a63:	6a 00                	push   $0x0
  801a65:	ff 75 14             	pushl  0x14(%ebp)
  801a68:	ff 75 10             	pushl  0x10(%ebp)
  801a6b:	ff 75 0c             	pushl  0xc(%ebp)
  801a6e:	50                   	push   %eax
  801a6f:	6a 21                	push   $0x21
  801a71:	e8 26 fc ff ff       	call   80169c <syscall>
  801a76:	83 c4 18             	add    $0x18,%esp
}
  801a79:	c9                   	leave  
  801a7a:	c3                   	ret    

00801a7b <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801a7b:	55                   	push   %ebp
  801a7c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a81:	6a 00                	push   $0x0
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	50                   	push   %eax
  801a8a:	6a 22                	push   $0x22
  801a8c:	e8 0b fc ff ff       	call   80169c <syscall>
  801a91:	83 c4 18             	add    $0x18,%esp
}
  801a94:	90                   	nop
  801a95:	c9                   	leave  
  801a96:	c3                   	ret    

00801a97 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801a97:	55                   	push   %ebp
  801a98:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	50                   	push   %eax
  801aa6:	6a 23                	push   $0x23
  801aa8:	e8 ef fb ff ff       	call   80169c <syscall>
  801aad:	83 c4 18             	add    $0x18,%esp
}
  801ab0:	90                   	nop
  801ab1:	c9                   	leave  
  801ab2:	c3                   	ret    

00801ab3 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ab3:	55                   	push   %ebp
  801ab4:	89 e5                	mov    %esp,%ebp
  801ab6:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ab9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801abc:	8d 50 04             	lea    0x4(%eax),%edx
  801abf:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 00                	push   $0x0
  801ac8:	52                   	push   %edx
  801ac9:	50                   	push   %eax
  801aca:	6a 24                	push   $0x24
  801acc:	e8 cb fb ff ff       	call   80169c <syscall>
  801ad1:	83 c4 18             	add    $0x18,%esp
	return result;
  801ad4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ad7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ada:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801add:	89 01                	mov    %eax,(%ecx)
  801adf:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae5:	c9                   	leave  
  801ae6:	c2 04 00             	ret    $0x4

00801ae9 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ae9:	55                   	push   %ebp
  801aea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	ff 75 10             	pushl  0x10(%ebp)
  801af3:	ff 75 0c             	pushl  0xc(%ebp)
  801af6:	ff 75 08             	pushl  0x8(%ebp)
  801af9:	6a 13                	push   $0x13
  801afb:	e8 9c fb ff ff       	call   80169c <syscall>
  801b00:	83 c4 18             	add    $0x18,%esp
	return ;
  801b03:	90                   	nop
}
  801b04:	c9                   	leave  
  801b05:	c3                   	ret    

00801b06 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b06:	55                   	push   %ebp
  801b07:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	6a 25                	push   $0x25
  801b15:	e8 82 fb ff ff       	call   80169c <syscall>
  801b1a:	83 c4 18             	add    $0x18,%esp
}
  801b1d:	c9                   	leave  
  801b1e:	c3                   	ret    

00801b1f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b1f:	55                   	push   %ebp
  801b20:	89 e5                	mov    %esp,%ebp
  801b22:	83 ec 04             	sub    $0x4,%esp
  801b25:	8b 45 08             	mov    0x8(%ebp),%eax
  801b28:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b2b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	50                   	push   %eax
  801b38:	6a 26                	push   $0x26
  801b3a:	e8 5d fb ff ff       	call   80169c <syscall>
  801b3f:	83 c4 18             	add    $0x18,%esp
	return ;
  801b42:	90                   	nop
}
  801b43:	c9                   	leave  
  801b44:	c3                   	ret    

00801b45 <rsttst>:
void rsttst()
{
  801b45:	55                   	push   %ebp
  801b46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	6a 00                	push   $0x0
  801b52:	6a 28                	push   $0x28
  801b54:	e8 43 fb ff ff       	call   80169c <syscall>
  801b59:	83 c4 18             	add    $0x18,%esp
	return ;
  801b5c:	90                   	nop
}
  801b5d:	c9                   	leave  
  801b5e:	c3                   	ret    

00801b5f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801b5f:	55                   	push   %ebp
  801b60:	89 e5                	mov    %esp,%ebp
  801b62:	83 ec 04             	sub    $0x4,%esp
  801b65:	8b 45 14             	mov    0x14(%ebp),%eax
  801b68:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801b6b:	8b 55 18             	mov    0x18(%ebp),%edx
  801b6e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b72:	52                   	push   %edx
  801b73:	50                   	push   %eax
  801b74:	ff 75 10             	pushl  0x10(%ebp)
  801b77:	ff 75 0c             	pushl  0xc(%ebp)
  801b7a:	ff 75 08             	pushl  0x8(%ebp)
  801b7d:	6a 27                	push   $0x27
  801b7f:	e8 18 fb ff ff       	call   80169c <syscall>
  801b84:	83 c4 18             	add    $0x18,%esp
	return ;
  801b87:	90                   	nop
}
  801b88:	c9                   	leave  
  801b89:	c3                   	ret    

00801b8a <chktst>:
void chktst(uint32 n)
{
  801b8a:	55                   	push   %ebp
  801b8b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	ff 75 08             	pushl  0x8(%ebp)
  801b98:	6a 29                	push   $0x29
  801b9a:	e8 fd fa ff ff       	call   80169c <syscall>
  801b9f:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba2:	90                   	nop
}
  801ba3:	c9                   	leave  
  801ba4:	c3                   	ret    

00801ba5 <inctst>:

void inctst()
{
  801ba5:	55                   	push   %ebp
  801ba6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 2a                	push   $0x2a
  801bb4:	e8 e3 fa ff ff       	call   80169c <syscall>
  801bb9:	83 c4 18             	add    $0x18,%esp
	return ;
  801bbc:	90                   	nop
}
  801bbd:	c9                   	leave  
  801bbe:	c3                   	ret    

00801bbf <gettst>:
uint32 gettst()
{
  801bbf:	55                   	push   %ebp
  801bc0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 2b                	push   $0x2b
  801bce:	e8 c9 fa ff ff       	call   80169c <syscall>
  801bd3:	83 c4 18             	add    $0x18,%esp
}
  801bd6:	c9                   	leave  
  801bd7:	c3                   	ret    

00801bd8 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801bd8:	55                   	push   %ebp
  801bd9:	89 e5                	mov    %esp,%ebp
  801bdb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 2c                	push   $0x2c
  801bea:	e8 ad fa ff ff       	call   80169c <syscall>
  801bef:	83 c4 18             	add    $0x18,%esp
  801bf2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801bf5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801bf9:	75 07                	jne    801c02 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801bfb:	b8 01 00 00 00       	mov    $0x1,%eax
  801c00:	eb 05                	jmp    801c07 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c02:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c07:	c9                   	leave  
  801c08:	c3                   	ret    

00801c09 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c09:	55                   	push   %ebp
  801c0a:	89 e5                	mov    %esp,%ebp
  801c0c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 2c                	push   $0x2c
  801c1b:	e8 7c fa ff ff       	call   80169c <syscall>
  801c20:	83 c4 18             	add    $0x18,%esp
  801c23:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c26:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c2a:	75 07                	jne    801c33 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c2c:	b8 01 00 00 00       	mov    $0x1,%eax
  801c31:	eb 05                	jmp    801c38 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c33:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c38:	c9                   	leave  
  801c39:	c3                   	ret    

00801c3a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c3a:	55                   	push   %ebp
  801c3b:	89 e5                	mov    %esp,%ebp
  801c3d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 2c                	push   $0x2c
  801c4c:	e8 4b fa ff ff       	call   80169c <syscall>
  801c51:	83 c4 18             	add    $0x18,%esp
  801c54:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801c57:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801c5b:	75 07                	jne    801c64 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801c5d:	b8 01 00 00 00       	mov    $0x1,%eax
  801c62:	eb 05                	jmp    801c69 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801c64:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c69:	c9                   	leave  
  801c6a:	c3                   	ret    

00801c6b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801c6b:	55                   	push   %ebp
  801c6c:	89 e5                	mov    %esp,%ebp
  801c6e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 2c                	push   $0x2c
  801c7d:	e8 1a fa ff ff       	call   80169c <syscall>
  801c82:	83 c4 18             	add    $0x18,%esp
  801c85:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801c88:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801c8c:	75 07                	jne    801c95 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801c8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c93:	eb 05                	jmp    801c9a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801c95:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c9a:	c9                   	leave  
  801c9b:	c3                   	ret    

00801c9c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801c9c:	55                   	push   %ebp
  801c9d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 00                	push   $0x0
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	ff 75 08             	pushl  0x8(%ebp)
  801caa:	6a 2d                	push   $0x2d
  801cac:	e8 eb f9 ff ff       	call   80169c <syscall>
  801cb1:	83 c4 18             	add    $0x18,%esp
	return ;
  801cb4:	90                   	nop
}
  801cb5:	c9                   	leave  
  801cb6:	c3                   	ret    

00801cb7 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801cb7:	55                   	push   %ebp
  801cb8:	89 e5                	mov    %esp,%ebp
  801cba:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801cbb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cbe:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cc1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc7:	6a 00                	push   $0x0
  801cc9:	53                   	push   %ebx
  801cca:	51                   	push   %ecx
  801ccb:	52                   	push   %edx
  801ccc:	50                   	push   %eax
  801ccd:	6a 2e                	push   $0x2e
  801ccf:	e8 c8 f9 ff ff       	call   80169c <syscall>
  801cd4:	83 c4 18             	add    $0x18,%esp
}
  801cd7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801cda:	c9                   	leave  
  801cdb:	c3                   	ret    

00801cdc <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801cdc:	55                   	push   %ebp
  801cdd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801cdf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	52                   	push   %edx
  801cec:	50                   	push   %eax
  801ced:	6a 2f                	push   $0x2f
  801cef:	e8 a8 f9 ff ff       	call   80169c <syscall>
  801cf4:	83 c4 18             	add    $0x18,%esp
}
  801cf7:	c9                   	leave  
  801cf8:	c3                   	ret    

00801cf9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801cf9:	55                   	push   %ebp
  801cfa:	89 e5                	mov    %esp,%ebp
  801cfc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801cff:	8d 45 10             	lea    0x10(%ebp),%eax
  801d02:	83 c0 04             	add    $0x4,%eax
  801d05:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801d08:	a1 00 60 80 00       	mov    0x806000,%eax
  801d0d:	85 c0                	test   %eax,%eax
  801d0f:	74 16                	je     801d27 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801d11:	a1 00 60 80 00       	mov    0x806000,%eax
  801d16:	83 ec 08             	sub    $0x8,%esp
  801d19:	50                   	push   %eax
  801d1a:	68 40 27 80 00       	push   $0x802740
  801d1f:	e8 07 e9 ff ff       	call   80062b <cprintf>
  801d24:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801d27:	a1 00 30 80 00       	mov    0x803000,%eax
  801d2c:	ff 75 0c             	pushl  0xc(%ebp)
  801d2f:	ff 75 08             	pushl  0x8(%ebp)
  801d32:	50                   	push   %eax
  801d33:	68 45 27 80 00       	push   $0x802745
  801d38:	e8 ee e8 ff ff       	call   80062b <cprintf>
  801d3d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801d40:	8b 45 10             	mov    0x10(%ebp),%eax
  801d43:	83 ec 08             	sub    $0x8,%esp
  801d46:	ff 75 f4             	pushl  -0xc(%ebp)
  801d49:	50                   	push   %eax
  801d4a:	e8 71 e8 ff ff       	call   8005c0 <vcprintf>
  801d4f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801d52:	83 ec 08             	sub    $0x8,%esp
  801d55:	6a 00                	push   $0x0
  801d57:	68 61 27 80 00       	push   $0x802761
  801d5c:	e8 5f e8 ff ff       	call   8005c0 <vcprintf>
  801d61:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801d64:	e8 e0 e7 ff ff       	call   800549 <exit>

	// should not return here
	while (1) ;
  801d69:	eb fe                	jmp    801d69 <_panic+0x70>

00801d6b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801d6b:	55                   	push   %ebp
  801d6c:	89 e5                	mov    %esp,%ebp
  801d6e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801d71:	a1 20 30 80 00       	mov    0x803020,%eax
  801d76:	8b 50 74             	mov    0x74(%eax),%edx
  801d79:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d7c:	39 c2                	cmp    %eax,%edx
  801d7e:	74 14                	je     801d94 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801d80:	83 ec 04             	sub    $0x4,%esp
  801d83:	68 64 27 80 00       	push   $0x802764
  801d88:	6a 26                	push   $0x26
  801d8a:	68 b0 27 80 00       	push   $0x8027b0
  801d8f:	e8 65 ff ff ff       	call   801cf9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801d94:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801d9b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801da2:	e9 b6 00 00 00       	jmp    801e5d <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801da7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801daa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801db1:	8b 45 08             	mov    0x8(%ebp),%eax
  801db4:	01 d0                	add    %edx,%eax
  801db6:	8b 00                	mov    (%eax),%eax
  801db8:	85 c0                	test   %eax,%eax
  801dba:	75 08                	jne    801dc4 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801dbc:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801dbf:	e9 96 00 00 00       	jmp    801e5a <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801dc4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801dcb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801dd2:	eb 5d                	jmp    801e31 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801dd4:	a1 20 30 80 00       	mov    0x803020,%eax
  801dd9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801ddf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801de2:	c1 e2 04             	shl    $0x4,%edx
  801de5:	01 d0                	add    %edx,%eax
  801de7:	8a 40 04             	mov    0x4(%eax),%al
  801dea:	84 c0                	test   %al,%al
  801dec:	75 40                	jne    801e2e <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801dee:	a1 20 30 80 00       	mov    0x803020,%eax
  801df3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801df9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801dfc:	c1 e2 04             	shl    $0x4,%edx
  801dff:	01 d0                	add    %edx,%eax
  801e01:	8b 00                	mov    (%eax),%eax
  801e03:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801e06:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801e09:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801e0e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801e10:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e13:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801e1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1d:	01 c8                	add    %ecx,%eax
  801e1f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801e21:	39 c2                	cmp    %eax,%edx
  801e23:	75 09                	jne    801e2e <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801e25:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801e2c:	eb 12                	jmp    801e40 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e2e:	ff 45 e8             	incl   -0x18(%ebp)
  801e31:	a1 20 30 80 00       	mov    0x803020,%eax
  801e36:	8b 50 74             	mov    0x74(%eax),%edx
  801e39:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e3c:	39 c2                	cmp    %eax,%edx
  801e3e:	77 94                	ja     801dd4 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801e40:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801e44:	75 14                	jne    801e5a <CheckWSWithoutLastIndex+0xef>
			panic(
  801e46:	83 ec 04             	sub    $0x4,%esp
  801e49:	68 bc 27 80 00       	push   $0x8027bc
  801e4e:	6a 3a                	push   $0x3a
  801e50:	68 b0 27 80 00       	push   $0x8027b0
  801e55:	e8 9f fe ff ff       	call   801cf9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801e5a:	ff 45 f0             	incl   -0x10(%ebp)
  801e5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e60:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801e63:	0f 8c 3e ff ff ff    	jl     801da7 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801e69:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e70:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801e77:	eb 20                	jmp    801e99 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801e79:	a1 20 30 80 00       	mov    0x803020,%eax
  801e7e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801e84:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801e87:	c1 e2 04             	shl    $0x4,%edx
  801e8a:	01 d0                	add    %edx,%eax
  801e8c:	8a 40 04             	mov    0x4(%eax),%al
  801e8f:	3c 01                	cmp    $0x1,%al
  801e91:	75 03                	jne    801e96 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801e93:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801e96:	ff 45 e0             	incl   -0x20(%ebp)
  801e99:	a1 20 30 80 00       	mov    0x803020,%eax
  801e9e:	8b 50 74             	mov    0x74(%eax),%edx
  801ea1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ea4:	39 c2                	cmp    %eax,%edx
  801ea6:	77 d1                	ja     801e79 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801ea8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801eab:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801eae:	74 14                	je     801ec4 <CheckWSWithoutLastIndex+0x159>
		panic(
  801eb0:	83 ec 04             	sub    $0x4,%esp
  801eb3:	68 10 28 80 00       	push   $0x802810
  801eb8:	6a 44                	push   $0x44
  801eba:	68 b0 27 80 00       	push   $0x8027b0
  801ebf:	e8 35 fe ff ff       	call   801cf9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801ec4:	90                   	nop
  801ec5:	c9                   	leave  
  801ec6:	c3                   	ret    
  801ec7:	90                   	nop

00801ec8 <__udivdi3>:
  801ec8:	55                   	push   %ebp
  801ec9:	57                   	push   %edi
  801eca:	56                   	push   %esi
  801ecb:	53                   	push   %ebx
  801ecc:	83 ec 1c             	sub    $0x1c,%esp
  801ecf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ed3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ed7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801edb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801edf:	89 ca                	mov    %ecx,%edx
  801ee1:	89 f8                	mov    %edi,%eax
  801ee3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ee7:	85 f6                	test   %esi,%esi
  801ee9:	75 2d                	jne    801f18 <__udivdi3+0x50>
  801eeb:	39 cf                	cmp    %ecx,%edi
  801eed:	77 65                	ja     801f54 <__udivdi3+0x8c>
  801eef:	89 fd                	mov    %edi,%ebp
  801ef1:	85 ff                	test   %edi,%edi
  801ef3:	75 0b                	jne    801f00 <__udivdi3+0x38>
  801ef5:	b8 01 00 00 00       	mov    $0x1,%eax
  801efa:	31 d2                	xor    %edx,%edx
  801efc:	f7 f7                	div    %edi
  801efe:	89 c5                	mov    %eax,%ebp
  801f00:	31 d2                	xor    %edx,%edx
  801f02:	89 c8                	mov    %ecx,%eax
  801f04:	f7 f5                	div    %ebp
  801f06:	89 c1                	mov    %eax,%ecx
  801f08:	89 d8                	mov    %ebx,%eax
  801f0a:	f7 f5                	div    %ebp
  801f0c:	89 cf                	mov    %ecx,%edi
  801f0e:	89 fa                	mov    %edi,%edx
  801f10:	83 c4 1c             	add    $0x1c,%esp
  801f13:	5b                   	pop    %ebx
  801f14:	5e                   	pop    %esi
  801f15:	5f                   	pop    %edi
  801f16:	5d                   	pop    %ebp
  801f17:	c3                   	ret    
  801f18:	39 ce                	cmp    %ecx,%esi
  801f1a:	77 28                	ja     801f44 <__udivdi3+0x7c>
  801f1c:	0f bd fe             	bsr    %esi,%edi
  801f1f:	83 f7 1f             	xor    $0x1f,%edi
  801f22:	75 40                	jne    801f64 <__udivdi3+0x9c>
  801f24:	39 ce                	cmp    %ecx,%esi
  801f26:	72 0a                	jb     801f32 <__udivdi3+0x6a>
  801f28:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f2c:	0f 87 9e 00 00 00    	ja     801fd0 <__udivdi3+0x108>
  801f32:	b8 01 00 00 00       	mov    $0x1,%eax
  801f37:	89 fa                	mov    %edi,%edx
  801f39:	83 c4 1c             	add    $0x1c,%esp
  801f3c:	5b                   	pop    %ebx
  801f3d:	5e                   	pop    %esi
  801f3e:	5f                   	pop    %edi
  801f3f:	5d                   	pop    %ebp
  801f40:	c3                   	ret    
  801f41:	8d 76 00             	lea    0x0(%esi),%esi
  801f44:	31 ff                	xor    %edi,%edi
  801f46:	31 c0                	xor    %eax,%eax
  801f48:	89 fa                	mov    %edi,%edx
  801f4a:	83 c4 1c             	add    $0x1c,%esp
  801f4d:	5b                   	pop    %ebx
  801f4e:	5e                   	pop    %esi
  801f4f:	5f                   	pop    %edi
  801f50:	5d                   	pop    %ebp
  801f51:	c3                   	ret    
  801f52:	66 90                	xchg   %ax,%ax
  801f54:	89 d8                	mov    %ebx,%eax
  801f56:	f7 f7                	div    %edi
  801f58:	31 ff                	xor    %edi,%edi
  801f5a:	89 fa                	mov    %edi,%edx
  801f5c:	83 c4 1c             	add    $0x1c,%esp
  801f5f:	5b                   	pop    %ebx
  801f60:	5e                   	pop    %esi
  801f61:	5f                   	pop    %edi
  801f62:	5d                   	pop    %ebp
  801f63:	c3                   	ret    
  801f64:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f69:	89 eb                	mov    %ebp,%ebx
  801f6b:	29 fb                	sub    %edi,%ebx
  801f6d:	89 f9                	mov    %edi,%ecx
  801f6f:	d3 e6                	shl    %cl,%esi
  801f71:	89 c5                	mov    %eax,%ebp
  801f73:	88 d9                	mov    %bl,%cl
  801f75:	d3 ed                	shr    %cl,%ebp
  801f77:	89 e9                	mov    %ebp,%ecx
  801f79:	09 f1                	or     %esi,%ecx
  801f7b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f7f:	89 f9                	mov    %edi,%ecx
  801f81:	d3 e0                	shl    %cl,%eax
  801f83:	89 c5                	mov    %eax,%ebp
  801f85:	89 d6                	mov    %edx,%esi
  801f87:	88 d9                	mov    %bl,%cl
  801f89:	d3 ee                	shr    %cl,%esi
  801f8b:	89 f9                	mov    %edi,%ecx
  801f8d:	d3 e2                	shl    %cl,%edx
  801f8f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f93:	88 d9                	mov    %bl,%cl
  801f95:	d3 e8                	shr    %cl,%eax
  801f97:	09 c2                	or     %eax,%edx
  801f99:	89 d0                	mov    %edx,%eax
  801f9b:	89 f2                	mov    %esi,%edx
  801f9d:	f7 74 24 0c          	divl   0xc(%esp)
  801fa1:	89 d6                	mov    %edx,%esi
  801fa3:	89 c3                	mov    %eax,%ebx
  801fa5:	f7 e5                	mul    %ebp
  801fa7:	39 d6                	cmp    %edx,%esi
  801fa9:	72 19                	jb     801fc4 <__udivdi3+0xfc>
  801fab:	74 0b                	je     801fb8 <__udivdi3+0xf0>
  801fad:	89 d8                	mov    %ebx,%eax
  801faf:	31 ff                	xor    %edi,%edi
  801fb1:	e9 58 ff ff ff       	jmp    801f0e <__udivdi3+0x46>
  801fb6:	66 90                	xchg   %ax,%ax
  801fb8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801fbc:	89 f9                	mov    %edi,%ecx
  801fbe:	d3 e2                	shl    %cl,%edx
  801fc0:	39 c2                	cmp    %eax,%edx
  801fc2:	73 e9                	jae    801fad <__udivdi3+0xe5>
  801fc4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801fc7:	31 ff                	xor    %edi,%edi
  801fc9:	e9 40 ff ff ff       	jmp    801f0e <__udivdi3+0x46>
  801fce:	66 90                	xchg   %ax,%ax
  801fd0:	31 c0                	xor    %eax,%eax
  801fd2:	e9 37 ff ff ff       	jmp    801f0e <__udivdi3+0x46>
  801fd7:	90                   	nop

00801fd8 <__umoddi3>:
  801fd8:	55                   	push   %ebp
  801fd9:	57                   	push   %edi
  801fda:	56                   	push   %esi
  801fdb:	53                   	push   %ebx
  801fdc:	83 ec 1c             	sub    $0x1c,%esp
  801fdf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801fe3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801fe7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801feb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801fef:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ff3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ff7:	89 f3                	mov    %esi,%ebx
  801ff9:	89 fa                	mov    %edi,%edx
  801ffb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fff:	89 34 24             	mov    %esi,(%esp)
  802002:	85 c0                	test   %eax,%eax
  802004:	75 1a                	jne    802020 <__umoddi3+0x48>
  802006:	39 f7                	cmp    %esi,%edi
  802008:	0f 86 a2 00 00 00    	jbe    8020b0 <__umoddi3+0xd8>
  80200e:	89 c8                	mov    %ecx,%eax
  802010:	89 f2                	mov    %esi,%edx
  802012:	f7 f7                	div    %edi
  802014:	89 d0                	mov    %edx,%eax
  802016:	31 d2                	xor    %edx,%edx
  802018:	83 c4 1c             	add    $0x1c,%esp
  80201b:	5b                   	pop    %ebx
  80201c:	5e                   	pop    %esi
  80201d:	5f                   	pop    %edi
  80201e:	5d                   	pop    %ebp
  80201f:	c3                   	ret    
  802020:	39 f0                	cmp    %esi,%eax
  802022:	0f 87 ac 00 00 00    	ja     8020d4 <__umoddi3+0xfc>
  802028:	0f bd e8             	bsr    %eax,%ebp
  80202b:	83 f5 1f             	xor    $0x1f,%ebp
  80202e:	0f 84 ac 00 00 00    	je     8020e0 <__umoddi3+0x108>
  802034:	bf 20 00 00 00       	mov    $0x20,%edi
  802039:	29 ef                	sub    %ebp,%edi
  80203b:	89 fe                	mov    %edi,%esi
  80203d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802041:	89 e9                	mov    %ebp,%ecx
  802043:	d3 e0                	shl    %cl,%eax
  802045:	89 d7                	mov    %edx,%edi
  802047:	89 f1                	mov    %esi,%ecx
  802049:	d3 ef                	shr    %cl,%edi
  80204b:	09 c7                	or     %eax,%edi
  80204d:	89 e9                	mov    %ebp,%ecx
  80204f:	d3 e2                	shl    %cl,%edx
  802051:	89 14 24             	mov    %edx,(%esp)
  802054:	89 d8                	mov    %ebx,%eax
  802056:	d3 e0                	shl    %cl,%eax
  802058:	89 c2                	mov    %eax,%edx
  80205a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80205e:	d3 e0                	shl    %cl,%eax
  802060:	89 44 24 04          	mov    %eax,0x4(%esp)
  802064:	8b 44 24 08          	mov    0x8(%esp),%eax
  802068:	89 f1                	mov    %esi,%ecx
  80206a:	d3 e8                	shr    %cl,%eax
  80206c:	09 d0                	or     %edx,%eax
  80206e:	d3 eb                	shr    %cl,%ebx
  802070:	89 da                	mov    %ebx,%edx
  802072:	f7 f7                	div    %edi
  802074:	89 d3                	mov    %edx,%ebx
  802076:	f7 24 24             	mull   (%esp)
  802079:	89 c6                	mov    %eax,%esi
  80207b:	89 d1                	mov    %edx,%ecx
  80207d:	39 d3                	cmp    %edx,%ebx
  80207f:	0f 82 87 00 00 00    	jb     80210c <__umoddi3+0x134>
  802085:	0f 84 91 00 00 00    	je     80211c <__umoddi3+0x144>
  80208b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80208f:	29 f2                	sub    %esi,%edx
  802091:	19 cb                	sbb    %ecx,%ebx
  802093:	89 d8                	mov    %ebx,%eax
  802095:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802099:	d3 e0                	shl    %cl,%eax
  80209b:	89 e9                	mov    %ebp,%ecx
  80209d:	d3 ea                	shr    %cl,%edx
  80209f:	09 d0                	or     %edx,%eax
  8020a1:	89 e9                	mov    %ebp,%ecx
  8020a3:	d3 eb                	shr    %cl,%ebx
  8020a5:	89 da                	mov    %ebx,%edx
  8020a7:	83 c4 1c             	add    $0x1c,%esp
  8020aa:	5b                   	pop    %ebx
  8020ab:	5e                   	pop    %esi
  8020ac:	5f                   	pop    %edi
  8020ad:	5d                   	pop    %ebp
  8020ae:	c3                   	ret    
  8020af:	90                   	nop
  8020b0:	89 fd                	mov    %edi,%ebp
  8020b2:	85 ff                	test   %edi,%edi
  8020b4:	75 0b                	jne    8020c1 <__umoddi3+0xe9>
  8020b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8020bb:	31 d2                	xor    %edx,%edx
  8020bd:	f7 f7                	div    %edi
  8020bf:	89 c5                	mov    %eax,%ebp
  8020c1:	89 f0                	mov    %esi,%eax
  8020c3:	31 d2                	xor    %edx,%edx
  8020c5:	f7 f5                	div    %ebp
  8020c7:	89 c8                	mov    %ecx,%eax
  8020c9:	f7 f5                	div    %ebp
  8020cb:	89 d0                	mov    %edx,%eax
  8020cd:	e9 44 ff ff ff       	jmp    802016 <__umoddi3+0x3e>
  8020d2:	66 90                	xchg   %ax,%ax
  8020d4:	89 c8                	mov    %ecx,%eax
  8020d6:	89 f2                	mov    %esi,%edx
  8020d8:	83 c4 1c             	add    $0x1c,%esp
  8020db:	5b                   	pop    %ebx
  8020dc:	5e                   	pop    %esi
  8020dd:	5f                   	pop    %edi
  8020de:	5d                   	pop    %ebp
  8020df:	c3                   	ret    
  8020e0:	3b 04 24             	cmp    (%esp),%eax
  8020e3:	72 06                	jb     8020eb <__umoddi3+0x113>
  8020e5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8020e9:	77 0f                	ja     8020fa <__umoddi3+0x122>
  8020eb:	89 f2                	mov    %esi,%edx
  8020ed:	29 f9                	sub    %edi,%ecx
  8020ef:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8020f3:	89 14 24             	mov    %edx,(%esp)
  8020f6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020fa:	8b 44 24 04          	mov    0x4(%esp),%eax
  8020fe:	8b 14 24             	mov    (%esp),%edx
  802101:	83 c4 1c             	add    $0x1c,%esp
  802104:	5b                   	pop    %ebx
  802105:	5e                   	pop    %esi
  802106:	5f                   	pop    %edi
  802107:	5d                   	pop    %ebp
  802108:	c3                   	ret    
  802109:	8d 76 00             	lea    0x0(%esi),%esi
  80210c:	2b 04 24             	sub    (%esp),%eax
  80210f:	19 fa                	sbb    %edi,%edx
  802111:	89 d1                	mov    %edx,%ecx
  802113:	89 c6                	mov    %eax,%esi
  802115:	e9 71 ff ff ff       	jmp    80208b <__umoddi3+0xb3>
  80211a:	66 90                	xchg   %ax,%ax
  80211c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802120:	72 ea                	jb     80210c <__umoddi3+0x134>
  802122:	89 d9                	mov    %ebx,%ecx
  802124:	e9 62 ff ff ff       	jmp    80208b <__umoddi3+0xb3>
