# 📱Home Screen

- [x]  Replace the current home screen with the new Flutter UI Kit. Keep navBar.
    - [x]  More details at the end 👇🏼
    - [TASK 1] Materials from @Hasan AlDoy
        
        ### Sample Flutter Project for Referencing ✅ 🔍
        
        > This Flutter I purchased is using old packages or syntax, not feasible to fix.
        > 
        > 
        > > Request access to these private repos 💌
        > > 
        
        ### [Task 1] Suggested Code
        
        ```dart
        Container(
              color: innerWhite ? null : GridItemColor().listTileColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  key: boxKey,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: items.map((e) {
                    Widget w = Padding(
                      padding: EdgeInsets.only(
                          left: position == 0 ? 8.0 : 4,
                          right: position == items.length - 1 ? 8.0 : 4),
                      child: CategoryFourGridItemLayout(
                        e,
                        imageWidth,
                        imageHeight,
                        sizeDiscountedPrice: sizeDiscountedPrice,
                        boxHeight: boxHeight,
                        colorDiscount: colorDiscount,
                        titleSize: titleSize,
                        titleFontWeight: titleFontWeight,
                        isDiscountedPriceMediumBold: isDiscountedPriceMediumBold,
                        ratingFontWeight: ratingFontWeight,
                      ),
                    );
                    position++;
                    return w;
                  }).toList(),
                ),
              ),
            );
        ```
        
        [https://github.com/aldoyh/uiflutter.git](https://github.com/aldoyh/uiflutter.git)