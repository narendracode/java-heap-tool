import java.util.HashMap;
import java.util.Map;
import java.lang.management.ManagementFactory;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;

public class Test {

	public static void main(String[] args) {
		Map<String,String> map = new HashMap<String,String>();
		String PID="/Users/narendra/Documents/workspace/shellscript/jvmtool/pid";
		try {
			 File pidFile = new File(PID);
			 if(!pidFile.exists()){
				 pidFile.createNewFile();
			 }
			 Writer writer = new BufferedWriter(new OutputStreamWriter( new FileOutputStream(pidFile), "utf-8"));
			 writer.write(getProcessId("<PID>"));
			 writer.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println("Program is running...");
		for(int i=0;i<900000000;i++){
			map.put("string"+i, "Hello world");
		}
	}

	private static String getProcessId(final String fallback) {
    // Note: may fail in some JVM implementations
    // therefore fallback has to be provided

    // something like '<pid>@<hostname>', at least in SUN / Oracle JVMs
    final String jvmName = ManagementFactory.getRuntimeMXBean().getName();
    final int index = jvmName.indexOf('@');

    if (index < 1) {
        // part before '@' empty (index = 0) / '@' not found (index = -1)
        return fallback;
    }

    try {
        return Long.toString(Long.parseLong(jvmName.substring(0, index)));
    } catch (NumberFormatException e) {
        // ignore
    }
    return fallback;
}
}