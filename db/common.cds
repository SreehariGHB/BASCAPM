namespace anubhav.common;

using {sap,Currency,temporal,managed } from '@sap/cds/common';

type Gender : String(1) enum{
    Male = 'M';
    Female = 'F';
    nonBinary = 'N';
    noDisclosure = 'D';
    selfDescribe = 'S';
};

type AmountT : Decimal(15,2)@(
    Semantics.amount.currency_code: 'CURRENCY_CODE',
    Sap.unit: 'CURRENCY_CODE'

);

aspect Amount {
    CURRENCY_CODE: String(4);	
    GROSS_AMOUNT:AmountT;	
    NET_AMOUNT:AmountT;
    TAX_AMOUNT:AmountT;     
}


// type PhoneNumber : String(30)@assert.format : '((?:\+|00)[17](?: |\-)?|(?:\+|00)[1-9]\d{0,2}(?: |\-)?|(?:\+|00)1\-\d{3}(?: |\-)?)?(0\d|\([0-9]{3}\)|[1-9]{0,3})(?:((?: |\-)[0-9]{2}){4}|((?:[0-9]{2}){4})|((?: |\-)[0-9]{3}(?: |\-)[0-9]{4})|([0-9]{7}))';
type PhoneNumber : String(30)@assert.format : '\B\+91 [0-9]{10}\b';
type Email: String(255)@assert.format : '^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';



