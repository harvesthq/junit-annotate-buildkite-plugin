require 'minitest/autorun'
require 'open3'

class AnnotateTest < Minitest::Test
  def test_minitest_files
    output, status = Open3.capture2e("#{__dir__}/../bin/annotate", "#{__dir__}/minitest/")

    assert_equal <<~OUTPUT, output
      Parsing 8 junit files
      --- ❓ Checking failures
      Ran 331 tests in 22.03s.
      There are 4 failures/errors 😭
      --- ✍️ Preparing annotation
      Ran **331** tests in **22.03s**.
      <details>
      <summary><code>AccountTest#test_harvest_accounts_have_the_name_limited_to_90_characters</code></summary>

      <pre class=\"term\"><code>Expected: &quot;foo bar&quot;\r
        Actual: &quot;bar foo&quot;

      test/models/account_test.rb:23:in `block in &lt;class:AccountTest&gt;&#39;</code></pre>

      </details>

      <details>
      <summary><code>ClientTest#test_#default_invoice_settings_returns_empty_hash_if_nil</code></summary>

      <pre class=\"term\"><code>Expected: {:foo=&gt;false}\r
        Actual: {}

      test/models/client_test.rb:25:in `block in &lt;class:ClientTest&gt;&#39;</code></pre>

      </details>

      <details>
      <summary><code>CompanyTest#test_#timesheet_version_returns_a_current_timestamp_if_the_latest_timesheet_version_from_its_users_is_more_than_one_hour_old_new</code></summary>

      <pre class=\"term\"><code>--- expected\r
      +++ actual\r
      @@ -1,2 +1,2 @@\r
      -# encoding: US-ASCII\r
      -&quot;1517933436.0&quot;\r
      +# encoding: ASCII-8BIT\r
      +&quot;1517928036.0&quot;

      test/models/company_test.rb:2288:in `block (3 levels) in &lt;class:CompanyTest&gt;&#39;
      test/models/company_test.rb:2287:in `block (2 levels) in &lt;class:CompanyTest&gt;&#39;</code></pre>

      </details>

      <details>
      <summary><code>PayPalHelperTest#test_PayPal-availability-check_for_customers_in_india_doesn't_raise_if_company_has_been_deleted</code></summary>

      <pre class=\"term\"><code>OpenSSL::Cipher::CipherError

      app/models/asana_settings.rb:122:in `access_token&#39;
      app/models/asana_settings.rb:100:in `revoke_token&#39;
      app/models/company.rb:421:in `destroy&#39;
      test/helpers/pay_pal_helper_test.rb:93:in `block in &lt;class:PayPalHelperTest&gt;&#39;</code></pre>

      </details>
    OUTPUT

    assert_equal 0, status.exitstatus
  end

  def test_rspec_files
    output, status = Open3.capture2e("#{__dir__}/../bin/annotate", "#{__dir__}/rspec/")

    assert_equal <<~OUTPUT, output
      Parsing 1 junit file
      --- ❓ Checking failures
      Ran 11 tests in 76.93s.
      There is 1 failure/error 😭
      --- ✍️ Preparing annotation
      Ran **11** tests in **76.93s**.
      <details>
      <summary><code>spec.features.harvestapp.invitation_spec</code></summary>

      <pre class=\"term\"><code>Failure/Error: expect(page).to have_content(&quot;I am testing the spec errors&quot;)
        expected to find text &quot;I am testing the spec errors&quot; in &quot;master 1ecb249 3fba97bf8344 2.5.8 5.2.4.3 development\\nTime\\nExpenses\\nProjects\\nTeam\\nReports\\nInvoices\\nManage\\nHelp\\nSettings\\nTheron\\nAdd Person\\nWelcome to Team! Here you can review and edit your team’s time, and see how they’re\\ndoing against capacity. That’s the number of hours per week they typically work.\\nHow many hours do most team members work each week?\\n0.5\\n1\\n1.5\\n2\\n2.5\\n3\\n3.5\\n4\\n4.5\\n5\\n5.5\\n6\\n6.5\\n7\\n7.5\\n8\\n8.5\\n9\\n9.5\\n10\\n10.5\\n11\\n11.5\\n12\\n12.5\\n13\\n13.5\\n14\\n14.5\\n15\\n15.5\\n16\\n16.5\\n17\\n17.5\\n18\\n18.5\\n19\\n19.5\\n20\\n20.5\\n21\\n21.5\\n22\\n22.5\\n23\\n23.5\\n24\\n24.5\\n25\\n25.5\\n26\\n26.5\\n27\\n27.5\\n28\\n28.5\\n29\\n29.5\\n30\\n30.5\\n31\\n31.5\\n32\\n32.5\\n33\\n33.5\\n34\\n34.5\\n35\\n35.5\\n36\\n36.5\\n37\\n37.5\\n38\\n38.5\\n39\\n39.5\\n40\\n40.5\\n41\\n41.5\\n42\\n42.5\\n43\\n43.5\\n44\\n44.5\\n45\\n45.5\\n46\\n46.5\\n47\\n47.5\\n48\\n48.5\\n49\\n49.5\\n50\\n50.5\\n51\\n51.5\\n52\\n52.5\\n53\\n53.5\\n54\\n54.5\\n55\\n55.5\\n56\\n56.5\\n57\\n57.5\\n58\\n58.5\\n59\\n59.5\\n60\\nWhen are timesheets due each week?\\nNo Preference\\nNo Preference\\nMonday\\nTuesday\\nWednesday\\nThursday\\nFriday\\nSaturday\\nSunday\\nYou can always change these options from Settings.\\nAll Set, Show Me Team\\n30 days left in your free trial See Upgrade Options\\nPrivacy\\nTerms&quot;
      ./spec/features/harvestapp/invitation_spec.rb:14:in `block (3 levels) in &lt;top (required)&gt;&#39;</code></pre>

      </details>
    OUTPUT

    assert_equal 0, status.exitstatus
  end
end
