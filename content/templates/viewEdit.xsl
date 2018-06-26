<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes"/>

<xsl:template match="/">
	<form method="post" action="{$current-url}">
		<fieldset class="settings">
			<legend>Template Settings</legend>
			<div>
				<xsl:if test="/data/errors/name">
					<xsl:attribute name="class">
						<xsl:text>invalid</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<label>
					Name
					<input type="text" name="fields[name]">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="/data/fields">
									<xsl:value-of select="/data/fields/name"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/data/templates/entry/name"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</input>
				</label>
				<xsl:if test="/data/errors/name">
					<p><xsl:value-of select="/data/errors/name"/></p>
				</xsl:if>
			</div>
			<label>
				Datasources
				<i>optional</i>
				<select multiple="multiple" name="fields[datasources][]">
					<xsl:for-each select="/data/datasources/entry">
						<option value="{handle}">
							<xsl:choose>
								<xsl:when test="/data/fields">
									<xsl:if test="/data/fields/datasources/item = handle">
										<xsl:attribute name="selected" select="'selected'"/>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="/data/templates/entry/datasources/item = handle">
										<xsl:attribute name="selected" select="'selected'"/>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="name"/>
						</option>
					</xsl:for-each>
					<xsl:if test="not(/data/datasources/entry)">
						<option value="0" disabled="1">No datasources installed</option>
					</xsl:if>
				</select>
			</label>
			<p class="help">Layouts will be able to use these datasources to build their content.</p>
			<label>
				Layouts
				<select name="fields[layouts]">
					<option value="both">
						<xsl:if test="(/data/templates/entry/layouts/html) and (/data/templates/entry/layouts/plain) or (not(/data/templates/entry/layouts/html) and not(/data/templates/entry/layouts/plain))">
							<xsl:attribute name="selected">1</xsl:attribute>
						</xsl:if>
						HTML and Plain
					</option>
					<option value="html">
						<xsl:if test="not(/data/templates/entry/layouts/plain) and (/data/templates/entry/layouts/html)">
							<xsl:attribute name="selected">1</xsl:attribute>
						</xsl:if>
						HTML only
					</option>
					<option value="plain">
						<xsl:if test="not(/data/templates/entry/layouts/html) and (/data/templates/entry/layouts/plain)">
							<xsl:attribute name="selected">1</xsl:attribute>
						</xsl:if>
						Plain only
					</option>
				</select>
			</label>
			<p class="help">Only the layouts selected will be emailed.</p>
		</fieldset>
		<fieldset class="settings">
			<legend>Email Settings</legend>
			<p class="help">These settings are global settings for this template. They can be overwritten by extensions or custom events. <br /><br />Use the {$param} and {/xpath/query} notation to include dynamic parts. It is not possible to combine the two syntaxes: {/xpath/$param} is not possible.</p>
			<div>
				<xsl:if test="/data/errors/subject">
					<xsl:attribute name="class">
						<xsl:text>invalid</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<label>
					Subject
					<input type="text" name="fields[subject]">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="/data/fields">
									<xsl:value-of select="/data/fields/subject"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/data/templates/entry/subject"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</input>
				</label>
				<xsl:if test="/data/errors/subject">
					<p><xsl:value-of select="/data/errors/subject"/></p>
				</xsl:if>
				<xsl:if test="not(/data/errors/subject)">
					<p class="help">Use the {$param} and {/xpath/query} notation to include dynamic parts. It is not possible to combine the two syntaxes. If the XPath returns more than one result, only the first is used</p>
				</xsl:if>
			</div>
			<div>
				<xsl:if test="/data/errors/recipients">
					<xsl:attribute name="class">
						<xsl:text>invalid</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<label>
					Recipients
					<i>optional</i>
					<input type="text" name="fields[recipients]">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="/data/fields">
									<xsl:value-of select="/data/fields/recipients"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/data/templates/entry/recipients"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</input>
				</label>
				<xsl:if test="/data/errors/recipients">
					<p><xsl:value-of select="/data/errors/recipients"/></p>
				</xsl:if>
				<xsl:if test="not(/data/errors/recipients)">
					<p class="help">Select multiple recipients by separating them with commas. This is also possible dynamically: <code>{/data/authors/author/name} &lt;{/data/authors/author/email}&gt;</code> will return: <code>name &lt;email@domain.com&gt;, name2 &lt;email2@domain.com&gt;</code></p>
				</xsl:if>
			</div>
			<div class="group">
				<div>
					<xsl:if test="/data/errors/reply-to-name">
						<xsl:attribute name="class">
							<xsl:text>invalid</xsl:text>
						</xsl:attribute>
					</xsl:if>
					<label>
						Reply-To Name
						<i>optional</i>
						<input type="text" name="fields[reply-to-name]">
							<xsl:attribute name="value">
								<xsl:choose>
									<xsl:when test="/data/fields">
										<xsl:value-of select="/data/fields/reply-to-name"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="/data/templates/entry/reply-to-name"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</input>
					</label>
					<xsl:if test="/data/errors/reply-to-name">
						<p><xsl:value-of select="/data/errors/reply-to-name"/></p>
					</xsl:if>
				</div>
				<div>
					<xsl:if test="/data/errors/reply-to-email-address">
						<xsl:attribute name="class">
							<xsl:text>invalid</xsl:text>
						</xsl:attribute>
					</xsl:if>
					<label>
						Reply-To Email Address
						<i>optional</i>
						<input type="text" name="fields[reply-to-email-address]">
							<xsl:attribute name="value">
								<xsl:choose>
									<xsl:when test="/data/fields">
										<xsl:value-of select="/data/fields/reply-to-email-address"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="/data/templates/entry/reply-to-email-address"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</input>
					</label>
					<xsl:if test="/data/errors/reply-to-email-address">
						<p><xsl:value-of select="/data/errors/reply-to-email-address"/></p>
					</xsl:if>
				</div>
			</div>
			<div>
				<xsl:if test="/data/errors/attachments">
					<xsl:attribute name="class">
						<xsl:text>invalid</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<label>
					Attachments
					<i>optional</i>
					<input type="text" name="fields[attachments]">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="/data/fields">
									<xsl:value-of select="/data/fields/attachments"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/data/templates/entry/attachments"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</input>
				</label>
				<xsl:if test="/data/errors/attachments">
					<p><xsl:value-of select="/data/errors/attachments"/></p>
				</xsl:if>
				<xsl:if test="not(/data/errors/attachments)">
					<p class="help">Select multiple attachments by separating them with commas. For each file define either a URL or a local path starting from the DOCROOT, e.g. <code>/workspace/media/foo.pdf</code>. It is also possible to include dynamic parts. URLs and local paths must not contain commas.</p>
				</xsl:if>
			</div>
			<div>
				<xsl:if test="/data/errors/ignore-attachment-errors">
					<xsl:attribute name="class">
						<xsl:text>invalid</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<label>
					<input type="checkbox" name="fields[ignore-attachment-errors]">
						<xsl:choose>
							<xsl:when test="/data/fields/ignore-attachment-errors">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:when>
							<xsl:when test="/data/templates/entry/ignore-attachment-errors">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:when>
						</xsl:choose>
					</input>
					<xsl:text> </xsl:text>
					<xsl:text>Ignore attachment errors</xsl:text>
				</label>
				<xsl:if test="/data/errors/attachments">
					<p><xsl:value-of select="/data/errors/attachments"/></p>
				</xsl:if>
				<xsl:if test="not(/data/errors/attachments)">
					<p class="help">With the above option an email will be sent even if an attachment can not be loaded.</p>
				</xsl:if>
			</div>
		</fieldset>
		<div class="actions">
			<div class="svg-icon-container">
				<svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="28.7px" height="19.3px" viewBox="0 0 28.7 19.3">
					<path fill="currentColor" d="M21.2,19.3H6.4C2.8,19.3,0,16.5,0,13c0-2.9,2-5.4,4.7-6.1C5.5,2.9,9,0,13.2,0c2.3,0,4.4,0.9,6.1,2.5c0.4,0.4,0.4,1,0,1.4c-0.4,0.4-1,0.4-1.4,0C16.6,2.7,15,2,13.2,2C9.8,2,7,4.5,6.6,7.9c0,0.5-0.4,0.8-0.9,0.9C3.6,9.1,2,10.9,2,13c0,2.4,1.9,4.3,4.4,4.3h14.8c3.1,0,5.5-2.4,5.5-5.4c0-1.9-1.1-3.7-2.8-4.7c-0.5-0.3-0.6-0.9-0.4-1.4c0.3-0.5,0.9-0.6,1.4-0.4c2.3,1.3,3.8,3.8,3.8,6.4C28.7,16,25.4,19.3,21.2,19.3z"></path>
					<path fill="currentColor" d="M13.9,13.2L13.9,13.2c-0.3,0-0.5-0.1-0.7-0.3L9.5,9.3c-0.4-0.4-0.4-1,0-1.4s1-0.4,1.4,0l2.9,2.9l9.3-9.3c0.4-0.4,1-0.4,1.4,0s0.4,1,0,1.4l-10,10C14.4,13.1,14.1,13.2,13.9,13.2z"></path>
				</svg>
				<input type="submit" accesskey="s" name="action[save]">
					<xsl:attribute name="value">
						<xsl:choose>
							<xsl:when test="/data/templates/entry/name">Save Changes</xsl:when>
							<xsl:otherwise>Create Template</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</input>
			</div>
			<xsl:if test="not(/data/context/item[@index=1] = 'new')" >
				<div class="svg-icon-container">
					<svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="26.2px" height="26px" viewBox="0 0 26.2 26">
						<path fill="currentColor" d="M25.2,24c-0.6,0-1-0.4-1-1V11.5L21.8,11c0,0,0,0,0,0c-3.7,0-6.6-2.5-6.6-6.1V1c0-0.6,0.4-1,1-1s1,0.4,1,1v3.9c0,2.5,2,4.5,4.6,4.5l3.4,0.1c0.5,0,1,0.5,1,1V23C26.2,23.6,25.8,24,25.2,24z"></path>
						<path fill="currentColor" d="M23.2,26h-16c-1.7,0-3-1.3-3-3c0-0.6,0.4-1,1-1s1,0.4,1,1c0,0.6,0.4,1,1,1h16c0.6,0,1-0.4,1-1V10.1c-0.6-1.3-6.8-7.5-8.1-8.1H7.2c-0.6,0-1,0.4-1,1c0,0.6-0.4,1-1,1s-1-0.4-1-1c0-1.7,1.3-3,3-3h9c1.7,0,10,8.3,10,10v13C26.2,24.7,24.9,26,23.2,26z M24.3,10.2L24.3,10.2L24.3,10.2z M16.1,2L16.1,2L16.1,2z"></path>
						<path fill="currentColor" d="M1,18.2c-0.3,0-0.5-0.1-0.7-0.3c-0.4-0.4-0.4-1,0-1.4l8.5-8.5c0.4-0.4,1-0.4,1.4,0s0.4,1,0,1.4l-8.5,8.5C1.5,18.1,1.3,18.2,1,18.2z"></path>
						<path fill="currentColor" d="M9.5,18.2c-0.3,0-0.5-0.1-0.7-0.3L0.3,9.5c-0.4-0.4-0.4-1,0-1.4s1-0.4,1.4,0l8.5,8.5c0.4,0.4,0.4,1,0,1.4C10,18.1,9.7,18.2,9.5,18.2z"></path>
					</svg>

					<button accesskey="d" title="Delete this page" class="button confirm delete" name="action[delete]">Delete</button>
				</div>
			</xsl:if>

			<svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="9.2px" height="5.6px" viewBox="0 0 9.2 5.6">
				<path fill="currentColor" d="M4.6,5.6c-0.3,0-0.5-0.1-0.7-0.3L0.3,1.7c-0.4-0.4-0.4-1,0-1.4s1-0.4,1.4,0l2.9,2.9l2.8-2.8c0.4-0.4,1-0.4,1.4,0s0.4,1,0,1.4L5.3,5.3C5.2,5.5,4.9,5.6,4.6,5.6z"></path>
			</svg>

			<xsl:if test="/data/xsrf_input">
				<xsl:copy-of select="/data/xsrf_input/*"/>
			</xsl:if>
		</div>
		</form>
</xsl:template>

</xsl:stylesheet>
