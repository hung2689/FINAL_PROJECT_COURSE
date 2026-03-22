package courseitproject.utils;

import courseitproject.service.EnrollmentServiceImp;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@WebListener 
public class DailyAIDropoutJob implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("🚀 [AI Scheduler] Initializing automated dropout risk scanning system...");
        
        scheduler = Executors.newSingleThreadScheduledExecutor();

        // 1. Tính toán thời gian từ bây giờ đến 00:00 sáng mai (Nửa đêm)
        LocalDateTime localNow = LocalDateTime.now();
        ZoneId currentZone = ZoneId.systemDefault();
        ZonedDateTime zonedNow = ZonedDateTime.of(localNow, currentZone);
        
        // Thiết lập mốc 00:00:00 của ngày tiếp theo
        ZonedDateTime zonedNextMidnight = zonedNow.withHour(0).withMinute(0).withSecond(0).withNano(0).plusDays(1);
        
        // Tính số giây cần chờ cho đến lần chạy đầu tiên
        long initialDelay =5;//Duration.between(zonedNow, zonedNextMidnight).getSeconds();
        
        // 2. Thiết lập chu kỳ lặp lại là 24 giờ (tính bằng giây)
        long period = TimeUnit.DAYS.toSeconds(1); 

        // Lên lịch chạy!
        scheduler.scheduleAtFixedRate(new Runnable() {
            @Override
            public void run() {
                runDailyAggregation();
            }
        }, initialDelay, period, TimeUnit.SECONDS);

        System.out.println("✅ [AI Scheduler] System is ONLINE!");
        System.out.println("🕒 [Info] First scan will start in: " + (initialDelay / 3600) + " hours and " + ((initialDelay % 3600) / 60) + " minutes (at 00:00 AM).");
        System.out.println("🔄 [Info] Repeat cycle: Every 24 hours.");
    }

    private void runDailyAggregation() {
        System.out.println("⏳ [AI Scheduler] Starting daily automated scan for ALL active students...");
        try {
            EnrollmentServiceImp enrollmentService = new EnrollmentServiceImp();
            
            // Quét toàn bộ học viên đang ACTIVE
            enrollmentService.checkAllActiveStudentsRisk();
            
            System.out.println("✅ [AI Scheduler] Daily batch analysis completed successfully!");
            System.out.println("------------------------------------------------------");

        } catch (Exception e) {
            System.out.println("❌ [AI Scheduler] Critical error during daily job: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null) {
            scheduler.shutdownNow();
            System.out.println("🛑 [AI Scheduler] Background scheduler has been stopped.");
        }
    }
}