package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.FeedbackDTO;
import com.sweeth_clothes_store.mapper.FeedbackMapper;
import com.sweeth_clothes_store.model.Account;
import com.sweeth_clothes_store.model.Feedback;
import com.sweeth_clothes_store.model.Product;
import com.sweeth_clothes_store.repository.AccountRepository;
import com.sweeth_clothes_store.repository.FeedbackRepository;
import com.sweeth_clothes_store.repository.ProductRepository;
import com.sweeth_clothes_store.util.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class FeedbackService {
    @Autowired
    private FeedbackRepository feedbackRepository;
    @Autowired
    private AccountRepository accountRepository;
    @Autowired
    private ProductRepository productRepository;

    public Page<FeedbackDTO> getAllFeedbacks(Pageable pageable) {
        Page<Feedback> feedbackPage = feedbackRepository.findAll(pageable);
        return feedbackPage.map(FeedbackMapper::toFeedbackDTO);
    }

    public FeedbackDTO getFeedbackById(Integer id) {
        Feedback feedback = feedbackRepository.findById(id).orElse(null);
        return FeedbackMapper.toFeedbackDTO(feedback);
    }

    public FeedbackDTO createFeedback(FeedbackDTO feedbackDTO) {
        Account account = accountRepository.findById(feedbackDTO.getAccountId()).orElseThrow(() -> new ResourceNotFoundException("Account not found"));
        Product product = productRepository.findById(feedbackDTO.getProductId()).orElseThrow(() -> new ResourceNotFoundException("Product not found"));
        Feedback feedback = FeedbackMapper.toFeedback(feedbackDTO, account, product);
        feedback = feedbackRepository.save(feedback);
        return FeedbackMapper.toFeedbackDTO(feedback);
    }

    public FeedbackDTO updateFeedback(Integer id, FeedbackDTO feedbackDTO) {
        if (!feedbackRepository.existsById(id)) {
            throw new ResourceNotFoundException("Feedback not found");
        }
        Account account = accountRepository.findById(feedbackDTO.getAccountId()).orElseThrow(() -> new ResourceNotFoundException("Account not found"));
        Product product = productRepository.findById(feedbackDTO.getProductId()).orElseThrow(() -> new ResourceNotFoundException("Product not found"));
        Feedback feedback = FeedbackMapper.toFeedback(feedbackDTO, account, product);
        feedback.setId(id);
        feedback = feedbackRepository.save(feedback);
        return FeedbackMapper.toFeedbackDTO(feedback);
    }

    public void deleteFeedback(Integer id) {
        if (!feedbackRepository.existsById(id)) {
            throw new ResourceNotFoundException("Feedback not found");
        }
        feedbackRepository.deleteById(id);
    }

    public List<FeedbackDTO> getAllFeedbacks() {
        List<Feedback> feedbacks = feedbackRepository.findAll();
        return feedbacks.stream()
                .map(FeedbackMapper::toFeedbackDTO)
                .collect(Collectors.toList());
    }
}

