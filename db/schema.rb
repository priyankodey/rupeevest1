# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140430122125) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "analyses", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.float    "goalamount"
    t.integer  "timeperiod"
    t.float    "initialamount"
    t.float    "periodicamount"
    t.integer  "periodicity"
    t.string   "yield"
    t.string   "creditrating"
    t.integer  "generalrisk"
    t.integer  "tenuregovt"
    t.integer  "tenurefixed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banklist", force: true do |t|
    t.string   "bid"
    t.string   "bank_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banks", force: true do |t|
    t.integer  "user_id"
    t.string   "name_of_bank"
    t.string   "bank_account_num"
    t.string   "bank_account_type"
    t.string   "bank_mode_of_holding"
    t.string   "bank_first_holder"
    t.string   "bank_second_holder"
    t.string   "bank_branch_address"
    t.string   "bank_city"
    t.string   "bank_ifsc_code"
    t.string   "bank_micr_code"
    t.integer  "bank_sip_mandate_status"
    t.integer  "bank_sip_year"
    t.integer  "bank_sip_mandate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "umrn"
    t.string   "reason"
    t.string   "bankid_pg"
  end

  create_table "camsfeeds", force: true do |t|
    t.string   "amc_code"
    t.string   "folio_no"
    t.string   "prodcode"
    t.string   "scheme"
    t.string   "inv_name"
    t.string   "trxntype"
    t.string   "trxnno"
    t.string   "trxnmode"
    t.string   "trxnstat"
    t.string   "usercode"
    t.string   "usrtrxno"
    t.date     "traddate"
    t.date     "postdate"
    t.float    "purprice"
    t.float    "units"
    t.float    "amount"
    t.string   "brokcode"
    t.string   "subbrok"
    t.string   "brokperc"
    t.string   "brokcomm"
    t.string   "altfolio"
    t.date     "rep_date"
    t.string   "time1"
    t.string   "trxnsubtyp"
    t.string   "application_no"
    t.string   "trxn_nature"
    t.float    "tax"
    t.float    "total_tax"
    t.string   "te_15h"
    t.string   "micr_no"
    t.string   "remarks"
    t.string   "swflag"
    t.string   "old_folio"
    t.string   "seq_no"
    t.string   "reinvest_flag"
    t.string   "mult_brok"
    t.float    "stt"
    t.string   "location"
    t.string   "scheme_type"
    t.string   "tax_status"
    t.float    "load"
    t.string   "scanrefno"
    t.string   "pan"
    t.float    "inv_iin"
    t.string   "targ_src_scheme"
    t.string   "trxn_type_flag"
    t.string   "ticob_trtype"
    t.string   "ticob_trno"
    t.date     "ticob_posted_date"
    t.string   "dp_id"
    t.float    "trxn_charges"
    t.float    "eligib_amt"
    t.string   "src_of_txn"
    t.string   "trxn_suffix"
    t.string   "siptrxnno"
    t.string   "ter_location"
    t.string   "euin"
    t.string   "euin_valid"
    t.string   "euin_opted"
    t.string   "sub_brk_arn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "freekycs", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funds", force: true do |t|
    t.integer  "scheme_code"
    t.string   "scheme_name"
    t.date     "launch_date"
    t.integer  "min_investment"
    t.string   "exit_load"
    t.float    "net_assets"
    t.float    "nav"
    t.string   "category"
    t.float    "expense_ratio"
    t.string   "colour_code"
    t.string   "benchmark"
    t.integer  "min_sip_investment"
    t.integer  "min_sip_chqs"
    t.float    "fund_ytd"
    t.float    "fund_1month"
    t.float    "fund_3month"
    t.float    "fund_1year"
    t.float    "fund_3year"
    t.float    "fund_5year"
    t.float    "fund_10year"
    t.float    "benchmark_ytd"
    t.float    "benchmark_1month"
    t.float    "benchmark_3month"
    t.float    "benchmark_1year"
    t.float    "benchmark_3year"
    t.float    "benchmark_5year"
    t.float    "benchmark_10year"
    t.float    "category_ytd"
    t.float    "category_1month"
    t.float    "category_3month"
    t.float    "category_1year"
    t.float    "category_3year"
    t.float    "category_5year"
    t.float    "category_10year"
    t.integer  "rank_ytd"
    t.integer  "rank_1month"
    t.integer  "rank_3month"
    t.integer  "rank_1year"
    t.integer  "rank_3year"
    t.integer  "rank_5year"
    t.integer  "rank_10year"
    t.integer  "no_of_fund_ytd"
    t.integer  "no_of_fund_1month"
    t.integer  "no_of_fund_3month"
    t.integer  "no_of_fund_1year"
    t.integer  "no_of_fund_3year"
    t.integer  "no_of_fund_5year"
    t.integer  "no_of_fund_10year"
    t.date     "trailing_returns_date"
    t.float    "fund_mean"
    t.float    "fund_stddev"
    t.float    "fund_sharpe"
    t.float    "fund_sortino"
    t.float    "fund_beta"
    t.float    "fund_alpha"
    t.float    "benchmark_mean"
    t.float    "benchmark_stddev"
    t.float    "benchmark_sharpe"
    t.float    "benchmark_sortino"
    t.float    "benchmark_beta"
    t.float    "benchmark_alpha"
    t.float    "category_mean"
    t.float    "category_stddev"
    t.float    "category_sharpe"
    t.float    "category_sortino"
    t.float    "category_beta"
    t.float    "category_alpha"
    t.integer  "rank_mean"
    t.integer  "rank_stddev"
    t.integer  "rank_sharpe"
    t.integer  "rank_sortino"
    t.integer  "rank_beta"
    t.integer  "rank_alpha"
    t.integer  "no_of_fund_mean"
    t.integer  "no_of_fund_stddev"
    t.integer  "no_of_fund_sharpe"
    t.integer  "no_of_fund_sortino"
    t.integer  "no_of_fund_beta"
    t.integer  "no_of_fund_alpha"
    t.date     "risk_measure_date"
    t.string   "no_of_stocks"
    t.float    "top_10"
    t.float    "top_5"
    t.float    "top_3_sectors"
    t.float    "portfolio_pb_ratio"
    t.float    "portfolio_pe_ratio"
    t.string   "holdings1_company"
    t.string   "holdings1_sector"
    t.float    "holdings1_pe"
    t.float    "holdings1_asset"
    t.string   "holdings2_company"
    t.string   "holdings2_sector"
    t.float    "holdings2_pe"
    t.float    "holdings2_asset"
    t.string   "holdings3_company"
    t.string   "holdings3_sector"
    t.float    "holdings3_pe"
    t.float    "holdings3_asset"
    t.string   "holdings4_company"
    t.string   "holdings4_sector"
    t.float    "holdings4_pe"
    t.float    "holdings4_asset"
    t.string   "holdings5_company"
    t.string   "holdings5_sector"
    t.float    "holdings5_pe"
    t.float    "holdings5_asset"
    t.string   "holdings6_company"
    t.string   "holdings6_sector"
    t.float    "holdings6_pe"
    t.float    "holdings6_asset"
    t.string   "holdings7_company"
    t.string   "holdings7_sector"
    t.float    "holdings7_pe"
    t.float    "holdings7_asset"
    t.string   "holdings8_company"
    t.string   "holdings8_sector"
    t.float    "holdings8_pe"
    t.float    "holdings8_asset"
    t.string   "holdings9_company"
    t.string   "holdings9_sector"
    t.float    "holdings9_pe"
    t.float    "holdings9_asset"
    t.string   "holdings10_company"
    t.string   "holdings10_sector"
    t.float    "holdings10_pe"
    t.float    "holdings10_asset"
    t.text     "investment_objective"
    t.string   "fund_manager"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "amc"
    t.string   "amc_code"
    t.string   "amfi_code"
    t.string   "scheme_code_pg"
    t.string   "prodcode"
    t.string   "fund_type"
  end

  create_table "holdings", force: true do |t|
    t.integer  "user_id"
    t.integer  "fund_id"
    t.integer  "transaction_id"
    t.integer  "units"
    t.float    "buy_value"
    t.float    "current_value"
    t.string   "folio"
    t.string   "amc_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "karvyfeedcons", force: true do |t|
    t.string   "AMC",        limit: 3
    t.string   "Folio",      limit: 15
    t.string   "Appl_No",    limit: 25
    t.string   "Sch_Code",   limit: 4
    t.string   "option",     limit: 1
    t.string   "Sch_desc",   limit: 200
    t.string   "Inv_name",   limit: 40
    t.string   "Jt1_Hld",    limit: 40
    t.string   "Jt2_Hld",    limit: 40
    t.string   "Add1",       limit: 40
    t.string   "Add2",       limit: 40
    t.string   "Add3",       limit: 40
    t.string   "City",       limit: 40
    t.string   "pincode",    limit: 6
    t.string   "Trxn_Num",   limit: 15
    t.string   "User_Cd",    limit: 10
    t.string   "Usr_trno",   limit: 15
    t.string   "Trn_Mode",   limit: 1
    t.string   "Sub_TrTy",   limit: 2
    t.date     "Tr_Date"
    t.date     "Pr_Date"
    t.string   "POP",        limit: 10
    t.string   "Units",      limit: 25
    t.string   "Amount",     limit: 25
    t.string   "STT",        limit: 10
    t.string   "TDS",        limit: 10
    t.string   "Load",       limit: 10
    t.string   "Tr_Type",    limit: 15
    t.string   "Tr_Desc",    limit: 40
    t.string   "NAV",        limit: 10
    t.string   "Br_code",    limit: 10
    t.string   "Sub_code",   limit: 25
    t.string   "Red_Mode",   limit: 10
    t.string   "Bnk_Name",   limit: 40
    t.string   "Bnk_acno",   limit: 40
    t.string   "Bnk_acty",   limit: 10
    t.string   "Bnk_Brn",    limit: 40
    t.string   "Bnk_city",   limit: 40
    t.string   "MOH",        limit: 2
    t.string   "Tax_Stat",   limit: 2
    t.string   "Category",   limit: 2
    t.string   "BRN_Code",   limit: 5
    t.string   "IH_No",      limit: 15
    t.date     "Rep_Date"
    t.float    "Tranfee"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "karvyfeeds", force: true do |t|
    t.integer  "user_id"
    t.integer  "transaction_id"
    t.string   "transaction_status"
    t.string   "feed_status"
    t.string   "AMC_CODE",           limit: 3
    t.string   "BROKE_CD",           limit: 20
    t.string   "SBBR_CODE",          limit: 15
    t.string   "User_Code",          limit: 10
    t.integer  "USR_TXN_NO",         limit: 8
    t.string   "Appl_No",            limit: 10
    t.string   "FOLIO_NO",           limit: 15
    t.string   "Ck_DIG_NO",          limit: 10
    t.string   "TRXN_TYPE",          limit: 7
    t.string   "SCH_CODE",           limit: 5
    t.string   "FIRST_NAME",         limit: 70
    t.string   "JONT_NAME1",         limit: 35
    t.string   "JONT_NAME2",         limit: 35
    t.string   "ADD1",               limit: 40
    t.string   "ADD2",               limit: 40
    t.string   "ADD3",               limit: 40
    t.string   "CITY",               limit: 35
    t.string   "PINCODE",            limit: 15
    t.string   "PHONE_OFF",          limit: 15
    t.string   "MOBILE_NO",          limit: 15
    t.date     "TRXN_DATE"
    t.time     "TRXN_TIME"
    t.float    "UNITS"
    t.float    "AMOUNT"
    t.string   "CLOS_AC_CH",         limit: 1
    t.date     "DOB"
    t.string   "GUARDIAN",           limit: 35
    t.string   "TAX_NUMBER",         limit: 40
    t.string   "PHONE_RES",          limit: 15
    t.string   "FAX_OFF",            limit: 15
    t.string   "FAX_RES",            limit: 15
    t.string   "EMAIL",              limit: 50
    t.string   "ACCT_NO",            limit: 40
    t.string   "ACCT_TYPE",          limit: 5
    t.string   "BANK_NAME",          limit: 40
    t.string   "BR_NAME",            limit: 40
    t.string   "BANK_CITY",          limit: 35
    t.string   "REINV_TAG",          limit: 1
    t.string   "HOLD_NATUR",         limit: 2
    t.string   "OCC_CODE",           limit: 2
    t.string   "TAX_STATUS",         limit: 2
    t.string   "REMARKS",            limit: 250
    t.string   "STATE",              limit: 2
    t.string   "PAN_2_HLDR",         limit: 40
    t.string   "PAN_3_HLDR",         limit: 40
    t.string   "Guard_PAN",          limit: 40
    t.string   "LOCATION",           limit: 10
    t.string   "UINno",              limit: 10
    t.string   "FORM6061",           limit: 1
    t.string   "FORM6061J1",         limit: 1
    t.string   "FORM6061J2",         limit: 1
    t.string   "PAY_MEC",            limit: 1
    t.string   "RTGS_CD",            limit: 11
    t.string   "NEFT_CD",            limit: 11
    t.string   "MICR_CD",            limit: 9
    t.string   "DEPBANK",            limit: 40
    t.string   "DEP_ACNO",           limit: 50
    t.date     "DEP_DATE"
    t.string   "DEP_RFNo",           limit: 25
    t.string   "SUB_TRXN_T",         limit: 6
    t.string   "SIP_RFNO",           limit: 8
    t.date     "SIP_RGDT"
    t.string   "NOM_NAME",           limit: 40
    t.string   "NOM_RELA",           limit: 40
    t.string   "KYC_FLG",            limit: 1
    t.string   "POA_STAT",           limit: 1
    t.string   "MOD_TRXN",           limit: 1
    t.string   "SIGN_VF",            limit: 1
    t.string   "CUST_ID",            limit: 12
    t.string   "LOG_WT",             limit: 70
    t.string   "LOG_PE",             limit: 70
    t.string   "DPID",               limit: 25
    t.string   "ClientID",           limit: 25
    t.string   "NRI_SOF",            limit: 25
    t.string   "EUIN",               limit: 16
    t.string   "EUIN_OPT",           limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kycs", force: true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "father_spouse_name"
    t.string   "gender"
    t.string   "marital_status"
    t.date     "date_of_birth"
    t.string   "nationality"
    t.string   "residence_status"
    t.string   "pan"
    t.string   "proof_of_identity"
    t.string   "correspondence_city_town_village"
    t.string   "correspondence_state"
    t.string   "correspondence_country"
    t.string   "correspondence_postal_code"
    t.string   "correspondence_landline"
    t.string   "correspondence_mobile"
    t.string   "correspondence_email"
    t.string   "correspondence_proof_of_address"
    t.boolean  "same"
    t.string   "permanent_city_town_village"
    t.string   "permanent_state"
    t.string   "permanent_country"
    t.string   "permanent_postal_code"
    t.string   "permanent_landline"
    t.string   "permanent_mobile"
    t.string   "permanent_email"
    t.string   "permanent_proof_of_address"
    t.float    "annual_income"
    t.string   "occupation"
    t.string   "pep_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "c_house_no"
    t.string   "c_street_name"
    t.string   "c_area_name"
    t.string   "p_house_no"
    t.string   "p_street_name"
    t.string   "p_area_name"
  end

  create_table "msgfrompgs", force: true do |t|
    t.integer  "user_id"
    t.string   "order_number"
    t.float    "amount"
    t.text     "msgpg"
    t.string   "auth_status"
    t.string   "error"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "msgtopgs", force: true do |t|
    t.integer  "user_id"
    t.string   "order_number"
    t.float    "amount"
    t.text     "msg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.date     "released_on"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taxsavings", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.integer  "user_id"
    t.integer  "bank_id"
    t.integer  "fund_id"
    t.string   "option"
    t.string   "transaction_type"
    t.float    "amount"
    t.float    "price_per_unit"
    t.string   "transaction_status"
    t.string   "folio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "billdesk_trnx_no"
    t.string   "transaction_status_reason"
    t.string   "order_number"
    t.string   "checksum"
    t.string   "liq_non"
    t.string   "error_status"
    t.string   "error_desc"
    t.string   "auth_status"
    t.float    "transaction_charges"
    t.string   "arn_code"
    t.date     "t_date"
    t.integer  "sip_months"
    t.string   "rta"
    t.string   "dividend_option"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "kyc_status"
    t.integer  "bank_status"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "visitors", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
