function SelectItem() {
    const ItemDetailsID = document.getElementById("Description_button").value;

    const mainDiv = document.getElementById("OptionsDiv");
    while (mainDiv.firstChild) {
        mainDiv.removeChild(mainDiv.firstChild);
    }

    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/Home/ItemDetail', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            CreateDetails(xhr.responseText);

        }
    }
    xhr.send(`chosenType=${ItemDetailsID}`);
}


function CreateDetails(responseText) {
    SelectedItem = JSON.parse(responseText)
    const MainDiv = document.getElementById("OptionsDiv");
    
    const LeftDetailsDivEl = document.createElement("div");
    const RightDetailsDivEl = document.createElement("div");
    LeftDetailsDivEl.className = "LeftDetailsDiv";

    const LeftDivTableEl = document.createElement("table");
    const BrandRow = document.createElement("tr");
    BrandRow.className = "Brand_row";
    const BrandEl = document.createElement("th");
    BrandEl.className = "row_first__th";
    BrandEl.innerHTML = "Brand";
    const BrandNameEl = document.createElement("th");
    BrandNameEl.className = "row_second__th";
    BrandNameEl.innerHTML = SelectedItem.brand.brandName;
    const ColourRow = document.createElement("tr");
    ColourRow.className = "Colour_row";
    const ColourEl = document.createElement("th");
    ColourEl.className = "row_first__th";
    ColourEl.innerHTML = "Colour";
    const ColourNameEl = document.createElement("th");
    ColourNameEl.className = "row_second__th";
    ColourNameEl.innerHTML = SelectedItem.item.itemColour;

    BrandRow.appendChild(BrandEl);
    BrandRow.appendChild(BrandNameEl);
    ColourRow.appendChild(ColourEl);
    ColourRow.appendChild(ColourNameEl);
    LeftDivTableEl.appendChild(BrandRow);
    LeftDivTableEl.appendChild(ColourRow);

    RightDetailsDivEl.className = "RightDetailsDiv";

    const NameEl = document.createElement("p");
    NameEl.innerHTML = "Name: Here will be the item's name";
    NameEl.id = "p_style_5";
    const DescriptionEl = document.createElement("p");
    DescriptionEl.innerHTML = "Description:";
    DescriptionEl.id = "p_style_4"
    const ItemDescriptionEl = document.createElement("p");
    ItemDescriptionEl.innerHTML = SelectedItem.item.itemDescription;

    RightDetailsDivEl.appendChild(NameEl);
    RightDetailsDivEl.appendChild(DescriptionEl);
    RightDetailsDivEl.appendChild(ItemDescriptionEl)
    
    LeftDetailsDivEl.appendChild(LeftDivTableEl);
    MainDiv.appendChild(LeftDetailsDivEl);
    MainDiv.appendChild(RightDetailsDivEl);


}

function CreatingOpinions() {
    const ItemID = document.getElementById("Comment_button").value;

    const mainDiv = document.getElementById("OptionsDiv");
    while (mainDiv.firstChild) {
        mainDiv.removeChild(mainDiv.firstChild);
    }

    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/Home/Opinions', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            console.log(xhr.responseText);
            CreateOpinins(xhr.responseText);

        }
    }
    xhr.send(`chosenType=${ItemID}`);
}

function CreateOpinins(responseText) {
    Opinions = JSON.parse(responseText)
    const MainDiv = document.getElementById("OptionsDiv");
    if (Opinions.length == 0) {
        const NoItemEl = document.createElement("h1");
        NoItemEl.innerHTML = "There is no opinions to this item.Be you the first!";
        MainDiv.appendChild(NoItemEl);
    }
    else {
        const OpinionsMainDivEl = document.createElement("div");
        const HeadingRowEl = document.createElement("tr");
        HeadingRowEl.className = "heading_tr";
        const HeadingRowLeftSideEl = document.createElement("th");
        HeadingRowLeftSideEl.id = "reviews_th";
        const LeftRowPEl = document.createElement("p");
        LeftRowPEl.id = "p_stlye_6";
        LeftRowPEl.innerHTML = "Item Review(s)"
        HeadingRowLeftSideEl.appendChild(LeftRowPEl);
        const HeadingRowRightSideEl = document.createElement("th");
        HeadingRowRightSideEl.id = "sort_button_th";
        const SortButtonEl = document.createElement("button");
        SortButtonEl.id = "sort_button";
        SortButtonEl.innerHTML = "Sort";
        
        HeadingRowEl.appendChild(HeadingRowLeftSideEl);
        HeadingRowRightSideEl.appendChild(SortButtonEl);
        HeadingRowEl.appendChild(HeadingRowRightSideEl);
        OpinionsMainDivEl.appendChild(HeadingRowEl);
        
        for (let i = 0; i < Opinions.length; i++) {
            const opinion = Opinions[i];
            const OpinionTable = document.createElement("table");
            OpinionTable.className = "opinion_table";
            const Profiletd = document.createElement("td");
            Profiletd.id = "profile_td";
            const PostDateEl = document.createElement("p");
            PostDateEl.innerHTML = opinion.postDate;
            const UserNameEl = document.createElement("p");
            UserNameEl.innerHTML = opinion.userName;
            Profiletd.appendChild(PostDateEl);
            Profiletd.appendChild(UserNameEl);
            const Opiniontd = document.createElement("td");
            
            const ItemRatingEl = document.createElement("p");
            
            ItemRatingEl.innerHTML = "He/She's Rating: " + opinion.theUserRating;
            const OpinionEl = document.createElement("p");
            
            OpinionEl.innerHTML = opinion.opinion;
            Opiniontd.appendChild(ItemRatingEl);
            Opiniontd.appendChild(OpinionEl);



            OpinionTable.appendChild(Profiletd);
            OpinionTable.appendChild(Opiniontd);
            OpinionsMainDivEl.appendChild(OpinionTable);
            MainDiv.appendChild(OpinionsMainDivEl);
        }

    }
}

function CreateNewReview() {

    const mainDiv = document.getElementById("OptionsDiv");
    while (mainDiv.firstChild) {
        mainDiv.removeChild(mainDiv.firstChild);
    }
    const New_Review_FormEl = document.createElement("form");
    New_Review_FormEl.setAttribute('method', "post");

    const RatingDivEl = document.createElement("div");
    RatingDivEl.className = "Rating_div";
    const StepOneDivEl = document.createElement("div");
    StepOneDivEl.innerHTML = "1";
    StepOneDivEl.className = "Step_Div";
    const ContentDiv = document.createElement("div");
    ContentDiv.className = "Content_Div";
    const SelectEl = document.createElement("select");
    SelectEl.id = "DdlSelect";
    SelectEl.name = "rating";
    SelectEl.required = true;
    for (let i = 1; i <= 5; i++) {
        const OptionEl = document.createElement("option");
        OptionEl.value = i;
        OptionEl.innerHTML = i;
        SelectEl.appendChild(OptionEl);

    }
    const RatingTitleDivEl = document.createElement("div");
    RatingTitleDivEl.innerHTML = "Please rating our product:";
    RatingTitleDivEl.className = "Description_Div";
    ContentDiv.appendChild(SelectEl);
    RatingDivEl.appendChild(StepOneDivEl);
    RatingDivEl.appendChild(RatingTitleDivEl);
    RatingDivEl.appendChild(ContentDiv);

    const ReviewDivEl = document.createElement("div");
    ReviewDivEl.className = "Review_Div";
    const StepTwoDivEl = document.createElement("div");
    StepTwoDivEl.innerHTML = "2";
    StepTwoDivEl.className = "Step_Div_2";
    const ReviewContentDiv = document.createElement("div");
    ReviewContentDiv.innerHTML = "Review";
    ReviewContentDiv.className = "Description_Div_2";
    const TextAreaDiv = document.createElement("textarea");
    TextAreaDiv.rows = 5;
    TextAreaDiv.type = "text";
    TextAreaDiv.name = "Textarea";
    TextAreaDiv.id = "Text_Area";

    ReviewDivEl.appendChild(StepTwoDivEl);
    ReviewDivEl.appendChild(ReviewContentDiv);
    ReviewDivEl.appendChild(TextAreaDiv);

    const SubmitDiv = document.createElement("div");
    SubmitDiv.className = "Submit_Div";
    const ButtonEl = document.createElement("button");
    ButtonEl.innerHTML = "Post";
    ButtonEl.id = "Submit_Button";
    SubmitDiv.appendChild(ButtonEl);

    const HiddenInputValue = document.getElementById("Details_id").value;
    const HiddenInputEl = document.createElement("input");
    HiddenInputEl.type = "hidden";
    HiddenInputEl.name = "DetailsID";
    HiddenInputEl.value = HiddenInputValue;

    New_Review_FormEl.appendChild(HiddenInputEl);
    New_Review_FormEl.appendChild(RatingDivEl);
    New_Review_FormEl.appendChild(ReviewDivEl);
    New_Review_FormEl.appendChild(SubmitDiv);
    mainDiv.appendChild(New_Review_FormEl);
}

