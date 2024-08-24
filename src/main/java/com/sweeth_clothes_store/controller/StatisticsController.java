package com.sweeth_clothes_store.controller;

import com.sweeth_clothes_store.service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.YearMonth;

@RestController
@RequestMapping("/api/statistics")
public class StatisticsController {

    @Autowired
    private StatisticsService statisticsService;

    @GetMapping("/daily-revenue/{date}")
    public ResponseEntity<BigDecimal> getDailyRevenue(@PathVariable("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        System.out.println("Received date: " + date);
        return ResponseEntity.ok(statisticsService.getDailyRevenue(date));
    }

    @GetMapping("/daily-orders-count/{date}")
    public ResponseEntity<Long> getDailyOrdersCount(@PathVariable("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        System.out.println("Received date: " + date);
        return ResponseEntity.ok(statisticsService.getDailyOrdersCount(date));
    }

    @GetMapping("/daily-products-sold-count/{date}")
    public ResponseEntity<Long> getDailyProductsSoldCount(@PathVariable("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        System.out.println("Received date: " + date);
        return ResponseEntity.ok(statisticsService.getDailyProductsSoldCount(date));
    }

    @GetMapping("/monthly-revenue/{month}")
    public ResponseEntity<BigDecimal> getMonthlyRevenue(@PathVariable("month") @DateTimeFormat(pattern = "yyyy-MM") YearMonth month) {
        return ResponseEntity.ok(statisticsService.getMonthlyRevenue(month));
    }

    @GetMapping("/monthly-orders-count/{month}")
    public ResponseEntity<Long> getMonthlyOrdersCount(@PathVariable("month") @DateTimeFormat(pattern = "yyyy-MM") YearMonth month) {
        return ResponseEntity.ok(statisticsService.getMonthlyOrdersCount(month));
    }

    @GetMapping("/monthly-products-sold-count/{month}")
    public ResponseEntity<Long> getMonthlyProductsSoldCount(@PathVariable("month") @DateTimeFormat(pattern = "yyyy-MM") YearMonth month) {
        return ResponseEntity.ok(statisticsService.getMonthlyProductsSoldCount(month));
    }

    @GetMapping("/total-accounts")
    public ResponseEntity<Long> getTotalAccounts() {
        return ResponseEntity.ok(statisticsService.getTotalAccounts());
    }

    @GetMapping("/total-orders")
    public ResponseEntity<Long> getTotalOrders() {
        return ResponseEntity.ok(statisticsService.getTotalOrders());
    }

    @GetMapping("/total-revenue")
    public ResponseEntity<BigDecimal> getTotalRevenue() {
        return ResponseEntity.ok(statisticsService.getTotalRevenue());
    }
}