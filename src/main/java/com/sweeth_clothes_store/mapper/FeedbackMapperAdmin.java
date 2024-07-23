//package com.sweeth_clothes_store.mapper;
//
//import com.sweeth_clothes_store.dto.FeedbackDTOAdmin;
//import com.sweeth_clothes_store.model.Account;
//import com.sweeth_clothes_store.model.Feedback;
//import com.sweeth_clothes_store.model.Product;
//
//public class FeedbackMapperAdmin {
//    // Convert Feedback entity to FeedbackDTO
//    public static FeedbackDTOAdmin toFeedbackDTO(Feedback feedback) {
//        if (feedback == null) {
//            return null;
//        }
//        FeedbackDTOAdmin dto = new FeedbackDTOAdmin();
//        dto.setId(feedback.getId());
//        dto.setRate(feedback.getRate());
//        dto.setContent(feedback.getContent());
//        dto.setCreateDate(feedback.getCreateDate());
//        dto.setStatus(feedback.isStatus());
//        dto.setAccountId(feedback.getAccount().getId());
//        dto.setProductId(feedback.getProduct().getId());
//        return dto;
//    }
//
//    // Convert FeedbackDTO to Feedback entity
//    public static Feedback toFeedback(FeedbackDTOAdmin dto, Account account, Product product) {
//        if (dto == null) {
//            return null;
//        }
//        Feedback feedback = new Feedback();
//        feedback.setId(dto.getId());
//        feedback.setRate(dto.getRate());
//        feedback.setContent(dto.getContent());
//        feedback.setCreateDate(dto.getCreateDate());
//        feedback.setStatus(dto.isStatus());
//        feedback.setAccount(account);
//        feedback.setProduct(product);
//        return feedback;
//    }
//}
