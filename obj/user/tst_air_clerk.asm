
obj/user/tst_air_clerk:     file format elf32-i386


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
  800031:	e8 e7 05 00 00       	call   80061d <libmain>
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
  80003e:	81 ec 9c 01 00 00    	sub    $0x19c,%esp
	int parentenvID = sys_getparentenvid();
  800044:	e8 ef 18 00 00       	call   801938 <sys_getparentenvid>
  800049:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	// Get the shared variables from the main program ***********************************

	char _customers[] = "customers";
  80004c:	8d 45 ae             	lea    -0x52(%ebp),%eax
  80004f:	bb 75 21 80 00       	mov    $0x802175,%ebx
  800054:	ba 0a 00 00 00       	mov    $0xa,%edx
  800059:	89 c7                	mov    %eax,%edi
  80005b:	89 de                	mov    %ebx,%esi
  80005d:	89 d1                	mov    %edx,%ecx
  80005f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custCounter[] = "custCounter";
  800061:	8d 45 a2             	lea    -0x5e(%ebp),%eax
  800064:	bb 7f 21 80 00       	mov    $0x80217f,%ebx
  800069:	ba 03 00 00 00       	mov    $0x3,%edx
  80006e:	89 c7                	mov    %eax,%edi
  800070:	89 de                	mov    %ebx,%esi
  800072:	89 d1                	mov    %edx,%ecx
  800074:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1Counter[] = "flight1Counter";
  800076:	8d 45 93             	lea    -0x6d(%ebp),%eax
  800079:	bb 8b 21 80 00       	mov    $0x80218b,%ebx
  80007e:	ba 0f 00 00 00       	mov    $0xf,%edx
  800083:	89 c7                	mov    %eax,%edi
  800085:	89 de                	mov    %ebx,%esi
  800087:	89 d1                	mov    %edx,%ecx
  800089:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2Counter[] = "flight2Counter";
  80008b:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80008e:	bb 9a 21 80 00       	mov    $0x80219a,%ebx
  800093:	ba 0f 00 00 00       	mov    $0xf,%edx
  800098:	89 c7                	mov    %eax,%edi
  80009a:	89 de                	mov    %ebx,%esi
  80009c:	89 d1                	mov    %edx,%ecx
  80009e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Counter[] = "flightBooked1Counter";
  8000a0:	8d 85 6f ff ff ff    	lea    -0x91(%ebp),%eax
  8000a6:	bb a9 21 80 00       	mov    $0x8021a9,%ebx
  8000ab:	ba 15 00 00 00       	mov    $0x15,%edx
  8000b0:	89 c7                	mov    %eax,%edi
  8000b2:	89 de                	mov    %ebx,%esi
  8000b4:	89 d1                	mov    %edx,%ecx
  8000b6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Counter[] = "flightBooked2Counter";
  8000b8:	8d 85 5a ff ff ff    	lea    -0xa6(%ebp),%eax
  8000be:	bb be 21 80 00       	mov    $0x8021be,%ebx
  8000c3:	ba 15 00 00 00       	mov    $0x15,%edx
  8000c8:	89 c7                	mov    %eax,%edi
  8000ca:	89 de                	mov    %ebx,%esi
  8000cc:	89 d1                	mov    %edx,%ecx
  8000ce:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Arr[] = "flightBooked1Arr";
  8000d0:	8d 85 49 ff ff ff    	lea    -0xb7(%ebp),%eax
  8000d6:	bb d3 21 80 00       	mov    $0x8021d3,%ebx
  8000db:	ba 11 00 00 00       	mov    $0x11,%edx
  8000e0:	89 c7                	mov    %eax,%edi
  8000e2:	89 de                	mov    %ebx,%esi
  8000e4:	89 d1                	mov    %edx,%ecx
  8000e6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Arr[] = "flightBooked2Arr";
  8000e8:	8d 85 38 ff ff ff    	lea    -0xc8(%ebp),%eax
  8000ee:	bb e4 21 80 00       	mov    $0x8021e4,%ebx
  8000f3:	ba 11 00 00 00       	mov    $0x11,%edx
  8000f8:	89 c7                	mov    %eax,%edi
  8000fa:	89 de                	mov    %ebx,%esi
  8000fc:	89 d1                	mov    %edx,%ecx
  8000fe:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _cust_ready_queue[] = "cust_ready_queue";
  800100:	8d 85 27 ff ff ff    	lea    -0xd9(%ebp),%eax
  800106:	bb f5 21 80 00       	mov    $0x8021f5,%ebx
  80010b:	ba 11 00 00 00       	mov    $0x11,%edx
  800110:	89 c7                	mov    %eax,%edi
  800112:	89 de                	mov    %ebx,%esi
  800114:	89 d1                	mov    %edx,%ecx
  800116:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_in[] = "queue_in";
  800118:	8d 85 1e ff ff ff    	lea    -0xe2(%ebp),%eax
  80011e:	bb 06 22 80 00       	mov    $0x802206,%ebx
  800123:	ba 09 00 00 00       	mov    $0x9,%edx
  800128:	89 c7                	mov    %eax,%edi
  80012a:	89 de                	mov    %ebx,%esi
  80012c:	89 d1                	mov    %edx,%ecx
  80012e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_out[] = "queue_out";
  800130:	8d 85 14 ff ff ff    	lea    -0xec(%ebp),%eax
  800136:	bb 0f 22 80 00       	mov    $0x80220f,%ebx
  80013b:	ba 0a 00 00 00       	mov    $0xa,%edx
  800140:	89 c7                	mov    %eax,%edi
  800142:	89 de                	mov    %ebx,%esi
  800144:	89 d1                	mov    %edx,%ecx
  800146:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _cust_ready[] = "cust_ready";
  800148:	8d 85 09 ff ff ff    	lea    -0xf7(%ebp),%eax
  80014e:	bb 19 22 80 00       	mov    $0x802219,%ebx
  800153:	ba 0b 00 00 00       	mov    $0xb,%edx
  800158:	89 c7                	mov    %eax,%edi
  80015a:	89 de                	mov    %ebx,%esi
  80015c:	89 d1                	mov    %edx,%ecx
  80015e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custQueueCS[] = "custQueueCS";
  800160:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800166:	bb 24 22 80 00       	mov    $0x802224,%ebx
  80016b:	ba 03 00 00 00       	mov    $0x3,%edx
  800170:	89 c7                	mov    %eax,%edi
  800172:	89 de                	mov    %ebx,%esi
  800174:	89 d1                	mov    %edx,%ecx
  800176:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1CS[] = "flight1CS";
  800178:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  80017e:	bb 30 22 80 00       	mov    $0x802230,%ebx
  800183:	ba 0a 00 00 00       	mov    $0xa,%edx
  800188:	89 c7                	mov    %eax,%edi
  80018a:	89 de                	mov    %ebx,%esi
  80018c:	89 d1                	mov    %edx,%ecx
  80018e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2CS[] = "flight2CS";
  800190:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800196:	bb 3a 22 80 00       	mov    $0x80223a,%ebx
  80019b:	ba 0a 00 00 00       	mov    $0xa,%edx
  8001a0:	89 c7                	mov    %eax,%edi
  8001a2:	89 de                	mov    %ebx,%esi
  8001a4:	89 d1                	mov    %edx,%ecx
  8001a6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _clerk[] = "clerk";
  8001a8:	c7 85 e3 fe ff ff 63 	movl   $0x72656c63,-0x11d(%ebp)
  8001af:	6c 65 72 
  8001b2:	66 c7 85 e7 fe ff ff 	movw   $0x6b,-0x119(%ebp)
  8001b9:	6b 00 
	char _custCounterCS[] = "custCounterCS";
  8001bb:	8d 85 d5 fe ff ff    	lea    -0x12b(%ebp),%eax
  8001c1:	bb 44 22 80 00       	mov    $0x802244,%ebx
  8001c6:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001cb:	89 c7                	mov    %eax,%edi
  8001cd:	89 de                	mov    %ebx,%esi
  8001cf:	89 d1                	mov    %edx,%ecx
  8001d1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custTerminated[] = "custTerminated";
  8001d3:	8d 85 c6 fe ff ff    	lea    -0x13a(%ebp),%eax
  8001d9:	bb 52 22 80 00       	mov    $0x802252,%ebx
  8001de:	ba 0f 00 00 00       	mov    $0xf,%edx
  8001e3:	89 c7                	mov    %eax,%edi
  8001e5:	89 de                	mov    %ebx,%esi
  8001e7:	89 d1                	mov    %edx,%ecx
  8001e9:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _taircl[] = "taircl";
  8001eb:	8d 85 bf fe ff ff    	lea    -0x141(%ebp),%eax
  8001f1:	bb 61 22 80 00       	mov    $0x802261,%ebx
  8001f6:	ba 07 00 00 00       	mov    $0x7,%edx
  8001fb:	89 c7                	mov    %eax,%edi
  8001fd:	89 de                	mov    %ebx,%esi
  8001ff:	89 d1                	mov    %edx,%ecx
  800201:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _taircu[] = "taircu";
  800203:	8d 85 b8 fe ff ff    	lea    -0x148(%ebp),%eax
  800209:	bb 68 22 80 00       	mov    $0x802268,%ebx
  80020e:	ba 07 00 00 00       	mov    $0x7,%edx
  800213:	89 c7                	mov    %eax,%edi
  800215:	89 de                	mov    %ebx,%esi
  800217:	89 d1                	mov    %edx,%ecx
  800219:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	struct Customer * customers = sget(parentenvID, _customers);
  80021b:	83 ec 08             	sub    $0x8,%esp
  80021e:	8d 45 ae             	lea    -0x52(%ebp),%eax
  800221:	50                   	push   %eax
  800222:	ff 75 e4             	pushl  -0x1c(%ebp)
  800225:	e8 b8 15 00 00       	call   8017e2 <sget>
  80022a:	83 c4 10             	add    $0x10,%esp
  80022d:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int* flight1Counter = sget(parentenvID, _flight1Counter);
  800230:	83 ec 08             	sub    $0x8,%esp
  800233:	8d 45 93             	lea    -0x6d(%ebp),%eax
  800236:	50                   	push   %eax
  800237:	ff 75 e4             	pushl  -0x1c(%ebp)
  80023a:	e8 a3 15 00 00       	call   8017e2 <sget>
  80023f:	83 c4 10             	add    $0x10,%esp
  800242:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int* flight2Counter = sget(parentenvID, _flight2Counter);
  800245:	83 ec 08             	sub    $0x8,%esp
  800248:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80024b:	50                   	push   %eax
  80024c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80024f:	e8 8e 15 00 00       	call   8017e2 <sget>
  800254:	83 c4 10             	add    $0x10,%esp
  800257:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* flight1BookedCounter = sget(parentenvID, _flightBooked1Counter);
  80025a:	83 ec 08             	sub    $0x8,%esp
  80025d:	8d 85 6f ff ff ff    	lea    -0x91(%ebp),%eax
  800263:	50                   	push   %eax
  800264:	ff 75 e4             	pushl  -0x1c(%ebp)
  800267:	e8 76 15 00 00       	call   8017e2 <sget>
  80026c:	83 c4 10             	add    $0x10,%esp
  80026f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	int* flight2BookedCounter = sget(parentenvID, _flightBooked2Counter);
  800272:	83 ec 08             	sub    $0x8,%esp
  800275:	8d 85 5a ff ff ff    	lea    -0xa6(%ebp),%eax
  80027b:	50                   	push   %eax
  80027c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80027f:	e8 5e 15 00 00       	call   8017e2 <sget>
  800284:	83 c4 10             	add    $0x10,%esp
  800287:	89 45 d0             	mov    %eax,-0x30(%ebp)

	int* flight1BookedArr = sget(parentenvID, _flightBooked1Arr);
  80028a:	83 ec 08             	sub    $0x8,%esp
  80028d:	8d 85 49 ff ff ff    	lea    -0xb7(%ebp),%eax
  800293:	50                   	push   %eax
  800294:	ff 75 e4             	pushl  -0x1c(%ebp)
  800297:	e8 46 15 00 00       	call   8017e2 <sget>
  80029c:	83 c4 10             	add    $0x10,%esp
  80029f:	89 45 cc             	mov    %eax,-0x34(%ebp)
	int* flight2BookedArr = sget(parentenvID, _flightBooked2Arr);
  8002a2:	83 ec 08             	sub    $0x8,%esp
  8002a5:	8d 85 38 ff ff ff    	lea    -0xc8(%ebp),%eax
  8002ab:	50                   	push   %eax
  8002ac:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002af:	e8 2e 15 00 00       	call   8017e2 <sget>
  8002b4:	83 c4 10             	add    $0x10,%esp
  8002b7:	89 45 c8             	mov    %eax,-0x38(%ebp)

	int* cust_ready_queue = sget(parentenvID, _cust_ready_queue);
  8002ba:	83 ec 08             	sub    $0x8,%esp
  8002bd:	8d 85 27 ff ff ff    	lea    -0xd9(%ebp),%eax
  8002c3:	50                   	push   %eax
  8002c4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002c7:	e8 16 15 00 00       	call   8017e2 <sget>
  8002cc:	83 c4 10             	add    $0x10,%esp
  8002cf:	89 45 c4             	mov    %eax,-0x3c(%ebp)

	int* queue_out = sget(parentenvID, _queue_out);
  8002d2:	83 ec 08             	sub    $0x8,%esp
  8002d5:	8d 85 14 ff ff ff    	lea    -0xec(%ebp),%eax
  8002db:	50                   	push   %eax
  8002dc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002df:	e8 fe 14 00 00       	call   8017e2 <sget>
  8002e4:	83 c4 10             	add    $0x10,%esp
  8002e7:	89 45 c0             	mov    %eax,-0x40(%ebp)

	while(1==1)
	{
		int custId;
		//wait for a customer
		sys_waitSemaphore(parentenvID, _cust_ready);
  8002ea:	83 ec 08             	sub    $0x8,%esp
  8002ed:	8d 85 09 ff ff ff    	lea    -0xf7(%ebp),%eax
  8002f3:	50                   	push   %eax
  8002f4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002f7:	e8 6b 18 00 00       	call   801b67 <sys_waitSemaphore>
  8002fc:	83 c4 10             	add    $0x10,%esp

		//dequeue the customer info
		sys_waitSemaphore(parentenvID, _custQueueCS);
  8002ff:	83 ec 08             	sub    $0x8,%esp
  800302:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800308:	50                   	push   %eax
  800309:	ff 75 e4             	pushl  -0x1c(%ebp)
  80030c:	e8 56 18 00 00       	call   801b67 <sys_waitSemaphore>
  800311:	83 c4 10             	add    $0x10,%esp
		{
			//cprintf("*queue_out = %d\n", *queue_out);
			custId = cust_ready_queue[*queue_out];
  800314:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800317:	8b 00                	mov    (%eax),%eax
  800319:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800320:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800323:	01 d0                	add    %edx,%eax
  800325:	8b 00                	mov    (%eax),%eax
  800327:	89 45 bc             	mov    %eax,-0x44(%ebp)
			*queue_out = *queue_out +1;
  80032a:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80032d:	8b 00                	mov    (%eax),%eax
  80032f:	8d 50 01             	lea    0x1(%eax),%edx
  800332:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800335:	89 10                	mov    %edx,(%eax)
		}
		sys_signalSemaphore(parentenvID, _custQueueCS);
  800337:	83 ec 08             	sub    $0x8,%esp
  80033a:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800340:	50                   	push   %eax
  800341:	ff 75 e4             	pushl  -0x1c(%ebp)
  800344:	e8 3c 18 00 00       	call   801b85 <sys_signalSemaphore>
  800349:	83 c4 10             	add    $0x10,%esp

		//try reserving on the required flight
		int custFlightType = customers[custId].flightType;
  80034c:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80034f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800356:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800359:	01 d0                	add    %edx,%eax
  80035b:	8b 00                	mov    (%eax),%eax
  80035d:	89 45 b8             	mov    %eax,-0x48(%ebp)
		//cprintf("custId dequeued = %d, ft = %d\n", custId, customers[custId].flightType);

		switch (custFlightType)
  800360:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800363:	83 f8 02             	cmp    $0x2,%eax
  800366:	0f 84 90 00 00 00    	je     8003fc <_main+0x3c4>
  80036c:	83 f8 03             	cmp    $0x3,%eax
  80036f:	0f 84 05 01 00 00    	je     80047a <_main+0x442>
  800375:	83 f8 01             	cmp    $0x1,%eax
  800378:	0f 85 f8 01 00 00    	jne    800576 <_main+0x53e>
		{
		case 1:
		{
			//Check and update Flight1
			sys_waitSemaphore(parentenvID, _flight1CS);
  80037e:	83 ec 08             	sub    $0x8,%esp
  800381:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  800387:	50                   	push   %eax
  800388:	ff 75 e4             	pushl  -0x1c(%ebp)
  80038b:	e8 d7 17 00 00       	call   801b67 <sys_waitSemaphore>
  800390:	83 c4 10             	add    $0x10,%esp
			{
				if(*flight1Counter > 0)
  800393:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800396:	8b 00                	mov    (%eax),%eax
  800398:	85 c0                	test   %eax,%eax
  80039a:	7e 46                	jle    8003e2 <_main+0x3aa>
				{
					*flight1Counter = *flight1Counter - 1;
  80039c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80039f:	8b 00                	mov    (%eax),%eax
  8003a1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8003a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003a7:	89 10                	mov    %edx,(%eax)
					customers[custId].booked = 1;
  8003a9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8003ac:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8003b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003b6:	01 d0                	add    %edx,%eax
  8003b8:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
					flight1BookedArr[*flight1BookedCounter] = custId;
  8003bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003c2:	8b 00                	mov    (%eax),%eax
  8003c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cb:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8003ce:	01 c2                	add    %eax,%edx
  8003d0:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8003d3:	89 02                	mov    %eax,(%edx)
					*flight1BookedCounter =*flight1BookedCounter+1;
  8003d5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003d8:	8b 00                	mov    (%eax),%eax
  8003da:	8d 50 01             	lea    0x1(%eax),%edx
  8003dd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003e0:	89 10                	mov    %edx,(%eax)
				else
				{

				}
			}
			sys_signalSemaphore(parentenvID, _flight1CS);
  8003e2:	83 ec 08             	sub    $0x8,%esp
  8003e5:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  8003eb:	50                   	push   %eax
  8003ec:	ff 75 e4             	pushl  -0x1c(%ebp)
  8003ef:	e8 91 17 00 00       	call   801b85 <sys_signalSemaphore>
  8003f4:	83 c4 10             	add    $0x10,%esp
		}

		break;
  8003f7:	e9 91 01 00 00       	jmp    80058d <_main+0x555>
		case 2:
		{
			//Check and update Flight2
			sys_waitSemaphore(parentenvID, _flight2CS);
  8003fc:	83 ec 08             	sub    $0x8,%esp
  8003ff:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800405:	50                   	push   %eax
  800406:	ff 75 e4             	pushl  -0x1c(%ebp)
  800409:	e8 59 17 00 00       	call   801b67 <sys_waitSemaphore>
  80040e:	83 c4 10             	add    $0x10,%esp
			{
				if(*flight2Counter > 0)
  800411:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800414:	8b 00                	mov    (%eax),%eax
  800416:	85 c0                	test   %eax,%eax
  800418:	7e 46                	jle    800460 <_main+0x428>
				{
					*flight2Counter = *flight2Counter - 1;
  80041a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80041d:	8b 00                	mov    (%eax),%eax
  80041f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800422:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800425:	89 10                	mov    %edx,(%eax)
					customers[custId].booked = 1;
  800427:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80042a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800431:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800434:	01 d0                	add    %edx,%eax
  800436:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
					flight2BookedArr[*flight2BookedCounter] = custId;
  80043d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800440:	8b 00                	mov    (%eax),%eax
  800442:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800449:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80044c:	01 c2                	add    %eax,%edx
  80044e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800451:	89 02                	mov    %eax,(%edx)
					*flight2BookedCounter =*flight2BookedCounter+1;
  800453:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800456:	8b 00                	mov    (%eax),%eax
  800458:	8d 50 01             	lea    0x1(%eax),%edx
  80045b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80045e:	89 10                	mov    %edx,(%eax)
				else
				{

				}
			}
			sys_signalSemaphore(parentenvID, _flight2CS);
  800460:	83 ec 08             	sub    $0x8,%esp
  800463:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800469:	50                   	push   %eax
  80046a:	ff 75 e4             	pushl  -0x1c(%ebp)
  80046d:	e8 13 17 00 00       	call   801b85 <sys_signalSemaphore>
  800472:	83 c4 10             	add    $0x10,%esp
		}
		break;
  800475:	e9 13 01 00 00       	jmp    80058d <_main+0x555>
		case 3:
		{
			//Check and update Both Flights
			sys_waitSemaphore(parentenvID, _flight1CS); sys_waitSemaphore(parentenvID, _flight2CS);
  80047a:	83 ec 08             	sub    $0x8,%esp
  80047d:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  800483:	50                   	push   %eax
  800484:	ff 75 e4             	pushl  -0x1c(%ebp)
  800487:	e8 db 16 00 00       	call   801b67 <sys_waitSemaphore>
  80048c:	83 c4 10             	add    $0x10,%esp
  80048f:	83 ec 08             	sub    $0x8,%esp
  800492:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800498:	50                   	push   %eax
  800499:	ff 75 e4             	pushl  -0x1c(%ebp)
  80049c:	e8 c6 16 00 00       	call   801b67 <sys_waitSemaphore>
  8004a1:	83 c4 10             	add    $0x10,%esp
			{
				if(*flight1Counter > 0 && *flight2Counter >0 )
  8004a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004a7:	8b 00                	mov    (%eax),%eax
  8004a9:	85 c0                	test   %eax,%eax
  8004ab:	0f 8e 99 00 00 00    	jle    80054a <_main+0x512>
  8004b1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8004b4:	8b 00                	mov    (%eax),%eax
  8004b6:	85 c0                	test   %eax,%eax
  8004b8:	0f 8e 8c 00 00 00    	jle    80054a <_main+0x512>
				{
					*flight1Counter = *flight1Counter - 1;
  8004be:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004c1:	8b 00                	mov    (%eax),%eax
  8004c3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8004c6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004c9:	89 10                	mov    %edx,(%eax)
					customers[custId].booked = 1;
  8004cb:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8004ce:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8004d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004d8:	01 d0                	add    %edx,%eax
  8004da:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
					flight1BookedArr[*flight1BookedCounter] = custId;
  8004e1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8004e4:	8b 00                	mov    (%eax),%eax
  8004e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ed:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8004f0:	01 c2                	add    %eax,%edx
  8004f2:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8004f5:	89 02                	mov    %eax,(%edx)
					*flight1BookedCounter =*flight1BookedCounter+1;
  8004f7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8004fa:	8b 00                	mov    (%eax),%eax
  8004fc:	8d 50 01             	lea    0x1(%eax),%edx
  8004ff:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800502:	89 10                	mov    %edx,(%eax)

					*flight2Counter = *flight2Counter - 1;
  800504:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800507:	8b 00                	mov    (%eax),%eax
  800509:	8d 50 ff             	lea    -0x1(%eax),%edx
  80050c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80050f:	89 10                	mov    %edx,(%eax)
					customers[custId].booked = 1;
  800511:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800514:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80051b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80051e:	01 d0                	add    %edx,%eax
  800520:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
					flight2BookedArr[*flight2BookedCounter] = custId;
  800527:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80052a:	8b 00                	mov    (%eax),%eax
  80052c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800533:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800536:	01 c2                	add    %eax,%edx
  800538:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80053b:	89 02                	mov    %eax,(%edx)
					*flight2BookedCounter =*flight2BookedCounter+1;
  80053d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800540:	8b 00                	mov    (%eax),%eax
  800542:	8d 50 01             	lea    0x1(%eax),%edx
  800545:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800548:	89 10                	mov    %edx,(%eax)
				else
				{

				}
			}
			sys_signalSemaphore(parentenvID, _flight2CS); sys_signalSemaphore(parentenvID, _flight1CS);
  80054a:	83 ec 08             	sub    $0x8,%esp
  80054d:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800553:	50                   	push   %eax
  800554:	ff 75 e4             	pushl  -0x1c(%ebp)
  800557:	e8 29 16 00 00       	call   801b85 <sys_signalSemaphore>
  80055c:	83 c4 10             	add    $0x10,%esp
  80055f:	83 ec 08             	sub    $0x8,%esp
  800562:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  800568:	50                   	push   %eax
  800569:	ff 75 e4             	pushl  -0x1c(%ebp)
  80056c:	e8 14 16 00 00       	call   801b85 <sys_signalSemaphore>
  800571:	83 c4 10             	add    $0x10,%esp
		}
		break;
  800574:	eb 17                	jmp    80058d <_main+0x555>
		default:
			panic("customer must have flight type\n");
  800576:	83 ec 04             	sub    $0x4,%esp
  800579:	68 40 21 80 00       	push   $0x802140
  80057e:	68 8f 00 00 00       	push   $0x8f
  800583:	68 60 21 80 00       	push   $0x802160
  800588:	e8 d5 01 00 00       	call   800762 <_panic>
		}

		//signal finished
		char prefix[30]="cust_finished";
  80058d:	8d 85 9a fe ff ff    	lea    -0x166(%ebp),%eax
  800593:	bb 6f 22 80 00       	mov    $0x80226f,%ebx
  800598:	ba 0e 00 00 00       	mov    $0xe,%edx
  80059d:	89 c7                	mov    %eax,%edi
  80059f:	89 de                	mov    %ebx,%esi
  8005a1:	89 d1                	mov    %edx,%ecx
  8005a3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8005a5:	8d 95 a8 fe ff ff    	lea    -0x158(%ebp),%edx
  8005ab:	b9 04 00 00 00       	mov    $0x4,%ecx
  8005b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8005b5:	89 d7                	mov    %edx,%edi
  8005b7:	f3 ab                	rep stos %eax,%es:(%edi)
		char id[5]; char sname[50];
		ltostr(custId, id);
  8005b9:	83 ec 08             	sub    $0x8,%esp
  8005bc:	8d 85 95 fe ff ff    	lea    -0x16b(%ebp),%eax
  8005c2:	50                   	push   %eax
  8005c3:	ff 75 bc             	pushl  -0x44(%ebp)
  8005c6:	e8 61 0f 00 00       	call   80152c <ltostr>
  8005cb:	83 c4 10             	add    $0x10,%esp
		strcconcat(prefix, id, sname);
  8005ce:	83 ec 04             	sub    $0x4,%esp
  8005d1:	8d 85 63 fe ff ff    	lea    -0x19d(%ebp),%eax
  8005d7:	50                   	push   %eax
  8005d8:	8d 85 95 fe ff ff    	lea    -0x16b(%ebp),%eax
  8005de:	50                   	push   %eax
  8005df:	8d 85 9a fe ff ff    	lea    -0x166(%ebp),%eax
  8005e5:	50                   	push   %eax
  8005e6:	e8 39 10 00 00       	call   801624 <strcconcat>
  8005eb:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(parentenvID, sname);
  8005ee:	83 ec 08             	sub    $0x8,%esp
  8005f1:	8d 85 63 fe ff ff    	lea    -0x19d(%ebp),%eax
  8005f7:	50                   	push   %eax
  8005f8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8005fb:	e8 85 15 00 00       	call   801b85 <sys_signalSemaphore>
  800600:	83 c4 10             	add    $0x10,%esp

		//signal the clerk
		sys_signalSemaphore(parentenvID, _clerk);
  800603:	83 ec 08             	sub    $0x8,%esp
  800606:	8d 85 e3 fe ff ff    	lea    -0x11d(%ebp),%eax
  80060c:	50                   	push   %eax
  80060d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800610:	e8 70 15 00 00       	call   801b85 <sys_signalSemaphore>
  800615:	83 c4 10             	add    $0x10,%esp
	}
  800618:	e9 cd fc ff ff       	jmp    8002ea <_main+0x2b2>

0080061d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80061d:	55                   	push   %ebp
  80061e:	89 e5                	mov    %esp,%ebp
  800620:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800623:	e8 f7 12 00 00       	call   80191f <sys_getenvindex>
  800628:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80062b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80062e:	89 d0                	mov    %edx,%eax
  800630:	c1 e0 03             	shl    $0x3,%eax
  800633:	01 d0                	add    %edx,%eax
  800635:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80063c:	01 c8                	add    %ecx,%eax
  80063e:	01 c0                	add    %eax,%eax
  800640:	01 d0                	add    %edx,%eax
  800642:	01 c0                	add    %eax,%eax
  800644:	01 d0                	add    %edx,%eax
  800646:	89 c2                	mov    %eax,%edx
  800648:	c1 e2 05             	shl    $0x5,%edx
  80064b:	29 c2                	sub    %eax,%edx
  80064d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800654:	89 c2                	mov    %eax,%edx
  800656:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80065c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800661:	a1 20 30 80 00       	mov    0x803020,%eax
  800666:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80066c:	84 c0                	test   %al,%al
  80066e:	74 0f                	je     80067f <libmain+0x62>
		binaryname = myEnv->prog_name;
  800670:	a1 20 30 80 00       	mov    0x803020,%eax
  800675:	05 40 3c 01 00       	add    $0x13c40,%eax
  80067a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80067f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800683:	7e 0a                	jle    80068f <libmain+0x72>
		binaryname = argv[0];
  800685:	8b 45 0c             	mov    0xc(%ebp),%eax
  800688:	8b 00                	mov    (%eax),%eax
  80068a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80068f:	83 ec 08             	sub    $0x8,%esp
  800692:	ff 75 0c             	pushl  0xc(%ebp)
  800695:	ff 75 08             	pushl  0x8(%ebp)
  800698:	e8 9b f9 ff ff       	call   800038 <_main>
  80069d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006a0:	e8 15 14 00 00       	call   801aba <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006a5:	83 ec 0c             	sub    $0xc,%esp
  8006a8:	68 a8 22 80 00       	push   $0x8022a8
  8006ad:	e8 52 03 00 00       	call   800a04 <cprintf>
  8006b2:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ba:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8006c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8006c5:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8006cb:	83 ec 04             	sub    $0x4,%esp
  8006ce:	52                   	push   %edx
  8006cf:	50                   	push   %eax
  8006d0:	68 d0 22 80 00       	push   $0x8022d0
  8006d5:	e8 2a 03 00 00       	call   800a04 <cprintf>
  8006da:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8006dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8006e2:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8006e8:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ed:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006f3:	83 ec 04             	sub    $0x4,%esp
  8006f6:	52                   	push   %edx
  8006f7:	50                   	push   %eax
  8006f8:	68 f8 22 80 00       	push   $0x8022f8
  8006fd:	e8 02 03 00 00       	call   800a04 <cprintf>
  800702:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800705:	a1 20 30 80 00       	mov    0x803020,%eax
  80070a:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800710:	83 ec 08             	sub    $0x8,%esp
  800713:	50                   	push   %eax
  800714:	68 39 23 80 00       	push   $0x802339
  800719:	e8 e6 02 00 00       	call   800a04 <cprintf>
  80071e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800721:	83 ec 0c             	sub    $0xc,%esp
  800724:	68 a8 22 80 00       	push   $0x8022a8
  800729:	e8 d6 02 00 00       	call   800a04 <cprintf>
  80072e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800731:	e8 9e 13 00 00       	call   801ad4 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800736:	e8 19 00 00 00       	call   800754 <exit>
}
  80073b:	90                   	nop
  80073c:	c9                   	leave  
  80073d:	c3                   	ret    

0080073e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80073e:	55                   	push   %ebp
  80073f:	89 e5                	mov    %esp,%ebp
  800741:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800744:	83 ec 0c             	sub    $0xc,%esp
  800747:	6a 00                	push   $0x0
  800749:	e8 9d 11 00 00       	call   8018eb <sys_env_destroy>
  80074e:	83 c4 10             	add    $0x10,%esp
}
  800751:	90                   	nop
  800752:	c9                   	leave  
  800753:	c3                   	ret    

00800754 <exit>:

void
exit(void)
{
  800754:	55                   	push   %ebp
  800755:	89 e5                	mov    %esp,%ebp
  800757:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80075a:	e8 f2 11 00 00       	call   801951 <sys_env_exit>
}
  80075f:	90                   	nop
  800760:	c9                   	leave  
  800761:	c3                   	ret    

00800762 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800762:	55                   	push   %ebp
  800763:	89 e5                	mov    %esp,%ebp
  800765:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800768:	8d 45 10             	lea    0x10(%ebp),%eax
  80076b:	83 c0 04             	add    $0x4,%eax
  80076e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800771:	a1 18 31 80 00       	mov    0x803118,%eax
  800776:	85 c0                	test   %eax,%eax
  800778:	74 16                	je     800790 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80077a:	a1 18 31 80 00       	mov    0x803118,%eax
  80077f:	83 ec 08             	sub    $0x8,%esp
  800782:	50                   	push   %eax
  800783:	68 50 23 80 00       	push   $0x802350
  800788:	e8 77 02 00 00       	call   800a04 <cprintf>
  80078d:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800790:	a1 00 30 80 00       	mov    0x803000,%eax
  800795:	ff 75 0c             	pushl  0xc(%ebp)
  800798:	ff 75 08             	pushl  0x8(%ebp)
  80079b:	50                   	push   %eax
  80079c:	68 55 23 80 00       	push   $0x802355
  8007a1:	e8 5e 02 00 00       	call   800a04 <cprintf>
  8007a6:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ac:	83 ec 08             	sub    $0x8,%esp
  8007af:	ff 75 f4             	pushl  -0xc(%ebp)
  8007b2:	50                   	push   %eax
  8007b3:	e8 e1 01 00 00       	call   800999 <vcprintf>
  8007b8:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007bb:	83 ec 08             	sub    $0x8,%esp
  8007be:	6a 00                	push   $0x0
  8007c0:	68 71 23 80 00       	push   $0x802371
  8007c5:	e8 cf 01 00 00       	call   800999 <vcprintf>
  8007ca:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007cd:	e8 82 ff ff ff       	call   800754 <exit>

	// should not return here
	while (1) ;
  8007d2:	eb fe                	jmp    8007d2 <_panic+0x70>

008007d4 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007d4:	55                   	push   %ebp
  8007d5:	89 e5                	mov    %esp,%ebp
  8007d7:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007da:	a1 20 30 80 00       	mov    0x803020,%eax
  8007df:	8b 50 74             	mov    0x74(%eax),%edx
  8007e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007e5:	39 c2                	cmp    %eax,%edx
  8007e7:	74 14                	je     8007fd <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007e9:	83 ec 04             	sub    $0x4,%esp
  8007ec:	68 74 23 80 00       	push   $0x802374
  8007f1:	6a 26                	push   $0x26
  8007f3:	68 c0 23 80 00       	push   $0x8023c0
  8007f8:	e8 65 ff ff ff       	call   800762 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800804:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80080b:	e9 b6 00 00 00       	jmp    8008c6 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800810:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800813:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80081a:	8b 45 08             	mov    0x8(%ebp),%eax
  80081d:	01 d0                	add    %edx,%eax
  80081f:	8b 00                	mov    (%eax),%eax
  800821:	85 c0                	test   %eax,%eax
  800823:	75 08                	jne    80082d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800825:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800828:	e9 96 00 00 00       	jmp    8008c3 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80082d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800834:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80083b:	eb 5d                	jmp    80089a <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80083d:	a1 20 30 80 00       	mov    0x803020,%eax
  800842:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800848:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80084b:	c1 e2 04             	shl    $0x4,%edx
  80084e:	01 d0                	add    %edx,%eax
  800850:	8a 40 04             	mov    0x4(%eax),%al
  800853:	84 c0                	test   %al,%al
  800855:	75 40                	jne    800897 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800857:	a1 20 30 80 00       	mov    0x803020,%eax
  80085c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800862:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800865:	c1 e2 04             	shl    $0x4,%edx
  800868:	01 d0                	add    %edx,%eax
  80086a:	8b 00                	mov    (%eax),%eax
  80086c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80086f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800872:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800877:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800879:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80087c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800883:	8b 45 08             	mov    0x8(%ebp),%eax
  800886:	01 c8                	add    %ecx,%eax
  800888:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80088a:	39 c2                	cmp    %eax,%edx
  80088c:	75 09                	jne    800897 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80088e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800895:	eb 12                	jmp    8008a9 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800897:	ff 45 e8             	incl   -0x18(%ebp)
  80089a:	a1 20 30 80 00       	mov    0x803020,%eax
  80089f:	8b 50 74             	mov    0x74(%eax),%edx
  8008a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008a5:	39 c2                	cmp    %eax,%edx
  8008a7:	77 94                	ja     80083d <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008a9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008ad:	75 14                	jne    8008c3 <CheckWSWithoutLastIndex+0xef>
			panic(
  8008af:	83 ec 04             	sub    $0x4,%esp
  8008b2:	68 cc 23 80 00       	push   $0x8023cc
  8008b7:	6a 3a                	push   $0x3a
  8008b9:	68 c0 23 80 00       	push   $0x8023c0
  8008be:	e8 9f fe ff ff       	call   800762 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008c3:	ff 45 f0             	incl   -0x10(%ebp)
  8008c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008cc:	0f 8c 3e ff ff ff    	jl     800810 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008d2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008d9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008e0:	eb 20                	jmp    800902 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8008e7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008ed:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008f0:	c1 e2 04             	shl    $0x4,%edx
  8008f3:	01 d0                	add    %edx,%eax
  8008f5:	8a 40 04             	mov    0x4(%eax),%al
  8008f8:	3c 01                	cmp    $0x1,%al
  8008fa:	75 03                	jne    8008ff <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8008fc:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ff:	ff 45 e0             	incl   -0x20(%ebp)
  800902:	a1 20 30 80 00       	mov    0x803020,%eax
  800907:	8b 50 74             	mov    0x74(%eax),%edx
  80090a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80090d:	39 c2                	cmp    %eax,%edx
  80090f:	77 d1                	ja     8008e2 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800911:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800914:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800917:	74 14                	je     80092d <CheckWSWithoutLastIndex+0x159>
		panic(
  800919:	83 ec 04             	sub    $0x4,%esp
  80091c:	68 20 24 80 00       	push   $0x802420
  800921:	6a 44                	push   $0x44
  800923:	68 c0 23 80 00       	push   $0x8023c0
  800928:	e8 35 fe ff ff       	call   800762 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80092d:	90                   	nop
  80092e:	c9                   	leave  
  80092f:	c3                   	ret    

00800930 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800930:	55                   	push   %ebp
  800931:	89 e5                	mov    %esp,%ebp
  800933:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800936:	8b 45 0c             	mov    0xc(%ebp),%eax
  800939:	8b 00                	mov    (%eax),%eax
  80093b:	8d 48 01             	lea    0x1(%eax),%ecx
  80093e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800941:	89 0a                	mov    %ecx,(%edx)
  800943:	8b 55 08             	mov    0x8(%ebp),%edx
  800946:	88 d1                	mov    %dl,%cl
  800948:	8b 55 0c             	mov    0xc(%ebp),%edx
  80094b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80094f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800952:	8b 00                	mov    (%eax),%eax
  800954:	3d ff 00 00 00       	cmp    $0xff,%eax
  800959:	75 2c                	jne    800987 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80095b:	a0 24 30 80 00       	mov    0x803024,%al
  800960:	0f b6 c0             	movzbl %al,%eax
  800963:	8b 55 0c             	mov    0xc(%ebp),%edx
  800966:	8b 12                	mov    (%edx),%edx
  800968:	89 d1                	mov    %edx,%ecx
  80096a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096d:	83 c2 08             	add    $0x8,%edx
  800970:	83 ec 04             	sub    $0x4,%esp
  800973:	50                   	push   %eax
  800974:	51                   	push   %ecx
  800975:	52                   	push   %edx
  800976:	e8 2e 0f 00 00       	call   8018a9 <sys_cputs>
  80097b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80097e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800981:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800987:	8b 45 0c             	mov    0xc(%ebp),%eax
  80098a:	8b 40 04             	mov    0x4(%eax),%eax
  80098d:	8d 50 01             	lea    0x1(%eax),%edx
  800990:	8b 45 0c             	mov    0xc(%ebp),%eax
  800993:	89 50 04             	mov    %edx,0x4(%eax)
}
  800996:	90                   	nop
  800997:	c9                   	leave  
  800998:	c3                   	ret    

00800999 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800999:	55                   	push   %ebp
  80099a:	89 e5                	mov    %esp,%ebp
  80099c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009a2:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009a9:	00 00 00 
	b.cnt = 0;
  8009ac:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009b3:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009b6:	ff 75 0c             	pushl  0xc(%ebp)
  8009b9:	ff 75 08             	pushl  0x8(%ebp)
  8009bc:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009c2:	50                   	push   %eax
  8009c3:	68 30 09 80 00       	push   $0x800930
  8009c8:	e8 11 02 00 00       	call   800bde <vprintfmt>
  8009cd:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009d0:	a0 24 30 80 00       	mov    0x803024,%al
  8009d5:	0f b6 c0             	movzbl %al,%eax
  8009d8:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009de:	83 ec 04             	sub    $0x4,%esp
  8009e1:	50                   	push   %eax
  8009e2:	52                   	push   %edx
  8009e3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009e9:	83 c0 08             	add    $0x8,%eax
  8009ec:	50                   	push   %eax
  8009ed:	e8 b7 0e 00 00       	call   8018a9 <sys_cputs>
  8009f2:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009f5:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009fc:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a02:	c9                   	leave  
  800a03:	c3                   	ret    

00800a04 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a04:	55                   	push   %ebp
  800a05:	89 e5                	mov    %esp,%ebp
  800a07:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a0a:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800a11:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a14:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a17:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1a:	83 ec 08             	sub    $0x8,%esp
  800a1d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a20:	50                   	push   %eax
  800a21:	e8 73 ff ff ff       	call   800999 <vcprintf>
  800a26:	83 c4 10             	add    $0x10,%esp
  800a29:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a2f:	c9                   	leave  
  800a30:	c3                   	ret    

00800a31 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a31:	55                   	push   %ebp
  800a32:	89 e5                	mov    %esp,%ebp
  800a34:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a37:	e8 7e 10 00 00       	call   801aba <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a3c:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a42:	8b 45 08             	mov    0x8(%ebp),%eax
  800a45:	83 ec 08             	sub    $0x8,%esp
  800a48:	ff 75 f4             	pushl  -0xc(%ebp)
  800a4b:	50                   	push   %eax
  800a4c:	e8 48 ff ff ff       	call   800999 <vcprintf>
  800a51:	83 c4 10             	add    $0x10,%esp
  800a54:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a57:	e8 78 10 00 00       	call   801ad4 <sys_enable_interrupt>
	return cnt;
  800a5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a5f:	c9                   	leave  
  800a60:	c3                   	ret    

00800a61 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a61:	55                   	push   %ebp
  800a62:	89 e5                	mov    %esp,%ebp
  800a64:	53                   	push   %ebx
  800a65:	83 ec 14             	sub    $0x14,%esp
  800a68:	8b 45 10             	mov    0x10(%ebp),%eax
  800a6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a6e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a71:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a74:	8b 45 18             	mov    0x18(%ebp),%eax
  800a77:	ba 00 00 00 00       	mov    $0x0,%edx
  800a7c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a7f:	77 55                	ja     800ad6 <printnum+0x75>
  800a81:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a84:	72 05                	jb     800a8b <printnum+0x2a>
  800a86:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a89:	77 4b                	ja     800ad6 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a8b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a8e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a91:	8b 45 18             	mov    0x18(%ebp),%eax
  800a94:	ba 00 00 00 00       	mov    $0x0,%edx
  800a99:	52                   	push   %edx
  800a9a:	50                   	push   %eax
  800a9b:	ff 75 f4             	pushl  -0xc(%ebp)
  800a9e:	ff 75 f0             	pushl  -0x10(%ebp)
  800aa1:	e8 36 14 00 00       	call   801edc <__udivdi3>
  800aa6:	83 c4 10             	add    $0x10,%esp
  800aa9:	83 ec 04             	sub    $0x4,%esp
  800aac:	ff 75 20             	pushl  0x20(%ebp)
  800aaf:	53                   	push   %ebx
  800ab0:	ff 75 18             	pushl  0x18(%ebp)
  800ab3:	52                   	push   %edx
  800ab4:	50                   	push   %eax
  800ab5:	ff 75 0c             	pushl  0xc(%ebp)
  800ab8:	ff 75 08             	pushl  0x8(%ebp)
  800abb:	e8 a1 ff ff ff       	call   800a61 <printnum>
  800ac0:	83 c4 20             	add    $0x20,%esp
  800ac3:	eb 1a                	jmp    800adf <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ac5:	83 ec 08             	sub    $0x8,%esp
  800ac8:	ff 75 0c             	pushl  0xc(%ebp)
  800acb:	ff 75 20             	pushl  0x20(%ebp)
  800ace:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad1:	ff d0                	call   *%eax
  800ad3:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ad6:	ff 4d 1c             	decl   0x1c(%ebp)
  800ad9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800add:	7f e6                	jg     800ac5 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800adf:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ae2:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ae7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aed:	53                   	push   %ebx
  800aee:	51                   	push   %ecx
  800aef:	52                   	push   %edx
  800af0:	50                   	push   %eax
  800af1:	e8 f6 14 00 00       	call   801fec <__umoddi3>
  800af6:	83 c4 10             	add    $0x10,%esp
  800af9:	05 94 26 80 00       	add    $0x802694,%eax
  800afe:	8a 00                	mov    (%eax),%al
  800b00:	0f be c0             	movsbl %al,%eax
  800b03:	83 ec 08             	sub    $0x8,%esp
  800b06:	ff 75 0c             	pushl  0xc(%ebp)
  800b09:	50                   	push   %eax
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	ff d0                	call   *%eax
  800b0f:	83 c4 10             	add    $0x10,%esp
}
  800b12:	90                   	nop
  800b13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b16:	c9                   	leave  
  800b17:	c3                   	ret    

00800b18 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b18:	55                   	push   %ebp
  800b19:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b1b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b1f:	7e 1c                	jle    800b3d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
  800b24:	8b 00                	mov    (%eax),%eax
  800b26:	8d 50 08             	lea    0x8(%eax),%edx
  800b29:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2c:	89 10                	mov    %edx,(%eax)
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	8b 00                	mov    (%eax),%eax
  800b33:	83 e8 08             	sub    $0x8,%eax
  800b36:	8b 50 04             	mov    0x4(%eax),%edx
  800b39:	8b 00                	mov    (%eax),%eax
  800b3b:	eb 40                	jmp    800b7d <getuint+0x65>
	else if (lflag)
  800b3d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b41:	74 1e                	je     800b61 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
  800b46:	8b 00                	mov    (%eax),%eax
  800b48:	8d 50 04             	lea    0x4(%eax),%edx
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	89 10                	mov    %edx,(%eax)
  800b50:	8b 45 08             	mov    0x8(%ebp),%eax
  800b53:	8b 00                	mov    (%eax),%eax
  800b55:	83 e8 04             	sub    $0x4,%eax
  800b58:	8b 00                	mov    (%eax),%eax
  800b5a:	ba 00 00 00 00       	mov    $0x0,%edx
  800b5f:	eb 1c                	jmp    800b7d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b61:	8b 45 08             	mov    0x8(%ebp),%eax
  800b64:	8b 00                	mov    (%eax),%eax
  800b66:	8d 50 04             	lea    0x4(%eax),%edx
  800b69:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6c:	89 10                	mov    %edx,(%eax)
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	8b 00                	mov    (%eax),%eax
  800b73:	83 e8 04             	sub    $0x4,%eax
  800b76:	8b 00                	mov    (%eax),%eax
  800b78:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b7d:	5d                   	pop    %ebp
  800b7e:	c3                   	ret    

00800b7f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b7f:	55                   	push   %ebp
  800b80:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b82:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b86:	7e 1c                	jle    800ba4 <getint+0x25>
		return va_arg(*ap, long long);
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	8b 00                	mov    (%eax),%eax
  800b8d:	8d 50 08             	lea    0x8(%eax),%edx
  800b90:	8b 45 08             	mov    0x8(%ebp),%eax
  800b93:	89 10                	mov    %edx,(%eax)
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	8b 00                	mov    (%eax),%eax
  800b9a:	83 e8 08             	sub    $0x8,%eax
  800b9d:	8b 50 04             	mov    0x4(%eax),%edx
  800ba0:	8b 00                	mov    (%eax),%eax
  800ba2:	eb 38                	jmp    800bdc <getint+0x5d>
	else if (lflag)
  800ba4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ba8:	74 1a                	je     800bc4 <getint+0x45>
		return va_arg(*ap, long);
  800baa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bad:	8b 00                	mov    (%eax),%eax
  800baf:	8d 50 04             	lea    0x4(%eax),%edx
  800bb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb5:	89 10                	mov    %edx,(%eax)
  800bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bba:	8b 00                	mov    (%eax),%eax
  800bbc:	83 e8 04             	sub    $0x4,%eax
  800bbf:	8b 00                	mov    (%eax),%eax
  800bc1:	99                   	cltd   
  800bc2:	eb 18                	jmp    800bdc <getint+0x5d>
	else
		return va_arg(*ap, int);
  800bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc7:	8b 00                	mov    (%eax),%eax
  800bc9:	8d 50 04             	lea    0x4(%eax),%edx
  800bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcf:	89 10                	mov    %edx,(%eax)
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	8b 00                	mov    (%eax),%eax
  800bd6:	83 e8 04             	sub    $0x4,%eax
  800bd9:	8b 00                	mov    (%eax),%eax
  800bdb:	99                   	cltd   
}
  800bdc:	5d                   	pop    %ebp
  800bdd:	c3                   	ret    

00800bde <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bde:	55                   	push   %ebp
  800bdf:	89 e5                	mov    %esp,%ebp
  800be1:	56                   	push   %esi
  800be2:	53                   	push   %ebx
  800be3:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800be6:	eb 17                	jmp    800bff <vprintfmt+0x21>
			if (ch == '\0')
  800be8:	85 db                	test   %ebx,%ebx
  800bea:	0f 84 af 03 00 00    	je     800f9f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bf0:	83 ec 08             	sub    $0x8,%esp
  800bf3:	ff 75 0c             	pushl  0xc(%ebp)
  800bf6:	53                   	push   %ebx
  800bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfa:	ff d0                	call   *%eax
  800bfc:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bff:	8b 45 10             	mov    0x10(%ebp),%eax
  800c02:	8d 50 01             	lea    0x1(%eax),%edx
  800c05:	89 55 10             	mov    %edx,0x10(%ebp)
  800c08:	8a 00                	mov    (%eax),%al
  800c0a:	0f b6 d8             	movzbl %al,%ebx
  800c0d:	83 fb 25             	cmp    $0x25,%ebx
  800c10:	75 d6                	jne    800be8 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c12:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c16:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c1d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c24:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c2b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c32:	8b 45 10             	mov    0x10(%ebp),%eax
  800c35:	8d 50 01             	lea    0x1(%eax),%edx
  800c38:	89 55 10             	mov    %edx,0x10(%ebp)
  800c3b:	8a 00                	mov    (%eax),%al
  800c3d:	0f b6 d8             	movzbl %al,%ebx
  800c40:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c43:	83 f8 55             	cmp    $0x55,%eax
  800c46:	0f 87 2b 03 00 00    	ja     800f77 <vprintfmt+0x399>
  800c4c:	8b 04 85 b8 26 80 00 	mov    0x8026b8(,%eax,4),%eax
  800c53:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c55:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c59:	eb d7                	jmp    800c32 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c5b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c5f:	eb d1                	jmp    800c32 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c61:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c68:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c6b:	89 d0                	mov    %edx,%eax
  800c6d:	c1 e0 02             	shl    $0x2,%eax
  800c70:	01 d0                	add    %edx,%eax
  800c72:	01 c0                	add    %eax,%eax
  800c74:	01 d8                	add    %ebx,%eax
  800c76:	83 e8 30             	sub    $0x30,%eax
  800c79:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c7f:	8a 00                	mov    (%eax),%al
  800c81:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c84:	83 fb 2f             	cmp    $0x2f,%ebx
  800c87:	7e 3e                	jle    800cc7 <vprintfmt+0xe9>
  800c89:	83 fb 39             	cmp    $0x39,%ebx
  800c8c:	7f 39                	jg     800cc7 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c8e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c91:	eb d5                	jmp    800c68 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c93:	8b 45 14             	mov    0x14(%ebp),%eax
  800c96:	83 c0 04             	add    $0x4,%eax
  800c99:	89 45 14             	mov    %eax,0x14(%ebp)
  800c9c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c9f:	83 e8 04             	sub    $0x4,%eax
  800ca2:	8b 00                	mov    (%eax),%eax
  800ca4:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800ca7:	eb 1f                	jmp    800cc8 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ca9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cad:	79 83                	jns    800c32 <vprintfmt+0x54>
				width = 0;
  800caf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cb6:	e9 77 ff ff ff       	jmp    800c32 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800cbb:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800cc2:	e9 6b ff ff ff       	jmp    800c32 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800cc7:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800cc8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ccc:	0f 89 60 ff ff ff    	jns    800c32 <vprintfmt+0x54>
				width = precision, precision = -1;
  800cd2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cd5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cd8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cdf:	e9 4e ff ff ff       	jmp    800c32 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ce4:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ce7:	e9 46 ff ff ff       	jmp    800c32 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cec:	8b 45 14             	mov    0x14(%ebp),%eax
  800cef:	83 c0 04             	add    $0x4,%eax
  800cf2:	89 45 14             	mov    %eax,0x14(%ebp)
  800cf5:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf8:	83 e8 04             	sub    $0x4,%eax
  800cfb:	8b 00                	mov    (%eax),%eax
  800cfd:	83 ec 08             	sub    $0x8,%esp
  800d00:	ff 75 0c             	pushl  0xc(%ebp)
  800d03:	50                   	push   %eax
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	ff d0                	call   *%eax
  800d09:	83 c4 10             	add    $0x10,%esp
			break;
  800d0c:	e9 89 02 00 00       	jmp    800f9a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d11:	8b 45 14             	mov    0x14(%ebp),%eax
  800d14:	83 c0 04             	add    $0x4,%eax
  800d17:	89 45 14             	mov    %eax,0x14(%ebp)
  800d1a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1d:	83 e8 04             	sub    $0x4,%eax
  800d20:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d22:	85 db                	test   %ebx,%ebx
  800d24:	79 02                	jns    800d28 <vprintfmt+0x14a>
				err = -err;
  800d26:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d28:	83 fb 64             	cmp    $0x64,%ebx
  800d2b:	7f 0b                	jg     800d38 <vprintfmt+0x15a>
  800d2d:	8b 34 9d 00 25 80 00 	mov    0x802500(,%ebx,4),%esi
  800d34:	85 f6                	test   %esi,%esi
  800d36:	75 19                	jne    800d51 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d38:	53                   	push   %ebx
  800d39:	68 a5 26 80 00       	push   $0x8026a5
  800d3e:	ff 75 0c             	pushl  0xc(%ebp)
  800d41:	ff 75 08             	pushl  0x8(%ebp)
  800d44:	e8 5e 02 00 00       	call   800fa7 <printfmt>
  800d49:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d4c:	e9 49 02 00 00       	jmp    800f9a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d51:	56                   	push   %esi
  800d52:	68 ae 26 80 00       	push   $0x8026ae
  800d57:	ff 75 0c             	pushl  0xc(%ebp)
  800d5a:	ff 75 08             	pushl  0x8(%ebp)
  800d5d:	e8 45 02 00 00       	call   800fa7 <printfmt>
  800d62:	83 c4 10             	add    $0x10,%esp
			break;
  800d65:	e9 30 02 00 00       	jmp    800f9a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d6a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d6d:	83 c0 04             	add    $0x4,%eax
  800d70:	89 45 14             	mov    %eax,0x14(%ebp)
  800d73:	8b 45 14             	mov    0x14(%ebp),%eax
  800d76:	83 e8 04             	sub    $0x4,%eax
  800d79:	8b 30                	mov    (%eax),%esi
  800d7b:	85 f6                	test   %esi,%esi
  800d7d:	75 05                	jne    800d84 <vprintfmt+0x1a6>
				p = "(null)";
  800d7f:	be b1 26 80 00       	mov    $0x8026b1,%esi
			if (width > 0 && padc != '-')
  800d84:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d88:	7e 6d                	jle    800df7 <vprintfmt+0x219>
  800d8a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d8e:	74 67                	je     800df7 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d90:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d93:	83 ec 08             	sub    $0x8,%esp
  800d96:	50                   	push   %eax
  800d97:	56                   	push   %esi
  800d98:	e8 0c 03 00 00       	call   8010a9 <strnlen>
  800d9d:	83 c4 10             	add    $0x10,%esp
  800da0:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800da3:	eb 16                	jmp    800dbb <vprintfmt+0x1dd>
					putch(padc, putdat);
  800da5:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800da9:	83 ec 08             	sub    $0x8,%esp
  800dac:	ff 75 0c             	pushl  0xc(%ebp)
  800daf:	50                   	push   %eax
  800db0:	8b 45 08             	mov    0x8(%ebp),%eax
  800db3:	ff d0                	call   *%eax
  800db5:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800db8:	ff 4d e4             	decl   -0x1c(%ebp)
  800dbb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dbf:	7f e4                	jg     800da5 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dc1:	eb 34                	jmp    800df7 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800dc3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800dc7:	74 1c                	je     800de5 <vprintfmt+0x207>
  800dc9:	83 fb 1f             	cmp    $0x1f,%ebx
  800dcc:	7e 05                	jle    800dd3 <vprintfmt+0x1f5>
  800dce:	83 fb 7e             	cmp    $0x7e,%ebx
  800dd1:	7e 12                	jle    800de5 <vprintfmt+0x207>
					putch('?', putdat);
  800dd3:	83 ec 08             	sub    $0x8,%esp
  800dd6:	ff 75 0c             	pushl  0xc(%ebp)
  800dd9:	6a 3f                	push   $0x3f
  800ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dde:	ff d0                	call   *%eax
  800de0:	83 c4 10             	add    $0x10,%esp
  800de3:	eb 0f                	jmp    800df4 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800de5:	83 ec 08             	sub    $0x8,%esp
  800de8:	ff 75 0c             	pushl  0xc(%ebp)
  800deb:	53                   	push   %ebx
  800dec:	8b 45 08             	mov    0x8(%ebp),%eax
  800def:	ff d0                	call   *%eax
  800df1:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800df4:	ff 4d e4             	decl   -0x1c(%ebp)
  800df7:	89 f0                	mov    %esi,%eax
  800df9:	8d 70 01             	lea    0x1(%eax),%esi
  800dfc:	8a 00                	mov    (%eax),%al
  800dfe:	0f be d8             	movsbl %al,%ebx
  800e01:	85 db                	test   %ebx,%ebx
  800e03:	74 24                	je     800e29 <vprintfmt+0x24b>
  800e05:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e09:	78 b8                	js     800dc3 <vprintfmt+0x1e5>
  800e0b:	ff 4d e0             	decl   -0x20(%ebp)
  800e0e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e12:	79 af                	jns    800dc3 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e14:	eb 13                	jmp    800e29 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e16:	83 ec 08             	sub    $0x8,%esp
  800e19:	ff 75 0c             	pushl  0xc(%ebp)
  800e1c:	6a 20                	push   $0x20
  800e1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e21:	ff d0                	call   *%eax
  800e23:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e26:	ff 4d e4             	decl   -0x1c(%ebp)
  800e29:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e2d:	7f e7                	jg     800e16 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e2f:	e9 66 01 00 00       	jmp    800f9a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e34:	83 ec 08             	sub    $0x8,%esp
  800e37:	ff 75 e8             	pushl  -0x18(%ebp)
  800e3a:	8d 45 14             	lea    0x14(%ebp),%eax
  800e3d:	50                   	push   %eax
  800e3e:	e8 3c fd ff ff       	call   800b7f <getint>
  800e43:	83 c4 10             	add    $0x10,%esp
  800e46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e49:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e4f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e52:	85 d2                	test   %edx,%edx
  800e54:	79 23                	jns    800e79 <vprintfmt+0x29b>
				putch('-', putdat);
  800e56:	83 ec 08             	sub    $0x8,%esp
  800e59:	ff 75 0c             	pushl  0xc(%ebp)
  800e5c:	6a 2d                	push   $0x2d
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e61:	ff d0                	call   *%eax
  800e63:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e66:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e69:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e6c:	f7 d8                	neg    %eax
  800e6e:	83 d2 00             	adc    $0x0,%edx
  800e71:	f7 da                	neg    %edx
  800e73:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e76:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e79:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e80:	e9 bc 00 00 00       	jmp    800f41 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e85:	83 ec 08             	sub    $0x8,%esp
  800e88:	ff 75 e8             	pushl  -0x18(%ebp)
  800e8b:	8d 45 14             	lea    0x14(%ebp),%eax
  800e8e:	50                   	push   %eax
  800e8f:	e8 84 fc ff ff       	call   800b18 <getuint>
  800e94:	83 c4 10             	add    $0x10,%esp
  800e97:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e9a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e9d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ea4:	e9 98 00 00 00       	jmp    800f41 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ea9:	83 ec 08             	sub    $0x8,%esp
  800eac:	ff 75 0c             	pushl  0xc(%ebp)
  800eaf:	6a 58                	push   $0x58
  800eb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb4:	ff d0                	call   *%eax
  800eb6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800eb9:	83 ec 08             	sub    $0x8,%esp
  800ebc:	ff 75 0c             	pushl  0xc(%ebp)
  800ebf:	6a 58                	push   $0x58
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	ff d0                	call   *%eax
  800ec6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ec9:	83 ec 08             	sub    $0x8,%esp
  800ecc:	ff 75 0c             	pushl  0xc(%ebp)
  800ecf:	6a 58                	push   $0x58
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed4:	ff d0                	call   *%eax
  800ed6:	83 c4 10             	add    $0x10,%esp
			break;
  800ed9:	e9 bc 00 00 00       	jmp    800f9a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ede:	83 ec 08             	sub    $0x8,%esp
  800ee1:	ff 75 0c             	pushl  0xc(%ebp)
  800ee4:	6a 30                	push   $0x30
  800ee6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee9:	ff d0                	call   *%eax
  800eeb:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800eee:	83 ec 08             	sub    $0x8,%esp
  800ef1:	ff 75 0c             	pushl  0xc(%ebp)
  800ef4:	6a 78                	push   $0x78
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	ff d0                	call   *%eax
  800efb:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800efe:	8b 45 14             	mov    0x14(%ebp),%eax
  800f01:	83 c0 04             	add    $0x4,%eax
  800f04:	89 45 14             	mov    %eax,0x14(%ebp)
  800f07:	8b 45 14             	mov    0x14(%ebp),%eax
  800f0a:	83 e8 04             	sub    $0x4,%eax
  800f0d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f12:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f19:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f20:	eb 1f                	jmp    800f41 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f22:	83 ec 08             	sub    $0x8,%esp
  800f25:	ff 75 e8             	pushl  -0x18(%ebp)
  800f28:	8d 45 14             	lea    0x14(%ebp),%eax
  800f2b:	50                   	push   %eax
  800f2c:	e8 e7 fb ff ff       	call   800b18 <getuint>
  800f31:	83 c4 10             	add    $0x10,%esp
  800f34:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f37:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f3a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f41:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f45:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f48:	83 ec 04             	sub    $0x4,%esp
  800f4b:	52                   	push   %edx
  800f4c:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f4f:	50                   	push   %eax
  800f50:	ff 75 f4             	pushl  -0xc(%ebp)
  800f53:	ff 75 f0             	pushl  -0x10(%ebp)
  800f56:	ff 75 0c             	pushl  0xc(%ebp)
  800f59:	ff 75 08             	pushl  0x8(%ebp)
  800f5c:	e8 00 fb ff ff       	call   800a61 <printnum>
  800f61:	83 c4 20             	add    $0x20,%esp
			break;
  800f64:	eb 34                	jmp    800f9a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f66:	83 ec 08             	sub    $0x8,%esp
  800f69:	ff 75 0c             	pushl  0xc(%ebp)
  800f6c:	53                   	push   %ebx
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	ff d0                	call   *%eax
  800f72:	83 c4 10             	add    $0x10,%esp
			break;
  800f75:	eb 23                	jmp    800f9a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f77:	83 ec 08             	sub    $0x8,%esp
  800f7a:	ff 75 0c             	pushl  0xc(%ebp)
  800f7d:	6a 25                	push   $0x25
  800f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f82:	ff d0                	call   *%eax
  800f84:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f87:	ff 4d 10             	decl   0x10(%ebp)
  800f8a:	eb 03                	jmp    800f8f <vprintfmt+0x3b1>
  800f8c:	ff 4d 10             	decl   0x10(%ebp)
  800f8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f92:	48                   	dec    %eax
  800f93:	8a 00                	mov    (%eax),%al
  800f95:	3c 25                	cmp    $0x25,%al
  800f97:	75 f3                	jne    800f8c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f99:	90                   	nop
		}
	}
  800f9a:	e9 47 fc ff ff       	jmp    800be6 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f9f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fa0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fa3:	5b                   	pop    %ebx
  800fa4:	5e                   	pop    %esi
  800fa5:	5d                   	pop    %ebp
  800fa6:	c3                   	ret    

00800fa7 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fa7:	55                   	push   %ebp
  800fa8:	89 e5                	mov    %esp,%ebp
  800faa:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fad:	8d 45 10             	lea    0x10(%ebp),%eax
  800fb0:	83 c0 04             	add    $0x4,%eax
  800fb3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb9:	ff 75 f4             	pushl  -0xc(%ebp)
  800fbc:	50                   	push   %eax
  800fbd:	ff 75 0c             	pushl  0xc(%ebp)
  800fc0:	ff 75 08             	pushl  0x8(%ebp)
  800fc3:	e8 16 fc ff ff       	call   800bde <vprintfmt>
  800fc8:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fcb:	90                   	nop
  800fcc:	c9                   	leave  
  800fcd:	c3                   	ret    

00800fce <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fce:	55                   	push   %ebp
  800fcf:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd4:	8b 40 08             	mov    0x8(%eax),%eax
  800fd7:	8d 50 01             	lea    0x1(%eax),%edx
  800fda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fdd:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fe0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe3:	8b 10                	mov    (%eax),%edx
  800fe5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe8:	8b 40 04             	mov    0x4(%eax),%eax
  800feb:	39 c2                	cmp    %eax,%edx
  800fed:	73 12                	jae    801001 <sprintputch+0x33>
		*b->buf++ = ch;
  800fef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff2:	8b 00                	mov    (%eax),%eax
  800ff4:	8d 48 01             	lea    0x1(%eax),%ecx
  800ff7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ffa:	89 0a                	mov    %ecx,(%edx)
  800ffc:	8b 55 08             	mov    0x8(%ebp),%edx
  800fff:	88 10                	mov    %dl,(%eax)
}
  801001:	90                   	nop
  801002:	5d                   	pop    %ebp
  801003:	c3                   	ret    

00801004 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801004:	55                   	push   %ebp
  801005:	89 e5                	mov    %esp,%ebp
  801007:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80100a:	8b 45 08             	mov    0x8(%ebp),%eax
  80100d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801010:	8b 45 0c             	mov    0xc(%ebp),%eax
  801013:	8d 50 ff             	lea    -0x1(%eax),%edx
  801016:	8b 45 08             	mov    0x8(%ebp),%eax
  801019:	01 d0                	add    %edx,%eax
  80101b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80101e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801025:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801029:	74 06                	je     801031 <vsnprintf+0x2d>
  80102b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80102f:	7f 07                	jg     801038 <vsnprintf+0x34>
		return -E_INVAL;
  801031:	b8 03 00 00 00       	mov    $0x3,%eax
  801036:	eb 20                	jmp    801058 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801038:	ff 75 14             	pushl  0x14(%ebp)
  80103b:	ff 75 10             	pushl  0x10(%ebp)
  80103e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801041:	50                   	push   %eax
  801042:	68 ce 0f 80 00       	push   $0x800fce
  801047:	e8 92 fb ff ff       	call   800bde <vprintfmt>
  80104c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80104f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801052:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801055:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801058:	c9                   	leave  
  801059:	c3                   	ret    

0080105a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80105a:	55                   	push   %ebp
  80105b:	89 e5                	mov    %esp,%ebp
  80105d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801060:	8d 45 10             	lea    0x10(%ebp),%eax
  801063:	83 c0 04             	add    $0x4,%eax
  801066:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801069:	8b 45 10             	mov    0x10(%ebp),%eax
  80106c:	ff 75 f4             	pushl  -0xc(%ebp)
  80106f:	50                   	push   %eax
  801070:	ff 75 0c             	pushl  0xc(%ebp)
  801073:	ff 75 08             	pushl  0x8(%ebp)
  801076:	e8 89 ff ff ff       	call   801004 <vsnprintf>
  80107b:	83 c4 10             	add    $0x10,%esp
  80107e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801081:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801084:	c9                   	leave  
  801085:	c3                   	ret    

00801086 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801086:	55                   	push   %ebp
  801087:	89 e5                	mov    %esp,%ebp
  801089:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80108c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801093:	eb 06                	jmp    80109b <strlen+0x15>
		n++;
  801095:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801098:	ff 45 08             	incl   0x8(%ebp)
  80109b:	8b 45 08             	mov    0x8(%ebp),%eax
  80109e:	8a 00                	mov    (%eax),%al
  8010a0:	84 c0                	test   %al,%al
  8010a2:	75 f1                	jne    801095 <strlen+0xf>
		n++;
	return n;
  8010a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010a7:	c9                   	leave  
  8010a8:	c3                   	ret    

008010a9 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8010a9:	55                   	push   %ebp
  8010aa:	89 e5                	mov    %esp,%ebp
  8010ac:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8010af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010b6:	eb 09                	jmp    8010c1 <strnlen+0x18>
		n++;
  8010b8:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8010bb:	ff 45 08             	incl   0x8(%ebp)
  8010be:	ff 4d 0c             	decl   0xc(%ebp)
  8010c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010c5:	74 09                	je     8010d0 <strnlen+0x27>
  8010c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ca:	8a 00                	mov    (%eax),%al
  8010cc:	84 c0                	test   %al,%al
  8010ce:	75 e8                	jne    8010b8 <strnlen+0xf>
		n++;
	return n;
  8010d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010d3:	c9                   	leave  
  8010d4:	c3                   	ret    

008010d5 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8010d5:	55                   	push   %ebp
  8010d6:	89 e5                	mov    %esp,%ebp
  8010d8:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8010db:	8b 45 08             	mov    0x8(%ebp),%eax
  8010de:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8010e1:	90                   	nop
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	8d 50 01             	lea    0x1(%eax),%edx
  8010e8:	89 55 08             	mov    %edx,0x8(%ebp)
  8010eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ee:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010f1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010f4:	8a 12                	mov    (%edx),%dl
  8010f6:	88 10                	mov    %dl,(%eax)
  8010f8:	8a 00                	mov    (%eax),%al
  8010fa:	84 c0                	test   %al,%al
  8010fc:	75 e4                	jne    8010e2 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801101:	c9                   	leave  
  801102:	c3                   	ret    

00801103 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801103:	55                   	push   %ebp
  801104:	89 e5                	mov    %esp,%ebp
  801106:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801109:	8b 45 08             	mov    0x8(%ebp),%eax
  80110c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80110f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801116:	eb 1f                	jmp    801137 <strncpy+0x34>
		*dst++ = *src;
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
  80111b:	8d 50 01             	lea    0x1(%eax),%edx
  80111e:	89 55 08             	mov    %edx,0x8(%ebp)
  801121:	8b 55 0c             	mov    0xc(%ebp),%edx
  801124:	8a 12                	mov    (%edx),%dl
  801126:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801128:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112b:	8a 00                	mov    (%eax),%al
  80112d:	84 c0                	test   %al,%al
  80112f:	74 03                	je     801134 <strncpy+0x31>
			src++;
  801131:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801134:	ff 45 fc             	incl   -0x4(%ebp)
  801137:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80113a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80113d:	72 d9                	jb     801118 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80113f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801142:	c9                   	leave  
  801143:	c3                   	ret    

00801144 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801144:	55                   	push   %ebp
  801145:	89 e5                	mov    %esp,%ebp
  801147:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80114a:	8b 45 08             	mov    0x8(%ebp),%eax
  80114d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801150:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801154:	74 30                	je     801186 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801156:	eb 16                	jmp    80116e <strlcpy+0x2a>
			*dst++ = *src++;
  801158:	8b 45 08             	mov    0x8(%ebp),%eax
  80115b:	8d 50 01             	lea    0x1(%eax),%edx
  80115e:	89 55 08             	mov    %edx,0x8(%ebp)
  801161:	8b 55 0c             	mov    0xc(%ebp),%edx
  801164:	8d 4a 01             	lea    0x1(%edx),%ecx
  801167:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80116a:	8a 12                	mov    (%edx),%dl
  80116c:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80116e:	ff 4d 10             	decl   0x10(%ebp)
  801171:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801175:	74 09                	je     801180 <strlcpy+0x3c>
  801177:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117a:	8a 00                	mov    (%eax),%al
  80117c:	84 c0                	test   %al,%al
  80117e:	75 d8                	jne    801158 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801180:	8b 45 08             	mov    0x8(%ebp),%eax
  801183:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801186:	8b 55 08             	mov    0x8(%ebp),%edx
  801189:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80118c:	29 c2                	sub    %eax,%edx
  80118e:	89 d0                	mov    %edx,%eax
}
  801190:	c9                   	leave  
  801191:	c3                   	ret    

00801192 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801192:	55                   	push   %ebp
  801193:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801195:	eb 06                	jmp    80119d <strcmp+0xb>
		p++, q++;
  801197:	ff 45 08             	incl   0x8(%ebp)
  80119a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	8a 00                	mov    (%eax),%al
  8011a2:	84 c0                	test   %al,%al
  8011a4:	74 0e                	je     8011b4 <strcmp+0x22>
  8011a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a9:	8a 10                	mov    (%eax),%dl
  8011ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ae:	8a 00                	mov    (%eax),%al
  8011b0:	38 c2                	cmp    %al,%dl
  8011b2:	74 e3                	je     801197 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b7:	8a 00                	mov    (%eax),%al
  8011b9:	0f b6 d0             	movzbl %al,%edx
  8011bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bf:	8a 00                	mov    (%eax),%al
  8011c1:	0f b6 c0             	movzbl %al,%eax
  8011c4:	29 c2                	sub    %eax,%edx
  8011c6:	89 d0                	mov    %edx,%eax
}
  8011c8:	5d                   	pop    %ebp
  8011c9:	c3                   	ret    

008011ca <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8011ca:	55                   	push   %ebp
  8011cb:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8011cd:	eb 09                	jmp    8011d8 <strncmp+0xe>
		n--, p++, q++;
  8011cf:	ff 4d 10             	decl   0x10(%ebp)
  8011d2:	ff 45 08             	incl   0x8(%ebp)
  8011d5:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8011d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011dc:	74 17                	je     8011f5 <strncmp+0x2b>
  8011de:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e1:	8a 00                	mov    (%eax),%al
  8011e3:	84 c0                	test   %al,%al
  8011e5:	74 0e                	je     8011f5 <strncmp+0x2b>
  8011e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ea:	8a 10                	mov    (%eax),%dl
  8011ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ef:	8a 00                	mov    (%eax),%al
  8011f1:	38 c2                	cmp    %al,%dl
  8011f3:	74 da                	je     8011cf <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011f9:	75 07                	jne    801202 <strncmp+0x38>
		return 0;
  8011fb:	b8 00 00 00 00       	mov    $0x0,%eax
  801200:	eb 14                	jmp    801216 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	8a 00                	mov    (%eax),%al
  801207:	0f b6 d0             	movzbl %al,%edx
  80120a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120d:	8a 00                	mov    (%eax),%al
  80120f:	0f b6 c0             	movzbl %al,%eax
  801212:	29 c2                	sub    %eax,%edx
  801214:	89 d0                	mov    %edx,%eax
}
  801216:	5d                   	pop    %ebp
  801217:	c3                   	ret    

00801218 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801218:	55                   	push   %ebp
  801219:	89 e5                	mov    %esp,%ebp
  80121b:	83 ec 04             	sub    $0x4,%esp
  80121e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801221:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801224:	eb 12                	jmp    801238 <strchr+0x20>
		if (*s == c)
  801226:	8b 45 08             	mov    0x8(%ebp),%eax
  801229:	8a 00                	mov    (%eax),%al
  80122b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80122e:	75 05                	jne    801235 <strchr+0x1d>
			return (char *) s;
  801230:	8b 45 08             	mov    0x8(%ebp),%eax
  801233:	eb 11                	jmp    801246 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801235:	ff 45 08             	incl   0x8(%ebp)
  801238:	8b 45 08             	mov    0x8(%ebp),%eax
  80123b:	8a 00                	mov    (%eax),%al
  80123d:	84 c0                	test   %al,%al
  80123f:	75 e5                	jne    801226 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801241:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801246:	c9                   	leave  
  801247:	c3                   	ret    

00801248 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801248:	55                   	push   %ebp
  801249:	89 e5                	mov    %esp,%ebp
  80124b:	83 ec 04             	sub    $0x4,%esp
  80124e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801251:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801254:	eb 0d                	jmp    801263 <strfind+0x1b>
		if (*s == c)
  801256:	8b 45 08             	mov    0x8(%ebp),%eax
  801259:	8a 00                	mov    (%eax),%al
  80125b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80125e:	74 0e                	je     80126e <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801260:	ff 45 08             	incl   0x8(%ebp)
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	8a 00                	mov    (%eax),%al
  801268:	84 c0                	test   %al,%al
  80126a:	75 ea                	jne    801256 <strfind+0xe>
  80126c:	eb 01                	jmp    80126f <strfind+0x27>
		if (*s == c)
			break;
  80126e:	90                   	nop
	return (char *) s;
  80126f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801272:	c9                   	leave  
  801273:	c3                   	ret    

00801274 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801274:	55                   	push   %ebp
  801275:	89 e5                	mov    %esp,%ebp
  801277:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80127a:	8b 45 08             	mov    0x8(%ebp),%eax
  80127d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801280:	8b 45 10             	mov    0x10(%ebp),%eax
  801283:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801286:	eb 0e                	jmp    801296 <memset+0x22>
		*p++ = c;
  801288:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80128b:	8d 50 01             	lea    0x1(%eax),%edx
  80128e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801291:	8b 55 0c             	mov    0xc(%ebp),%edx
  801294:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801296:	ff 4d f8             	decl   -0x8(%ebp)
  801299:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80129d:	79 e9                	jns    801288 <memset+0x14>
		*p++ = c;

	return v;
  80129f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012a2:	c9                   	leave  
  8012a3:	c3                   	ret    

008012a4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8012a4:	55                   	push   %ebp
  8012a5:	89 e5                	mov    %esp,%ebp
  8012a7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8012aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8012b6:	eb 16                	jmp    8012ce <memcpy+0x2a>
		*d++ = *s++;
  8012b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012bb:	8d 50 01             	lea    0x1(%eax),%edx
  8012be:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012c4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012c7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012ca:	8a 12                	mov    (%edx),%dl
  8012cc:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8012ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012d4:	89 55 10             	mov    %edx,0x10(%ebp)
  8012d7:	85 c0                	test   %eax,%eax
  8012d9:	75 dd                	jne    8012b8 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8012db:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012de:	c9                   	leave  
  8012df:	c3                   	ret    

008012e0 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8012e0:	55                   	push   %ebp
  8012e1:	89 e5                	mov    %esp,%ebp
  8012e3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8012e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ef:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012f8:	73 50                	jae    80134a <memmove+0x6a>
  8012fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801300:	01 d0                	add    %edx,%eax
  801302:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801305:	76 43                	jbe    80134a <memmove+0x6a>
		s += n;
  801307:	8b 45 10             	mov    0x10(%ebp),%eax
  80130a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80130d:	8b 45 10             	mov    0x10(%ebp),%eax
  801310:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801313:	eb 10                	jmp    801325 <memmove+0x45>
			*--d = *--s;
  801315:	ff 4d f8             	decl   -0x8(%ebp)
  801318:	ff 4d fc             	decl   -0x4(%ebp)
  80131b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80131e:	8a 10                	mov    (%eax),%dl
  801320:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801323:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801325:	8b 45 10             	mov    0x10(%ebp),%eax
  801328:	8d 50 ff             	lea    -0x1(%eax),%edx
  80132b:	89 55 10             	mov    %edx,0x10(%ebp)
  80132e:	85 c0                	test   %eax,%eax
  801330:	75 e3                	jne    801315 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801332:	eb 23                	jmp    801357 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801334:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801337:	8d 50 01             	lea    0x1(%eax),%edx
  80133a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80133d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801340:	8d 4a 01             	lea    0x1(%edx),%ecx
  801343:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801346:	8a 12                	mov    (%edx),%dl
  801348:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80134a:	8b 45 10             	mov    0x10(%ebp),%eax
  80134d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801350:	89 55 10             	mov    %edx,0x10(%ebp)
  801353:	85 c0                	test   %eax,%eax
  801355:	75 dd                	jne    801334 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80135a:	c9                   	leave  
  80135b:	c3                   	ret    

0080135c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80135c:	55                   	push   %ebp
  80135d:	89 e5                	mov    %esp,%ebp
  80135f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801368:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136b:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80136e:	eb 2a                	jmp    80139a <memcmp+0x3e>
		if (*s1 != *s2)
  801370:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801373:	8a 10                	mov    (%eax),%dl
  801375:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801378:	8a 00                	mov    (%eax),%al
  80137a:	38 c2                	cmp    %al,%dl
  80137c:	74 16                	je     801394 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80137e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801381:	8a 00                	mov    (%eax),%al
  801383:	0f b6 d0             	movzbl %al,%edx
  801386:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801389:	8a 00                	mov    (%eax),%al
  80138b:	0f b6 c0             	movzbl %al,%eax
  80138e:	29 c2                	sub    %eax,%edx
  801390:	89 d0                	mov    %edx,%eax
  801392:	eb 18                	jmp    8013ac <memcmp+0x50>
		s1++, s2++;
  801394:	ff 45 fc             	incl   -0x4(%ebp)
  801397:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80139a:	8b 45 10             	mov    0x10(%ebp),%eax
  80139d:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013a0:	89 55 10             	mov    %edx,0x10(%ebp)
  8013a3:	85 c0                	test   %eax,%eax
  8013a5:	75 c9                	jne    801370 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8013a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013ac:	c9                   	leave  
  8013ad:	c3                   	ret    

008013ae <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8013ae:	55                   	push   %ebp
  8013af:	89 e5                	mov    %esp,%ebp
  8013b1:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8013b4:	8b 55 08             	mov    0x8(%ebp),%edx
  8013b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ba:	01 d0                	add    %edx,%eax
  8013bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8013bf:	eb 15                	jmp    8013d6 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	8a 00                	mov    (%eax),%al
  8013c6:	0f b6 d0             	movzbl %al,%edx
  8013c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013cc:	0f b6 c0             	movzbl %al,%eax
  8013cf:	39 c2                	cmp    %eax,%edx
  8013d1:	74 0d                	je     8013e0 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8013d3:	ff 45 08             	incl   0x8(%ebp)
  8013d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8013dc:	72 e3                	jb     8013c1 <memfind+0x13>
  8013de:	eb 01                	jmp    8013e1 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8013e0:	90                   	nop
	return (void *) s;
  8013e1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013e4:	c9                   	leave  
  8013e5:	c3                   	ret    

008013e6 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8013e6:	55                   	push   %ebp
  8013e7:	89 e5                	mov    %esp,%ebp
  8013e9:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8013ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013f3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013fa:	eb 03                	jmp    8013ff <strtol+0x19>
		s++;
  8013fc:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	8a 00                	mov    (%eax),%al
  801404:	3c 20                	cmp    $0x20,%al
  801406:	74 f4                	je     8013fc <strtol+0x16>
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
  80140b:	8a 00                	mov    (%eax),%al
  80140d:	3c 09                	cmp    $0x9,%al
  80140f:	74 eb                	je     8013fc <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801411:	8b 45 08             	mov    0x8(%ebp),%eax
  801414:	8a 00                	mov    (%eax),%al
  801416:	3c 2b                	cmp    $0x2b,%al
  801418:	75 05                	jne    80141f <strtol+0x39>
		s++;
  80141a:	ff 45 08             	incl   0x8(%ebp)
  80141d:	eb 13                	jmp    801432 <strtol+0x4c>
	else if (*s == '-')
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	8a 00                	mov    (%eax),%al
  801424:	3c 2d                	cmp    $0x2d,%al
  801426:	75 0a                	jne    801432 <strtol+0x4c>
		s++, neg = 1;
  801428:	ff 45 08             	incl   0x8(%ebp)
  80142b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801432:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801436:	74 06                	je     80143e <strtol+0x58>
  801438:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80143c:	75 20                	jne    80145e <strtol+0x78>
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	8a 00                	mov    (%eax),%al
  801443:	3c 30                	cmp    $0x30,%al
  801445:	75 17                	jne    80145e <strtol+0x78>
  801447:	8b 45 08             	mov    0x8(%ebp),%eax
  80144a:	40                   	inc    %eax
  80144b:	8a 00                	mov    (%eax),%al
  80144d:	3c 78                	cmp    $0x78,%al
  80144f:	75 0d                	jne    80145e <strtol+0x78>
		s += 2, base = 16;
  801451:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801455:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80145c:	eb 28                	jmp    801486 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80145e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801462:	75 15                	jne    801479 <strtol+0x93>
  801464:	8b 45 08             	mov    0x8(%ebp),%eax
  801467:	8a 00                	mov    (%eax),%al
  801469:	3c 30                	cmp    $0x30,%al
  80146b:	75 0c                	jne    801479 <strtol+0x93>
		s++, base = 8;
  80146d:	ff 45 08             	incl   0x8(%ebp)
  801470:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801477:	eb 0d                	jmp    801486 <strtol+0xa0>
	else if (base == 0)
  801479:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80147d:	75 07                	jne    801486 <strtol+0xa0>
		base = 10;
  80147f:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	8a 00                	mov    (%eax),%al
  80148b:	3c 2f                	cmp    $0x2f,%al
  80148d:	7e 19                	jle    8014a8 <strtol+0xc2>
  80148f:	8b 45 08             	mov    0x8(%ebp),%eax
  801492:	8a 00                	mov    (%eax),%al
  801494:	3c 39                	cmp    $0x39,%al
  801496:	7f 10                	jg     8014a8 <strtol+0xc2>
			dig = *s - '0';
  801498:	8b 45 08             	mov    0x8(%ebp),%eax
  80149b:	8a 00                	mov    (%eax),%al
  80149d:	0f be c0             	movsbl %al,%eax
  8014a0:	83 e8 30             	sub    $0x30,%eax
  8014a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8014a6:	eb 42                	jmp    8014ea <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8014a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ab:	8a 00                	mov    (%eax),%al
  8014ad:	3c 60                	cmp    $0x60,%al
  8014af:	7e 19                	jle    8014ca <strtol+0xe4>
  8014b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b4:	8a 00                	mov    (%eax),%al
  8014b6:	3c 7a                	cmp    $0x7a,%al
  8014b8:	7f 10                	jg     8014ca <strtol+0xe4>
			dig = *s - 'a' + 10;
  8014ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bd:	8a 00                	mov    (%eax),%al
  8014bf:	0f be c0             	movsbl %al,%eax
  8014c2:	83 e8 57             	sub    $0x57,%eax
  8014c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8014c8:	eb 20                	jmp    8014ea <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8014ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cd:	8a 00                	mov    (%eax),%al
  8014cf:	3c 40                	cmp    $0x40,%al
  8014d1:	7e 39                	jle    80150c <strtol+0x126>
  8014d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d6:	8a 00                	mov    (%eax),%al
  8014d8:	3c 5a                	cmp    $0x5a,%al
  8014da:	7f 30                	jg     80150c <strtol+0x126>
			dig = *s - 'A' + 10;
  8014dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014df:	8a 00                	mov    (%eax),%al
  8014e1:	0f be c0             	movsbl %al,%eax
  8014e4:	83 e8 37             	sub    $0x37,%eax
  8014e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8014ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014ed:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014f0:	7d 19                	jge    80150b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014f2:	ff 45 08             	incl   0x8(%ebp)
  8014f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f8:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014fc:	89 c2                	mov    %eax,%edx
  8014fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801501:	01 d0                	add    %edx,%eax
  801503:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801506:	e9 7b ff ff ff       	jmp    801486 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80150b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80150c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801510:	74 08                	je     80151a <strtol+0x134>
		*endptr = (char *) s;
  801512:	8b 45 0c             	mov    0xc(%ebp),%eax
  801515:	8b 55 08             	mov    0x8(%ebp),%edx
  801518:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80151a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80151e:	74 07                	je     801527 <strtol+0x141>
  801520:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801523:	f7 d8                	neg    %eax
  801525:	eb 03                	jmp    80152a <strtol+0x144>
  801527:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80152a:	c9                   	leave  
  80152b:	c3                   	ret    

0080152c <ltostr>:

void
ltostr(long value, char *str)
{
  80152c:	55                   	push   %ebp
  80152d:	89 e5                	mov    %esp,%ebp
  80152f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801532:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801539:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801540:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801544:	79 13                	jns    801559 <ltostr+0x2d>
	{
		neg = 1;
  801546:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80154d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801550:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801553:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801556:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801559:	8b 45 08             	mov    0x8(%ebp),%eax
  80155c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801561:	99                   	cltd   
  801562:	f7 f9                	idiv   %ecx
  801564:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801567:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80156a:	8d 50 01             	lea    0x1(%eax),%edx
  80156d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801570:	89 c2                	mov    %eax,%edx
  801572:	8b 45 0c             	mov    0xc(%ebp),%eax
  801575:	01 d0                	add    %edx,%eax
  801577:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80157a:	83 c2 30             	add    $0x30,%edx
  80157d:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80157f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801582:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801587:	f7 e9                	imul   %ecx
  801589:	c1 fa 02             	sar    $0x2,%edx
  80158c:	89 c8                	mov    %ecx,%eax
  80158e:	c1 f8 1f             	sar    $0x1f,%eax
  801591:	29 c2                	sub    %eax,%edx
  801593:	89 d0                	mov    %edx,%eax
  801595:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801598:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80159b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8015a0:	f7 e9                	imul   %ecx
  8015a2:	c1 fa 02             	sar    $0x2,%edx
  8015a5:	89 c8                	mov    %ecx,%eax
  8015a7:	c1 f8 1f             	sar    $0x1f,%eax
  8015aa:	29 c2                	sub    %eax,%edx
  8015ac:	89 d0                	mov    %edx,%eax
  8015ae:	c1 e0 02             	shl    $0x2,%eax
  8015b1:	01 d0                	add    %edx,%eax
  8015b3:	01 c0                	add    %eax,%eax
  8015b5:	29 c1                	sub    %eax,%ecx
  8015b7:	89 ca                	mov    %ecx,%edx
  8015b9:	85 d2                	test   %edx,%edx
  8015bb:	75 9c                	jne    801559 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8015bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8015c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015c7:	48                   	dec    %eax
  8015c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8015cb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8015cf:	74 3d                	je     80160e <ltostr+0xe2>
		start = 1 ;
  8015d1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8015d8:	eb 34                	jmp    80160e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8015da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e0:	01 d0                	add    %edx,%eax
  8015e2:	8a 00                	mov    (%eax),%al
  8015e4:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8015e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ed:	01 c2                	add    %eax,%edx
  8015ef:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f5:	01 c8                	add    %ecx,%eax
  8015f7:	8a 00                	mov    (%eax),%al
  8015f9:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015fb:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801601:	01 c2                	add    %eax,%edx
  801603:	8a 45 eb             	mov    -0x15(%ebp),%al
  801606:	88 02                	mov    %al,(%edx)
		start++ ;
  801608:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80160b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80160e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801611:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801614:	7c c4                	jl     8015da <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801616:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801619:	8b 45 0c             	mov    0xc(%ebp),%eax
  80161c:	01 d0                	add    %edx,%eax
  80161e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801621:	90                   	nop
  801622:	c9                   	leave  
  801623:	c3                   	ret    

00801624 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801624:	55                   	push   %ebp
  801625:	89 e5                	mov    %esp,%ebp
  801627:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80162a:	ff 75 08             	pushl  0x8(%ebp)
  80162d:	e8 54 fa ff ff       	call   801086 <strlen>
  801632:	83 c4 04             	add    $0x4,%esp
  801635:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801638:	ff 75 0c             	pushl  0xc(%ebp)
  80163b:	e8 46 fa ff ff       	call   801086 <strlen>
  801640:	83 c4 04             	add    $0x4,%esp
  801643:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801646:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80164d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801654:	eb 17                	jmp    80166d <strcconcat+0x49>
		final[s] = str1[s] ;
  801656:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801659:	8b 45 10             	mov    0x10(%ebp),%eax
  80165c:	01 c2                	add    %eax,%edx
  80165e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801661:	8b 45 08             	mov    0x8(%ebp),%eax
  801664:	01 c8                	add    %ecx,%eax
  801666:	8a 00                	mov    (%eax),%al
  801668:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80166a:	ff 45 fc             	incl   -0x4(%ebp)
  80166d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801670:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801673:	7c e1                	jl     801656 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801675:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80167c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801683:	eb 1f                	jmp    8016a4 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801685:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801688:	8d 50 01             	lea    0x1(%eax),%edx
  80168b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80168e:	89 c2                	mov    %eax,%edx
  801690:	8b 45 10             	mov    0x10(%ebp),%eax
  801693:	01 c2                	add    %eax,%edx
  801695:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801698:	8b 45 0c             	mov    0xc(%ebp),%eax
  80169b:	01 c8                	add    %ecx,%eax
  80169d:	8a 00                	mov    (%eax),%al
  80169f:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8016a1:	ff 45 f8             	incl   -0x8(%ebp)
  8016a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016a7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016aa:	7c d9                	jl     801685 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8016ac:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016af:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b2:	01 d0                	add    %edx,%eax
  8016b4:	c6 00 00             	movb   $0x0,(%eax)
}
  8016b7:	90                   	nop
  8016b8:	c9                   	leave  
  8016b9:	c3                   	ret    

008016ba <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8016ba:	55                   	push   %ebp
  8016bb:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8016bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8016c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8016c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8016c9:	8b 00                	mov    (%eax),%eax
  8016cb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d5:	01 d0                	add    %edx,%eax
  8016d7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016dd:	eb 0c                	jmp    8016eb <strsplit+0x31>
			*string++ = 0;
  8016df:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e2:	8d 50 01             	lea    0x1(%eax),%edx
  8016e5:	89 55 08             	mov    %edx,0x8(%ebp)
  8016e8:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ee:	8a 00                	mov    (%eax),%al
  8016f0:	84 c0                	test   %al,%al
  8016f2:	74 18                	je     80170c <strsplit+0x52>
  8016f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f7:	8a 00                	mov    (%eax),%al
  8016f9:	0f be c0             	movsbl %al,%eax
  8016fc:	50                   	push   %eax
  8016fd:	ff 75 0c             	pushl  0xc(%ebp)
  801700:	e8 13 fb ff ff       	call   801218 <strchr>
  801705:	83 c4 08             	add    $0x8,%esp
  801708:	85 c0                	test   %eax,%eax
  80170a:	75 d3                	jne    8016df <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80170c:	8b 45 08             	mov    0x8(%ebp),%eax
  80170f:	8a 00                	mov    (%eax),%al
  801711:	84 c0                	test   %al,%al
  801713:	74 5a                	je     80176f <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801715:	8b 45 14             	mov    0x14(%ebp),%eax
  801718:	8b 00                	mov    (%eax),%eax
  80171a:	83 f8 0f             	cmp    $0xf,%eax
  80171d:	75 07                	jne    801726 <strsplit+0x6c>
		{
			return 0;
  80171f:	b8 00 00 00 00       	mov    $0x0,%eax
  801724:	eb 66                	jmp    80178c <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801726:	8b 45 14             	mov    0x14(%ebp),%eax
  801729:	8b 00                	mov    (%eax),%eax
  80172b:	8d 48 01             	lea    0x1(%eax),%ecx
  80172e:	8b 55 14             	mov    0x14(%ebp),%edx
  801731:	89 0a                	mov    %ecx,(%edx)
  801733:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80173a:	8b 45 10             	mov    0x10(%ebp),%eax
  80173d:	01 c2                	add    %eax,%edx
  80173f:	8b 45 08             	mov    0x8(%ebp),%eax
  801742:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801744:	eb 03                	jmp    801749 <strsplit+0x8f>
			string++;
  801746:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801749:	8b 45 08             	mov    0x8(%ebp),%eax
  80174c:	8a 00                	mov    (%eax),%al
  80174e:	84 c0                	test   %al,%al
  801750:	74 8b                	je     8016dd <strsplit+0x23>
  801752:	8b 45 08             	mov    0x8(%ebp),%eax
  801755:	8a 00                	mov    (%eax),%al
  801757:	0f be c0             	movsbl %al,%eax
  80175a:	50                   	push   %eax
  80175b:	ff 75 0c             	pushl  0xc(%ebp)
  80175e:	e8 b5 fa ff ff       	call   801218 <strchr>
  801763:	83 c4 08             	add    $0x8,%esp
  801766:	85 c0                	test   %eax,%eax
  801768:	74 dc                	je     801746 <strsplit+0x8c>
			string++;
	}
  80176a:	e9 6e ff ff ff       	jmp    8016dd <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80176f:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801770:	8b 45 14             	mov    0x14(%ebp),%eax
  801773:	8b 00                	mov    (%eax),%eax
  801775:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80177c:	8b 45 10             	mov    0x10(%ebp),%eax
  80177f:	01 d0                	add    %edx,%eax
  801781:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801787:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80178c:	c9                   	leave  
  80178d:	c3                   	ret    

0080178e <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  80178e:	55                   	push   %ebp
  80178f:	89 e5                	mov    %esp,%ebp
  801791:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801794:	83 ec 04             	sub    $0x4,%esp
  801797:	68 10 28 80 00       	push   $0x802810
  80179c:	6a 16                	push   $0x16
  80179e:	68 35 28 80 00       	push   $0x802835
  8017a3:	e8 ba ef ff ff       	call   800762 <_panic>

008017a8 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8017a8:	55                   	push   %ebp
  8017a9:	89 e5                	mov    %esp,%ebp
  8017ab:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8017ae:	83 ec 04             	sub    $0x4,%esp
  8017b1:	68 44 28 80 00       	push   $0x802844
  8017b6:	6a 2e                	push   $0x2e
  8017b8:	68 35 28 80 00       	push   $0x802835
  8017bd:	e8 a0 ef ff ff       	call   800762 <_panic>

008017c2 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8017c2:	55                   	push   %ebp
  8017c3:	89 e5                	mov    %esp,%ebp
  8017c5:	83 ec 18             	sub    $0x18,%esp
  8017c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8017cb:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8017ce:	83 ec 04             	sub    $0x4,%esp
  8017d1:	68 68 28 80 00       	push   $0x802868
  8017d6:	6a 3b                	push   $0x3b
  8017d8:	68 35 28 80 00       	push   $0x802835
  8017dd:	e8 80 ef ff ff       	call   800762 <_panic>

008017e2 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8017e2:	55                   	push   %ebp
  8017e3:	89 e5                	mov    %esp,%ebp
  8017e5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017e8:	83 ec 04             	sub    $0x4,%esp
  8017eb:	68 68 28 80 00       	push   $0x802868
  8017f0:	6a 41                	push   $0x41
  8017f2:	68 35 28 80 00       	push   $0x802835
  8017f7:	e8 66 ef ff ff       	call   800762 <_panic>

008017fc <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8017fc:	55                   	push   %ebp
  8017fd:	89 e5                	mov    %esp,%ebp
  8017ff:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801802:	83 ec 04             	sub    $0x4,%esp
  801805:	68 68 28 80 00       	push   $0x802868
  80180a:	6a 47                	push   $0x47
  80180c:	68 35 28 80 00       	push   $0x802835
  801811:	e8 4c ef ff ff       	call   800762 <_panic>

00801816 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801816:	55                   	push   %ebp
  801817:	89 e5                	mov    %esp,%ebp
  801819:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80181c:	83 ec 04             	sub    $0x4,%esp
  80181f:	68 68 28 80 00       	push   $0x802868
  801824:	6a 4c                	push   $0x4c
  801826:	68 35 28 80 00       	push   $0x802835
  80182b:	e8 32 ef ff ff       	call   800762 <_panic>

00801830 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
  801833:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801836:	83 ec 04             	sub    $0x4,%esp
  801839:	68 68 28 80 00       	push   $0x802868
  80183e:	6a 52                	push   $0x52
  801840:	68 35 28 80 00       	push   $0x802835
  801845:	e8 18 ef ff ff       	call   800762 <_panic>

0080184a <shrink>:
}
void shrink(uint32 newSize)
{
  80184a:	55                   	push   %ebp
  80184b:	89 e5                	mov    %esp,%ebp
  80184d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801850:	83 ec 04             	sub    $0x4,%esp
  801853:	68 68 28 80 00       	push   $0x802868
  801858:	6a 56                	push   $0x56
  80185a:	68 35 28 80 00       	push   $0x802835
  80185f:	e8 fe ee ff ff       	call   800762 <_panic>

00801864 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
  801867:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80186a:	83 ec 04             	sub    $0x4,%esp
  80186d:	68 68 28 80 00       	push   $0x802868
  801872:	6a 5b                	push   $0x5b
  801874:	68 35 28 80 00       	push   $0x802835
  801879:	e8 e4 ee ff ff       	call   800762 <_panic>

0080187e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80187e:	55                   	push   %ebp
  80187f:	89 e5                	mov    %esp,%ebp
  801881:	57                   	push   %edi
  801882:	56                   	push   %esi
  801883:	53                   	push   %ebx
  801884:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801887:	8b 45 08             	mov    0x8(%ebp),%eax
  80188a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80188d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801890:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801893:	8b 7d 18             	mov    0x18(%ebp),%edi
  801896:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801899:	cd 30                	int    $0x30
  80189b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80189e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8018a1:	83 c4 10             	add    $0x10,%esp
  8018a4:	5b                   	pop    %ebx
  8018a5:	5e                   	pop    %esi
  8018a6:	5f                   	pop    %edi
  8018a7:	5d                   	pop    %ebp
  8018a8:	c3                   	ret    

008018a9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8018a9:	55                   	push   %ebp
  8018aa:	89 e5                	mov    %esp,%ebp
  8018ac:	83 ec 04             	sub    $0x4,%esp
  8018af:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8018b5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	52                   	push   %edx
  8018c1:	ff 75 0c             	pushl  0xc(%ebp)
  8018c4:	50                   	push   %eax
  8018c5:	6a 00                	push   $0x0
  8018c7:	e8 b2 ff ff ff       	call   80187e <syscall>
  8018cc:	83 c4 18             	add    $0x18,%esp
}
  8018cf:	90                   	nop
  8018d0:	c9                   	leave  
  8018d1:	c3                   	ret    

008018d2 <sys_cgetc>:

int
sys_cgetc(void)
{
  8018d2:	55                   	push   %ebp
  8018d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 01                	push   $0x1
  8018e1:	e8 98 ff ff ff       	call   80187e <syscall>
  8018e6:	83 c4 18             	add    $0x18,%esp
}
  8018e9:	c9                   	leave  
  8018ea:	c3                   	ret    

008018eb <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8018eb:	55                   	push   %ebp
  8018ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8018ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	50                   	push   %eax
  8018fa:	6a 05                	push   $0x5
  8018fc:	e8 7d ff ff ff       	call   80187e <syscall>
  801901:	83 c4 18             	add    $0x18,%esp
}
  801904:	c9                   	leave  
  801905:	c3                   	ret    

00801906 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801906:	55                   	push   %ebp
  801907:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801909:	6a 00                	push   $0x0
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	6a 02                	push   $0x2
  801915:	e8 64 ff ff ff       	call   80187e <syscall>
  80191a:	83 c4 18             	add    $0x18,%esp
}
  80191d:	c9                   	leave  
  80191e:	c3                   	ret    

0080191f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80191f:	55                   	push   %ebp
  801920:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 03                	push   $0x3
  80192e:	e8 4b ff ff ff       	call   80187e <syscall>
  801933:	83 c4 18             	add    $0x18,%esp
}
  801936:	c9                   	leave  
  801937:	c3                   	ret    

00801938 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801938:	55                   	push   %ebp
  801939:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	6a 04                	push   $0x4
  801947:	e8 32 ff ff ff       	call   80187e <syscall>
  80194c:	83 c4 18             	add    $0x18,%esp
}
  80194f:	c9                   	leave  
  801950:	c3                   	ret    

00801951 <sys_env_exit>:


void sys_env_exit(void)
{
  801951:	55                   	push   %ebp
  801952:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 06                	push   $0x6
  801960:	e8 19 ff ff ff       	call   80187e <syscall>
  801965:	83 c4 18             	add    $0x18,%esp
}
  801968:	90                   	nop
  801969:	c9                   	leave  
  80196a:	c3                   	ret    

0080196b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80196b:	55                   	push   %ebp
  80196c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80196e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801971:	8b 45 08             	mov    0x8(%ebp),%eax
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	6a 00                	push   $0x0
  80197a:	52                   	push   %edx
  80197b:	50                   	push   %eax
  80197c:	6a 07                	push   $0x7
  80197e:	e8 fb fe ff ff       	call   80187e <syscall>
  801983:	83 c4 18             	add    $0x18,%esp
}
  801986:	c9                   	leave  
  801987:	c3                   	ret    

00801988 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801988:	55                   	push   %ebp
  801989:	89 e5                	mov    %esp,%ebp
  80198b:	56                   	push   %esi
  80198c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80198d:	8b 75 18             	mov    0x18(%ebp),%esi
  801990:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801993:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801996:	8b 55 0c             	mov    0xc(%ebp),%edx
  801999:	8b 45 08             	mov    0x8(%ebp),%eax
  80199c:	56                   	push   %esi
  80199d:	53                   	push   %ebx
  80199e:	51                   	push   %ecx
  80199f:	52                   	push   %edx
  8019a0:	50                   	push   %eax
  8019a1:	6a 08                	push   $0x8
  8019a3:	e8 d6 fe ff ff       	call   80187e <syscall>
  8019a8:	83 c4 18             	add    $0x18,%esp
}
  8019ab:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8019ae:	5b                   	pop    %ebx
  8019af:	5e                   	pop    %esi
  8019b0:	5d                   	pop    %ebp
  8019b1:	c3                   	ret    

008019b2 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8019b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	52                   	push   %edx
  8019c2:	50                   	push   %eax
  8019c3:	6a 09                	push   $0x9
  8019c5:	e8 b4 fe ff ff       	call   80187e <syscall>
  8019ca:	83 c4 18             	add    $0x18,%esp
}
  8019cd:	c9                   	leave  
  8019ce:	c3                   	ret    

008019cf <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8019cf:	55                   	push   %ebp
  8019d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	ff 75 0c             	pushl  0xc(%ebp)
  8019db:	ff 75 08             	pushl  0x8(%ebp)
  8019de:	6a 0a                	push   $0xa
  8019e0:	e8 99 fe ff ff       	call   80187e <syscall>
  8019e5:	83 c4 18             	add    $0x18,%esp
}
  8019e8:	c9                   	leave  
  8019e9:	c3                   	ret    

008019ea <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8019ea:	55                   	push   %ebp
  8019eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 0b                	push   $0xb
  8019f9:	e8 80 fe ff ff       	call   80187e <syscall>
  8019fe:	83 c4 18             	add    $0x18,%esp
}
  801a01:	c9                   	leave  
  801a02:	c3                   	ret    

00801a03 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801a03:	55                   	push   %ebp
  801a04:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	6a 00                	push   $0x0
  801a10:	6a 0c                	push   $0xc
  801a12:	e8 67 fe ff ff       	call   80187e <syscall>
  801a17:	83 c4 18             	add    $0x18,%esp
}
  801a1a:	c9                   	leave  
  801a1b:	c3                   	ret    

00801a1c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801a1c:	55                   	push   %ebp
  801a1d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	6a 00                	push   $0x0
  801a27:	6a 00                	push   $0x0
  801a29:	6a 0d                	push   $0xd
  801a2b:	e8 4e fe ff ff       	call   80187e <syscall>
  801a30:	83 c4 18             	add    $0x18,%esp
}
  801a33:	c9                   	leave  
  801a34:	c3                   	ret    

00801a35 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801a35:	55                   	push   %ebp
  801a36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	ff 75 0c             	pushl  0xc(%ebp)
  801a41:	ff 75 08             	pushl  0x8(%ebp)
  801a44:	6a 11                	push   $0x11
  801a46:	e8 33 fe ff ff       	call   80187e <syscall>
  801a4b:	83 c4 18             	add    $0x18,%esp
	return;
  801a4e:	90                   	nop
}
  801a4f:	c9                   	leave  
  801a50:	c3                   	ret    

00801a51 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801a51:	55                   	push   %ebp
  801a52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	ff 75 0c             	pushl  0xc(%ebp)
  801a5d:	ff 75 08             	pushl  0x8(%ebp)
  801a60:	6a 12                	push   $0x12
  801a62:	e8 17 fe ff ff       	call   80187e <syscall>
  801a67:	83 c4 18             	add    $0x18,%esp
	return ;
  801a6a:	90                   	nop
}
  801a6b:	c9                   	leave  
  801a6c:	c3                   	ret    

00801a6d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a6d:	55                   	push   %ebp
  801a6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a70:	6a 00                	push   $0x0
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 0e                	push   $0xe
  801a7c:	e8 fd fd ff ff       	call   80187e <syscall>
  801a81:	83 c4 18             	add    $0x18,%esp
}
  801a84:	c9                   	leave  
  801a85:	c3                   	ret    

00801a86 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a86:	55                   	push   %ebp
  801a87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 00                	push   $0x0
  801a8f:	6a 00                	push   $0x0
  801a91:	ff 75 08             	pushl  0x8(%ebp)
  801a94:	6a 0f                	push   $0xf
  801a96:	e8 e3 fd ff ff       	call   80187e <syscall>
  801a9b:	83 c4 18             	add    $0x18,%esp
}
  801a9e:	c9                   	leave  
  801a9f:	c3                   	ret    

00801aa0 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801aa0:	55                   	push   %ebp
  801aa1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 00                	push   $0x0
  801aab:	6a 00                	push   $0x0
  801aad:	6a 10                	push   $0x10
  801aaf:	e8 ca fd ff ff       	call   80187e <syscall>
  801ab4:	83 c4 18             	add    $0x18,%esp
}
  801ab7:	90                   	nop
  801ab8:	c9                   	leave  
  801ab9:	c3                   	ret    

00801aba <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801aba:	55                   	push   %ebp
  801abb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 14                	push   $0x14
  801ac9:	e8 b0 fd ff ff       	call   80187e <syscall>
  801ace:	83 c4 18             	add    $0x18,%esp
}
  801ad1:	90                   	nop
  801ad2:	c9                   	leave  
  801ad3:	c3                   	ret    

00801ad4 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ad4:	55                   	push   %ebp
  801ad5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 15                	push   $0x15
  801ae3:	e8 96 fd ff ff       	call   80187e <syscall>
  801ae8:	83 c4 18             	add    $0x18,%esp
}
  801aeb:	90                   	nop
  801aec:	c9                   	leave  
  801aed:	c3                   	ret    

00801aee <sys_cputc>:


void
sys_cputc(const char c)
{
  801aee:	55                   	push   %ebp
  801aef:	89 e5                	mov    %esp,%ebp
  801af1:	83 ec 04             	sub    $0x4,%esp
  801af4:	8b 45 08             	mov    0x8(%ebp),%eax
  801af7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801afa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 00                	push   $0x0
  801b04:	6a 00                	push   $0x0
  801b06:	50                   	push   %eax
  801b07:	6a 16                	push   $0x16
  801b09:	e8 70 fd ff ff       	call   80187e <syscall>
  801b0e:	83 c4 18             	add    $0x18,%esp
}
  801b11:	90                   	nop
  801b12:	c9                   	leave  
  801b13:	c3                   	ret    

00801b14 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801b14:	55                   	push   %ebp
  801b15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 00                	push   $0x0
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 17                	push   $0x17
  801b23:	e8 56 fd ff ff       	call   80187e <syscall>
  801b28:	83 c4 18             	add    $0x18,%esp
}
  801b2b:	90                   	nop
  801b2c:	c9                   	leave  
  801b2d:	c3                   	ret    

00801b2e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801b2e:	55                   	push   %ebp
  801b2f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801b31:	8b 45 08             	mov    0x8(%ebp),%eax
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 00                	push   $0x0
  801b3a:	ff 75 0c             	pushl  0xc(%ebp)
  801b3d:	50                   	push   %eax
  801b3e:	6a 18                	push   $0x18
  801b40:	e8 39 fd ff ff       	call   80187e <syscall>
  801b45:	83 c4 18             	add    $0x18,%esp
}
  801b48:	c9                   	leave  
  801b49:	c3                   	ret    

00801b4a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801b4a:	55                   	push   %ebp
  801b4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b50:	8b 45 08             	mov    0x8(%ebp),%eax
  801b53:	6a 00                	push   $0x0
  801b55:	6a 00                	push   $0x0
  801b57:	6a 00                	push   $0x0
  801b59:	52                   	push   %edx
  801b5a:	50                   	push   %eax
  801b5b:	6a 1b                	push   $0x1b
  801b5d:	e8 1c fd ff ff       	call   80187e <syscall>
  801b62:	83 c4 18             	add    $0x18,%esp
}
  801b65:	c9                   	leave  
  801b66:	c3                   	ret    

00801b67 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b67:	55                   	push   %ebp
  801b68:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	52                   	push   %edx
  801b77:	50                   	push   %eax
  801b78:	6a 19                	push   $0x19
  801b7a:	e8 ff fc ff ff       	call   80187e <syscall>
  801b7f:	83 c4 18             	add    $0x18,%esp
}
  801b82:	90                   	nop
  801b83:	c9                   	leave  
  801b84:	c3                   	ret    

00801b85 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b85:	55                   	push   %ebp
  801b86:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b88:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	52                   	push   %edx
  801b95:	50                   	push   %eax
  801b96:	6a 1a                	push   $0x1a
  801b98:	e8 e1 fc ff ff       	call   80187e <syscall>
  801b9d:	83 c4 18             	add    $0x18,%esp
}
  801ba0:	90                   	nop
  801ba1:	c9                   	leave  
  801ba2:	c3                   	ret    

00801ba3 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801ba3:	55                   	push   %ebp
  801ba4:	89 e5                	mov    %esp,%ebp
  801ba6:	83 ec 04             	sub    $0x4,%esp
  801ba9:	8b 45 10             	mov    0x10(%ebp),%eax
  801bac:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801baf:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801bb2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801bb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb9:	6a 00                	push   $0x0
  801bbb:	51                   	push   %ecx
  801bbc:	52                   	push   %edx
  801bbd:	ff 75 0c             	pushl  0xc(%ebp)
  801bc0:	50                   	push   %eax
  801bc1:	6a 1c                	push   $0x1c
  801bc3:	e8 b6 fc ff ff       	call   80187e <syscall>
  801bc8:	83 c4 18             	add    $0x18,%esp
}
  801bcb:	c9                   	leave  
  801bcc:	c3                   	ret    

00801bcd <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801bcd:	55                   	push   %ebp
  801bce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801bd0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	52                   	push   %edx
  801bdd:	50                   	push   %eax
  801bde:	6a 1d                	push   $0x1d
  801be0:	e8 99 fc ff ff       	call   80187e <syscall>
  801be5:	83 c4 18             	add    $0x18,%esp
}
  801be8:	c9                   	leave  
  801be9:	c3                   	ret    

00801bea <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801bea:	55                   	push   %ebp
  801beb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801bed:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bf0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	51                   	push   %ecx
  801bfb:	52                   	push   %edx
  801bfc:	50                   	push   %eax
  801bfd:	6a 1e                	push   $0x1e
  801bff:	e8 7a fc ff ff       	call   80187e <syscall>
  801c04:	83 c4 18             	add    $0x18,%esp
}
  801c07:	c9                   	leave  
  801c08:	c3                   	ret    

00801c09 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801c09:	55                   	push   %ebp
  801c0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801c0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	52                   	push   %edx
  801c19:	50                   	push   %eax
  801c1a:	6a 1f                	push   $0x1f
  801c1c:	e8 5d fc ff ff       	call   80187e <syscall>
  801c21:	83 c4 18             	add    $0x18,%esp
}
  801c24:	c9                   	leave  
  801c25:	c3                   	ret    

00801c26 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801c26:	55                   	push   %ebp
  801c27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 20                	push   $0x20
  801c35:	e8 44 fc ff ff       	call   80187e <syscall>
  801c3a:	83 c4 18             	add    $0x18,%esp
}
  801c3d:	c9                   	leave  
  801c3e:	c3                   	ret    

00801c3f <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801c3f:	55                   	push   %ebp
  801c40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801c42:	8b 45 08             	mov    0x8(%ebp),%eax
  801c45:	6a 00                	push   $0x0
  801c47:	ff 75 14             	pushl  0x14(%ebp)
  801c4a:	ff 75 10             	pushl  0x10(%ebp)
  801c4d:	ff 75 0c             	pushl  0xc(%ebp)
  801c50:	50                   	push   %eax
  801c51:	6a 21                	push   $0x21
  801c53:	e8 26 fc ff ff       	call   80187e <syscall>
  801c58:	83 c4 18             	add    $0x18,%esp
}
  801c5b:	c9                   	leave  
  801c5c:	c3                   	ret    

00801c5d <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801c5d:	55                   	push   %ebp
  801c5e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801c60:	8b 45 08             	mov    0x8(%ebp),%eax
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	50                   	push   %eax
  801c6c:	6a 22                	push   $0x22
  801c6e:	e8 0b fc ff ff       	call   80187e <syscall>
  801c73:	83 c4 18             	add    $0x18,%esp
}
  801c76:	90                   	nop
  801c77:	c9                   	leave  
  801c78:	c3                   	ret    

00801c79 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c79:	55                   	push   %ebp
  801c7a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	6a 00                	push   $0x0
  801c85:	6a 00                	push   $0x0
  801c87:	50                   	push   %eax
  801c88:	6a 23                	push   $0x23
  801c8a:	e8 ef fb ff ff       	call   80187e <syscall>
  801c8f:	83 c4 18             	add    $0x18,%esp
}
  801c92:	90                   	nop
  801c93:	c9                   	leave  
  801c94:	c3                   	ret    

00801c95 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c95:	55                   	push   %ebp
  801c96:	89 e5                	mov    %esp,%ebp
  801c98:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c9b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c9e:	8d 50 04             	lea    0x4(%eax),%edx
  801ca1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	52                   	push   %edx
  801cab:	50                   	push   %eax
  801cac:	6a 24                	push   $0x24
  801cae:	e8 cb fb ff ff       	call   80187e <syscall>
  801cb3:	83 c4 18             	add    $0x18,%esp
	return result;
  801cb6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801cb9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cbc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801cbf:	89 01                	mov    %eax,(%ecx)
  801cc1:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc7:	c9                   	leave  
  801cc8:	c2 04 00             	ret    $0x4

00801ccb <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ccb:	55                   	push   %ebp
  801ccc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 00                	push   $0x0
  801cd2:	ff 75 10             	pushl  0x10(%ebp)
  801cd5:	ff 75 0c             	pushl  0xc(%ebp)
  801cd8:	ff 75 08             	pushl  0x8(%ebp)
  801cdb:	6a 13                	push   $0x13
  801cdd:	e8 9c fb ff ff       	call   80187e <syscall>
  801ce2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ce5:	90                   	nop
}
  801ce6:	c9                   	leave  
  801ce7:	c3                   	ret    

00801ce8 <sys_rcr2>:
uint32 sys_rcr2()
{
  801ce8:	55                   	push   %ebp
  801ce9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 25                	push   $0x25
  801cf7:	e8 82 fb ff ff       	call   80187e <syscall>
  801cfc:	83 c4 18             	add    $0x18,%esp
}
  801cff:	c9                   	leave  
  801d00:	c3                   	ret    

00801d01 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801d01:	55                   	push   %ebp
  801d02:	89 e5                	mov    %esp,%ebp
  801d04:	83 ec 04             	sub    $0x4,%esp
  801d07:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801d0d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	6a 00                	push   $0x0
  801d19:	50                   	push   %eax
  801d1a:	6a 26                	push   $0x26
  801d1c:	e8 5d fb ff ff       	call   80187e <syscall>
  801d21:	83 c4 18             	add    $0x18,%esp
	return ;
  801d24:	90                   	nop
}
  801d25:	c9                   	leave  
  801d26:	c3                   	ret    

00801d27 <rsttst>:
void rsttst()
{
  801d27:	55                   	push   %ebp
  801d28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	6a 00                	push   $0x0
  801d34:	6a 28                	push   $0x28
  801d36:	e8 43 fb ff ff       	call   80187e <syscall>
  801d3b:	83 c4 18             	add    $0x18,%esp
	return ;
  801d3e:	90                   	nop
}
  801d3f:	c9                   	leave  
  801d40:	c3                   	ret    

00801d41 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801d41:	55                   	push   %ebp
  801d42:	89 e5                	mov    %esp,%ebp
  801d44:	83 ec 04             	sub    $0x4,%esp
  801d47:	8b 45 14             	mov    0x14(%ebp),%eax
  801d4a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801d4d:	8b 55 18             	mov    0x18(%ebp),%edx
  801d50:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d54:	52                   	push   %edx
  801d55:	50                   	push   %eax
  801d56:	ff 75 10             	pushl  0x10(%ebp)
  801d59:	ff 75 0c             	pushl  0xc(%ebp)
  801d5c:	ff 75 08             	pushl  0x8(%ebp)
  801d5f:	6a 27                	push   $0x27
  801d61:	e8 18 fb ff ff       	call   80187e <syscall>
  801d66:	83 c4 18             	add    $0x18,%esp
	return ;
  801d69:	90                   	nop
}
  801d6a:	c9                   	leave  
  801d6b:	c3                   	ret    

00801d6c <chktst>:
void chktst(uint32 n)
{
  801d6c:	55                   	push   %ebp
  801d6d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d6f:	6a 00                	push   $0x0
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	ff 75 08             	pushl  0x8(%ebp)
  801d7a:	6a 29                	push   $0x29
  801d7c:	e8 fd fa ff ff       	call   80187e <syscall>
  801d81:	83 c4 18             	add    $0x18,%esp
	return ;
  801d84:	90                   	nop
}
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    

00801d87 <inctst>:

void inctst()
{
  801d87:	55                   	push   %ebp
  801d88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d8a:	6a 00                	push   $0x0
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 2a                	push   $0x2a
  801d96:	e8 e3 fa ff ff       	call   80187e <syscall>
  801d9b:	83 c4 18             	add    $0x18,%esp
	return ;
  801d9e:	90                   	nop
}
  801d9f:	c9                   	leave  
  801da0:	c3                   	ret    

00801da1 <gettst>:
uint32 gettst()
{
  801da1:	55                   	push   %ebp
  801da2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 00                	push   $0x0
  801dac:	6a 00                	push   $0x0
  801dae:	6a 2b                	push   $0x2b
  801db0:	e8 c9 fa ff ff       	call   80187e <syscall>
  801db5:	83 c4 18             	add    $0x18,%esp
}
  801db8:	c9                   	leave  
  801db9:	c3                   	ret    

00801dba <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801dba:	55                   	push   %ebp
  801dbb:	89 e5                	mov    %esp,%ebp
  801dbd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 2c                	push   $0x2c
  801dcc:	e8 ad fa ff ff       	call   80187e <syscall>
  801dd1:	83 c4 18             	add    $0x18,%esp
  801dd4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801dd7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801ddb:	75 07                	jne    801de4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801ddd:	b8 01 00 00 00       	mov    $0x1,%eax
  801de2:	eb 05                	jmp    801de9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801de4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801de9:	c9                   	leave  
  801dea:	c3                   	ret    

00801deb <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801deb:	55                   	push   %ebp
  801dec:	89 e5                	mov    %esp,%ebp
  801dee:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 2c                	push   $0x2c
  801dfd:	e8 7c fa ff ff       	call   80187e <syscall>
  801e02:	83 c4 18             	add    $0x18,%esp
  801e05:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801e08:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801e0c:	75 07                	jne    801e15 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801e0e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e13:	eb 05                	jmp    801e1a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801e15:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e1a:	c9                   	leave  
  801e1b:	c3                   	ret    

00801e1c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801e1c:	55                   	push   %ebp
  801e1d:	89 e5                	mov    %esp,%ebp
  801e1f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 00                	push   $0x0
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 00                	push   $0x0
  801e2c:	6a 2c                	push   $0x2c
  801e2e:	e8 4b fa ff ff       	call   80187e <syscall>
  801e33:	83 c4 18             	add    $0x18,%esp
  801e36:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801e39:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801e3d:	75 07                	jne    801e46 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801e3f:	b8 01 00 00 00       	mov    $0x1,%eax
  801e44:	eb 05                	jmp    801e4b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801e46:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e4b:	c9                   	leave  
  801e4c:	c3                   	ret    

00801e4d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801e4d:	55                   	push   %ebp
  801e4e:	89 e5                	mov    %esp,%ebp
  801e50:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 2c                	push   $0x2c
  801e5f:	e8 1a fa ff ff       	call   80187e <syscall>
  801e64:	83 c4 18             	add    $0x18,%esp
  801e67:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e6a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e6e:	75 07                	jne    801e77 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e70:	b8 01 00 00 00       	mov    $0x1,%eax
  801e75:	eb 05                	jmp    801e7c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e77:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e7c:	c9                   	leave  
  801e7d:	c3                   	ret    

00801e7e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e7e:	55                   	push   %ebp
  801e7f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e81:	6a 00                	push   $0x0
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	ff 75 08             	pushl  0x8(%ebp)
  801e8c:	6a 2d                	push   $0x2d
  801e8e:	e8 eb f9 ff ff       	call   80187e <syscall>
  801e93:	83 c4 18             	add    $0x18,%esp
	return ;
  801e96:	90                   	nop
}
  801e97:	c9                   	leave  
  801e98:	c3                   	ret    

00801e99 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801e99:	55                   	push   %ebp
  801e9a:	89 e5                	mov    %esp,%ebp
  801e9c:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801e9d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ea0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ea3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea9:	6a 00                	push   $0x0
  801eab:	53                   	push   %ebx
  801eac:	51                   	push   %ecx
  801ead:	52                   	push   %edx
  801eae:	50                   	push   %eax
  801eaf:	6a 2e                	push   $0x2e
  801eb1:	e8 c8 f9 ff ff       	call   80187e <syscall>
  801eb6:	83 c4 18             	add    $0x18,%esp
}
  801eb9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801ebc:	c9                   	leave  
  801ebd:	c3                   	ret    

00801ebe <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801ebe:	55                   	push   %ebp
  801ebf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801ec1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ec4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 00                	push   $0x0
  801ecb:	6a 00                	push   $0x0
  801ecd:	52                   	push   %edx
  801ece:	50                   	push   %eax
  801ecf:	6a 2f                	push   $0x2f
  801ed1:	e8 a8 f9 ff ff       	call   80187e <syscall>
  801ed6:	83 c4 18             	add    $0x18,%esp
}
  801ed9:	c9                   	leave  
  801eda:	c3                   	ret    
  801edb:	90                   	nop

00801edc <__udivdi3>:
  801edc:	55                   	push   %ebp
  801edd:	57                   	push   %edi
  801ede:	56                   	push   %esi
  801edf:	53                   	push   %ebx
  801ee0:	83 ec 1c             	sub    $0x1c,%esp
  801ee3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ee7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801eeb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801eef:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ef3:	89 ca                	mov    %ecx,%edx
  801ef5:	89 f8                	mov    %edi,%eax
  801ef7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801efb:	85 f6                	test   %esi,%esi
  801efd:	75 2d                	jne    801f2c <__udivdi3+0x50>
  801eff:	39 cf                	cmp    %ecx,%edi
  801f01:	77 65                	ja     801f68 <__udivdi3+0x8c>
  801f03:	89 fd                	mov    %edi,%ebp
  801f05:	85 ff                	test   %edi,%edi
  801f07:	75 0b                	jne    801f14 <__udivdi3+0x38>
  801f09:	b8 01 00 00 00       	mov    $0x1,%eax
  801f0e:	31 d2                	xor    %edx,%edx
  801f10:	f7 f7                	div    %edi
  801f12:	89 c5                	mov    %eax,%ebp
  801f14:	31 d2                	xor    %edx,%edx
  801f16:	89 c8                	mov    %ecx,%eax
  801f18:	f7 f5                	div    %ebp
  801f1a:	89 c1                	mov    %eax,%ecx
  801f1c:	89 d8                	mov    %ebx,%eax
  801f1e:	f7 f5                	div    %ebp
  801f20:	89 cf                	mov    %ecx,%edi
  801f22:	89 fa                	mov    %edi,%edx
  801f24:	83 c4 1c             	add    $0x1c,%esp
  801f27:	5b                   	pop    %ebx
  801f28:	5e                   	pop    %esi
  801f29:	5f                   	pop    %edi
  801f2a:	5d                   	pop    %ebp
  801f2b:	c3                   	ret    
  801f2c:	39 ce                	cmp    %ecx,%esi
  801f2e:	77 28                	ja     801f58 <__udivdi3+0x7c>
  801f30:	0f bd fe             	bsr    %esi,%edi
  801f33:	83 f7 1f             	xor    $0x1f,%edi
  801f36:	75 40                	jne    801f78 <__udivdi3+0x9c>
  801f38:	39 ce                	cmp    %ecx,%esi
  801f3a:	72 0a                	jb     801f46 <__udivdi3+0x6a>
  801f3c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801f40:	0f 87 9e 00 00 00    	ja     801fe4 <__udivdi3+0x108>
  801f46:	b8 01 00 00 00       	mov    $0x1,%eax
  801f4b:	89 fa                	mov    %edi,%edx
  801f4d:	83 c4 1c             	add    $0x1c,%esp
  801f50:	5b                   	pop    %ebx
  801f51:	5e                   	pop    %esi
  801f52:	5f                   	pop    %edi
  801f53:	5d                   	pop    %ebp
  801f54:	c3                   	ret    
  801f55:	8d 76 00             	lea    0x0(%esi),%esi
  801f58:	31 ff                	xor    %edi,%edi
  801f5a:	31 c0                	xor    %eax,%eax
  801f5c:	89 fa                	mov    %edi,%edx
  801f5e:	83 c4 1c             	add    $0x1c,%esp
  801f61:	5b                   	pop    %ebx
  801f62:	5e                   	pop    %esi
  801f63:	5f                   	pop    %edi
  801f64:	5d                   	pop    %ebp
  801f65:	c3                   	ret    
  801f66:	66 90                	xchg   %ax,%ax
  801f68:	89 d8                	mov    %ebx,%eax
  801f6a:	f7 f7                	div    %edi
  801f6c:	31 ff                	xor    %edi,%edi
  801f6e:	89 fa                	mov    %edi,%edx
  801f70:	83 c4 1c             	add    $0x1c,%esp
  801f73:	5b                   	pop    %ebx
  801f74:	5e                   	pop    %esi
  801f75:	5f                   	pop    %edi
  801f76:	5d                   	pop    %ebp
  801f77:	c3                   	ret    
  801f78:	bd 20 00 00 00       	mov    $0x20,%ebp
  801f7d:	89 eb                	mov    %ebp,%ebx
  801f7f:	29 fb                	sub    %edi,%ebx
  801f81:	89 f9                	mov    %edi,%ecx
  801f83:	d3 e6                	shl    %cl,%esi
  801f85:	89 c5                	mov    %eax,%ebp
  801f87:	88 d9                	mov    %bl,%cl
  801f89:	d3 ed                	shr    %cl,%ebp
  801f8b:	89 e9                	mov    %ebp,%ecx
  801f8d:	09 f1                	or     %esi,%ecx
  801f8f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801f93:	89 f9                	mov    %edi,%ecx
  801f95:	d3 e0                	shl    %cl,%eax
  801f97:	89 c5                	mov    %eax,%ebp
  801f99:	89 d6                	mov    %edx,%esi
  801f9b:	88 d9                	mov    %bl,%cl
  801f9d:	d3 ee                	shr    %cl,%esi
  801f9f:	89 f9                	mov    %edi,%ecx
  801fa1:	d3 e2                	shl    %cl,%edx
  801fa3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fa7:	88 d9                	mov    %bl,%cl
  801fa9:	d3 e8                	shr    %cl,%eax
  801fab:	09 c2                	or     %eax,%edx
  801fad:	89 d0                	mov    %edx,%eax
  801faf:	89 f2                	mov    %esi,%edx
  801fb1:	f7 74 24 0c          	divl   0xc(%esp)
  801fb5:	89 d6                	mov    %edx,%esi
  801fb7:	89 c3                	mov    %eax,%ebx
  801fb9:	f7 e5                	mul    %ebp
  801fbb:	39 d6                	cmp    %edx,%esi
  801fbd:	72 19                	jb     801fd8 <__udivdi3+0xfc>
  801fbf:	74 0b                	je     801fcc <__udivdi3+0xf0>
  801fc1:	89 d8                	mov    %ebx,%eax
  801fc3:	31 ff                	xor    %edi,%edi
  801fc5:	e9 58 ff ff ff       	jmp    801f22 <__udivdi3+0x46>
  801fca:	66 90                	xchg   %ax,%ax
  801fcc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801fd0:	89 f9                	mov    %edi,%ecx
  801fd2:	d3 e2                	shl    %cl,%edx
  801fd4:	39 c2                	cmp    %eax,%edx
  801fd6:	73 e9                	jae    801fc1 <__udivdi3+0xe5>
  801fd8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801fdb:	31 ff                	xor    %edi,%edi
  801fdd:	e9 40 ff ff ff       	jmp    801f22 <__udivdi3+0x46>
  801fe2:	66 90                	xchg   %ax,%ax
  801fe4:	31 c0                	xor    %eax,%eax
  801fe6:	e9 37 ff ff ff       	jmp    801f22 <__udivdi3+0x46>
  801feb:	90                   	nop

00801fec <__umoddi3>:
  801fec:	55                   	push   %ebp
  801fed:	57                   	push   %edi
  801fee:	56                   	push   %esi
  801fef:	53                   	push   %ebx
  801ff0:	83 ec 1c             	sub    $0x1c,%esp
  801ff3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ff7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ffb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801fff:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802003:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802007:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80200b:	89 f3                	mov    %esi,%ebx
  80200d:	89 fa                	mov    %edi,%edx
  80200f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802013:	89 34 24             	mov    %esi,(%esp)
  802016:	85 c0                	test   %eax,%eax
  802018:	75 1a                	jne    802034 <__umoddi3+0x48>
  80201a:	39 f7                	cmp    %esi,%edi
  80201c:	0f 86 a2 00 00 00    	jbe    8020c4 <__umoddi3+0xd8>
  802022:	89 c8                	mov    %ecx,%eax
  802024:	89 f2                	mov    %esi,%edx
  802026:	f7 f7                	div    %edi
  802028:	89 d0                	mov    %edx,%eax
  80202a:	31 d2                	xor    %edx,%edx
  80202c:	83 c4 1c             	add    $0x1c,%esp
  80202f:	5b                   	pop    %ebx
  802030:	5e                   	pop    %esi
  802031:	5f                   	pop    %edi
  802032:	5d                   	pop    %ebp
  802033:	c3                   	ret    
  802034:	39 f0                	cmp    %esi,%eax
  802036:	0f 87 ac 00 00 00    	ja     8020e8 <__umoddi3+0xfc>
  80203c:	0f bd e8             	bsr    %eax,%ebp
  80203f:	83 f5 1f             	xor    $0x1f,%ebp
  802042:	0f 84 ac 00 00 00    	je     8020f4 <__umoddi3+0x108>
  802048:	bf 20 00 00 00       	mov    $0x20,%edi
  80204d:	29 ef                	sub    %ebp,%edi
  80204f:	89 fe                	mov    %edi,%esi
  802051:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802055:	89 e9                	mov    %ebp,%ecx
  802057:	d3 e0                	shl    %cl,%eax
  802059:	89 d7                	mov    %edx,%edi
  80205b:	89 f1                	mov    %esi,%ecx
  80205d:	d3 ef                	shr    %cl,%edi
  80205f:	09 c7                	or     %eax,%edi
  802061:	89 e9                	mov    %ebp,%ecx
  802063:	d3 e2                	shl    %cl,%edx
  802065:	89 14 24             	mov    %edx,(%esp)
  802068:	89 d8                	mov    %ebx,%eax
  80206a:	d3 e0                	shl    %cl,%eax
  80206c:	89 c2                	mov    %eax,%edx
  80206e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802072:	d3 e0                	shl    %cl,%eax
  802074:	89 44 24 04          	mov    %eax,0x4(%esp)
  802078:	8b 44 24 08          	mov    0x8(%esp),%eax
  80207c:	89 f1                	mov    %esi,%ecx
  80207e:	d3 e8                	shr    %cl,%eax
  802080:	09 d0                	or     %edx,%eax
  802082:	d3 eb                	shr    %cl,%ebx
  802084:	89 da                	mov    %ebx,%edx
  802086:	f7 f7                	div    %edi
  802088:	89 d3                	mov    %edx,%ebx
  80208a:	f7 24 24             	mull   (%esp)
  80208d:	89 c6                	mov    %eax,%esi
  80208f:	89 d1                	mov    %edx,%ecx
  802091:	39 d3                	cmp    %edx,%ebx
  802093:	0f 82 87 00 00 00    	jb     802120 <__umoddi3+0x134>
  802099:	0f 84 91 00 00 00    	je     802130 <__umoddi3+0x144>
  80209f:	8b 54 24 04          	mov    0x4(%esp),%edx
  8020a3:	29 f2                	sub    %esi,%edx
  8020a5:	19 cb                	sbb    %ecx,%ebx
  8020a7:	89 d8                	mov    %ebx,%eax
  8020a9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8020ad:	d3 e0                	shl    %cl,%eax
  8020af:	89 e9                	mov    %ebp,%ecx
  8020b1:	d3 ea                	shr    %cl,%edx
  8020b3:	09 d0                	or     %edx,%eax
  8020b5:	89 e9                	mov    %ebp,%ecx
  8020b7:	d3 eb                	shr    %cl,%ebx
  8020b9:	89 da                	mov    %ebx,%edx
  8020bb:	83 c4 1c             	add    $0x1c,%esp
  8020be:	5b                   	pop    %ebx
  8020bf:	5e                   	pop    %esi
  8020c0:	5f                   	pop    %edi
  8020c1:	5d                   	pop    %ebp
  8020c2:	c3                   	ret    
  8020c3:	90                   	nop
  8020c4:	89 fd                	mov    %edi,%ebp
  8020c6:	85 ff                	test   %edi,%edi
  8020c8:	75 0b                	jne    8020d5 <__umoddi3+0xe9>
  8020ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8020cf:	31 d2                	xor    %edx,%edx
  8020d1:	f7 f7                	div    %edi
  8020d3:	89 c5                	mov    %eax,%ebp
  8020d5:	89 f0                	mov    %esi,%eax
  8020d7:	31 d2                	xor    %edx,%edx
  8020d9:	f7 f5                	div    %ebp
  8020db:	89 c8                	mov    %ecx,%eax
  8020dd:	f7 f5                	div    %ebp
  8020df:	89 d0                	mov    %edx,%eax
  8020e1:	e9 44 ff ff ff       	jmp    80202a <__umoddi3+0x3e>
  8020e6:	66 90                	xchg   %ax,%ax
  8020e8:	89 c8                	mov    %ecx,%eax
  8020ea:	89 f2                	mov    %esi,%edx
  8020ec:	83 c4 1c             	add    $0x1c,%esp
  8020ef:	5b                   	pop    %ebx
  8020f0:	5e                   	pop    %esi
  8020f1:	5f                   	pop    %edi
  8020f2:	5d                   	pop    %ebp
  8020f3:	c3                   	ret    
  8020f4:	3b 04 24             	cmp    (%esp),%eax
  8020f7:	72 06                	jb     8020ff <__umoddi3+0x113>
  8020f9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8020fd:	77 0f                	ja     80210e <__umoddi3+0x122>
  8020ff:	89 f2                	mov    %esi,%edx
  802101:	29 f9                	sub    %edi,%ecx
  802103:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802107:	89 14 24             	mov    %edx,(%esp)
  80210a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80210e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802112:	8b 14 24             	mov    (%esp),%edx
  802115:	83 c4 1c             	add    $0x1c,%esp
  802118:	5b                   	pop    %ebx
  802119:	5e                   	pop    %esi
  80211a:	5f                   	pop    %edi
  80211b:	5d                   	pop    %ebp
  80211c:	c3                   	ret    
  80211d:	8d 76 00             	lea    0x0(%esi),%esi
  802120:	2b 04 24             	sub    (%esp),%eax
  802123:	19 fa                	sbb    %edi,%edx
  802125:	89 d1                	mov    %edx,%ecx
  802127:	89 c6                	mov    %eax,%esi
  802129:	e9 71 ff ff ff       	jmp    80209f <__umoddi3+0xb3>
  80212e:	66 90                	xchg   %ax,%ax
  802130:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802134:	72 ea                	jb     802120 <__umoddi3+0x134>
  802136:	89 d9                	mov    %ebx,%ecx
  802138:	e9 62 ff ff ff       	jmp    80209f <__umoddi3+0xb3>
