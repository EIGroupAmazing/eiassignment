<%-- 
    Document   : template
    Created on : Mar 28, 2015, 3:39:35 PM
    Author     : Alex
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!DOCTYPE html>
<html ng-app="demoShop">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Product Demo | 2Checkout</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width = device-width, initial-scale = 1, maximum-scale = 1, user-scalable = no">

   <link href="https://www.2checkout.com/?css=global_embeds/css_reset.v.1407270714" type="text/css" rel="stylesheet" media="screen" />
<link href="https://www.2checkout.com/?css=global_embeds/css_text.v.1407271028" type="text/css" rel="stylesheet" media="screen" />
<link href="https://www.2checkout.com/?css=global_embeds/css_forms.v.1407270798" type="text/css" rel="stylesheet" media="screen" />
<link href="https://www.2checkout.com/?css=demo/acme_css.v.1414766628" type="text/css" rel="stylesheet" media="screen" />
<link href="https://www.2checkout.com/?css=demo/ng_animation_css.v.1398108808" type="text/css" rel="stylesheet" media="screen" />
   <!--JS Library Reference-->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular-route.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular-animate.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/bower-angular-translate/2.0.1/angular-translate.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/3.32/jquery.form.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/money.js/0.1.3/money.min.js"></script>

<!--JS File Reference-->
<script src="/demo/layout_js" type="text/javascript"></script>
<script src="/demo/shop_js" type="text/javascript"></script>
<script src="/demo/cart_js" type="text/javascript"></script>
<script src="/demo/settings_js" type="text/javascript"></script>
<script src="/demo/app_js" type="text/javascript"></script>
<script src="/demo/controller_js" type="text/javascript"></script>
<script src="/demo/translation_js" type="text/javascript"></script>
<script src="/demo/currency_js" type="text/javascript"></script>

<!--Eloqua-->
<script type="text/javascript">

    var _elqQ = _elqQ || [];
    _elqQ.push(['elqSetSiteId', '686229964']);
    _elqQ.push(['elqTrackPageView']);
    
    (function () {
        function async_load() {
            var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true;
            s.src = '//img03.en25.com/i/elqCfg.min.js';
            var x = document.getElementsByTagName('script')[0]; x.parentNode.insertBefore(s, x);
        }
        if (window.addEventListener) window.addEventListener('DOMContentLoaded', async_load, false);
        else if (window.attachEvent) window.attachEvent('onload', async_load); 
    })();
    
</script>

<!--Google Analytics-->
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-8119346-1']);
  _gaq.push(['_setDomainName', '2checkout.com']);
  _gaq.push(['_setAllowLinker', true]);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<!--Adroll Tracking-->
<script type="text/javascript">

   adroll_adv_id = "5BSMJRNNHFHJHIJVHBM64S";
   adroll_pix_id = "H6ZCLV6NIJDTPA24XOJZPN";
   (function () {
   var oldonload = window.onload;
   window.onload = function(){
      __adroll_loaded=true;
      var scr = document.createElement("script");
      var host = (("https:" == document.location.protocol) ? "https://s.adroll.com" : "http://a.adroll.com");
      scr.setAttribute('async', 'true');
      scr.type = "text/javascript";
      scr.src = host + "/j/roundtrip.js";
      ((document.getElementsByTagName('head') || [null])[0] ||
       document.getElementsByTagName('script')[0].parentNode).appendChild(scr);
      if(oldonload){oldonload()}};
   }());
   
</script>

</head>
<body ng-controller="shopController" ng-init="store.convertCurrency(settings.currency)">
    <div id="wrap">
        <div id="header">
            <div class="container">
                <div id="referrer">
                    <a href="/">2Checkout</a>
                    <span>Product Demo</span>
                </div>
                <div class="btn-help"></div>
                <div class="btn-settings active">Settings</div>
                <a id="logo" href="https://www.2checkout.com/demo/" ng-click="cart.setStep(0)"><img src="/upload/images/logo_acme.png" alt="ACME Logo" /></a>
            </div>
            <div id="settings-panel" ng-controller="Settings">
                <div class="container">
                    <div class="description">
                        <h5>Select Your Checkout Settings &#187;</h5>
                        <p>Use these settings to configure which checkout experience, language, and currency you want to test.</p>
                    </div>
                    <div class="menu">
                        <label id="checkout-options">Checkout Experience</label>
                        <div class="checkout-experience" ng-class="{'active' : settings.checkoutType == 'API'}">
                            <div id="payment-api" class="item" ng-click="settings.setCheckoutType('API'); cart.setMethod('API'); cart.setStep(0);">
                                <span>Payment API</span>
                            </div>
                        </div>
                        <div class="checkout-experience" ng-class="{'active' : settings.checkoutType == 'Inline'}">
                            <div id="inline" class="item" ng-click="settings.setCheckoutType('Inline'); cart.setMethod('Inline'); cart.setStep(0);">
                                <span>Inline</span>
                            </div>
                        </div>
                        <div class="checkout-experience" ng-class="{'active' : settings.checkoutType == 'Hosted'}">
                            <div id="standard" class="item" ng-click="settings.setCheckoutType('Hosted'); cart.setMethod('Hosted'); cart.setStep(0); store.convertCurrency(settings.currency); cart.convertItemCurrency(settings.currency);">
                                <span>Standard</span>
                            </div>
                        </div>
                        <label id="language-options">Language</label>
                        <div id="language" class="item">
                            <img class="arrow" src="/upload/images/arrow_down_white_select-box.png" alt="Arrow" />
                            <select ng-model="settings.language" ng-change="langChange()">
                                <option value="en" selected>English</option>
                                <option value="es_ib">Spanish (European) — Español</option>
                                <option value="es_la">Spanish (Latin) — Español</option>
                                <option value="fr">French — Français</option>
                                <option value="ja">Japanese — 日本語</option>
                                <option value="de">German — Deutsch</option>
                                <option value="it">Italian — Italiano</option>
                                <option value="nl">Dutch — Nederlands</option>
                                <option value="pt">Portuguese — Português</option>
                                <option value="el">Greek — Ελληνική</option>
                                <option value="sv">Swedish — Svenska</option>
                                <option value="zh">Chinese (Traditional) — 語言名稱</option>
                                <option value="sl">Slovenian — Slovene</option>
                                <option value="da">Danish — Dansk</option>
                                <option value="no">Norwegian — Norsk</option>
                            </select>
                        </div>
                        <label id="currency-options">Currency</label>
                        <div id="currency" class="item">
                            <img class="arrow" src="/upload/images/arrow_down_white_select-box.png" alt="Arrow" />
                            <select ng-if="settings.checkoutType != 'Hosted'" id="currency-code" ng-model="settings.currency" ng-change="store.convertCurrency(settings.currency); cart.convertItemCurrency(settings.currency); settings.setCurrencySymbol();">
                                <option value="AED">AED — United Arab Emirates Dirham</option>
                                <option value="ARS">ARS — Argentina Peso</option>
                                <option value="AUD">AUD — Australian Dollar</option>
                                <option value="BRL">BRL — Brazilian Real</option>
                                <option value="CAD">CAD — Canadian Dollar</option>
                                <option value="CHF">CHF — Swiss Franc</option>
                                <option value="DKK">DKK — Danish Krone</option>
                                <option value="EUR">EUR — Euro</option>
                                <option value="GBP">GBP — British Pound</option>
                                <option value="HKD">HKD — Hong Kong Dollar</option>
                                <option value="ILS">ILS — Israeli New Shekel</option>
                                <option value="INR">INR — Indian Rupee</option>
                                <option value="JPY">JPY — Japanese Yen</option>
                                <option value="LTL">LTL — Lithuanian Litas</option>
                                <option value="MXN">MXN — Mexican Peso</option>
                                <option value="MYR">MYR — Malaysian Ringgit</option>
                                <option value="NOK">NOK — Norwegian Krone</option>
                                <option value="NZD">NZD — New Zealand Dollar</option>
                                <option value="PHP">PHP — Philippine Peso</option>
                                <option value="RON">RON — Romanian New Leu</option>
                                <option value="RUB">RUB — Russian Ruble</option>
                                <option value="SEK">SEK — Swedish Krona</option>
                                <option value="SGD">SGD — Singapore Dollar</option>
                                <option value="TRY">TRY — Turkish Lira</option>
                                <option value="USD" selected>USD — U.S. Dollar</option>
                                <option value="ZAR">ZAR — South African Rand</option>
                            </select>
                            <select ng-if="settings.checkoutType == 'Hosted'" id="currency-code" disabled>
                                <option value="USD" selected>USD — U.S. Dollar</option>
                            </select>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            <div id="settings-overlay"></div>
            <span id="buyer-experience" ng-click="save()" class="btn white">View Buyer Experience</span>
        </div>
        <div id="content">
            <div id="home" class="row top">
                 <div id="product-selection" class="container">
                     <div class="col span-12 center-align">
                         <h1>{{ 'INDEX_TITLE' | translate }}</h1>
                         <span class="">{{ 'INDEX_DESC' | translate }}</span>
                     </div>
                     <div class="col span-12">
                         <div class="product">
                             <div class="image">
                                 <img src="/upload/images/graphic_product_tangible.png" alt="Tangible Product Image" />
                             </div>
                             <div class="details">
                                 <h5 class="type">{{ 'PRODUCT_TYPE' | translate }} <br /> ({{ 'PRODUCT_CAPTION' | translate }})</h5>
                                 <h2 class="pricing">{{store.products[0].price | currency: settings.symbol}}</h2>
                                 <h5 class="name">{{ 'PRODUCT_NAME' | translate }}</h5>
                                 <p class="description">{{ 'PRODUCT_DESC' | translate }}</p>
                                 <div class="form-group">
                                     <input id="quantity" type="number" ng-model="quantity" ng-init="quantity=1"  maxlength="3" type="number" min="1" max="999" />
                                     <label for="quantity">{{ 'PRODUCT_QUANTITY' | translate }}</label>
                                 </div>
                                 <div ng-if="settings.checkoutType == 'Hosted'">
                                     <button class="btn white small" ng-click="cart.checkoutHosted('1', quantity, settings.language, settings.currency)">{{ 'ADD_TO_CART' | translate }}</button>
                                 </div>
                                 <div ng-if="settings.checkoutType != 'Hosted'">
                                     <button class="btn white small" ng-click="cart.addItem(store.products[0].id, store.products[0].name, store.products[0].price, store.products[0].basePrice, quantity, null, null, null);">{{ 'ADD_TO_CART' | translate }}</button>
                                 </div>
                             </div>
                             <div class="clear"></div>
                         </div>
                         <div class="product">
                             <div class="image">
                                 <img src="/upload/images/graphic_product_intangible.png" alt="Intangible Product Image" />
                             </div>
                             <div class="details">
                                 <h5 class="type">{{ 'SUBSCRIPTION_TYPE' | translate }} <br /> ({{ 'SUBSCRIPTION_CAPTION' | translate }})</h5>
                                 <h2 class="pricing">{{store.products[1].price | currency: settings.symbol}}<span class="label"> / {{ 'SUBSCRIPTION_MONTH' | translate }}</span></h2>
                                 <h5 class="name">{{store.products[1].name}}</h5>
                                 <p class="description">{{ 'SUBSCRIPTION_DESC' | translate }}</p>
                                 <div class="form-group">
                                     <input type="hidden">
                                     <label>&nbsp;</label>
                                 </div>
                                 <div ng-if="settings.checkoutType == 'Hosted'">
                                     <button class="btn white small" ng-click="cart.checkoutHosted('2', 1, settings.language, settings.currency)">{{ 'ADD_TO_CART' | translate }}</button>
                                 </div>
                                 <div ng-if="settings.checkoutType != 'Hosted'">
                                     <button class="btn white small" ng-click="cart.addItem(store.products[1].id, store.products[1].name, store.products[1].price, store.products[0].basePrice, 1, '1 Month', 'Forever', store.products[1].startup);">{{ 'ADD_TO_CART' | translate }}</button>
                                 </div>
                             </div>
                             <div class="clear"></div>
                         </div>
                     </div>
                     <div class="clear"></div>
                 </div>
                <form id="checkout-process" name="checkout" class="container" method="post" novalidate>
                    <div ng-if="!cart.complete" id="process-bar" class="col span-12">
                        <a id="back" class="circle-item" ng-href="" ng-click="cart.setStep(cart.prevStep())">«</a>
                        <span id="counter" class="circle-item"><span class="count">{{cart.getStep()}}</span> / {{cart.stepCount}}</span>
                            <ul id="selector" class="clearfix" ng-class="{'five' : cart.showShipping && settings.checkoutType !== 'Inline', 'four' : cart.showShipping && settings.checkoutType == 'Inline', 
                            'three' : !cart.showShipping && settings.checkoutType !== 'Inline', 'two' : !cart.showShipping && settings.checkoutType == 'Inline'}">
                            <li ng-class="{'complete' : 1 < cart.nav, 'active' : 1 == cart.nav}">
                                {{ 'STEP_CART' | translate }}
                                <img class="arrow" src="/upload/images/arrow_right_thin_dark.png" alt="arrow" />
                                <img class="arrow active" src="/upload/images/arrow_right_thin_dark_green.png" alt="arrow" />
                                <img class="arrow complete" src="/upload/images/arrow_right_thin_dark_blue.png" alt="arrow" />
                            </li>
                           <li ng-if="cart.showShipping" ng-class="{'complete' : 2 < cart.nav, 'active' : 2 == cart.nav}">
                                {{ 'STEP_SHIPPING_INFO' | translate }}
                                <img class="arrow" src="/upload/images/arrow_right_thin_dark.png" alt="arrow" />
                                <img class="arrow active" src="/upload/images/arrow_right_thin_dark_green.png" alt="arrow" />
                                <img class="arrow complete" src="/upload/images/arrow_right_thin_dark_blue.png" alt="arrow" />
                            </li>
                            <li ng-if="cart.showShipping" ng-class="{'complete' : 3 < cart.nav, 'active' : 3 == cart.nav}">
                                {{ 'STEP_SHIPPING_METHOD' | translate }}
                                <img class="arrow" src="/upload/images/arrow_right_thin_dark.png" alt="arrow" />
                                <img class="arrow active" src="/upload/images/arrow_right_thin_dark_green.png" alt="arrow" />
                                <img class="arrow complete" src="/upload/images/arrow_right_thin_dark_blue.png" alt="arrow" />
                            </li>
                            <li ng-class="{'complete' : 4 < cart.nav, 'active' : 4 == cart.nav}">
                                {{ 'STEP_BILLING' | translate }}
                                <img ng-if="settings.checkoutType != 'Inline'" class="arrow" src="/upload/images/arrow_right_thin_dark.png" alt="arrow" />
                                <img ng-if="settings.checkoutType != 'Inline'" class="arrow active" src="/upload/images/arrow_right_thin_dark_green.png" alt="arrow" />
                                <img ng-if="settings.checkoutType != 'Inline'" class="arrow complete" src="/upload/images/arrow_right_thin_dark_blue.png" alt="arrow" />
                            </li>
                            <li ng-if="settings.checkoutType != 'Inline'" ng-class="{'complete' : 5 < cart.nav, 'active' : 5 == cart.nav}">
                                {{ 'STEP_PAYMENT' | translate }}
                            </li>
                        </ul>
                    </div>
                    <div id="spinner-container">
                        <img id="spinner" src="/upload/images/graphic_progress.gif">
                    </div>
                    <div id="sections" class="col span-12">
                        <div class="container">
                            <div class="animate" ng-class="{'toggle' : cart.direction == 'back', 'toggle' : cart.direction == 'forward'}" ng-view></div>
                        </div>
                    </div>
                    <div ng-if="!cart.complete" id="cart-summary" class="col span-12 clearfix">
                        <div class="items">
                            <h5>{{ 'CART_SUMMARY_TITLE' | translate }}</h5>
                            <div class="form-group">
                                <label>{{ 'CART_SUMMARY_ITEMS' | translate }}</label>
                                <span>{{cart.getTotalPrice() | currency:settings.symbol}}</span>
                            </div>
                            <div class="form-group">
                                <label>{{ 'CART_SUMMARY_SHIPPING' | translate }}</label>
                                <span>{{settings.symbol}} {{cart.shippingCost}}</span>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="total">
                            <label>{{ 'CART_SUMMARY_TOTAL' | translate }} {{cart.currency}}</label>
                            <span>{{cart.getGrandTotal() | currency:settings.symbol}}</span>
                        </div>
                    </div>
                    <div class="col span-1"></div>
                    <div class="clear"></div>
                </form>
            </div>
            <div id="signup" class="row">
               <div class="container">
                  <div class="col span-12 center-align">
                     <span id="cta-signup" class="extra-large"><a href="/signup">Sign up</a> for a free 2Checkout Account</span>
                  </div>
                  <div class="col span-1"></div>
                  <div class="clear"></div>
               </div>
            </div>
        </div>
    </div>
    <div id="footer">
        <div class="container">
            <p id="copyright">
                &copy 2003-
                <script type="text/javascript">var year = new Date(); document.write(year.getFullYear());</script> 2Checkout.com, Inc. All rights reserved.
            </p>
            <p id="disclaimer">ACME is a fake company used by 2Checkout to provide examples of our checkout options and integration.</p>
            <ul id="links">
                <li><a href="/">2Checkout Website</a></li>
                <li><a href="/documentation">Documentation</a></li>
                <li><a href="http://help.2checkout.com/">Knowledge Base</a></li>
            </ul>
        </div>
    </div>
    <!-- Modal Code -->
    <div class="overlay" id="help-overlay"></div>
    <div id="help-popup" class="modal">
       <div class="btn-help active"></div>
       <div class="modal-dialog">
          <div class="modal-content">
             <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h5 class="modal-title">Help</h5>
             </div>
             <div class="modal-body">
                <div class="main-content">
                   <p>The 2Checkout ACME demo allows anyone to try out all three of our checkout platforms from start to finish in minutes. Choose from our Payment API, Inline, and Standard checkouts with the option to offer a one-time physical purchase or recurring subscription.</p>
                   <ul class="disc">
                      <li>
                         <strong>Payment API</strong> is an advanced integration that allows you to host the payment form on your site and use our API to process transactions.
                         <div class="clear"></div>
                         <a class="boxed" href="/payment-api" target="_blank">Features</a><a class="boxed" href="/documentation/payment-api" target="_blank">Integrate with Payment API</a>
                      </li>
                      <li>
                         <strong>Inline Checkout*</strong> is a hosted solution, but instead of redirecting the buyer to our site, it provides a simplified popup form over your site. Inline only collects payment information, so your site needs to pass in all other information for Inline to process the transaction correctly.
                         <div class="clear"></div>
                         <a class="boxed" href="/hosted-checkout" target="_blank">Features</a><a class="boxed" href="/documentation/checkout/inline-checkout" target="_blank">Integrate with Inline</a>
                      </li>
                      <li>
                         <strong>Standard Checkout*</strong> is our other hosted solution, but it redirects the buyer to our site. Standard Checkout works best with our Buy Button integration method. If you just have a couple products, Standard is the quickest and easiest to integrate.
                         <div class="clear"></div>
                         <a class="boxed" href="/hosted-checkout" target="_blank">Features</a><a class="boxed" href="/documentation/checkout/standard-checkout" target="_blank">Integrate with Standard</a>
                      </li>
                   </ul>
                   <p class="extra-small">*PayPal is available with our hosted checkout solutions. However, PayPal is not available during demo sales and on the ACME demo site.</p>
                </div>
                <div class="sidebar-content">
                   <a class="domains" href="/documentation" target="_blank"><img src="/upload/images/icon_documentation.png" alt="Documentation Icon"/><span>Documentation</span></a>
                   <a class="domains" href="http://help.2checkout.com/" target="_blank"><img src="/upload/images/icon_knowledge-base.png" alt="Knowledge Base Icon"/><span>Knowledge Base</span></a>
                   <span class="contact">For questions about our service, contact our sales team at <a href="mailto:salesteam@2co.com">salesteam@2co.com</a></span>
                   <span class="contact">For questions about integration, contact tech support at <a href="mailto:techsupport@2co.com">techsupport@2co.com</a></span>
                </div>
                <div class="clear"></div>
             </div>
             <div class="modal-footer">
                <button id="close" type="button" class="btn black small">Close</button>
             </div>
          </div>
      </div>
   </div>
   <div class="overlay" id="paypal-overlay"></div>
       <div id="paypal-popup" class="modal">
          <div class="modal-dialog">
             <div class="modal-content">
                <div class="modal-header">
                   <button type="button" class="paypal-close" data-dismiss="modal" aria-hidden="true">&times;</button>
                   <h5 class="modal-title">PayPal</h5>
                </div>
                <div class="modal-body">
                   <div class="main-content center-align">
                      <p>{{ 'PAYPAL_HELP' | translate }} <a href="/signup">2Checkout</a> {{ 'ACCOUNT' | translate }}.</p>
                      <div class="clear"></div>
                   </div>
                </div>
                <div class="modal-footer">
                   <button id="paypal-close" type="button" class="btn black small paypal-close">Close</button>
                </div>
              </div>
          </div>
      </div>
   </div>
   <!-- /Modal Code -->
</body>
</html>
