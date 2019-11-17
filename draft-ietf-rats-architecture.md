---
title: Remote Attestation Procedures Architecture
abbrev: RATS Arch & Terms
docname: draft-ietf-rats-architecture-latest
wg: RATS Working Group
stand_alone: true
ipr: trust200902
area: Security
kw: Internet-Draft
cat: info
pi:
  toc: yes
  sortrefs: yes
  symrefs: yes

author:
- ins: H. Birkholz
  name: Henk Birkholz
  org: Fraunhofer SIT
  abbrev: Fraunhofer SIT
  email: henk.birkholz@sit.fraunhofer.de
  street: Rheinstrasse 75
  code: '64295'
  city: Darmstadt
  country: Germany
- ins: D. Thaler
  name: Dave Thaler
  org: Microsoft
  email: dthaler@microsoft.com
  street: ""
  code: ""
  city: ""
  region: ""
  country: USA
- ins: M. Richardson
  name: Michael Richardson
  org: Sandelman Software Works
  email: mcr+ietf@sandelman.ca
  street: ""
  code: ""
  city: ""
  region: ""
  country: Canada
- ins: N. Smith
  name: Ned Smith
  org: Intel Corporation
  abbrev: Intel
  email: ned.smith@intel.com
  street: ""
  code: ""
  city: ""
  country: USA

normative:
  RFC2119:
  RFC8174:

informative:
  I-D.ietf-teep-architecture: TEEP
  DOLEV-YAO: DOI.10.1109_tit.1983.1056650
  ABLP:
    title: A Calculus for Access Control in Distributed Systems
    author:
    - ins: M. Abadi
      name: Martin Abadi
    - ins: M. Burrows
      name: Michael Burrows
    - ins: B. Lampson
      name: Butler Lampson
    - ins: G. Plotkin
      name: Gordon Plotkin
    seriesinfo:
      Springer: Annual International Cryptology Conference
      page: 1-23
      DOI: 10.1.1.36.691
    date: 1991
  Lampson2007:
    title: Practical Principles for Computer Security
    author:
    - ins: B. Lampson
      name: Butler Lampson
    seriesinfo:
      IOSPress: Proceedings of Software System Reliability and Security
      page: 151-195
      DOI: 10.1.1.63.5360
    date: 2007
  iothreats:
    title: "The Internet of Things or the Internet of threats?"
    target: "https://gcn.com/articles/2016/05/03/internet-of-threats.aspx"
    author:
    - ins: GDN
      name: STEVE SARNECKI
    date: 2016
  RFC5209:
  RFC3552:
  RFC4949:
  I-D.richardson-rats-usecases: rats-usecases
  I-D.fedorkow-rats-network-device-attestation:
  I-D.birkholz-rats-tuda: tuda
  I-D.ietf-rats-eat: EAT
  keystore:
    target: "https://developer.android.com/training/articles/keystore"
    title: "Android Keystore System"
    author:
    -  ins: "Google"
       name: "Google"
    date: 2019
  fido:
    target: "https://fidoalliance.org/specifications/"
    title: "FIDO Specification Overview"
    author:
    -  ins: "FIDO Alliance"
       name: "FIDO Alliance"
    date: 2019

--- abstract

An entity (a relying party) requires a source of truth and evidence about a remote peer to assess the peer's trustworthiness. The evidence is typically a believable set of claims about its host, software or hardware platform. This document describes an architecture for such remote attestation procedures (RATS).

--- middle

# Introduction

## RATS in a Nutshell

# Terminology {#terminology}

{::boilerplate bcp14}

Appraisal:

: A Verifier process that compares Evidence to Reference values while taking into account Endorsements and produces Attestation Results.

Asserter:

: See {{asserter}}.

Attester:

: See {{attester}}.

Attested Environment:

: A target environment that is observed or controlled by an Attesting Environment.

Attesting Environment:

: An environment capable of making trustworthiness Claims about an Attested Environment.

Background-Check Message Flow:

: An attestation workflow where the Attester provides Evidence to a Relying Party, who consults one or more Verifiers who supply Attestation Results to the Relying Party. See [background].

Claim:

: A statement about the construction, composition, validation or behavior of an Entity that affects trustworthiness. Evidence, Reference Values and Attestation Results are expressions that consists of one or more Claims.

Conveyance:

: The process of transferring Evidence, Reference Values and Attestation Results between Entities participating in attestation workflow.

Entity:

: A device, component (see System Component {{RFC4949}}), or environment that implements one or more Roles.

Evidence:

: See {{evidence}}.

Passport Message Flow:

: An attestation workflow where the Attester provides Evidence to a Verifier who returns Attestation Results that are then forwarded to one or more Relying Parties. See [passport].

Reference Values:

: See {{reference}}. Also referred to as Known-Good-Values.

Relying Party:

: See {{relyingparty}}.

Attestation Results:

: See {{results}}.

Role:

: A function or process in an attestation workflow, typically described by: Attester, Verifier, Relying Party and Asserter.

Verifier:

: See {{verifier}}.

# Reference Use Cases {#referenceusecases}

This section provides an overview of a number of distinct use cases that benefit from a standardized claim format.
In addition to outlining the user, the specific message flow is identified from among the flows detailed in [messageflows].

## Device Capabilities/Firmware Attestation {#netattest}

This is a large category of claims that includes a number of subcategories,
not detailed here.

Use case name:

: Device Identity

Who will use it:

: Network Operators, larger enterprises

Attester:

: varies

Message Flow:

: sometimes passport and sometimes background check

Relying Party:

: varies

Description:

: Network operators want a trustworthiness report of identity and version of
information of the hardware and software on the machines attached to their
network.
The process starts with some kind of Root of Trust that provides device
identity and protected storage for measurements. The mechanism performs a
series of measurements, and expresses this
with an attestation as to the hardware and firmware/software which is
running.

This is a general description for which there are many specific use cases,
including {{I-D.fedorkow-rats-network-device-attestation}} section 1.2,
"Software Inventory"

## IETF TEEP WG Use-Case

Use case name:

: TAM validation

Who will use it:

: The TAM server

Message Flow:

: background check

Attester:

: Trusted Execution Environment (TEE)

Relying Party:

: end-application

Description:

: The "Trusted Application Manager (TAM)" server wants to verify the state of a
TEE, or applications in the TEE, of a device.  The TEE attests to the TAM,
which can then decide whether to install sensitive data in the TEE, or
whether the TEE is out of compliance and the TAM needs to install updated
code in the TEE to bring it back into compliance with the TAM's policy.

## Safety Critical Systems

Use case name:

: Safety Critical Systems

Who will use it:

: Power plants and other systems that need to assert their current state, but which can not accept any inputs from the outside.  The corollary system is
a black-box (such as in an aircraft), which needs to log the state of a system,
but which can never initiate a handshake.

Message Flow:

: background check

Attester:

: web services and other sources of status/sensor information

Relying Party:

: open

Claims used as Evidence:

: the beginning and ending time as endorsed by a Time Stamp Authority,
represented by a time stamp token.  The real time clock of the system
itself.  A Root of Trust for time; the TPM has a relative time from
startup.

Description:

: These requirements motivate the creation of the Time-Base Unidirectional Attestation (TUDA) {{-tuda}}, the output of TUDA is typically a secure audit log, where freshness is determined by synchronization to a trusted source of external time.

: The freshness is preserved in the Evidence by the use of a Time Stamp Authority (TSA) which provides Time Stamp Tokens (TST).

## Virtualized Multi-Tenant Hosts

Use case name:

: Multi-Tenant Hosts

Who will use it:

: Virtual machine systems

Message Flow:

: passport

Attester:

: virtual machine hypervisor

Relying Party:

: network operators

Description:

: The host system will do verification as per {{netattest}}

: The tenant virtual machines will do verification as per {{netattest}}.

: The network operator wants to know if the system *as a whole* is free of
malware, but the network operator is not allowed to know who the tenants are.

: This is contrasted to the Chassis + Line Cards case (To Be Defined: TBD).

: Multiple Line Cards, but a small attestation system on the main card can
combine things together.
This is a kind of proxy.

## Cryptographic Key Attestation {#cryptattest}

Cryptographic Attestion includes subcategories such as Device Type
Attestation (the FIDO use case), and Key storage Attestation (the Android
Keystore use case), and End-User Authorization.

Use case name:

: Key Attestation

Who will use it:

: network authentication systems

Message Flow:

: passport

Attester:

: device platform

Relying Party:

: internet peers

Description:

: The relying party wants to know how secure a private key that identifies an entity is.
Unlike the network attestation, the relying party is not part of the network infrastructure, nor do they necessarily have a business relationship (such as ownership) over the end device.

: The Device Type Attestation is provided by a Firmware TPM performing the Verifier function, creating Attestation Results that indicate a particular model/type of device.  In TCG terms, this is called Implicit Attestation, in this case the Attested Environment is the (smartphone) Rich Execution Environment (REE) ({{I-D.ietf-teep-architecture}} section 2), and the Attesting Environment is within the TEE.

## Geographic Evidence

Use case name:

: Location Evidence

Who will use it:

: geo-fenced systems

Message Flow:

: passport (probably)

Attester:

: secure GPS system(s)

Relying Party:

: internet peers

Description:

: The relying party wants to know the physical location (on the planet earth, using a geodetic system) of the device.
This may be provided directly by a GPS/GLONASS/BeiDou/Galileo module that is incorporated into a TPM.
This may also be provided by collecting other proximity messages from other device that the relying party can form a trust relationship with.

## Device Provenance Attestation

Use case name:

: RIV - Device Provenance

Who will use it:

: Industrial IoT devices

Message Flow:

: passport

Attester:

: network management station

Relying Party:

: a network entity

Description:

: A newly manufactured device needs to be onboarded into a network where many
if not all device management duties are performed by the network owner.
The device owner wants to verify the device originated from a legitimate vendor.
A cryptographic device identity such as an IEEE802.1AR is embedded during manufacturing and a certificate identifying the device is delivered to the owner  onboarding agent.
The device authenticates using its 802.1AR IDevID to prove it originated from the expected vendor.

The device chain of custody from the original device manufacturer to the new owner may also be verified as part of device provenance attestation.
The chain of custody history may be collected by a cloud service or similar capability that the supply chain and owner agree to use.

{{I-D.fedorkow-rats-network-device-attestation}} section 1.2 refers to this as "Provable Device Identity", and section 2.3 details the parties.

# Conceptual Overview {#overview}

In network protocol exchanges, it is often the case that one entity (a Relying Party) requires an assessment of the trustworthiness of a remote entity (an Attester or specific system components {{RFC4949}} thereof).
Remote ATtestation procedureS (RATS) enable Relying Parties to establish a level of confidence in the trustworthiness of Attesters through the

* Creation,
* Conveyance, and
* Appraisal

of attestation Evidence.

Qualities of Evidence:

: Evidence is composed of Claims about trustworthiness (the set of Claims is unbounded). The system characteristics of Attesters -- the Environments they are composed-of, and their continuous development -- have an impact on the veracity of trustworthiness Claims included in valid Evidence.

: Valid Evidence about the intactness of an Attester must be impossible to create by an untrustworthy or compromised Environment of an Attester.

Qualities of Environments:

: The resilience of Environments that are part of an Attester can vary widely - ranging from those highly resistant to attacks to those having little or no resistance to attacks.
Configuration options, if set poorly, can result in a highly resistant environment being operationally less resistant.
When a trustworthy Environment changes, it is possible that it transitions from
being trustworthy to being untrustworthy.

: An untrustworthy or compromised Environment must never be able to create valid Evidence expressing the intactness of an Attester.

The architecture provides a framework for anticipating when a relevant change with respect to a trustworthiness attribute occurs, what exactly changed and how relevant it is. The architecture also creates a context for enabling an appropriate response by applications, system software and protocol endpoints when changes to trustworthiness attributes do occur.

Detailed protocol specifications for message flows are defined in separate documents.

## Two Types of Environments

An Attester produces Evidence about its own integrity, which means "it measures itself". To disambiguate this recursive or circular looking relationships, two types of Environments inside an Attester are distinguished:

The attest-ED Environments and the attest-ING Environments.

Attested Environments are measured. They provide the raw values and the information to be represented in Claims and ultimately expressed as Evidence.

Attesting Environments conduct the measuring. They collect the Claims, format them appropriately, and typically use key material and cryptographic functions, such as signing or cipher algorithms, to create Evidence.

Attesting Environments use system components that have to be trusted. As a result, Evidence includes Claims
about the Attested and the Attesting Environments. Claims about the Attested Environments are appraised using
Reference Values and Claims about the Attesting Environments are appraised using Endorsements. It is not mandated
that both Environments have to be separate, but it is highly encouraged. Examples of separated Environments that
can be used as Attesting Environments include: Trusted Execution Environments (TEE), embedded Secure Elements
(eSE), or Hardware Security Modules (HSM).

In summary, the majority of the creation of evidence can take place in an Attested Environments. Exemplary duties include the collection and formatting of Claim values, or the trigger for creating Evidence. A trusted sub-set of the creation of evidence can take place in an Attesting Environment, that provide special protection with respect to key material, identity documents, or primitive functions to create the Evidence itself.

## Evidence Creation Prerequisites

## Trustworthiness

## Interoperability

# Goals

RATS architecture has the following goals:

* Enable semantic interoperability of attestation semantics through information models about computing environments and trustworthiness.
* Enable data structure interoperability related to claims, endpoint composition / structure, and end-to-end integrity and confidentiality protection mechanisms.
* Enable programmatic assessment of trustworthiness. (Note: Mechanisms that manage risk, justify a level of confidence, or determine a consequence of an attestation result are out of scope).
* Provide the building blocks, including Roles and Principals that enable the composition of service-chains/hierarchies and workflows that can create and appraise evidence about the trustworthiness of devices and services.
* Use-case driven architecture and design (see {{-rats-usecases}} and {{referenceusecases}})
* Terminology conventions that are consistently applied across RATS specifications.
* Reinforce trusted computing principles that include attestation.

## Attestation Principles

Specifications developed by the RATS working group apply the following principles:

* Freshness - replay of previously asserted Claims about an Attested Environment can be detected.
* Identity - the Attesting Environment is identifiable (non-anonymous).
* Context - the Attested Environment is well-defined (unambiguous).
* Provenance - the origin of Claims with respect to the Attested and Attesting Environments are known.
* Validity - the expected lifetime of Claims about an Attested Environment is known.
* Veracity - the believability (level of confidence) of Claims is based on verifiable proofs.

## Attestation Workflow

The basic function of RATS workflow is the creation, conveyance and appraisal of attestation Evidence. The architecture defines attestation Roles: Attester, Verifier, Asserter and Relying Party. An Attester creates attestation Evidence that are conveyed to a Verifier for appraisal. The appraisals compare Evidence with expected Known-Good-Values obtained from Asserters (e.g. Principals that are Supply Chain Entities).
There can be multiple forms of appraisal (e.g., software integrity verification, device composition and configuration verification, device identity and provenance verification).
Attestation Results are the output of appraisals. Attestation Results are signed and conveyed to Relying Parties. Attestation Results provide the basis by which the Relying Party may determine a level of confidence to place in the application data or operations that follow.

Attestation workflow helps a Relying Party make better decisions by providing insight about the trustworthiness of endpoints participating in a distributed system. The workflow consists primarily of four roles; Relying Party, Verifier, Attester and Asserter. Attestation messages contain information useful for appraising the trustworthiness of an Attester endpoint and informing the Relying Party of the appraisal result.

The detailed definition of workflow message syntax and semantics are found in an appropriate document, such as {{-EAT}} or other protocols to be defined.
Roles can be combined in various ways into Principals, depending upon the needs of the use case.
Information Model representations are realized as data structure and conveyance protocol specifications.


# Roles {#roles}

An endpoint system (a.k.a., Entity) may implement one or more attestation Roles to accommodate a variety of possible message flows. Exemplary message flows are described in [passport] and [background]. Role messages are secured by the Entity that generated it. Entities possess credentials (e.g., cryptographic keys) that authenticate, integrity protect and optionally confidentiality protect attestation messages.

## Attester {#attester}

The Attester consists of both an Attesting Environment and an Attested Environment. In some implementations these environments may be combined. Other implementations may have multiples of Attesting and Attested environments. Although endpoint environments can be complex, and that complexity is security relevant, the basic function of an Attester is to create Evidence that captures operational conditions affecting trustworthiness.

## Asserter {#asserter}

The Asserter role is out of scope.
The mechanism by which an Asserter communicates Known-Good-Values to a Verifier is also not subject to standardization.
Users of the RATS architecture are assumed to have pre-existing mechanisms.

## Verifier {#verifier}

The Verifier workflow function accepts Evidence from an Attester and accepts Reference Values from one or more Asserters. Reference values may be supplied a priori, cached or used to created policies. The Verifier performs an appraisal by matching Claims found in Evidence with Claims found in Reference Values and policies. If an attested Claim value differs from an expected Claim value, the Verifier flags this as a change possibly impacting trust level.

Endorsements may not have corresponding Claims in Evidence (because of their intrinsic nature). Consequently, the Verifier need only authenticate the endpoint and verify the Endorsements match the endpoint identity.

The result of appraisals and Endorsements, informed by owner policies, produces a new set of Claims that a Relying Party is suited to consume.

## Relying Party {#relyingparty}

A Role in an attestation workflow that accepts Attestation Results from a Verifier that may be used by the Relying Party to inform application specific decision making. How Attestation Results are used to inform decision making is out-of-scope for this architecture.

# Role Messages {#messages}

## Evidence {#evidence}

Claims that are formatted and protected by an Attester.

Evidence SHOULD satisfy Verifier expectations for freshness, identity, context, provenance, validity, and veracity.

## Appraisal Policies {#reference}

Appraisal Policies are Claims that a manufacturer, vendor or other supply chain entity makes that affect the trustworthiness of an Attester endpoint.

Claims may be persistent properties of the endpoint due to the physical nature of how it was manufactured or may reflect the processes that were followed as part of moving the endpoint through a supply-chain; e.g., validation or compliance testing. This class of Reference-values is known as Endorsements.

Another class of Appraisal Policies identifies the firmware and software that could be installed in the endpoint after its manufacture.
A digest of the firmware or software can be an effective identifier for keeping track of the images produced by vendors and installed on an endpoint.

Known-Good-Values:

: Claims about the Attested Environment. Typically, Known-Good-Value (KGV) Claims are message digests of firmware, software or configuration data supplied by various vendors.
If an Attesting Environment implements cryptography, they include Claims about key material.

: Like Claims, Known-Good-Values SHOULD satisfy a Verifier's expectations for freshness, identity, context, provenance, validity, relevance and veracity.
Known-Good-Values are reference Claims that are - like Evidence - well formatted and protected (e.g. signed).

Endorsements:

: Claims about immutable and implicit characteristics of the Attesting Environment. Typically, endorsement Claims are created by manufacturing or supply chain entities.

: Endorsements are intended to increase the level of confidence with respect to Evidence created by an Attester.

## Attestation Results {#results}

Statements about the output of an appraisal of Evidence that are created, formatted and protected by a Verifier.

Attestation Results provide the basis for a Relying Party to establish a level of confidence in the trustworthiness of an Attester.
Attestation Results SHOULD satisfy Relying Party expectations for freshness, identity, context, provenance, validity, relevance and veracity.

# Principals (Entities?) -- Containers for the Roles

\[The authors are unhappy with the term Principal, and have been looking for something else.  JOSE/JWT uses the term Principal]

Principals are Containers for the Roles.

Principals are users, organizations, devices and computing environments (e.g., devices, platforms, services, peripherals).

Principals may implement one or more Roles. Massage flows occurring within the same Principal are out-of-scope.

The methods whereby Principals may be identified, discovered, authenticated, connected and trusted, though important, are out-of-scope.

Principal operations that apply resiliency, scaling, load balancing or replication are generally believed to be out-of-scope.

{:rats: artwork-align="center"}

~~~~ RATS
+------------------+   +------------------+
|  Principal 1     |   |  Principal 2     |
|  +------------+  |   |  +------------+  |
|  |            |  |   |  |            |  |
|  |    Role A  |<-|---|->|    Role D  |  |
|  |            |  |   |  |            |  |
|  +------------+  |   |  +------------+  |
|                  |   |                  |
|  +-----+------+  |   |  +-----+------+  |
|  |            |  |   |  |            |  |
|  |    Role B  |<-|---|->|    Role E  |  |
|  |            |  |   |  |            |  |
|  +------------+  |   |  +------------+  |
|                  |   |                  |
+------------------+   +------------------+
~~~~
{:rats #Principals title="Principals-Role Composition"}

Principals have the following properties:

* Multiplicity - Multiple instances of Principals that possess the same Roles can exist.
* Composition - Principals possessing different Roles can be combined into a singleton Principal possessing the union of Roles. Message flows between combined Principals is uninteresting.
* Decomposition -  A singleton Principal possessing multiple Roles can be divided into multiple Principals.

# Privacy Considerations

The conveyance of Evidence and the resulting Attestation Results reveal a great deal of information about the internal state of a device.
In many cases the whole point of the Attestation process is to provided reliable evidence about the type of the device and the firmware that the device is running.
This information is particularly interesting to many attackers: knowing that a device is running a weak version of a firmware provides a way to aim attacks better.

Just knowing the existence of a device is itself a disclosure.

Conveyance protocols must detail what kinds of information is disclosed, and to whom it is exposed.

# Security Considerations

Evidence, Verifiable Assertions and Attestation Results SHOULD use formats that support end-to-end integrity protection and MAY support end-to-end confidentiality protection.

Replay attacks are a concern that protocol implementations MUST deal with.
This is typically done via a Nonce Claim, but the details belong to the protocol.

All other attacks involving RATS structures are not explicitly addressed by the architecture.

Additional security protections MAY be required of conveyance mechanisms.
For example, additional means of authentication, confidentiality, integrity, replay, denial of service and privacy protection of RATS payloads and Principals may be needed.

# Acknowledgments

Special thanks go to David Wooten, Jörg Borchert, Hannes Tschofenig, Laurence Lundblade, Diego Lopez, Jessica Fitzgerald-McKay, Frank Xia, and Nancy Cam-Winget.

# Contributors

Thomas Hardjono created older versions of the terminology section in collaboration with Ned Smith.
Eric Voit provided the conceptual separation between Attestation Provision Flows and Attestation Evidence Flows.
Monty Wisemen created the content structure of the first three architecture drafts.
Carsten Bormann provided many of the motivational building blocks with respect to the Internet Threat Model.
