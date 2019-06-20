global class scheduledBatchable implements Schedulable{
     global void execute(SchedulableContext sc) {
         DailyRecordAddBatch b = new DailyRecordAddBatch(); 
         database.executebatch(b);
     }
  }