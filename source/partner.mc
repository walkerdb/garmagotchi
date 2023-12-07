// import Toybox.Math;
// import Toybox.System;
// using Toybox.Application.Storage;

// class Partner {
//   private var partner;
//   private var partnerKiss;
//   private var partnerSparkle;
//   private var partnerSquish;

//   private var partnerAnimationStartTime;

//   function initialize() {
//     partner = new BitmapAsset(Rez.Drawables.MyPartner);
//     partnerKiss = new BitmapAsset(Rez.Drawables.MyPartnerKiss);
//     partnerSparkle = new BitmapAsset(Rez.Drawables.MyPartnerSparkle);
//     partnerSquish = new BitmapAsset(Rez.Drawables.MyPartnerSquish);
//   }

//   function draw(dc) {
//     if (partnerAnimationStartTime != -1) {
//       var currentSecond = System.getClockTime().sec;
//       if (
//         currentSecond == partnerAnimationStartTime + 1 ||
//         currentSecond == partnerAnimationStartTime + 3
//       ) {
//         partner.draw(dc);
//       } else if (currentSecond == partnerAnimationStartTime + 2) {
//         var rand = Math.rand() % 3;
//         if (rand == 0) {
//           partnerSparkle.draw(dc);
//         } else if (rand == 1) {
//           partnerKiss.draw(dc);
//         } else if (rand == 2) {
//           partnerSquish.draw(dc);
//         }
//       }
//       if (currentSecond == partnerAnimationStartTime + 4) {
//         partnerAnimationStartTime = -1;
//       }
//     }
//   }

//   function setAnimationStartTime(time) {
//     if (Storage.getValue("garmagotchiCharacter").equals("me")) {
//       partnerAnimationStartTime = time;
//     }
//   }
// }
