/**
 * @description This class generates a dummy id.
 * Dummyids can be used on any sobject.
 */
public class TestId {
    private Static Set<Id> generatedIds = new Set<Id>();

    /*
     *  Replicates with dummy values:
     *	char 1-3 (3 chars)	  001	  Key Prefix
  	 *	char 4-5 (2 chars)	  55	  Instance
  	 *	char 6 (1 char)	  0	  Reserved
  	 *	char 7-15 (9 chars)	  0000WO1Zi	  Unique identifier
  	 *	char 16-18 (3 chars)	  AAL	  Case-insensitivty checksum
     */
    public static Id generate(Schema.SObjectType sObjectType) {
        final String instance = '2N';
        final String reserved = '0';
        final String checkSum = 'BEL';
        final Integer uniqueIdLen = 9;

        String keyPrefix = sObjectType.getDescribe().getKeyPrefix();

        String uniqueId = String.valueOf(generatedIds.size()+1);
        uniqueId = uniqueId.leftPad(uniqueIdLen, '0');
        Id r = keyPrefix + instance + reserved + uniqueId + checkSum;
        generatedIds.add(r);

        return r;
    }
}