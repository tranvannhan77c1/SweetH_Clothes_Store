package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;

@Service
public class StatisticsService {

    @Autowired
    private OrderRepository orderRepository;

    public BigDecimal getDailyRevenue(LocalDate date) {
        LocalDateTime startOfDay = date.atStartOfDay();
        LocalDateTime endOfDay = startOfDay.plusDays(1).minusSeconds(1);
        BigDecimal revenue = orderRepository.findTotalRevenueBetweenDates(startOfDay, endOfDay);
        return revenue != null ? revenue : BigDecimal.ZERO;
    }

    public Long getDailyOrdersCount(LocalDate date) {
        LocalDateTime startOfDay = date.atStartOfDay();
        LocalDateTime endOfDay = startOfDay.plusDays(1).minusSeconds(1);
        Long count = orderRepository.countOrdersBetweenDates(startOfDay, endOfDay);
        return count != null ? count : 0L;
    }

    public Long getDailyProductsSoldCount(LocalDate date) {
        LocalDateTime startOfDay = date.atStartOfDay();
        LocalDateTime endOfDay = startOfDay.plusDays(1).minusSeconds(1);
        Long count = orderRepository.countTotalProductsSoldBetweenDates(startOfDay, endOfDay);
        return count != null ? count : 0L;
    }

    public BigDecimal getMonthlyRevenue(YearMonth month) {
        LocalDateTime startOfMonth = month.atDay(1).atStartOfDay();
        LocalDateTime endOfMonth = startOfMonth.plusMonths(1).minusSeconds(1);
        BigDecimal revenue = orderRepository.findTotalRevenueBetweenDates(startOfMonth, endOfMonth);
        return revenue != null ? revenue : BigDecimal.ZERO;
    }

    public Long getMonthlyOrdersCount(YearMonth month) {
        LocalDateTime startOfMonth = month.atDay(1).atStartOfDay();
        LocalDateTime endOfMonth = startOfMonth.plusMonths(1).minusSeconds(1);
        Long count = orderRepository.countOrdersBetweenDates(startOfMonth, endOfMonth);
        return count != null ? count : 0L;
    }

    public Long getMonthlyProductsSoldCount(YearMonth month) {
        LocalDateTime startOfMonth = month.atDay(1).atStartOfDay();
        LocalDateTime endOfMonth = startOfMonth.plusMonths(1).minusSeconds(1);
        Long count = orderRepository.countTotalProductsSoldBetweenDates(startOfMonth, endOfMonth);
        return count != null ? count : 0L;
    }

    public Long getTotalAccounts() {
        Long count = orderRepository.countTotalAccounts();
        return count != null ? count : 0L;
    }

    public Long getTotalOrders() {
        Long count = orderRepository.countTotalOrders();
        return count != null ? count : 0L;
    }

    public BigDecimal getTotalRevenue() {
        BigDecimal revenue = orderRepository.findTotalRevenue();
        return revenue != null ? revenue : BigDecimal.ZERO;
    }
}
